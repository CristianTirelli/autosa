// See LICENSE for license details.
package autosa.blocks.dla

import sys.process._
import chisel3._
import chisel3.util._
import org.chipsalliance.cde.config.{Field, Parameters, Config}
import freechips.rocketchip.subsystem.BaseSubsystem
import freechips.rocketchip.diplomacy.LazyModule
import freechips.rocketchip.tilelink.{TLBuffer, TLIdentityNode, TLWidthWidget, TLFragmenter}

// Parameter Key
case object AUTOSAKey extends Field[Option[AUTOSAParams]](None)

// Parameter Value
case class AUTOSAParams(kernelName: String, raddress: BigInt)

// Mix-in feature of having AUTOSA as accelerator
class WithAUTOSA(kernelName: String) extends Config((site, here, up) => {
  case AUTOSAKey => Some(AUTOSAParams(kernelName = kernelName, raddress = 0x10040000L))
})

// Mix-in Trait
trait CanHavePeripheryAUTOSA { this: BaseSubsystem =>
  p(AUTOSAKey).map { params =>
    val autosa = LazyModule(new AUTOSA(params))

    fbus.coupleFrom("autosa_gmem_A") { _ := autosa.gmem_A_tl_node }
    fbus.coupleFrom("autosa_gmem_B") { _ := autosa.gmem_B_tl_node }
    fbus.coupleFrom("autosa_gmem_C") { _ := autosa.gmem_C_tl_node }
    pbus.coupleTo("autosa_control") { autosa.control_tl_node := TLFragmenter(4, pbus.blockBytes) := TLWidthWidget(pbus.beatBytes) := _ }

    ibus.fromSync := autosa.int_node

  }
}



// AUTOSA Main blackbox lazymodule
class AUTOSA(params: AUTOSAParams)(implicit p: Parameters) extends LazyModule {

  // DTS
  val dtsdevice = new SimpleDevice("nvdla",Seq("nvidia,nv_" + params.config))

  // gmem data TL node
  val gmem_A_tl_node = TLIdentityNode()
  val gmem_B_tl_node = TLIdentityNode()
  val gmem_C_tl_node = TLIdentityNode()

  // gmem data AXI node
  def get_gmem_axi_node(nodeName: String) = {
    AXI4MasterNode(
        Seq(
          AXI4MasterPortParameters(
            masters = Seq(AXI4MasterParameters(
              name    = nodeName,
              id      = IdRange(0, 256))))))
  }
  val gmem_A_axi_node = get_gmem_axi_node("AUTOSA GMEM DATA A")
  val gmem_B_axi_node = get_gmem_axi_node("AUTOSA GMEM DATA B")
  val gmem_C_axi_node = get_gmem_axi_node("AUTOSA GMEM DATA C")

  def connectTL2AXI(tl_node: TLIdentityNode, axi_node: AXI4MasterNode): Unit = {
    (tl_node
      := TLBuffer()
      := TLWidthWidget(dataWidthAXI/8)
      := AXI4ToTL()
      := AXI4UserYanker(capMaxFlight=Some(16))
      := AXI4Fragmenter()
      := AXI4IdIndexer(idBits=3)
      := AXI4Buffer()
      := axi_node)
  }
  connectTL2AXI(gmem_A_tl_node, gmem_A_axi_node)
  connectTL2AXI(gmem_B_tl_node, gmem_B_axi_node)
  connectTL2AXI(gmem_C_tl_node, gmem_C_axi_node)

  // control APB node
  val cfg_apb_node = APBSlaveNode(
    Seq(
      APBSlavePortParameters(
        slaves = Seq(APBSlaveParameters(
          address       = Seq(AddressSet(params.raddress, 0x40000L-1L)), // 256KB
          resources     = dtsdevice.reg("control"),
          executable    = false,
          supportsWrite = true,
          supportsRead  = true)),
        beatBytes = 4)))

  // control TL node and adapter to convert it to APB
  val cfg_tl_node = cfg_apb_node := LazyModule(new TLToAPB).node

  // Interrupt node
  val int_node = IntSourceNode(IntSourcePortSimple(num = 1, resources = dtsdevice.int))

  // Connect the Diplomacy Node into IO of blackbox
  lazy val module = new LazyModuleImp(this) {

    // Instance of the blackbox
    val u_autosa = Module(new autosa(params))

    ////////////////////////
    // Clock Reset Interrupt
    ////////////////////////

    u_autosa.io.ap_clk         := clock
    u_autosa.io.ap_rst_n       := ~reset.asBool
    val (io_int, _) = int_node.out(0)
    io_int(0)   := u_autosa.io.interrupt

    ////////////////////////
    // gmem_control ////////
    ////////////////////////

    // Get the APB node
    val (cfg, _) = cfg_apb_node.in(0)

    // AUTOSA -> APB -> TL
    cfg.pslverr  := false.B
    cfg.pready   := u_autosa.io.s_axi_control_AWREADY && u_autosa.io.s_axi_control_WREADY && u_autosa.io.s_axi_control_ARREADY
    cfg.prdata   := u_autosa.io.s_axi_control_RDATA

    // TL -> APB -> AUTOSA
    val doWrite: Bool = cfg.psel && cfg.penable && cfg.pwrite
    u_autosa.io.s_axi_control_AWVALID := doWrite
    u_autosa.io.s_axi_control_AWADDR  := cfg.paddr
    u_autosa.io.s_axi_control_WVALID  := doWrite
    u_autosa.io.s_axi_control_WDATA   := cfg.pwdata
    u_autosa.io.s_axi_control_WSTRB   := "b1111".U
    u_autosa.io.s_axi_control_ARVALID := false.B
    u_autosa.io.s_axi_control_ARADDR  := DontCare
    u_autosa.io.s_axi_control_RREADY  := false.B
    u_autosa.io.s_axi_control_BREADY  := false.B

    ////////////////////////
    // gmem_A //////////////
    ////////////////////////

    // Get the AXI node
    val (gmem_A, _) = gmem_A_axi_node.out(0)

    // AW, Write Address
    gmem_A.aw.valid := u_autosa.io.m_axi_gmem_A_AWVALID
    u_autosa.io.m_axi_gmem_A_AWREADY := gmem_A.aw.ready
    gmem_A.aw.bits.addr := u_autosa.io.m_axi_gmem_A_AWADDR
    gmem_A.aw.bits.id   := u_autosa.io.m_axi_gmem_A_AWID
    gmem_A.aw.bits.len  := u_autosa.io.m_axi_gmem_A_AWLEN
    gmem_A.aw.bits.size := u_autosa.io.m_axi_gmem_A_AWSIZE

    // W, Write Data
    gmem_A.w.valid := u_autosa.io.m_axi_gmem_A_WVALID
    u_autosa.io.m_axi_gmem_A_WREADY := gmem_A.w.ready
    gmem_A.w.bits.data := u_autosa.io.m_axi_gmem_A_WDATA
    gmem_A.w.bits.strb := u_autosa.io.m_axi_gmem_A_WSTRB
    gmem_A.w.bits.last := u_autosa.io.m_axi_gmem_A_WLAST

    // AR, Read Address
    gmem_A.ar.valid := u_autosa.io.m_axi_gmem_A_ARVALID
    u_autosa.io.m_axi_gmem_A_ARREADY := gmem_A.ar.ready
    gmem_A.ar.bits.id := u_autosa.io.m_axi_gmem_A_ARID
    gmem_A.ar.bits.len:= u_autosa.io.m_axi_gmem_A_ARLEN
    gmem_A.ar.bits.size:= u_autosa.io.m_axi_gmem_A_ARSIZE
    gmem_A.ar.bits.addr := u_autosa.io.m_axi_gmem_A_ARADDR

    // B, response channel
    u_autosa.io.m_axi_gmem_A_BVALID := gmem_A.b.valid
    gmem_A.b.ready := u_autosa.io.m_axi_gmem_A_BREADY
    u_autosa.io.m_axi_gmem_A_BID := gmem_A.b.bits.id
    u_autosa.io.m_axi_gmem_A_BRESP := 0.U
    u_autosa.io.m_axi_gmem_A_BUSER := 0.U

    // R, Read Data
    u_autosa.io.m_axi_gmem_A_RVALID := gmem_A.r.valid
    gmem_A.r.ready := u_autosa.io.m_axi_gmem_A_RREADY
    u_autosa.io.m_axi_gmem_A_RID  := gmem_A.r.bits.id
    u_autosa.io.m_axi_gmem_A_RLAST:= gmem_A.r.bits.last
    u_autosa.io.m_axi_gmem_A_RDATA:= gmem_A.r.bits.data
    u_autosa.io.m_axi_gmem_A_RRESP:= 0.U
    u_autosa.io.m_axi_gmem_A_RUSER:= 0.U

    ////////////////////////
    // gmem_B //////////////
    ////////////////////////

    // Get the AXI node
    val (gmem_B, _) = gmem_B_axi_node.out(0)

    // AW, Write Address
    gmem_B.aw.valid := u_autosa.io.m_axi_gmem_B_AWVALID
    u_autosa.io.m_axi_gmem_B_AWREADY := gmem_B.aw.ready
    gmem_B.aw.bits.addr := u_autosa.io.m_axi_gmem_B_AWADDR
    gmem_B.aw.bits.id   := u_autosa.io.m_axi_gmem_B_AWID
    gmem_B.aw.bits.len  := u_autosa.io.m_axi_gmem_B_AWLEN
    gmem_B.aw.bits.size := u_autosa.io.m_axi_gmem_B_AWSIZE

    // W, Write Data
    gmem_B.w.valid := u_autosa.io.m_axi_gmem_B_WVALID
    u_autosa.io.m_axi_gmem_B_WREADY := gmem_B.w.ready
    gmem_B.w.bits.data := u_autosa.io.m_axi_gmem_B_WDATA
    gmem_B.w.bits.strb := u_autosa.io.m_axi_gmem_B_WSTRB
    gmem_B.w.bits.last := u_autosa.io.m_axi_gmem_B_WLAST

    // AR, Read Address
    gmem_B.ar.valid := u_autosa.io.m_axi_gmem_B_ARVALID
    u_autosa.io.m_axi_gmem_B_ARREADY := gmem_B.ar.ready
    gmem_B.ar.bits.id := u_autosa.io.m_axi_gmem_B_ARID
    gmem_B.ar.bits.len:= u_autosa.io.m_axi_gmem_B_ARLEN
    gmem_B.ar.bits.size:= u_autosa.io.m_axi_gmem_B_ARSIZE
    gmem_B.ar.bits.addr := u_autosa.io.m_axi_gmem_B_ARADDR

    // B, response channel
    u_autosa.io.m_axi_gmem_B_BVALID := gmem_B.b.valid
    gmem_B.b.ready := u_autosa.io.m_axi_gmem_B_BREADY
    u_autosa.io.m_axi_gmem_B_BID := gmem_B.b.bits.id
    u_autosa.io.m_axi_gmem_B_BRESP := 0.U
    u_autosa.io.m_axi_gmem_B_BUSER := 0.U

    // R, Read Data
    u_autosa.io.m_axi_gmem_B_RVALID := gmem_B.r.valid
    gmem_B.r.ready := u_autosa.io.m_axi_gmem_B_RREADY
    u_autosa.io.m_axi_gmem_B_RID  := gmem_B.r.bits.id
    u_autosa.io.m_axi_gmem_B_RLAST:= gmem_B.r.bits.last
    u_autosa.io.m_axi_gmem_B_RDATA:= gmem_B.r.bits.data
    u_autosa.io.m_axi_gmem_B_RRESP:= 0.U
    u_autosa.io.m_axi_gmem_B_RUSER:= 0.U

    ////////////////////////
    // gmem_C //////////////
    ////////////////////////

    // Get the AXI node
    val (gmem_C, _) = gmem_C_axi_node.out(0)

    // AW, Write Address
    gmem_C.aw.valid := u_autosa.io.m_axi_gmem_C_AWVALID
    u_autosa.io.m_axi_gmem_C_AWREADY := gmem_C.aw.ready
    gmem_C.aw.bits.addr := u_autosa.io.m_axi_gmem_C_AWADDR
    gmem_C.aw.bits.id   := u_autosa.io.m_axi_gmem_C_AWID
    gmem_C.aw.bits.len  := u_autosa.io.m_axi_gmem_C_AWLEN
    gmem_C.aw.bits.size := u_autosa.io.m_axi_gmem_C_AWSIZE

    // W, Write Data
    gmem_C.w.valid := u_autosa.io.m_axi_gmem_C_WVALID
    u_autosa.io.m_axi_gmem_C_WREADY := gmem_C.w.ready
    gmem_C.w.bits.data := u_autosa.io.m_axi_gmem_C_WDATA
    gmem_C.w.bits.strb := u_autosa.io.m_axi_gmem_C_WSTRB
    gmem_C.w.bits.last := u_autosa.io.m_axi_gmem_C_WLAST

    // AR, Read Address
    gmem_C.ar.valid := u_autosa.io.m_axi_gmem_C_ARVALID
    u_autosa.io.m_axi_gmem_C_ARREADY := gmem_C.ar.ready
    gmem_C.ar.bits.id := u_autosa.io.m_axi_gmem_C_ARID
    gmem_C.ar.bits.len:= u_autosa.io.m_axi_gmem_C_ARLEN
    gmem_C.ar.bits.size:= u_autosa.io.m_axi_gmem_C_ARSIZE
    gmem_C.ar.bits.addr := u_autosa.io.m_axi_gmem_C_ARADDR

    // B, response channel
    u_autosa.io.m_axi_gmem_C_BVALID := gmem_C.b.valid
    gmem_C.b.ready := u_autosa.io.m_axi_gmem_C_BREADY
    u_autosa.io.m_axi_gmem_C_BID := gmem_C.b.bits.id
    u_autosa.io.m_axi_gmem_C_BRESP := 0.U
    u_autosa.io.m_axi_gmem_C_BUSER := 0.U

    // R, Read Data
    u_autosa.io.m_axi_gmem_C_RVALID := gmem_C.r.valid
    gmem_C.r.ready := u_autosa.io.m_axi_gmem_C_RREADY
    u_autosa.io.m_axi_gmem_C_RID  := gmem_C.r.bits.id
    u_autosa.io.m_axi_gmem_C_RLAST:= gmem_C.r.bits.last
    u_autosa.io.m_axi_gmem_C_RDATA:= gmem_C.r.bits.data
    u_autosa.io.m_axi_gmem_C_RRESP:= 0.U
    u_autosa.io.m_axi_gmem_C_RUSER:= 0.U
  }
}

// The IO of the blackbox
class autosaio() extends Bundle {

    // Clock, Reset and Interrupt
    val ap_clk    = Input(Clock())
    val ap_rst_n  = Input(Bool())
    val interrupt = Output(Bool())
    
    // control AXI
    // AW
    val s_axi_control_AWVALID = Input(Bool())
    val s_axi_control_AWREADY = Output(Bool())
    val s_axi_control_AWADDR = Input(UInt((6).W))
    // W
    val s_axi_control_WVALID = Input(Bool())
    val s_axi_control_WREADY = Output(Bool())
    val s_axi_control_WDATA = Input(UInt((32).W))
    val s_axi_control_WSTRB = Input(UInt((4).W))
    // AR
    val s_axi_control_ARVALID = Input(Bool())
    val s_axi_control_ARREADY = Output(Bool())
    val s_axi_control_ARADDR = Input(UInt((6).W))
    // R
    val s_axi_control_RVALID = Output(Bool())
    val s_axi_control_RREADY = Input(Bool())
    val s_axi_control_RDATA = Output(UInt((32).W))
    val s_axi_control_RRESP = Output(UInt((2).W))
    // B
    val s_axi_control_BVALID = Output(Bool())
    val s_axi_control_BREADY = Input(Bool())
    val s_axi_control_BRESP = Output(UInt((2).W))
    
    // gmem_A AXI
    // AW
    val m_axi_gmem_A_AWVALID = Output(Bool())
    val m_axi_gmem_A_AWREADY = Input(Bool())
    val m_axi_gmem_A_AWADDR = Output(UInt((64).W))
    val m_axi_gmem_A_AWID = Output(UInt((1).W))
    val m_axi_gmem_A_AWLEN = Output(UInt((8).W))
    val m_axi_gmem_A_AWSIZE = Output(UInt((3).W))
    val m_axi_gmem_A_AWBURST = Output(UInt((2).W))
    val m_axi_gmem_A_AWLOCK = Output(UInt((2).W))
    val m_axi_gmem_A_AWCACHE = Output(UInt((4).W))
    val m_axi_gmem_A_AWPROT = Output(UInt((3).W))
    val m_axi_gmem_A_AWQOS = Output(UInt((4).W))
    val m_axi_gmem_A_AWREGION = Output(UInt((4).W))
    val m_axi_gmem_A_AWUSER = Output(UInt((2).W))
    // W
    val m_axi_gmem_A_WVALID = Output(Bool())
    val m_axi_gmem_A_WREADY = Input(Bool())
    val m_axi_gmem_A_WDATA = Output(UInt((512).W))
    val m_axi_gmem_A_WSTRB = Output(UInt((64).W))
    val m_axi_gmem_A_WLAST = Output(Bool())
    val m_axi_gmem_A_WID = Output(UInt((1).W))
    val m_axi_gmem_A_WUSER = Output(UInt((1).W))
    // AR
    val m_axi_gmem_A_ARVALID = Output(Bool())
    val m_axi_gmem_A_ARREADY = Input(Bool())
    val m_axi_gmem_A_ARADDR = Output(UInt((64).W))
    val m_axi_gmem_A_ARID = Output(UInt((1).W))
    val m_axi_gmem_A_ARLEN = Output(UInt((8).W))
    val m_axi_gmem_A_ARSIZE = Output(UInt((3).W))
    val m_axi_gmem_A_ARBURST = Output(UInt((2).W))
    val m_axi_gmem_A_ARLOCK = Output(UInt((2).W))
    val m_axi_gmem_A_ARCACHE = Output(UInt((4).W))
    val m_axi_gmem_A_ARPROT = Output(UInt((3).W))
    val m_axi_gmem_A_ARQOS = Output(UInt((4).W))
    val m_axi_gmem_A_ARREGION = Output(UInt((4).W))
    val m_axi_gmem_A_ARUSER = Output(UInt((1).W))
    // R
    val m_axi_gmem_A_RVALID = Input(Bool())
    val m_axi_gmem_A_RREADY = Output(Bool())
    val m_axi_gmem_A_RDATA = Input(UInt((512).W))
    val m_axi_gmem_A_RLAST = Input(Bool())
    val m_axi_gmem_A_RID = Input(UInt((1).W))
    val m_axi_gmem_A_RUSER = Input(UInt((1).W))
    val m_axi_gmem_A_RRESP = Input(UInt((2).W))
    // B
    val m_axi_gmem_A_BVALID = Input(Bool())
    val m_axi_gmem_A_BREADY = Output(Bool())
    val m_axi_gmem_A_BRESP = Input(UInt((2).W))
    val m_axi_gmem_A_BID = Input(UInt((1).W))
    val m_axi_gmem_A_BUSER = Input(UInt((1).W))

    // gmem_B AXI
    // AW
    val m_axi_gmem_B_AWVALID = Output(Bool())
    val m_axi_gmem_B_AWREADY = Input(Bool())
    val m_axi_gmem_B_AWADDR = Output(UInt((64).W))
    val m_axi_gmem_B_AWID = Output(UInt((1).W))
    val m_axi_gmem_B_AWLEN = Output(UInt((8).W))
    val m_axi_gmem_B_AWSIZE = Output(UInt((3).W))
    val m_axi_gmem_B_AWBURST = Output(UInt((2).W))
    val m_axi_gmem_B_AWLOCK = Output(UInt((2).W))
    val m_axi_gmem_B_AWCACHE = Output(UInt((4).W))
    val m_axi_gmem_B_AWPROT = Output(UInt((3).W))
    val m_axi_gmem_B_AWQOS = Output(UInt((4).W))
    val m_axi_gmem_B_AWREGION = Output(UInt((4).W))
    val m_axi_gmem_B_AWUSER = Output(UInt((2).W))
    // W
    val m_axi_gmem_B_WVALID = Output(Bool())
    val m_axi_gmem_B_WREADY = Input(Bool())
    val m_axi_gmem_B_WDATA = Output(UInt((512).W))
    val m_axi_gmem_B_WSTRB = Output(UInt((64).W))
    val m_axi_gmem_B_WLAST = Output(Bool())
    val m_axi_gmem_B_WID = Output(UInt((1).W))
    val m_axi_gmem_B_WUSER = Output(UInt((1).W))
    // AR
    val m_axi_gmem_B_ARVALID = Output(Bool())
    val m_axi_gmem_B_ARREADY = Input(Bool())
    val m_axi_gmem_B_ARADDR = Output(UInt((64).W))
    val m_axi_gmem_B_ARID = Output(UInt((1).W))
    val m_axi_gmem_B_ARLEN = Output(UInt((8).W))
    val m_axi_gmem_B_ARSIZE = Output(UInt((3).W))
    val m_axi_gmem_B_ARBURST = Output(UInt((2).W))
    val m_axi_gmem_B_ARLOCK = Output(UInt((2).W))
    val m_axi_gmem_B_ARCACHE = Output(UInt((4).W))
    val m_axi_gmem_B_ARPROT = Output(UInt((3).W))
    val m_axi_gmem_B_ARQOS = Output(UInt((4).W))
    val m_axi_gmem_B_ARREGION = Output(UInt((4).W))
    val m_axi_gmem_B_ARUSER = Output(UInt((1).W))
    // R
    val m_axi_gmem_B_RVALID = Input(Bool())
    val m_axi_gmem_B_RREADY = Output(Bool())
    val m_axi_gmem_B_RDATA = Input(UInt((512).W))
    val m_axi_gmem_B_RLAST = Input(Bool())
    val m_axi_gmem_B_RID = Input(UInt((1).W))
    val m_axi_gmem_B_RUSER = Input(UInt((1).W))
    val m_axi_gmem_B_RRESP = Input(UInt((2).W))
    // B
    val m_axi_gmem_B_BVALID = Input(Bool())
    val m_axi_gmem_B_BREADY = Output(Bool())
    val m_axi_gmem_B_BRESP = Input(UInt((2).W))
    val m_axi_gmem_B_BID = Input(UInt((1).W))
    val m_axi_gmem_B_BUSER = Input(UInt((1).W))

    // gmem_C AXI
    // AW
    val m_axi_gmem_C_AWVALID = Output(Bool())
    val m_axi_gmem_C_AWREADY = Input(Bool())
    val m_axi_gmem_C_AWADDR = Output(UInt((64).W))
    val m_axi_gmem_C_AWID = Output(UInt((1).W))
    val m_axi_gmem_C_AWLEN = Output(UInt((8).W))
    val m_axi_gmem_C_AWSIZE = Output(UInt((3).W))
    val m_axi_gmem_C_AWBURST = Output(UInt((2).W))
    val m_axi_gmem_C_AWLOCK = Output(UInt((2).W))
    val m_axi_gmem_C_AWCACHE = Output(UInt((4).W))
    val m_axi_gmem_C_AWPROT = Output(UInt((3).W))
    val m_axi_gmem_C_AWQOS = Output(UInt((4).W))
    val m_axi_gmem_C_AWREGION = Output(UInt((4).W))
    val m_axi_gmem_C_AWUSER = Output(UInt((2).W))
    // W
    val m_axi_gmem_C_WVALID = Output(Bool())
    val m_axi_gmem_C_WREADY = Input(Bool())
    val m_axi_gmem_C_WDATA = Output(UInt((512).W))
    val m_axi_gmem_C_WSTRB = Output(UInt((64).W))
    val m_axi_gmem_C_WLAST = Output(Bool())
    val m_axi_gmem_C_WID = Output(UInt((1).W))
    val m_axi_gmem_C_WUSER = Output(UInt((1).W))
    // AR
    val m_axi_gmem_C_ARVALID = Output(Bool())
    val m_axi_gmem_C_ARREADY = Input(Bool())
    val m_axi_gmem_C_ARADDR = Output(UInt((64).W))
    val m_axi_gmem_C_ARID = Output(UInt((1).W))
    val m_axi_gmem_C_ARLEN = Output(UInt((8).W))
    val m_axi_gmem_C_ARSIZE = Output(UInt((3).W))
    val m_axi_gmem_C_ARBURST = Output(UInt((2).W))
    val m_axi_gmem_C_ARLOCK = Output(UInt((2).W))
    val m_axi_gmem_C_ARCACHE = Output(UInt((4).W))
    val m_axi_gmem_C_ARPROT = Output(UInt((3).W))
    val m_axi_gmem_C_ARQOS = Output(UInt((4).W))
    val m_axi_gmem_C_ARREGION = Output(UInt((4).W))
    val m_axi_gmem_C_ARUSER = Output(UInt((1).W))
    // R
    val m_axi_gmem_C_RVALID = Input(Bool())
    val m_axi_gmem_C_RREADY = Output(Bool())
    val m_axi_gmem_C_RDATA = Input(UInt((512).W))
    val m_axi_gmem_C_RLAST = Input(Bool())
    val m_axi_gmem_C_RID = Input(UInt((1).W))
    val m_axi_gmem_C_RUSER = Input(UInt((1).W))
    val m_axi_gmem_C_RRESP = Input(UInt((2).W))
    // B
    val m_axi_gmem_C_BVALID = Input(Bool())
    val m_axi_gmem_C_BREADY = Output(Bool())
    val m_axi_gmem_C_BRESP = Input(UInt((2).W))
    val m_axi_gmem_C_BID = Input(UInt((1).W))
    val m_axi_gmem_C_BUSER = Input(UInt((1).W))
}

// The actual blackbox
class autosa(params: AUTOSAParams) extends BlackBox with HasBlackBoxPath{
  // Set the name of BlackBox
  override def desiredName = params.kernelName
  // Define IO
  val io = IO(new autosaio)
  // Set the path
  val chipyardDir = System.getProperty("user.dir")
  val autosaVsrcDir = s"$chipyardDir/generators/autosa/src/main/resources/vsrc/demo"
  // Include the blackbox
  addPath(s"$autosaVsrcDir/kernel0.v")
}
