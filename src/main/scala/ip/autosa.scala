// See LICENSE for license details.
package autosa.blocks.ip.dla

import sys.process._

import chisel3._
import chisel3.util._

//scalastyle:off
//turn off linter: blackbox name must match verilog module
class autosa(configName: String, blackboxName: String, hasSecondAXI: Boolean, dataWidthAXI: Int, synthRAMs: Boolean)
  extends BlackBox with HasBlackBoxPath
{


  
  override def desiredName = blackboxName

  
  val io = IO(new Bundle {
    
    val ap_clk = Input(Clock())
    val ap_rst_n = Input(Bool())

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
    
    /*
    val core_clk = Input(Clock())
    val rstn = Input(Bool())
    val csb_rstn = Input(Bool())

    val dla_intr = Output(Bool())
    // dbb AXI
    val autosa_core2dbb_aw_awvalid = Output(Bool())
    val autosa_core2dbb_aw_awready = Input(Bool())
    val autosa_core2dbb_aw_awid = Output(UInt((8).W))
    val autosa_core2dbb_aw_awlen = Output(UInt((4).W))
    val autosa_core2dbb_aw_awsize = Output(UInt((3).W))
    val autosa_core2dbb_aw_awaddr = Output(UInt((64).W))

    val autosa_core2dbb_w_wvalid = Output(Bool())
    val autosa_core2dbb_w_wready = Input(Bool())
    val autosa_core2dbb_w_wdata = Output(UInt((dataWidthAXI).W))
    val autosa_core2dbb_w_wstrb = Output(UInt((dataWidthAXI/8).W))
    val autosa_core2dbb_w_wlast = Output(Bool())

    val autosa_core2dbb_ar_arvalid = Output(Bool())
    val autosa_core2dbb_ar_arready = Input(Bool())
    val autosa_core2dbb_ar_arid = Output(UInt((8).W))
    val autosa_core2dbb_ar_arlen = Output(UInt((4).W))
    val autosa_core2dbb_ar_arsize = Output(UInt((3).W))
    val autosa_core2dbb_ar_araddr = Output(UInt((64).W))

    val autosa_core2dbb_b_bvalid = Input(Bool())
    val autosa_core2dbb_b_bready = Output(Bool())
    val autosa_core2dbb_b_bid = Input(UInt((8).W))

    val autosa_core2dbb_r_rvalid = Input(Bool())
    val autosa_core2dbb_r_rready = Output(Bool())
    val autosa_core2dbb_r_rid = Input(UInt((8).W))
    val autosa_core2dbb_r_rlast = Input(Bool())
    val autosa_core2dbb_r_rdata = Input(UInt((dataWidthAXI).W))
    // cvsram AXI
    val autosa_core2cvsram = if (hasSecondAXI) Some(new Bundle {

      val aw_awvalid = Output(Bool())
      val aw_awready = Input(Bool())
      val aw_awid = Output(UInt((8).W))
      val aw_awlen = Output(UInt((4).W))
      val aw_awsize = Output(UInt((3).W))
      val aw_awaddr = Output(UInt((64).W))

      val w_wvalid = Output(Bool())
      val w_wready = Input(Bool())
      val w_wdata = Output(UInt((dataWidthAXI).W))
      val w_wstrb = Output(UInt((dataWidthAXI/8).W))
      val w_wlast = Output(Bool())

      val ar_arvalid = Output(Bool())
      val ar_arready = Input(Bool())
      val ar_arid = Output(UInt((8).W))
      val ar_arlen = Output(UInt((4).W))
      val ar_arsize = Output(UInt((3).W))
      val ar_araddr = Output(UInt((64).W))

      val b_bvalid = Input(Bool())
      val b_bready = Output(Bool())
      val b_bid = Input(UInt((8).W))

      val r_rvalid = Input(Bool())
      val r_rready = Output(Bool())
      val r_rid = Input(UInt((8).W))
      val r_rlast = Input(Bool())
      val r_rdata = Input(UInt((dataWidthAXI).W))
    }) else None
    // cfg APB
    val psel = Input(Bool())
    val penable = Input(Bool())
    val pwrite = Input(Bool())
    val paddr = Input(UInt((32).W))
    val pwdata = Input(UInt((32).W))
    val prdata = Output(UInt((32).W))
    val pready = Output(Bool())*/
  })

  val chipyardDir = System.getProperty("user.dir")
  //val autosaVsrcDir = s"$chipyardDir/generators/autosa/src/main/resources"
  val autosaVsrcDir = s"$chipyardDir/generators/autosa/src/main/resources/vsrc/mm/verilog"

  //val makeStr = s"make -C $autosaVsrcDir default AUTOSA_TYPE=${configName}"
  //val preproc = if (synthRAMs) makeStr + "AUTOSA_RAMS=synth" else makeStr
  //require (preproc.! == 0, "Failed to run pre-processing step")

  //addPath(s"$autosaVsrcDir/autosa_${configName}.preprocessed.v")
  addPath(s"$autosaVsrcDir/kernel0.v")
}
