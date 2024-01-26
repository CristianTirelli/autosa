// See LICENSE for license details.
package autosa.blocks.dla

import chisel3._
import org.chipsalliance.cde.config._
import freechips.rocketchip.diplomacy._
import freechips.rocketchip.amba.axi4._
import freechips.rocketchip.amba.apb._
import freechips.rocketchip.tilelink._
import freechips.rocketchip.interrupts._
import freechips.rocketchip.subsystem._

import autosa.blocks.ip.dla._


case class AUTOSAParams(
  config: String,
  raddress: BigInt,
  synthRAMs: Boolean = false
)

class AUTOSA(params: AUTOSAParams)(implicit p: Parameters) extends LazyModule {

  val blackboxName = "autosa_" + params.config
  val hasSecondAXI = params.config == "large"
  val dataWidthAXI = if (params.config == "large") 256 else 64

  // DTS
  val dtsdevice = new SimpleDevice("autosa",Seq("autosa,nv_" + params.config))

  val control_axi_node = AXI4SlaveNode(Seq(AXI4SlavePortParameters(
    slaves = Seq(AXI4SlaveParameters(
    address       = Seq(AddressSet(params.raddress, 0x40000L-1L)), // 256KB,
    resources     = dtsdevice.reg("control"),
    regionType    = RegionType.UNCACHED,
    executable    = false,
    supportsWrite = TransferSizes(1, 256*8),
    supportsRead  = TransferSizes(1, 256*8),
    interleavedId = Some(0)
    )),
  beatBytes = 8)))

/*
  APBSlaveNode(
    Seq(
      APBSlavePortParameters(
        slaves = Seq(APBSlaveParameters(
          address       = Seq(AddressSet(params.raddress, 0x40000L-1L)), // 256KB
          resources     = dtsdevice.reg("control"),
          executable    = false,
          supportsWrite = true,
          supportsRead  = true)),
        beatBytes = 4)))

  val cfg_tl_node = control_axi_node := LazyModule(new TLToAPB).node
*/

  val gmem_A_axi_node = AXI4MasterNode(
    Seq(
      AXI4MasterPortParameters(
        masters = Seq(AXI4MasterParameters(
          name    = "AUTOSA A",
          id      = IdRange(0, 256))))))

  val gmem_B_axi_node = AXI4MasterNode(
    Seq(
      AXI4MasterPortParameters(
        masters = Seq(AXI4MasterParameters(
          name    = "AUTOSA B",
          id      = IdRange(0, 256))))))

  val gmem_C_axi_node = AXI4MasterNode(
    Seq(
      AXI4MasterPortParameters(
        masters = Seq(AXI4MasterParameters(
          name    = "AUTOSA C",
          id      = IdRange(0, 256))))))


  
  
  //val dbb_tl_node = TLIdentityNode()


  // control TL
  val control_tl_node = TLIdentityNode()

  // gmem_A TL
  val gmem_A_tl_node = TLIdentityNode()

  // gmem_B TL
  val gmem_B_tl_node = TLIdentityNode()

  // gmem_C TL
  val gmem_C_tl_node = TLIdentityNode()


  // TL <-- AXI (not correct, should have TL --> AXI)
  //(control_tl_node
  //  := TLBuffer()
  //  := TLWidthWidget(dataWidthAXI/8)
  //  := AXI4ToTL()
  //  := AXI4UserYanker(capMaxFlight=Some(16))
  //  := AXI4Fragmenter()
  //  := AXI4IdIndexer(idBits=3)
  //  := AXI4Buffer()
  //  := control_axi_node)


(control_axi_node := AXI4Buffer()
                  := AXI4IdIndexer(idBits=3)
                  := AXI4Fragmenter()
                  := AXI4UserYanker(capMaxFlight=Some(16))
                  := TLToAXI4()
                  := TLWidthWidget(dataWidthAXI/8)
                  := TLBuffer()
                  := control_tl_node
)


  // gmem_A TL <-> AXI

  // Pbus --> TL <-- AXI // wrong

  // Pbus <-- TL <-- AXI correct

  (gmem_A_tl_node
    := TLBuffer()
    := TLWidthWidget(dataWidthAXI/8)
    := AXI4ToTL()
    := AXI4UserYanker(capMaxFlight=Some(16))
    := AXI4Fragmenter()
    := AXI4IdIndexer(idBits=3)
    := AXI4Buffer()
    := gmem_A_axi_node)


  // gmem_B TL <-> AXI
  (gmem_B_tl_node
    := TLBuffer()
    := TLWidthWidget(dataWidthAXI/8)
    := AXI4ToTL()
    := AXI4UserYanker(capMaxFlight=Some(16))
    := AXI4Fragmenter()
    := AXI4IdIndexer(idBits=3)
    := AXI4Buffer()
    := gmem_B_axi_node)

  // gmem_C TL <-> AXI
  (gmem_C_tl_node
    := TLBuffer()
    := TLWidthWidget(dataWidthAXI/8)
    := AXI4ToTL()
    := AXI4UserYanker(capMaxFlight=Some(16))
    := AXI4Fragmenter()
    := AXI4IdIndexer(idBits=3)
    := AXI4Buffer()
    := gmem_C_axi_node)

  // cfg APB
  /*
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

  val cfg_tl_node = cfg_apb_node := LazyModule(new TLToAPB).node 
  */
  
  val int_node = IntSourceNode(IntSourcePortSimple(num = 1, resources = dtsdevice.int))


  lazy val module = new LazyModuleImp(this) {

    val u_autosa = Module(new autosa(params.config, blackboxName, hasSecondAXI, dataWidthAXI, params.synthRAMs))

    //chisel3.dontTouch(module)


    //u_autosa.io.core_clk    := clock
    //u_autosa.io.rstn        := ~reset.asBool
    //u_autosa.io.csb_rstn    := ~reset.asBool

    u_autosa.io.ap_clk    := clock
    u_autosa.io.ap_rst_n        := ~reset.asBool
    //u_autosa.io.interrupt    := ~reset.asBool
    

    //gmem_control 
    val (gmem_control, _) = control_axi_node.in(0)
    
    // AW
    gmem_control.aw.valid                              := u_autosa.io.s_axi_control_AWVALID
    u_autosa.io.s_axi_control_AWREADY    := gmem_control.aw.ready
    //gmem_control.aw.bits.id                          := u_autosa.io.m_axi_gmem_A_AWID
    //gmem_control.aw.bits.len                         := u_autosa.io.m_axi_gmem_A_AWLEN
    //gmem_control.aw.bits.size                        := u_autosa.io.m_axi_gmem_A_AWSIZE
    gmem_control.aw.bits.addr                          := u_autosa.io.s_axi_control_AWADDR
    //gmem_control.aw.bits.burst                       := u_autosa.io.m_axi_gmem_A_AWBURST
    //gmem_control.aw.bits.lock                        := u_autosa.io.m_axi_gmem_A_AWLOCK
    //gmem_control.aw.bits.cache                       := u_autosa.io.m_axi_gmem_A_AWCACHE
    //gmem_control.aw.bits.prot                        := u_autosa.io.m_axi_gmem_A_AWPROT
    //gmem_control.aw.bits.qos                         := u_autosa.io.m_axi_gmem_A_AWQOS
    //gmem_control.aw.bits.region                      := u_autosa.io.m_axi_gmem_A_AWREGION
    //gmem_control.aw.bits.user                        := u_autosa.io.m_axi_gmem_A_AWUSER
    // W
    gmem_control.w.valid                             := u_autosa.io.s_axi_control_WVALID
    u_autosa.io.s_axi_control_WREADY      := gmem_control.w.ready
    gmem_control.w.bits.data                         := u_autosa.io.s_axi_control_WDATA
    gmem_control.w.bits.strb                         := u_autosa.io.s_axi_control_WSTRB
    //gmem_control.w.bits.last                         := u_autosa.io.m_axi_gmem_A_WLAST
    //gmem_control.w.bits.id                         := u_autosa.io.m_axi_gmem_A_WID
    //gmem_control.w.bits.user                         := u_autosa.io.m_axi_gmem_A_WUSER
    // AR
    gmem_control.ar.valid                            := u_autosa.io.s_axi_control_ARVALID
    u_autosa.io.s_axi_control_ARREADY    := gmem_control.ar.ready
    //gmem_control.ar.bits.id                          := u_autosa.io.m_axi_gmem_A_ARID
    //gmem_control.ar.bits.len                         := u_autosa.io.m_axi_gmem_A_ARLEN
    //gmem_control.ar.bits.size                        := u_autosa.io.m_axi_gmem_A_ARSIZE
    gmem_control.ar.bits.addr                        := u_autosa.io.s_axi_control_ARADDR
    //gmem_control.ar.bits.burst                       := u_autosa.io.m_axi_gmem_A_ARBURST
    //gmem_control.ar.bits.lock                        := u_autosa.io.m_axi_gmem_A_ARLOCK
    //gmem_control.ar.bits.cache                       := u_autosa.io.m_axi_gmem_A_ARCACHE
    //gmem_control.ar.bits.prot                        := u_autosa.io.m_axi_gmem_A_ARPROT
    //gmem_control.ar.bits.qos                         := u_autosa.io.m_axi_gmem_A_ARQOS
    //gmem_control.ar.bits.region                      := u_autosa.io.m_axi_gmem_A_ARREGION
    //gmem_control.ar.bits.user                        := u_autosa.io.m_axi_gmem_A_ARUSER
    // B
    u_autosa.io.s_axi_control_BVALID        := gmem_control.b.valid
    gmem_control.b.ready                           := u_autosa.io.s_axi_control_BREADY
    u_autosa.io.s_axi_control_BRESP         := gmem_control.b.bits.resp
    //u_autosa.io.m_axi_gmem_A_BID           := gmem_control.b.bits.id
    //u_autosa.io.m_axi_gmem_A_BUSER         := gmem_control.b.bits.user
    // R
    u_autosa.io.s_axi_control_RVALID      := gmem_control.r.valid
    gmem_control.r.ready                             := u_autosa.io.s_axi_control_RREADY
    //u_autosa.io.m_axi_gmem_A_RID         := gmem_control.r.bits.id
    //u_autosa.io.m_axi_gmem_A_RLAST       := gmem_control.r.bits.last
    u_autosa.io.s_axi_control_RDATA       := gmem_control.r.bits.data
    //u_autosa.io.m_axi_gmem_A_RUSER       := gmem_control.r.bits.user
    u_autosa.io.s_axi_control_RRESP       := gmem_control.r.bits.resp

    // gmem_A
    val (gmem_A, _) = gmem_A_axi_node.out(0)

    // AW
    gmem_A.aw.valid                            := u_autosa.io.m_axi_gmem_A_AWVALID
    u_autosa.io.m_axi_gmem_A_AWREADY    := gmem_A.aw.ready
    gmem_A.aw.bits.id                          := u_autosa.io.m_axi_gmem_A_AWID
    gmem_A.aw.bits.len                         := u_autosa.io.m_axi_gmem_A_AWLEN
    gmem_A.aw.bits.size                        := u_autosa.io.m_axi_gmem_A_AWSIZE
    gmem_A.aw.bits.addr                        := u_autosa.io.m_axi_gmem_A_AWADDR
    gmem_A.aw.bits.burst                       := u_autosa.io.m_axi_gmem_A_AWBURST
    gmem_A.aw.bits.lock                        := u_autosa.io.m_axi_gmem_A_AWLOCK
    gmem_A.aw.bits.cache                       := u_autosa.io.m_axi_gmem_A_AWCACHE
    gmem_A.aw.bits.prot                        := u_autosa.io.m_axi_gmem_A_AWPROT
    gmem_A.aw.bits.qos                         := u_autosa.io.m_axi_gmem_A_AWQOS
    //gmem_A.aw.bits.region                      := u_autosa.io.m_axi_gmem_A_AWREGION
    gmem_A.aw.bits.user                        := u_autosa.io.m_axi_gmem_A_AWUSER
    // W
    gmem_A.w.valid                             := u_autosa.io.m_axi_gmem_A_WVALID
    u_autosa.io.m_axi_gmem_A_WREADY      := gmem_A.w.ready
    gmem_A.w.bits.data                         := u_autosa.io.m_axi_gmem_A_WDATA
    gmem_A.w.bits.strb                         := u_autosa.io.m_axi_gmem_A_WSTRB
    gmem_A.w.bits.last                         := u_autosa.io.m_axi_gmem_A_WLAST
    //gmem_A.w.bits.id                         := u_autosa.io.m_axi_gmem_A_WID
    gmem_A.w.bits.user                         := u_autosa.io.m_axi_gmem_A_WUSER
    // AR
    gmem_A.ar.valid                            := u_autosa.io.m_axi_gmem_A_ARVALID
    u_autosa.io.m_axi_gmem_A_ARREADY    := gmem_A.ar.ready
    gmem_A.ar.bits.id                          := u_autosa.io.m_axi_gmem_A_ARID
    gmem_A.ar.bits.len                         := u_autosa.io.m_axi_gmem_A_ARLEN
    gmem_A.ar.bits.size                        := u_autosa.io.m_axi_gmem_A_ARSIZE
    gmem_A.ar.bits.addr                        := u_autosa.io.m_axi_gmem_A_ARADDR
    gmem_A.ar.bits.burst                       := u_autosa.io.m_axi_gmem_A_ARBURST
    gmem_A.ar.bits.lock                        := u_autosa.io.m_axi_gmem_A_ARLOCK
    gmem_A.ar.bits.cache                       := u_autosa.io.m_axi_gmem_A_ARCACHE
    gmem_A.ar.bits.prot                        := u_autosa.io.m_axi_gmem_A_ARPROT
    gmem_A.ar.bits.qos                         := u_autosa.io.m_axi_gmem_A_ARQOS
    //gmem_A.ar.bits.region                      := u_autosa.io.m_axi_gmem_A_ARREGION
    gmem_A.ar.bits.user                        := u_autosa.io.m_axi_gmem_A_ARUSER
    // B
    u_autosa.io.m_axi_gmem_A_BVALID        := gmem_A.b.valid
    gmem_A.b.ready                           := u_autosa.io.m_axi_gmem_A_BREADY
    u_autosa.io.m_axi_gmem_A_BRESP         := gmem_A.b.bits.resp
    u_autosa.io.m_axi_gmem_A_BID           := gmem_A.b.bits.id
    u_autosa.io.m_axi_gmem_A_BUSER         := gmem_A.b.bits.user
    // R
    u_autosa.io.m_axi_gmem_A_RVALID      := gmem_A.r.valid
    gmem_A.r.ready                             := u_autosa.io.m_axi_gmem_A_RREADY
    u_autosa.io.m_axi_gmem_A_RID         := gmem_A.r.bits.id
    u_autosa.io.m_axi_gmem_A_RLAST       := gmem_A.r.bits.last
    u_autosa.io.m_axi_gmem_A_RDATA       := gmem_A.r.bits.data
    u_autosa.io.m_axi_gmem_A_RUSER       := gmem_A.r.bits.user
    u_autosa.io.m_axi_gmem_A_RRESP       := gmem_A.r.bits.resp

    // gmem_B
    val (gmem_B, _) = gmem_B_axi_node.out(0)

    // AW
    gmem_B.aw.valid                            := u_autosa.io.m_axi_gmem_B_AWVALID
    u_autosa.io.m_axi_gmem_B_AWREADY    := gmem_B.aw.ready
    gmem_B.aw.bits.id                          := u_autosa.io.m_axi_gmem_B_AWID
    gmem_B.aw.bits.len                         := u_autosa.io.m_axi_gmem_B_AWLEN
    gmem_B.aw.bits.size                        := u_autosa.io.m_axi_gmem_B_AWSIZE
    gmem_B.aw.bits.addr                        := u_autosa.io.m_axi_gmem_B_AWADDR
    gmem_B.aw.bits.burst                       := u_autosa.io.m_axi_gmem_B_AWBURST
    gmem_B.aw.bits.lock                        := u_autosa.io.m_axi_gmem_B_AWLOCK
    gmem_B.aw.bits.cache                       := u_autosa.io.m_axi_gmem_B_AWCACHE
    gmem_B.aw.bits.prot                        := u_autosa.io.m_axi_gmem_B_AWPROT
    gmem_B.aw.bits.qos                         := u_autosa.io.m_axi_gmem_B_AWQOS
    //gmem_B.aw.bits.region                      := u_autosa.io.m_axi_gmem_B_AWREGION
    gmem_B.aw.bits.user                        := u_autosa.io.m_axi_gmem_B_AWUSER
    // W
    gmem_B.w.valid                             := u_autosa.io.m_axi_gmem_B_WVALID
    u_autosa.io.m_axi_gmem_B_WREADY      := gmem_B.w.ready
    gmem_B.w.bits.data                         := u_autosa.io.m_axi_gmem_B_WDATA
    gmem_B.w.bits.strb                         := u_autosa.io.m_axi_gmem_B_WSTRB
    gmem_B.w.bits.last                         := u_autosa.io.m_axi_gmem_B_WLAST
    //gmem_B.w.bits.id                         := u_autosa.io.m_axi_gmem_B_WID
    gmem_B.w.bits.user                         := u_autosa.io.m_axi_gmem_B_WUSER
    // AR
    gmem_B.ar.valid                            := u_autosa.io.m_axi_gmem_B_ARVALID
    u_autosa.io.m_axi_gmem_B_ARREADY    := gmem_B.ar.ready
    gmem_B.ar.bits.id                          := u_autosa.io.m_axi_gmem_B_ARID
    gmem_B.ar.bits.len                         := u_autosa.io.m_axi_gmem_B_ARLEN
    gmem_B.ar.bits.size                        := u_autosa.io.m_axi_gmem_B_ARSIZE
    gmem_B.ar.bits.addr                        := u_autosa.io.m_axi_gmem_B_ARADDR
    gmem_B.ar.bits.burst                       := u_autosa.io.m_axi_gmem_B_ARBURST
    gmem_B.ar.bits.lock                        := u_autosa.io.m_axi_gmem_B_ARLOCK
    gmem_B.ar.bits.cache                       := u_autosa.io.m_axi_gmem_B_ARCACHE
    gmem_B.ar.bits.prot                        := u_autosa.io.m_axi_gmem_B_ARPROT
    gmem_B.ar.bits.qos                         := u_autosa.io.m_axi_gmem_B_ARQOS
    //gmem_B.ar.bits.region                      := u_autosa.io.m_axi_gmem_B_ARREGION
    gmem_B.ar.bits.user                        := u_autosa.io.m_axi_gmem_B_ARUSER
    // B
    u_autosa.io.m_axi_gmem_B_BVALID        := gmem_B.b.valid
    gmem_B.b.ready                           := u_autosa.io.m_axi_gmem_B_BREADY
    u_autosa.io.m_axi_gmem_B_BRESP         := gmem_B.b.bits.resp
    u_autosa.io.m_axi_gmem_B_BID           := gmem_B.b.bits.id
    u_autosa.io.m_axi_gmem_B_BUSER         := gmem_B.b.bits.user
    // R
    u_autosa.io.m_axi_gmem_B_RVALID      := gmem_B.r.valid
    gmem_B.r.ready                             := u_autosa.io.m_axi_gmem_B_RREADY
    u_autosa.io.m_axi_gmem_B_RID         := gmem_B.r.bits.id
    u_autosa.io.m_axi_gmem_B_RLAST       := gmem_B.r.bits.last
    u_autosa.io.m_axi_gmem_B_RDATA       := gmem_B.r.bits.data
    u_autosa.io.m_axi_gmem_B_RUSER       := gmem_B.r.bits.user
    u_autosa.io.m_axi_gmem_B_RRESP       := gmem_B.r.bits.resp

    // gmem_C
    val (gmem_C, _) = gmem_C_axi_node.out(0)

    // AW
    gmem_C.aw.valid                            := u_autosa.io.m_axi_gmem_C_AWVALID
    u_autosa.io.m_axi_gmem_A_AWREADY    := gmem_C.aw.ready
    gmem_C.aw.bits.id                          := u_autosa.io.m_axi_gmem_C_AWID
    gmem_C.aw.bits.len                         := u_autosa.io.m_axi_gmem_C_AWLEN
    gmem_C.aw.bits.size                        := u_autosa.io.m_axi_gmem_C_AWSIZE
    gmem_C.aw.bits.addr                        := u_autosa.io.m_axi_gmem_C_AWADDR
    gmem_C.aw.bits.burst                       := u_autosa.io.m_axi_gmem_C_AWBURST
    gmem_C.aw.bits.lock                        := u_autosa.io.m_axi_gmem_C_AWLOCK
    gmem_C.aw.bits.cache                       := u_autosa.io.m_axi_gmem_C_AWCACHE
    gmem_C.aw.bits.prot                        := u_autosa.io.m_axi_gmem_C_AWPROT
    gmem_C.aw.bits.qos                         := u_autosa.io.m_axi_gmem_C_AWQOS
    //gmem_C.aw.bits.region                      := u_autosa.io.m_axi_gmem_C_AWREGION
    gmem_C.aw.bits.user                        := u_autosa.io.m_axi_gmem_C_AWUSER
    // W
    gmem_C.w.valid                             := u_autosa.io.m_axi_gmem_C_WVALID
    u_autosa.io.m_axi_gmem_C_WREADY      := gmem_C.w.ready
    gmem_C.w.bits.data                         := u_autosa.io.m_axi_gmem_C_WDATA
    gmem_C.w.bits.strb                         := u_autosa.io.m_axi_gmem_C_WSTRB
    gmem_C.w.bits.last                         := u_autosa.io.m_axi_gmem_C_WLAST
    //gmem_C.w.bits.id                         := u_autosa.io.m_axi_gmem_C_WID
    gmem_C.w.bits.user                         := u_autosa.io.m_axi_gmem_C_WUSER
    // AR
    gmem_C.ar.valid                            := u_autosa.io.m_axi_gmem_C_ARVALID
    u_autosa.io.m_axi_gmem_C_ARREADY    := gmem_C.ar.ready
    gmem_C.ar.bits.id                          := u_autosa.io.m_axi_gmem_C_ARID
    gmem_C.ar.bits.len                         := u_autosa.io.m_axi_gmem_C_ARLEN
    gmem_C.ar.bits.size                        := u_autosa.io.m_axi_gmem_C_ARSIZE
    gmem_C.ar.bits.addr                        := u_autosa.io.m_axi_gmem_C_ARADDR
    gmem_C.ar.bits.burst                       := u_autosa.io.m_axi_gmem_C_ARBURST
    gmem_C.ar.bits.lock                        := u_autosa.io.m_axi_gmem_C_ARLOCK
    gmem_C.ar.bits.cache                       := u_autosa.io.m_axi_gmem_C_ARCACHE
    gmem_C.ar.bits.prot                        := u_autosa.io.m_axi_gmem_C_ARPROT
    gmem_C.ar.bits.qos                         := u_autosa.io.m_axi_gmem_C_ARQOS
    //gmem_C.ar.bits.region                      := u_autosa.io.m_axi_gmem_C_ARREGION
    gmem_C.ar.bits.user                        := u_autosa.io.m_axi_gmem_C_ARUSER
    // B
    u_autosa.io.m_axi_gmem_C_BVALID        := gmem_C.b.valid
    gmem_C.b.ready                           := u_autosa.io.m_axi_gmem_C_BREADY
    u_autosa.io.m_axi_gmem_C_BRESP         := gmem_C.b.bits.resp
    u_autosa.io.m_axi_gmem_C_BID           := gmem_C.b.bits.id
    u_autosa.io.m_axi_gmem_C_BUSER         := gmem_C.b.bits.user
    // R
    u_autosa.io.m_axi_gmem_C_RVALID      := gmem_C.r.valid
    gmem_C.r.ready                             := u_autosa.io.m_axi_gmem_C_RREADY
    u_autosa.io.m_axi_gmem_C_RID         := gmem_C.r.bits.id
    u_autosa.io.m_axi_gmem_C_RLAST       := gmem_C.r.bits.last
    u_autosa.io.m_axi_gmem_C_RDATA       := gmem_C.r.bits.data
    u_autosa.io.m_axi_gmem_C_RUSER       := gmem_C.r.bits.user
    u_autosa.io.m_axi_gmem_C_RRESP       := gmem_C.r.bits.resp
  
/*
    val (dbb, _) = dbb_axi_node.out(0)

    dbb.aw.valid                            := u_autosa.io.autosa_core2dbb_aw_awvalid
    u_autosa.io.autosa_core2dbb_aw_awready    := dbb.aw.ready
    dbb.aw.bits.id                          := u_autosa.io.autosa_core2dbb_aw_awid
    dbb.aw.bits.len                         := u_autosa.io.autosa_core2dbb_aw_awlen
    dbb.aw.bits.size                        := u_autosa.io.autosa_core2dbb_aw_awsize
    dbb.aw.bits.addr                        := u_autosa.io.autosa_core2dbb_aw_awaddr

    dbb.w.valid                             := u_autosa.io.autosa_core2dbb_w_wvalid
    u_autosa.io.autosa_core2dbb_w_wready      := dbb.w.ready
    dbb.w.bits.data                         := u_autosa.io.autosa_core2dbb_w_wdata
    dbb.w.bits.strb                         := u_autosa.io.autosa_core2dbb_w_wstrb
    dbb.w.bits.last                         := u_autosa.io.autosa_core2dbb_w_wlast
    dbb.w.bits.user                           := u_autosa.io.autosa_core2dbb_w_wlast

    dbb.ar.valid                            := u_autosa.io.autosa_core2dbb_ar_arvalid
    u_autosa.io.autosa_core2dbb_ar_arready    := dbb.ar.ready
    dbb.ar.bits.id                          := u_autosa.io.autosa_core2dbb_ar_arid
    dbb.ar.bits.len                         := u_autosa.io.autosa_core2dbb_ar_arlen
    dbb.ar.bits.size                        := u_autosa.io.autosa_core2dbb_ar_arsize
    dbb.ar.bits.addr                        := u_autosa.io.autosa_core2dbb_ar_araddr

    u_autosa.io.autosa_core2dbb_b_bvalid      := dbb.b.valid
    dbb.b.ready                             := u_autosa.io.autosa_core2dbb_b_bready
    u_autosa.io.autosa_core2dbb_b_bid         := dbb.b.bits.id

    u_autosa.io.autosa_core2dbb_r_rvalid      := dbb.r.valid
    dbb.r.ready                             := u_autosa.io.autosa_core2dbb_r_rready
    u_autosa.io.autosa_core2dbb_r_rid         := dbb.r.bits.id
    u_autosa.io.autosa_core2dbb_r_rlast       := dbb.r.bits.last
    u_autosa.io.autosa_core2dbb_r_rdata       := dbb.r.bits.data

    u_autosa.io.autosa_core2cvsram.foreach { u_autosa_cvsram =>
      val (cvsram, _) = cvsram_axi_node.get.out(0)

      cvsram.aw.valid                       := u_autosa_cvsram.aw_awvalid
      u_autosa_cvsram.aw_awready             := cvsram.aw.ready
      cvsram.aw.bits.id                     := u_autosa_cvsram.aw_awid
      cvsram.aw.bits.len                    := u_autosa_cvsram.aw_awlen
      cvsram.aw.bits.size                   := u_autosa_cvsram.aw_awsize
      cvsram.aw.bits.addr                   := u_autosa_cvsram.aw_awaddr

      cvsram.w.valid                        := u_autosa_cvsram.w_wvalid
      u_autosa_cvsram.w_wready               := cvsram.w.ready
      cvsram.w.bits.data                    := u_autosa_cvsram.w_wdata
      cvsram.w.bits.strb                    := u_autosa_cvsram.w_wstrb
      cvsram.w.bits.last                    := u_autosa_cvsram.w_wlast

      cvsram.ar.valid                       := u_autosa_cvsram.ar_arvalid
      u_autosa_cvsram.ar_arready             := cvsram.ar.ready
      cvsram.ar.bits.id                     := u_autosa_cvsram.ar_arid
      cvsram.ar.bits.len                    := u_autosa_cvsram.ar_arlen
      cvsram.ar.bits.size                   := u_autosa_cvsram.ar_arsize
      cvsram.ar.bits.addr                   := u_autosa_cvsram.ar_araddr

      u_autosa_cvsram.b_bvalid               := cvsram.b.valid
      cvsram.b.ready                        := u_autosa_cvsram.b_bready
      u_autosa_cvsram.b_bid                  := cvsram.b.bits.id

      u_autosa_cvsram.r_rvalid               := cvsram.r.valid
      cvsram.r.ready                        := u_autosa_cvsram.r_rready
      u_autosa_cvsram.r_rid                  := cvsram.r.bits.id
      u_autosa_cvsram.r_rlast                := cvsram.r.bits.last
      u_autosa_cvsram.r_rdata                := cvsram.r.bits.data
    }

    val (cfg, _) = cfg_apb_node.in(0)

    u_autosa.io.psel         := cfg.psel
    u_autosa.io.penable      := cfg.penable
    u_autosa.io.pwrite       := cfg.pwrite
    u_autosa.io.paddr        := cfg.paddr
    u_autosa.io.pwdata       := cfg.pwdata
    cfg.prdata              := u_autosa.io.prdata
    cfg.pready              := u_autosa.io.pready
    cfg.pslverr             := false.B
  */
    val (io_int, _) = int_node.out(0)

    io_int(0)   := u_autosa.io.interrupt

    //chisel3.dontTouch(gmem_control)
    //chisel3.dontTouch(gmem_A)
    //chisel3.dontTouch(gmem_B)
    //chisel3.dontTouch(gmem_C)
  }
}
