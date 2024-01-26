// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_partition_p.v
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
// ================================================================
// AUTOSA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_CMAC.h
`define DESIGNWARE_NOEXIST 1
`include "SA_HWACC_AUTOSA_tick_defines.vh"
module SA_AUTOSA_partition_p (
   cacc2sdp_pd //|< i
  ,cacc2sdp_valid //|< i
  ,csb2sdp_rdma_req_pd //|< i
  ,csb2sdp_rdma_req_pvld //|< i
  ,csb2sdp_req_pd //|< i
  ,csb2sdp_req_pvld //|< i
  ,direct_reset_ //|< i
  ,dla_reset_rstn //|< i
  ,global_clk_ovr_on //|< i
  ,autosa_clk_ovr_on //|< i
  ,autosa_core_clk //|< i
  ,pwrbus_ram_pd //|< i
  ,sdp_b2mcif_rd_cdt_lat_fifo_pop //|> o
  ,sdp_b2mcif_rd_req_pd //|> o
  ,sdp_b2mcif_rd_req_valid //|> o
  ,sdp_b2mcif_rd_req_ready //|< i
  ,mcif2sdp_b_rd_rsp_pd //|< i
  ,mcif2sdp_b_rd_rsp_valid //|< i
  ,mcif2sdp_b_rd_rsp_ready //|> o
  ,sdp_n2mcif_rd_cdt_lat_fifo_pop //|> o
  ,sdp_n2mcif_rd_req_pd //|> o
  ,sdp_n2mcif_rd_req_valid //|> o
  ,sdp_n2mcif_rd_req_ready //|< i
  ,mcif2sdp_n_rd_rsp_pd //|< i
  ,mcif2sdp_n_rd_rsp_valid //|< i
  ,mcif2sdp_n_rd_rsp_ready //|> o
  ,mcif2sdp_rd_rsp_pd //|< i
  ,mcif2sdp_rd_rsp_valid //|< i
  ,mcif2sdp_wr_rsp_complete //|< i
  ,sdp2mcif_rd_req_ready //|< i
  ,sdp2mcif_wr_req_ready //|< i
  ,mcif2sdp_rd_rsp_ready //|> o
  ,sdp2mcif_rd_cdt_lat_fifo_pop //|> o
  ,sdp2mcif_rd_req_pd //|> o
  ,sdp2mcif_rd_req_valid //|> o
  ,sdp2mcif_wr_req_pd //|> o
  ,sdp2mcif_wr_req_valid //|> o
  ,sdp2pdp_ready //|< i
  ,test_mode //|< i
  ,tmc2slcg_disable_clock_gating //|< i
  ,cacc2sdp_ready //|> o
  ,csb2sdp_rdma_req_prdy //|> o
  ,csb2sdp_req_prdy //|> o
  ,sdp2csb_resp_pd //|> o
  ,sdp2csb_resp_valid //|> o
  ,sdp2glb_done_intr_pd //|> o
  ,sdp2pdp_pd //|> o
  ,sdp2pdp_valid //|> o
  ,sdp_rdma2csb_resp_pd //|> o
  ,sdp_rdma2csb_resp_valid //|> o
  );
//
// SA_AUTOSA_partition_p_io.v
//
input test_mode;
input direct_reset_;
input global_clk_ovr_on;
input tmc2slcg_disable_clock_gating;
input cacc2sdp_valid; /* data valid */
output cacc2sdp_ready; /* data return handshake */
input [1*32+2-1:0] cacc2sdp_pd;
input csb2sdp_rdma_req_pvld; /* data valid */
output csb2sdp_rdma_req_prdy; /* data return handshake */
input [62:0] csb2sdp_rdma_req_pd;
input csb2sdp_req_pvld; /* data valid */
output csb2sdp_req_prdy; /* data return handshake */
input [62:0] csb2sdp_req_pd;
input [31:0] pwrbus_ram_pd;
output sdp2csb_resp_valid; /* data valid */
output [33:0] sdp2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
output [1:0] sdp2glb_done_intr_pd;
output sdp_b2mcif_rd_cdt_lat_fifo_pop;
output sdp_b2mcif_rd_req_valid; /* data valid */
input sdp_b2mcif_rd_req_ready; /* data return handshake */
output [32 +14:0] sdp_b2mcif_rd_req_pd;
input mcif2sdp_b_rd_rsp_valid; /* data valid */
output mcif2sdp_b_rd_rsp_ready; /* data return handshake */
input [64 +(64/8/8)-1:0] mcif2sdp_b_rd_rsp_pd;
output sdp_n2mcif_rd_cdt_lat_fifo_pop;
output sdp_n2mcif_rd_req_valid; /* data valid */
input sdp_n2mcif_rd_req_ready; /* data return handshake */
output [32 +14:0] sdp_n2mcif_rd_req_pd;
input mcif2sdp_n_rd_rsp_valid; /* data valid */
output mcif2sdp_n_rd_rsp_ready; /* data return handshake */
input [64 +(64/8/8)-1:0] mcif2sdp_n_rd_rsp_pd;
output sdp2mcif_rd_cdt_lat_fifo_pop;
input mcif2sdp_rd_rsp_valid;
output mcif2sdp_rd_rsp_ready;
input [64 +(64/8/8)-1:0] mcif2sdp_rd_rsp_pd;
output sdp2mcif_rd_req_valid;
input sdp2mcif_rd_req_ready;
output [32 +14:0] sdp2mcif_rd_req_pd;
output sdp2mcif_wr_req_valid;
input sdp2mcif_wr_req_ready;
output [64 +(64/8/8):0] sdp2mcif_wr_req_pd;
input mcif2sdp_wr_rsp_complete;
output sdp2pdp_valid;
input sdp2pdp_ready;
output [1*8 -1:0] sdp2pdp_pd;
output sdp_rdma2csb_resp_valid;
output [33:0] sdp_rdma2csb_resp_pd;
//input la_r_clk;
//input larstn;
input autosa_core_clk;
input dla_reset_rstn;
input autosa_clk_ovr_on;
wire dla_clk_ovr_on_sync;
wire global_clk_ovr_on_sync;
wire autosa_core_rstn;
////////////////////////////////////////////////////////////////////////
// AUTOSA Partition P: Reset Syncer //
////////////////////////////////////////////////////////////////////////
SA_AUTOSA_reset u_partition_p_reset (
   .dla_reset_rstn (dla_reset_rstn)
  ,.direct_reset_ (direct_reset_)
  ,.test_mode (test_mode)
  ,.synced_rstn (autosa_core_rstn)
  ,.autosa_clk (autosa_core_clk)
  );
////////////////////////////////////////////////////////////////////////
// Sync for SLCG
////////////////////////////////////////////////////////////////////////
SA_AUTOSA_sa_sync3d u_dla_clk_ovr_on_sync (
   .clk (autosa_core_clk)
  ,.sync_i (autosa_clk_ovr_on)
  ,.sync_o (dla_clk_ovr_on_sync)
  );
SA_AUTOSA_sa_sync3d_s u_global_clk_ovr_on_sync (
   .clk (autosa_core_clk)
  ,.prst (autosa_core_rstn)
  ,.sync_i (global_clk_ovr_on)
  ,.sync_o (global_clk_ovr_on_sync)
  );
////////////////////////////////////////////////////////////////////////
// AUTOSA Partition P: Single Data Processor //
////////////////////////////////////////////////////////////////////////
SA_AUTOSA_sdp u_SA_AUTOSA_sdp (
   .autosa_core_clk (autosa_core_clk)
  ,.autosa_core_rstn (autosa_core_rstn)
  ,.cacc2sdp_valid (cacc2sdp_valid)
  ,.cacc2sdp_ready (cacc2sdp_ready)
  ,.cacc2sdp_pd (cacc2sdp_pd)
  ,.csb2sdp_rdma_req_pvld (csb2sdp_rdma_req_pvld)
  ,.csb2sdp_rdma_req_prdy (csb2sdp_rdma_req_prdy)
  ,.csb2sdp_rdma_req_pd (csb2sdp_rdma_req_pd)
  ,.csb2sdp_req_pvld (csb2sdp_req_pvld)
  ,.csb2sdp_req_prdy (csb2sdp_req_prdy)
  ,.csb2sdp_req_pd (csb2sdp_req_pd)
  ,.sdp_b2mcif_rd_cdt_lat_fifo_pop (sdp_b2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp_b2mcif_rd_req_valid (sdp_b2mcif_rd_req_valid)
  ,.sdp_b2mcif_rd_req_ready (sdp_b2mcif_rd_req_ready)
  ,.sdp_b2mcif_rd_req_pd (sdp_b2mcif_rd_req_pd)
  ,.mcif2sdp_b_rd_rsp_valid (mcif2sdp_b_rd_rsp_valid)
  ,.mcif2sdp_b_rd_rsp_ready (mcif2sdp_b_rd_rsp_ready)
  ,.mcif2sdp_b_rd_rsp_pd (mcif2sdp_b_rd_rsp_pd)
  ,.sdp_n2mcif_rd_cdt_lat_fifo_pop (sdp_n2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp_n2mcif_rd_req_valid (sdp_n2mcif_rd_req_valid)
  ,.sdp_n2mcif_rd_req_ready (sdp_n2mcif_rd_req_ready)
  ,.sdp_n2mcif_rd_req_pd (sdp_n2mcif_rd_req_pd)
  ,.mcif2sdp_n_rd_rsp_valid (mcif2sdp_n_rd_rsp_valid)
  ,.mcif2sdp_n_rd_rsp_ready (mcif2sdp_n_rd_rsp_ready)
  ,.mcif2sdp_n_rd_rsp_pd (mcif2sdp_n_rd_rsp_pd)
  ,.mcif2sdp_rd_rsp_valid (mcif2sdp_rd_rsp_valid)
  ,.mcif2sdp_rd_rsp_ready (mcif2sdp_rd_rsp_ready)
  ,.mcif2sdp_rd_rsp_pd (mcif2sdp_rd_rsp_pd)
  ,.mcif2sdp_wr_rsp_complete (mcif2sdp_wr_rsp_complete)
  ,.pwrbus_ram_pd (pwrbus_ram_pd)
  ,.sdp2csb_resp_valid (sdp2csb_resp_valid)
  ,.sdp2csb_resp_pd (sdp2csb_resp_pd)
  ,.sdp2glb_done_intr_pd (sdp2glb_done_intr_pd)
  ,.sdp2mcif_rd_cdt_lat_fifo_pop (sdp2mcif_rd_cdt_lat_fifo_pop)
  ,.sdp2mcif_rd_req_valid (sdp2mcif_rd_req_valid)
  ,.sdp2mcif_rd_req_ready (sdp2mcif_rd_req_ready)
  ,.sdp2mcif_rd_req_pd (sdp2mcif_rd_req_pd)
  ,.sdp2mcif_wr_req_valid (sdp2mcif_wr_req_valid)
  ,.sdp2mcif_wr_req_ready (sdp2mcif_wr_req_ready)
  ,.sdp2mcif_wr_req_pd (sdp2mcif_wr_req_pd)
  ,.sdp2pdp_valid (sdp2pdp_valid)
  ,.sdp2pdp_ready (sdp2pdp_ready)
  ,.sdp2pdp_pd (sdp2pdp_pd)
  ,.sdp_rdma2csb_resp_valid (sdp_rdma2csb_resp_valid)
  ,.sdp_rdma2csb_resp_pd (sdp_rdma2csb_resp_pd)
  ,.dla_clk_ovr_on_sync (dla_clk_ovr_on_sync)
  ,.global_clk_ovr_on_sync (global_clk_ovr_on_sync)
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating)
  );
////////////////////////////////////////////////////////////////////////
// Dangles/Contenders report //
////////////////////////////////////////////////////////////////////////
endmodule // SA_AUTOSA_partition_p
