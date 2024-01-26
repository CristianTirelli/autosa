// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_autosa.v
// ================================================================
// AUTOSA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_define.h
///////////////////////////////////////////////////
//
//#if ( AUTOSA_PRIMARY_MEMIF_WIDTH  ==  512 )
//    #define LARGE_MEMBUS
//#endif
//#if ( AUTOSA_PRIMARY_MEMIF_WIDTH  ==  64 )
//    #define LARGE_MEMBUS
//#endif
`include "SA_HWACC_AUTOSA_tick_defines.vh"
// ================================================================
// AUTOSA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_CMAC.h
`define DESIGNWARE_NOEXIST 1
// ================================================================
// AUTOSA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_CSC.h
    //entry bits
    //atomC
    //in bytes, entry/8
    //CSC_ENTRY_HEX/2
    //CSC_ENTRY_HEX/4
    //CSC_ENTRY_HEX-1
    //atomK
    //atomK
    //atomK*2
    //atomK*4
//notice, for image case, first atom OP within one strip OP must fetch from entry align place, in the middle of an entry is not supported.
//thus, when atomC/atomK=4, stripe=4*atomK, feature data still keeps atomK*2
    `define CC_ATOMC_DIV_ATOMK_EQUAL_1
//batch keep 1
module SA_autosa (
   dla_core_clk //|< i
  ,dla_csb_clk //|< i
  ,global_clk_ovr_on //|< i
  ,tmc2slcg_disable_clock_gating //|< i
  ,dla_reset_rstn //|< i
  ,direct_reset_ //|< i
  ,test_mode //|< i
  ,csb2autosa_valid //|< i
  ,csb2autosa_ready //|> o
  ,csb2autosa_addr //|< i
  ,csb2autosa_wdat //|< i
  ,csb2autosa_write //|< i
  ,csb2autosa_nposted //|< i
  ,autosa2csb_valid //|> o
  ,autosa2csb_data //|> o
  ,autosa2csb_wr_complete //|> o
  ,autosa_core2dbb_aw_awvalid //|> o
  ,autosa_core2dbb_aw_awready //|< i
  ,autosa_core2dbb_aw_awid //|> o
  ,autosa_core2dbb_aw_awlen //|> o
  ,autosa_core2dbb_aw_awaddr //|> o
  ,autosa_core2dbb_w_wvalid //|> o
  ,autosa_core2dbb_w_wready //|< i
  ,autosa_core2dbb_w_wdata //|> o
  ,autosa_core2dbb_w_wstrb //|> o
  ,autosa_core2dbb_w_wlast //|> o
  ,autosa_core2dbb_b_bvalid //|< i
  ,autosa_core2dbb_b_bready //|> o
  ,autosa_core2dbb_b_bid //|< i
  ,autosa_core2dbb_ar_arvalid //|> o
  ,autosa_core2dbb_ar_arready //|< i
  ,autosa_core2dbb_ar_arid //|> o
  ,autosa_core2dbb_ar_arlen //|> o
  ,autosa_core2dbb_ar_araddr //|> o
  ,autosa_core2dbb_r_rvalid //|< i
  ,autosa_core2dbb_r_rready //|> o
  ,autosa_core2dbb_r_rid //|< i
  ,autosa_core2dbb_r_rlast //|< i
  ,autosa_core2dbb_r_rdata //|< i
  ,dla_intr //|> o
  ,autosa_pwrbus_ram_c_pd //|< i
  ,autosa_pwrbus_ram_ma_pd //|< i *
  ,autosa_pwrbus_ram_mb_pd //|< i *
  ,autosa_pwrbus_ram_p_pd //|< i
  ,autosa_pwrbus_ram_o_pd //|< i
  ,autosa_pwrbus_ram_a_pd //|< i
  );
////////////////////////////////////////////////////////////////////////////////
input dla_core_clk;
input dla_csb_clk;
input global_clk_ovr_on;
input tmc2slcg_disable_clock_gating;
input dla_reset_rstn;
input direct_reset_;
input test_mode;
//csb
input csb2autosa_valid;
output csb2autosa_ready;
input [15:0] csb2autosa_addr;
input [31:0] csb2autosa_wdat;
input csb2autosa_write;
input csb2autosa_nposted;
output autosa2csb_valid;
output [31:0] autosa2csb_data;
output autosa2csb_wr_complete;
///////////////
output autosa_core2dbb_aw_awvalid;
input autosa_core2dbb_aw_awready;
output [7:0] autosa_core2dbb_aw_awid;
output [3:0] autosa_core2dbb_aw_awlen;
output [32 -1:0] autosa_core2dbb_aw_awaddr;
output autosa_core2dbb_w_wvalid;
input autosa_core2dbb_w_wready;
output [64 -1:0] autosa_core2dbb_w_wdata;
output [64/8-1:0] autosa_core2dbb_w_wstrb;
output autosa_core2dbb_w_wlast;
output autosa_core2dbb_ar_arvalid;
input autosa_core2dbb_ar_arready;
output [7:0] autosa_core2dbb_ar_arid;
output [3:0] autosa_core2dbb_ar_arlen;
output [32 -1:0] autosa_core2dbb_ar_araddr;
input autosa_core2dbb_b_bvalid;
output autosa_core2dbb_b_bready;
input [7:0] autosa_core2dbb_b_bid;
input autosa_core2dbb_r_rvalid;
output autosa_core2dbb_r_rready;
input [7:0] autosa_core2dbb_r_rid;
input autosa_core2dbb_r_rlast;
input [64 -1:0] autosa_core2dbb_r_rdata;
output dla_intr;
input [31:0] autosa_pwrbus_ram_c_pd;
input [31:0] autosa_pwrbus_ram_ma_pd;
input [31:0] autosa_pwrbus_ram_mb_pd;
input [31:0] autosa_pwrbus_ram_p_pd;
input [31:0] autosa_pwrbus_ram_o_pd;
input [31:0] autosa_pwrbus_ram_a_pd;
////////////////////////////////////////////////////////////////////////////////
wire [2:0] accu2sc_credit_size;
wire accu2sc_credit_vld;
wire [33:0] cacc2csb_resp_pd;
wire cacc2csb_resp_valid;
wire [1:0] cacc2glb_done_intr_pd;
wire [1*32+2-1:0] cacc2sdp_pd;
wire cacc2sdp_ready;
wire cacc2sdp_valid;
wire [33:0] cdma2csb_resp_pd;
wire cdma2csb_resp_valid;
wire [1:0] cdma_dat2glb_done_intr_pd;
wire [1:0] cdma_wt2glb_done_intr_pd;
wire [33:0] cmac_a2csb_resp_pd;
wire cmac_a2csb_resp_valid;
wire [33:0] cmac_b2csb_resp_pd;
wire cmac_b2csb_resp_valid;
wire [62:0] csb2cdma_req_pd;
wire csb2cdma_req_prdy;
wire csb2cdma_req_pvld;
wire [62:0] csb2cacc_req_pd;
wire csb2cacc_req_prdy;
wire csb2cacc_req_pvld;
wire [62:0] csb2cmac_a_req_pd;
wire csb2cmac_a_req_prdy;
wire csb2cmac_a_req_pvld;
wire [62:0] csb2cmac_b_req_pd;
wire csb2cmac_b_req_prdy;
wire csb2cmac_b_req_pvld;
wire [62:0] csb2csc_req_pd;
wire csb2csc_req_prdy;
wire csb2csc_req_pvld;
wire [62:0] csb2sdp_rdma_req_pd;
wire csb2sdp_rdma_req_prdy;
wire csb2sdp_rdma_req_pvld;
wire [62:0] csb2sdp_req_pd;
wire csb2sdp_req_prdy;
wire csb2sdp_req_pvld;
wire [33:0] csc2csb_resp_pd;
wire csc2csb_resp_valid;
//: for(my $i=0; $i<8/2 ; $i++){
//: print qq(
//: wire [19 -1:0] mac_a2accu_data${i};
//: wire [19 -1:0] mac_b2accu_data${i};
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [19 -1:0] mac_a2accu_data0;
wire [19 -1:0] mac_b2accu_data0;

wire [19 -1:0] mac_a2accu_data1;
wire [19 -1:0] mac_b2accu_data1;

wire [19 -1:0] mac_a2accu_data2;
wire [19 -1:0] mac_b2accu_data2;

wire [19 -1:0] mac_a2accu_data3;
wire [19 -1:0] mac_b2accu_data3;

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [8/2-1:0] mac_a2accu_mask;
wire mac_a2accu_mode;
wire [8:0] mac_a2accu_pd;
wire mac_a2accu_pvld;
wire [8/2-1:0] mac_b2accu_mask;
wire mac_b2accu_mode;
wire [8:0] mac_b2accu_pd;
wire mac_b2accu_pvld;
wire [32 +14:0] cdma_dat2mcif_rd_req_pd;
wire cdma_dat2mcif_rd_req_ready;
wire cdma_dat2mcif_rd_req_valid;
wire [32 +14:0] cdma_wt2mcif_rd_req_pd;
wire cdma_wt2mcif_rd_req_ready;
wire cdma_wt2mcif_rd_req_valid;
wire [64 +(64/8/8)-1:0] mcif2cdma_dat_rd_rsp_pd;
wire mcif2cdma_dat_rd_rsp_ready;
wire mcif2cdma_dat_rd_rsp_valid;
wire [64 +(64/8/8)-1:0] mcif2cdma_wt_rd_rsp_pd;
wire mcif2cdma_wt_rd_rsp_ready;
wire mcif2cdma_wt_rd_rsp_valid;
  wire [64 +(64/8/8)-1:0] mcif2sdp_b_rd_rsp_pd;
  wire mcif2sdp_b_rd_rsp_ready;
  wire mcif2sdp_b_rd_rsp_valid;
  wire sdp_b2mcif_rd_cdt_lat_fifo_pop;
  wire [32 +14:0] sdp_b2mcif_rd_req_pd;
  wire sdp_b2mcif_rd_req_ready;
  wire sdp_b2mcif_rd_req_valid;
  wire [64 +(64/8/8)-1:0] mcif2sdp_n_rd_rsp_pd;
  wire mcif2sdp_n_rd_rsp_ready;
  wire mcif2sdp_n_rd_rsp_valid;
  wire sdp_n2mcif_rd_cdt_lat_fifo_pop;
  wire [32 +14:0] sdp_n2mcif_rd_req_pd;
  wire sdp_n2mcif_rd_req_ready;
  wire sdp_n2mcif_rd_req_valid;
wire [64 +(64/8/8)-1:0] mcif2sdp_rd_rsp_pd;
wire mcif2sdp_rd_rsp_ready;
wire mcif2sdp_rd_rsp_valid;
wire mcif2sdp_wr_rsp_complete;
wire sdp2mcif_rd_cdt_lat_fifo_pop;
wire [32 +14:0] sdp2mcif_rd_req_pd;
wire sdp2mcif_rd_req_ready;
wire sdp2mcif_rd_req_valid;
wire [64 +(64/8/8):0] sdp2mcif_wr_req_pd;
wire sdp2mcif_wr_req_ready;
wire sdp2mcif_wr_req_valid;
wire [33:0] sdp2csb_resp_pd;
wire sdp2csb_resp_valid;
wire [1:0] sdp2glb_done_intr_pd;
wire [1*8 -1:0] sdp2pdp_pd;
wire sdp2pdp_ready;
wire sdp2pdp_valid;
wire [33:0] sdp_rdma2csb_resp_pd;
wire sdp_rdma2csb_resp_valid;
wire autosa_clk_ovr_on;
wire autosa_core_rstn;
//: my $kk=8 -1;
//: foreach my $i (0..${kk}) {
//: print qq(
//: wire [8 -1:0] sc2mac_dat_a_data${i};
//: wire [8 -1:0] sc2mac_dat_b_data${i};
//: wire [8 -1:0] sc2mac_wt_a_data${i};
//: wire [8 -1:0] sc2mac_wt_b_data${i};
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [8 -1:0] sc2mac_dat_a_data0;
wire [8 -1:0] sc2mac_dat_b_data0;
wire [8 -1:0] sc2mac_wt_a_data0;
wire [8 -1:0] sc2mac_wt_b_data0;

wire [8 -1:0] sc2mac_dat_a_data1;
wire [8 -1:0] sc2mac_dat_b_data1;
wire [8 -1:0] sc2mac_wt_a_data1;
wire [8 -1:0] sc2mac_wt_b_data1;

wire [8 -1:0] sc2mac_dat_a_data2;
wire [8 -1:0] sc2mac_dat_b_data2;
wire [8 -1:0] sc2mac_wt_a_data2;
wire [8 -1:0] sc2mac_wt_b_data2;

wire [8 -1:0] sc2mac_dat_a_data3;
wire [8 -1:0] sc2mac_dat_b_data3;
wire [8 -1:0] sc2mac_wt_a_data3;
wire [8 -1:0] sc2mac_wt_b_data3;

wire [8 -1:0] sc2mac_dat_a_data4;
wire [8 -1:0] sc2mac_dat_b_data4;
wire [8 -1:0] sc2mac_wt_a_data4;
wire [8 -1:0] sc2mac_wt_b_data4;

wire [8 -1:0] sc2mac_dat_a_data5;
wire [8 -1:0] sc2mac_dat_b_data5;
wire [8 -1:0] sc2mac_wt_a_data5;
wire [8 -1:0] sc2mac_wt_b_data5;

wire [8 -1:0] sc2mac_dat_a_data6;
wire [8 -1:0] sc2mac_dat_b_data6;
wire [8 -1:0] sc2mac_wt_a_data6;
wire [8 -1:0] sc2mac_wt_b_data6;

wire [8 -1:0] sc2mac_dat_a_data7;
wire [8 -1:0] sc2mac_dat_b_data7;
wire [8 -1:0] sc2mac_wt_a_data7;
wire [8 -1:0] sc2mac_wt_b_data7;

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [8 -1:0] sc2mac_dat_a_mask;
wire [8:0] sc2mac_dat_a_pd;
wire sc2mac_dat_a_pvld;
wire [8 -1:0] sc2mac_dat_b_mask;
wire [8:0] sc2mac_dat_b_pd;
wire sc2mac_dat_b_pvld;
wire [8 -1:0] sc2mac_wt_a_mask;
wire sc2mac_wt_a_pvld;
wire [8/2-1:0] sc2mac_wt_a_sel;
wire [8 -1:0] sc2mac_wt_b_mask;
wire sc2mac_wt_b_pvld;
wire [8/2-1:0] sc2mac_wt_b_sel;
////////////////////////////////////////////////////////////////////////////////
   assign autosa_core2cvsram_aw_awvalid = 1'b0;
   assign autosa_core2cvsram_w_wvalid = 1'b0;
   assign autosa_core2cvsram_w_wlast = 1'b0;
   assign autosa_core2cvsram_b_bready = 1'b1;
   assign autosa_core2cvsram_r_rready = 1'b1;
////////////////////////////////////////////////////////////////////////
// AUTOSA Partition O //
////////////////////////////////////////////////////////////////////////
SA_AUTOSA_partition_o u_partition_o (
   .test_mode (test_mode)
  ,.direct_reset_ (direct_reset_)
  ,.global_clk_ovr_on (global_clk_ovr_on)
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
  ,.cacc2csb_resp_valid (cacc2csb_resp_valid)
  ,.cacc2csb_resp_pd (cacc2csb_resp_pd[33:0])
  ,.cacc2glb_done_intr_pd (cacc2glb_done_intr_pd[1:0])
  ,.csb2cacc_req_pvld (csb2cacc_req_pvld)
  ,.csb2cacc_req_prdy (csb2cacc_req_prdy)
  ,.csb2cacc_req_pd (csb2cacc_req_pd[62:0])
  ,.cmac_a2csb_resp_valid (cmac_a2csb_resp_valid)
  ,.cmac_a2csb_resp_pd (cmac_a2csb_resp_pd[33:0])
  ,.cmac_b2csb_resp_valid (cmac_b2csb_resp_valid)
  ,.cmac_b2csb_resp_pd (cmac_b2csb_resp_pd[33:0])
  ,.csb2cmac_a_req_pvld (csb2cmac_a_req_pvld)
  ,.csb2cmac_a_req_prdy (csb2cmac_a_req_prdy)
  ,.csb2cmac_a_req_pd (csb2cmac_a_req_pd[62:0])
  ,.csb2cmac_b_req_pvld (csb2cmac_b_req_pvld)
  ,.csb2cmac_b_req_prdy (csb2cmac_b_req_prdy)
  ,.csb2cmac_b_req_pd (csb2cmac_b_req_pd[62:0])
  ,.cdma2csb_resp_valid (cdma2csb_resp_valid)
  ,.cdma2csb_resp_pd (cdma2csb_resp_pd[33:0])
  ,.cdma_dat2glb_done_intr_pd (cdma_dat2glb_done_intr_pd[1:0])
  ,.cdma_dat2mcif_rd_req_valid (cdma_dat2mcif_rd_req_valid)
  ,.cdma_dat2mcif_rd_req_ready (cdma_dat2mcif_rd_req_ready)
  ,.cdma_dat2mcif_rd_req_pd (cdma_dat2mcif_rd_req_pd)
  ,.cdma_wt2glb_done_intr_pd (cdma_wt2glb_done_intr_pd[1:0])
  ,.cdma_wt2mcif_rd_req_valid (cdma_wt2mcif_rd_req_valid)
  ,.cdma_wt2mcif_rd_req_ready (cdma_wt2mcif_rd_req_ready)
  ,.cdma_wt2mcif_rd_req_pd (cdma_wt2mcif_rd_req_pd)
  ,.csb2cdma_req_pvld (csb2cdma_req_pvld)
  ,.csb2cdma_req_prdy (csb2cdma_req_prdy)
  ,.csb2cdma_req_pd (csb2cdma_req_pd[62:0])
  ,.csb2csc_req_pvld (csb2csc_req_pvld)
  ,.csb2csc_req_prdy (csb2csc_req_prdy)
  ,.csb2csc_req_pd (csb2csc_req_pd[62:0])
  ,.csb2autosa_valid (csb2autosa_valid)
  ,.csb2autosa_ready (csb2autosa_ready)
  ,.csb2autosa_addr (csb2autosa_addr[15:0])
  ,.csb2autosa_wdat (csb2autosa_wdat[31:0])
  ,.csb2autosa_write (csb2autosa_write)
  ,.csb2autosa_nposted (csb2autosa_nposted)
  ,.csb2sdp_rdma_req_pvld (csb2sdp_rdma_req_pvld)
  ,.csb2sdp_rdma_req_prdy (csb2sdp_rdma_req_prdy)
  ,.csb2sdp_rdma_req_pd (csb2sdp_rdma_req_pd[62:0])
  ,.csb2sdp_req_pvld (csb2sdp_req_pvld)
  ,.csb2sdp_req_prdy (csb2sdp_req_prdy)
  ,.csb2sdp_req_pd (csb2sdp_req_pd[62:0])
  ,.csc2csb_resp_valid (csc2csb_resp_valid)
  ,.csc2csb_resp_pd (csc2csb_resp_pd[33:0])
  ,.mcif2noc_axi_ar_arvalid (autosa_core2dbb_ar_arvalid)
  ,.mcif2noc_axi_ar_arready (autosa_core2dbb_ar_arready)
  ,.mcif2noc_axi_ar_arid (autosa_core2dbb_ar_arid[7:0])
  ,.mcif2noc_axi_ar_arlen (autosa_core2dbb_ar_arlen[3:0])
  ,.mcif2noc_axi_ar_araddr (autosa_core2dbb_ar_araddr)
  ,.mcif2noc_axi_aw_awvalid (autosa_core2dbb_aw_awvalid)
  ,.mcif2noc_axi_aw_awready (autosa_core2dbb_aw_awready)
  ,.mcif2noc_axi_aw_awid (autosa_core2dbb_aw_awid[7:0])
  ,.mcif2noc_axi_aw_awlen (autosa_core2dbb_aw_awlen[3:0])
  ,.mcif2noc_axi_aw_awaddr (autosa_core2dbb_aw_awaddr)
  ,.mcif2noc_axi_w_wvalid (autosa_core2dbb_w_wvalid)
  ,.mcif2noc_axi_w_wready (autosa_core2dbb_w_wready)
  ,.mcif2noc_axi_w_wdata (autosa_core2dbb_w_wdata)
  ,.mcif2noc_axi_w_wstrb (autosa_core2dbb_w_wstrb)
  ,.mcif2noc_axi_w_wlast (autosa_core2dbb_w_wlast)
  ,.noc2mcif_axi_b_bvalid (autosa_core2dbb_b_bvalid)
  ,.noc2mcif_axi_b_bready (autosa_core2dbb_b_bready)
  ,.noc2mcif_axi_b_bid (autosa_core2dbb_b_bid[7:0])
  ,.noc2mcif_axi_r_rvalid (autosa_core2dbb_r_rvalid)
  ,.noc2mcif_axi_r_rready (autosa_core2dbb_r_rready)
  ,.noc2mcif_axi_r_rid (autosa_core2dbb_r_rid[7:0])
  ,.noc2mcif_axi_r_rlast (autosa_core2dbb_r_rlast)
  ,.noc2mcif_axi_r_rdata (autosa_core2dbb_r_rdata)
  ,.mcif2cdma_dat_rd_rsp_valid (mcif2cdma_dat_rd_rsp_valid)
  ,.mcif2cdma_dat_rd_rsp_ready (mcif2cdma_dat_rd_rsp_ready)
  ,.mcif2cdma_dat_rd_rsp_pd (mcif2cdma_dat_rd_rsp_pd)
  ,.mcif2cdma_wt_rd_rsp_valid (mcif2cdma_wt_rd_rsp_valid)
  ,.mcif2cdma_wt_rd_rsp_ready (mcif2cdma_wt_rd_rsp_ready)
  ,.mcif2cdma_wt_rd_rsp_pd (mcif2cdma_wt_rd_rsp_pd)
  ,.mcif2sdp_b_rd_rsp_valid (mcif2sdp_b_rd_rsp_valid)
  ,.mcif2sdp_b_rd_rsp_ready (mcif2sdp_b_rd_rsp_ready)
  ,.mcif2sdp_b_rd_rsp_pd (mcif2sdp_b_rd_rsp_pd)
  ,.sdp_b2mcif_rd_cdt_lat_fifo_pop (sdp_b2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp_b2mcif_rd_req_valid (sdp_b2mcif_rd_req_valid)
  ,.sdp_b2mcif_rd_req_ready (sdp_b2mcif_rd_req_ready)
  ,.sdp_b2mcif_rd_req_pd (sdp_b2mcif_rd_req_pd)
  ,.mcif2sdp_n_rd_rsp_valid (mcif2sdp_n_rd_rsp_valid)
  ,.mcif2sdp_n_rd_rsp_ready (mcif2sdp_n_rd_rsp_ready)
  ,.mcif2sdp_n_rd_rsp_pd (mcif2sdp_n_rd_rsp_pd)
  ,.sdp_n2mcif_rd_cdt_lat_fifo_pop (sdp_n2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp_n2mcif_rd_req_valid (sdp_n2mcif_rd_req_valid)
  ,.sdp_n2mcif_rd_req_ready (sdp_n2mcif_rd_req_ready)
  ,.sdp_n2mcif_rd_req_pd (sdp_n2mcif_rd_req_pd)
  ,.mcif2sdp_rd_rsp_valid (mcif2sdp_rd_rsp_valid)
  ,.mcif2sdp_rd_rsp_ready (mcif2sdp_rd_rsp_ready)
  ,.mcif2sdp_rd_rsp_pd (mcif2sdp_rd_rsp_pd)
  ,.mcif2sdp_wr_rsp_complete (mcif2sdp_wr_rsp_complete)
  ,.sdp2mcif_rd_cdt_lat_fifo_pop (sdp2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp2mcif_rd_req_valid (sdp2mcif_rd_req_valid)
  ,.sdp2mcif_rd_req_ready (sdp2mcif_rd_req_ready)
  ,.sdp2mcif_rd_req_pd (sdp2mcif_rd_req_pd)
  ,.sdp2mcif_wr_req_valid (sdp2mcif_wr_req_valid)
  ,.sdp2mcif_wr_req_ready (sdp2mcif_wr_req_ready)
  ,.sdp2mcif_wr_req_pd (sdp2mcif_wr_req_pd)
  ,.autosa2csb_valid (autosa2csb_valid)
  ,.autosa2csb_data (autosa2csb_data[31:0])
  ,.autosa2csb_wr_complete (autosa2csb_wr_complete)
  ,.core_intr (dla_intr)
  ,.pwrbus_ram_pd (autosa_pwrbus_ram_o_pd[31:0])
  ,.sdp2csb_resp_valid (sdp2csb_resp_valid)
  ,.sdp2csb_resp_pd (sdp2csb_resp_pd[33:0])
  ,.sdp2glb_done_intr_pd (sdp2glb_done_intr_pd[1:0])
  ,.sdp2pdp_valid (sdp2pdp_valid)
  ,.sdp2pdp_ready (sdp2pdp_ready)
  ,.sdp2pdp_pd (sdp2pdp_pd)
  ,.sdp_rdma2csb_resp_valid (sdp_rdma2csb_resp_valid)
  ,.sdp_rdma2csb_resp_pd (sdp_rdma2csb_resp_pd[33:0])
  ,.autosa_core_clk (dla_core_clk)
  ,.dla_reset_rstn (dla_reset_rstn)
  ,.autosa_core_rstn (autosa_core_rstn)
  ,.autosa_falcon_clk (dla_csb_clk)
  ,.autosa_clk_ovr_on (autosa_clk_ovr_on)
  );
////////////////////////////////////////////////////////////////////////
// AUTOSA Partition C //
////////////////////////////////////////////////////////////////////////
SA_AUTOSA_partition_c u_partition_c (
   .test_mode (test_mode)
  ,.direct_reset_ (direct_reset_)
  ,.global_clk_ovr_on (global_clk_ovr_on)
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
  ,.accu2sc_credit_vld (accu2sc_credit_vld)
  ,.accu2sc_credit_size (accu2sc_credit_size[2:0])
  ,.cdma2csb_resp_valid (cdma2csb_resp_valid)
  ,.cdma2csb_resp_pd (cdma2csb_resp_pd[33:0])
  ,.cdma_dat2glb_done_intr_pd (cdma_dat2glb_done_intr_pd[1:0])
  ,.cdma_dat2mcif_rd_req_valid (cdma_dat2mcif_rd_req_valid)
  ,.cdma_dat2mcif_rd_req_ready (cdma_dat2mcif_rd_req_ready)
  ,.cdma_dat2mcif_rd_req_pd (cdma_dat2mcif_rd_req_pd)
  ,.cdma_wt2glb_done_intr_pd (cdma_wt2glb_done_intr_pd[1:0])
  ,.cdma_wt2mcif_rd_req_valid (cdma_wt2mcif_rd_req_valid)
  ,.cdma_wt2mcif_rd_req_ready (cdma_wt2mcif_rd_req_ready)
  ,.cdma_wt2mcif_rd_req_pd (cdma_wt2mcif_rd_req_pd)
  ,.csb2cdma_req_pvld (csb2cdma_req_pvld)
  ,.csb2cdma_req_prdy (csb2cdma_req_prdy)
  ,.csb2cdma_req_pd (csb2cdma_req_pd[62:0])
  ,.csb2csc_req_pvld (csb2csc_req_pvld)
  ,.csb2csc_req_prdy (csb2csc_req_prdy)
  ,.csb2csc_req_pd (csb2csc_req_pd[62:0])
  ,.csc2csb_resp_valid (csc2csb_resp_valid)
  ,.csc2csb_resp_pd (csc2csb_resp_pd[33:0])
  ,.mcif2cdma_dat_rd_rsp_valid (mcif2cdma_dat_rd_rsp_valid)
  ,.mcif2cdma_dat_rd_rsp_ready (mcif2cdma_dat_rd_rsp_ready)
  ,.mcif2cdma_dat_rd_rsp_pd (mcif2cdma_dat_rd_rsp_pd)
  ,.mcif2cdma_wt_rd_rsp_valid (mcif2cdma_wt_rd_rsp_valid)
  ,.mcif2cdma_wt_rd_rsp_ready (mcif2cdma_wt_rd_rsp_ready)
  ,.mcif2cdma_wt_rd_rsp_pd (mcif2cdma_wt_rd_rsp_pd)
  ,.pwrbus_ram_pd (autosa_pwrbus_ram_c_pd[31:0])
  ,.sc2mac_dat_a_pvld (sc2mac_dat_a_pvld)
  ,.sc2mac_dat_a_mask (sc2mac_dat_a_mask[8 -1:0])
//: my $kk=8 -1;
//: foreach my $i (0..${kk}){
//: print qq(
//: ,.sc2mac_dat_a_data${i} (sc2mac_dat_a_data${i})
//: ,.sc2mac_dat_b_data${i} (sc2mac_dat_b_data${i})
//: ,.sc2mac_wt_a_data${i} (sc2mac_wt_a_data${i})
//: ,.sc2mac_wt_b_data${i} (sc2mac_wt_b_data${i})
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.sc2mac_dat_a_data0 (sc2mac_dat_a_data0)
,.sc2mac_dat_b_data0 (sc2mac_dat_b_data0)
,.sc2mac_wt_a_data0 (sc2mac_wt_a_data0)
,.sc2mac_wt_b_data0 (sc2mac_wt_b_data0)

,.sc2mac_dat_a_data1 (sc2mac_dat_a_data1)
,.sc2mac_dat_b_data1 (sc2mac_dat_b_data1)
,.sc2mac_wt_a_data1 (sc2mac_wt_a_data1)
,.sc2mac_wt_b_data1 (sc2mac_wt_b_data1)

,.sc2mac_dat_a_data2 (sc2mac_dat_a_data2)
,.sc2mac_dat_b_data2 (sc2mac_dat_b_data2)
,.sc2mac_wt_a_data2 (sc2mac_wt_a_data2)
,.sc2mac_wt_b_data2 (sc2mac_wt_b_data2)

,.sc2mac_dat_a_data3 (sc2mac_dat_a_data3)
,.sc2mac_dat_b_data3 (sc2mac_dat_b_data3)
,.sc2mac_wt_a_data3 (sc2mac_wt_a_data3)
,.sc2mac_wt_b_data3 (sc2mac_wt_b_data3)

,.sc2mac_dat_a_data4 (sc2mac_dat_a_data4)
,.sc2mac_dat_b_data4 (sc2mac_dat_b_data4)
,.sc2mac_wt_a_data4 (sc2mac_wt_a_data4)
,.sc2mac_wt_b_data4 (sc2mac_wt_b_data4)

,.sc2mac_dat_a_data5 (sc2mac_dat_a_data5)
,.sc2mac_dat_b_data5 (sc2mac_dat_b_data5)
,.sc2mac_wt_a_data5 (sc2mac_wt_a_data5)
,.sc2mac_wt_b_data5 (sc2mac_wt_b_data5)

,.sc2mac_dat_a_data6 (sc2mac_dat_a_data6)
,.sc2mac_dat_b_data6 (sc2mac_dat_b_data6)
,.sc2mac_wt_a_data6 (sc2mac_wt_a_data6)
,.sc2mac_wt_b_data6 (sc2mac_wt_b_data6)

,.sc2mac_dat_a_data7 (sc2mac_dat_a_data7)
,.sc2mac_dat_b_data7 (sc2mac_dat_b_data7)
,.sc2mac_wt_a_data7 (sc2mac_wt_a_data7)
,.sc2mac_wt_b_data7 (sc2mac_wt_b_data7)

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.sc2mac_dat_a_pd (sc2mac_dat_a_pd[8:0])
  ,.sc2mac_dat_b_pvld (sc2mac_dat_b_pvld)
  ,.sc2mac_dat_b_mask (sc2mac_dat_b_mask[8 -1:0])
  ,.sc2mac_dat_b_pd (sc2mac_dat_b_pd[8:0])
  ,.sc2mac_wt_a_pvld (sc2mac_wt_a_pvld)
  ,.sc2mac_wt_a_mask (sc2mac_wt_a_mask[8 -1:0])
  ,.sc2mac_wt_a_sel (sc2mac_wt_a_sel[8/2-1:0])
  ,.sc2mac_wt_b_pvld (sc2mac_wt_b_pvld)
  ,.sc2mac_wt_b_mask (sc2mac_wt_b_mask[8 -1:0])
  ,.sc2mac_wt_b_sel (sc2mac_wt_b_sel[8/2-1:0])
  ,.autosa_core_clk (dla_core_clk)
  ,.dla_reset_rstn (autosa_core_rstn)
  ,.autosa_clk_ovr_on (autosa_clk_ovr_on)
  );
//&Connect /autosa_obs/ autosa_pwrpart_c_obs;
////////////////////////////////////////////////////////////////////////
// AUTOSA Partition MA //
////////////////////////////////////////////////////////////////////////
SA_AUTOSA_partition_m u_partition_ma (
   .test_mode (test_mode)
  ,.direct_reset_ (direct_reset_)
  ,.csb2cmac_a_req_pvld (csb2cmac_a_req_pvld) //|< w
  ,.csb2cmac_a_req_prdy (csb2cmac_a_req_prdy) //|> w
  ,.csb2cmac_a_req_pd (csb2cmac_a_req_pd) //|< w
  ,.cmac_a2csb_resp_valid (cmac_a2csb_resp_valid) //|> w
  ,.cmac_a2csb_resp_pd (cmac_a2csb_resp_pd) //|> w
  ,.sc2mac_wt_pvld (sc2mac_wt_a_pvld) //|< w
  ,.sc2mac_wt_mask (sc2mac_wt_a_mask) //|< w
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: ,.sc2mac_wt_data${i} (sc2mac_wt_a_data${i}) //|< w )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.sc2mac_wt_data0 (sc2mac_wt_a_data0) //|< w 
,.sc2mac_wt_data1 (sc2mac_wt_a_data1) //|< w 
,.sc2mac_wt_data2 (sc2mac_wt_a_data2) //|< w 
,.sc2mac_wt_data3 (sc2mac_wt_a_data3) //|< w 
,.sc2mac_wt_data4 (sc2mac_wt_a_data4) //|< w 
,.sc2mac_wt_data5 (sc2mac_wt_a_data5) //|< w 
,.sc2mac_wt_data6 (sc2mac_wt_a_data6) //|< w 
,.sc2mac_wt_data7 (sc2mac_wt_a_data7) //|< w 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.sc2mac_wt_sel (sc2mac_wt_a_sel) //|< w
  ,.sc2mac_dat_pvld (sc2mac_dat_a_pvld) //|< w
  ,.sc2mac_dat_mask (sc2mac_dat_a_mask) //|< w
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: ,.sc2mac_dat_data${i} (sc2mac_dat_a_data${i}) //|< w )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.sc2mac_dat_data0 (sc2mac_dat_a_data0) //|< w 
,.sc2mac_dat_data1 (sc2mac_dat_a_data1) //|< w 
,.sc2mac_dat_data2 (sc2mac_dat_a_data2) //|< w 
,.sc2mac_dat_data3 (sc2mac_dat_a_data3) //|< w 
,.sc2mac_dat_data4 (sc2mac_dat_a_data4) //|< w 
,.sc2mac_dat_data5 (sc2mac_dat_a_data5) //|< w 
,.sc2mac_dat_data6 (sc2mac_dat_a_data6) //|< w 
,.sc2mac_dat_data7 (sc2mac_dat_a_data7) //|< w 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.sc2mac_dat_pd (sc2mac_dat_a_pd) //|< w
  ,.mac2accu_pvld (mac_a2accu_pvld) //|> w
  ,.mac2accu_mask (mac_a2accu_mask) //|> w
  ,.mac2accu_mode (mac_a2accu_mode) //|> w
//: for(my $i=0; $i<8/2 ; $i++){
//: print qq(
//: ,.mac2accu_data${i} (mac_a2accu_data${i}) //|> w )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.mac2accu_data0 (mac_a2accu_data0) //|> w 
,.mac2accu_data1 (mac_a2accu_data1) //|> w 
,.mac2accu_data2 (mac_a2accu_data2) //|> w 
,.mac2accu_data3 (mac_a2accu_data3) //|> w 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.mac2accu_pd (mac_a2accu_pd) //|> w
  ,.global_clk_ovr_on (global_clk_ovr_on)
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
  ,.autosa_core_clk (dla_core_clk)
  ,.dla_reset_rstn (autosa_core_rstn)
  ,.autosa_clk_ovr_on (autosa_clk_ovr_on)
  );
////////////////////////////////////////////////////////////////////////
// AUTOSA Partition MB //
////////////////////////////////////////////////////////////////////////
SA_AUTOSA_partition_m u_partition_mb (
   .test_mode (test_mode)
  ,.direct_reset_ (direct_reset_)
  ,.csb2cmac_a_req_pvld (csb2cmac_b_req_pvld) //|< w
  ,.csb2cmac_a_req_prdy (csb2cmac_b_req_prdy) //|> w
  ,.csb2cmac_a_req_pd (csb2cmac_b_req_pd) //|< w
  ,.cmac_a2csb_resp_valid (cmac_b2csb_resp_valid) //|> w
  ,.cmac_a2csb_resp_pd (cmac_b2csb_resp_pd) //|> w
  ,.sc2mac_wt_pvld (sc2mac_wt_b_pvld) //|< w
  ,.sc2mac_wt_mask (sc2mac_wt_b_mask) //|< w
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: ,.sc2mac_wt_data${i} (sc2mac_wt_b_data${i}) //|< w )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.sc2mac_wt_data0 (sc2mac_wt_b_data0) //|< w 
,.sc2mac_wt_data1 (sc2mac_wt_b_data1) //|< w 
,.sc2mac_wt_data2 (sc2mac_wt_b_data2) //|< w 
,.sc2mac_wt_data3 (sc2mac_wt_b_data3) //|< w 
,.sc2mac_wt_data4 (sc2mac_wt_b_data4) //|< w 
,.sc2mac_wt_data5 (sc2mac_wt_b_data5) //|< w 
,.sc2mac_wt_data6 (sc2mac_wt_b_data6) //|< w 
,.sc2mac_wt_data7 (sc2mac_wt_b_data7) //|< w 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.sc2mac_wt_sel (sc2mac_wt_b_sel) //|< w
  ,.sc2mac_dat_pvld (sc2mac_dat_b_pvld) //|< w
  ,.sc2mac_dat_mask (sc2mac_dat_b_mask) //|< w
//: for(my $i=0; $i<8 ; $i++){
//: print qq(
//: ,.sc2mac_dat_data${i} (sc2mac_dat_b_data${i}) //|< w )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.sc2mac_dat_data0 (sc2mac_dat_b_data0) //|< w 
,.sc2mac_dat_data1 (sc2mac_dat_b_data1) //|< w 
,.sc2mac_dat_data2 (sc2mac_dat_b_data2) //|< w 
,.sc2mac_dat_data3 (sc2mac_dat_b_data3) //|< w 
,.sc2mac_dat_data4 (sc2mac_dat_b_data4) //|< w 
,.sc2mac_dat_data5 (sc2mac_dat_b_data5) //|< w 
,.sc2mac_dat_data6 (sc2mac_dat_b_data6) //|< w 
,.sc2mac_dat_data7 (sc2mac_dat_b_data7) //|< w 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.sc2mac_dat_pd (sc2mac_dat_b_pd) //|< w
  ,.mac2accu_pvld (mac_b2accu_pvld) //|> w
  ,.mac2accu_mask (mac_b2accu_mask) //|> w
  ,.mac2accu_mode (mac_b2accu_mode) //|> w
//: for(my $i=0; $i<8/2 ; $i++){
//: print qq(
//: ,.mac2accu_data${i} (mac_b2accu_data${i}) //|> w )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.mac2accu_data0 (mac_b2accu_data0) //|> w 
,.mac2accu_data1 (mac_b2accu_data1) //|> w 
,.mac2accu_data2 (mac_b2accu_data2) //|> w 
,.mac2accu_data3 (mac_b2accu_data3) //|> w 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.mac2accu_pd (mac_b2accu_pd) //|> w
  ,.global_clk_ovr_on (global_clk_ovr_on)
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
  ,.autosa_core_clk (dla_core_clk)
  ,.dla_reset_rstn (autosa_core_rstn)
  ,.autosa_clk_ovr_on (autosa_clk_ovr_on)
  );
////////////////////////////////////////////////////////////////////////
// AUTOSA Partition A //
////////////////////////////////////////////////////////////////////////
SA_AUTOSA_partition_a u_partition_a (
   .test_mode (test_mode)
  ,.direct_reset_ (direct_reset_)
  ,.global_clk_ovr_on (global_clk_ovr_on)
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
  ,.accu2sc_credit_vld (accu2sc_credit_vld)
  ,.accu2sc_credit_size (accu2sc_credit_size[2:0])
  ,.csb2cacc_req_pvld (csb2cacc_req_pvld)
  ,.csb2cacc_req_prdy (csb2cacc_req_prdy)
  ,.csb2cacc_req_pd (csb2cacc_req_pd[62:0])
  ,.cacc2csb_resp_valid (cacc2csb_resp_valid)
  ,.cacc2csb_resp_pd (cacc2csb_resp_pd[33:0])
  ,.cacc2glb_done_intr_pd (cacc2glb_done_intr_pd[1:0])
  ,.cacc2sdp_valid (cacc2sdp_valid)
  ,.cacc2sdp_ready (cacc2sdp_ready)
  ,.cacc2sdp_pd (cacc2sdp_pd)
  ,.mac_a2accu_pvld (mac_a2accu_pvld)
  ,.mac_a2accu_mask (mac_a2accu_mask[8/2-1:0])
  ,.mac_a2accu_mode (mac_a2accu_mode)
//: for(my $i=0; $i<8/2 ; $i++){
//: print qq(
//: ,.mac_a2accu_data${i} (mac_a2accu_data${i}[19 -1:0]) )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.mac_a2accu_data0 (mac_a2accu_data0[19 -1:0]) 
,.mac_a2accu_data1 (mac_a2accu_data1[19 -1:0]) 
,.mac_a2accu_data2 (mac_a2accu_data2[19 -1:0]) 
,.mac_a2accu_data3 (mac_a2accu_data3[19 -1:0]) 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.mac_a2accu_pd (mac_a2accu_pd[8:0])
  ,.mac_b2accu_pvld (mac_b2accu_pvld)
  ,.mac_b2accu_mask (mac_b2accu_mask[8/2-1:0])
  ,.mac_b2accu_mode (mac_b2accu_mode)
//: for(my $i=0; $i<8/2 ; $i++){
//: print qq(
//: ,.mac_b2accu_data${i} (mac_b2accu_data${i}[19 -1:0]) )
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.mac_b2accu_data0 (mac_b2accu_data0[19 -1:0]) 
,.mac_b2accu_data1 (mac_b2accu_data1[19 -1:0]) 
,.mac_b2accu_data2 (mac_b2accu_data2[19 -1:0]) 
,.mac_b2accu_data3 (mac_b2accu_data3[19 -1:0]) 
//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.mac_b2accu_pd (mac_b2accu_pd[8:0])
  ,.pwrbus_ram_pd (autosa_pwrbus_ram_a_pd[31:0])
  ,.autosa_core_clk (dla_core_clk)
  ,.dla_reset_rstn (autosa_core_rstn)
  ,.autosa_clk_ovr_on (autosa_clk_ovr_on)
  );
////////////////////////////////////////////////////////////////////////
// AUTOSA Partition P //
////////////////////////////////////////////////////////////////////////
SA_AUTOSA_partition_p u_partition_p (
   .test_mode (test_mode)
  ,.direct_reset_ (direct_reset_)
  ,.global_clk_ovr_on (global_clk_ovr_on)
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
  ,.cacc2sdp_valid (cacc2sdp_valid)
  ,.cacc2sdp_ready (cacc2sdp_ready)
  ,.cacc2sdp_pd (cacc2sdp_pd)
  ,.csb2sdp_rdma_req_pvld (csb2sdp_rdma_req_pvld)
  ,.csb2sdp_rdma_req_prdy (csb2sdp_rdma_req_prdy)
  ,.csb2sdp_rdma_req_pd (csb2sdp_rdma_req_pd[62:0])
  ,.csb2sdp_req_pvld (csb2sdp_req_pvld)
  ,.csb2sdp_req_prdy (csb2sdp_req_prdy)
  ,.csb2sdp_req_pd (csb2sdp_req_pd[62:0])
  ,.sdp_b2mcif_rd_cdt_lat_fifo_pop (sdp_b2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp_b2mcif_rd_req_valid (sdp_b2mcif_rd_req_valid)
  ,.sdp_b2mcif_rd_req_ready (sdp_b2mcif_rd_req_ready)
  ,.sdp_b2mcif_rd_req_pd (sdp_b2mcif_rd_req_pd )
  ,.mcif2sdp_b_rd_rsp_valid (mcif2sdp_b_rd_rsp_valid)
  ,.mcif2sdp_b_rd_rsp_ready (mcif2sdp_b_rd_rsp_ready)
  ,.mcif2sdp_b_rd_rsp_pd (mcif2sdp_b_rd_rsp_pd )
  ,.sdp_n2mcif_rd_cdt_lat_fifo_pop (sdp_n2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp_n2mcif_rd_req_valid (sdp_n2mcif_rd_req_valid)
  ,.sdp_n2mcif_rd_req_ready (sdp_n2mcif_rd_req_ready)
  ,.sdp_n2mcif_rd_req_pd (sdp_n2mcif_rd_req_pd )
  ,.mcif2sdp_n_rd_rsp_valid (mcif2sdp_n_rd_rsp_valid)
  ,.mcif2sdp_n_rd_rsp_ready (mcif2sdp_n_rd_rsp_ready)
  ,.mcif2sdp_n_rd_rsp_pd (mcif2sdp_n_rd_rsp_pd )
  ,.mcif2sdp_rd_rsp_valid (mcif2sdp_rd_rsp_valid)
  ,.mcif2sdp_rd_rsp_ready (mcif2sdp_rd_rsp_ready)
  ,.mcif2sdp_rd_rsp_pd (mcif2sdp_rd_rsp_pd )
  ,.mcif2sdp_wr_rsp_complete (mcif2sdp_wr_rsp_complete)
  ,.pwrbus_ram_pd (autosa_pwrbus_ram_p_pd[31:0])
  ,.sdp2csb_resp_valid (sdp2csb_resp_valid)
  ,.sdp2csb_resp_pd (sdp2csb_resp_pd[33:0])
  ,.sdp2glb_done_intr_pd (sdp2glb_done_intr_pd[1:0])
  ,.sdp2mcif_rd_cdt_lat_fifo_pop (sdp2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp2mcif_rd_req_valid (sdp2mcif_rd_req_valid)
  ,.sdp2mcif_rd_req_ready (sdp2mcif_rd_req_ready)
  ,.sdp2mcif_rd_req_pd (sdp2mcif_rd_req_pd )
  ,.sdp2mcif_wr_req_valid (sdp2mcif_wr_req_valid)
  ,.sdp2mcif_wr_req_ready (sdp2mcif_wr_req_ready)
  ,.sdp2mcif_wr_req_pd (sdp2mcif_wr_req_pd )
  ,.sdp2pdp_valid (sdp2pdp_valid)
  ,.sdp2pdp_ready (sdp2pdp_ready)
  ,.sdp2pdp_pd (sdp2pdp_pd )
  ,.sdp_rdma2csb_resp_valid (sdp_rdma2csb_resp_valid)
  ,.sdp_rdma2csb_resp_pd (sdp_rdma2csb_resp_pd[33:0])
  ,.autosa_core_clk (dla_core_clk)
  ,.dla_reset_rstn (autosa_core_rstn)
  ,.autosa_clk_ovr_on (autosa_clk_ovr_on)
  );
endmodule // SA_autosa