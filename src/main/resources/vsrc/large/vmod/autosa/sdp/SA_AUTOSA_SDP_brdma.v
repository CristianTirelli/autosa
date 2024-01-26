// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_SDP_brdma.v
// ================================================================
// AUTOSA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_SDP_define.h
module SA_AUTOSA_SDP_brdma (
   autosa_core_clk //|< i
  ,autosa_core_rstn //|< i
  ,pwrbus_ram_pd //|< i
  ,dla_clk_ovr_on_sync //|< i
  ,global_clk_ovr_on_sync //|< i
  ,tmc2slcg_disable_clock_gating //|< i
  ,brdma_disable //|< i
  ,brdma_slcg_op_en //|< i
  ,sdp_b2cvif_rd_cdt_lat_fifo_pop //|> o
  ,sdp_b2cvif_rd_req_pd //|> o
  ,sdp_b2cvif_rd_req_valid //|> o
  ,sdp_b2cvif_rd_req_ready //|< i
  ,cvif2sdp_b_rd_rsp_pd //|< i
  ,cvif2sdp_b_rd_rsp_valid //|< i
  ,cvif2sdp_b_rd_rsp_ready //|> o
  ,sdp_b2mcif_rd_cdt_lat_fifo_pop //|> o
  ,sdp_b2mcif_rd_req_pd //|> o
  ,sdp_b2mcif_rd_req_valid //|> o
  ,sdp_b2mcif_rd_req_ready //|< i
  ,mcif2sdp_b_rd_rsp_pd //|< i
  ,mcif2sdp_b_rd_rsp_valid //|< i
  ,mcif2sdp_b_rd_rsp_ready //|> o
  ,reg2dp_brdma_data_mode //|< i
  ,reg2dp_brdma_data_size //|< i
  ,reg2dp_brdma_data_use //|< i
  ,reg2dp_brdma_ram_type //|< i
  ,reg2dp_bs_base_addr_high //|< i
  ,reg2dp_bs_base_addr_low //|< i
  ,reg2dp_bs_line_stride //|< i
  ,reg2dp_bs_surface_stride //|< i
  ,reg2dp_batch_number //|< i
  ,reg2dp_channel //|< i
  ,reg2dp_height //|< i
  ,reg2dp_width //|< i
  ,reg2dp_op_en //|< i
  ,reg2dp_out_precision //|< i
  ,reg2dp_perf_dma_en //|< i
  ,reg2dp_proc_precision //|< i
  ,reg2dp_winograd //|< i
  ,dp2reg_brdma_stall //|> o
  ,dp2reg_done //|> o
  ,sdp_brdma2dp_alu_ready //|< i
  ,sdp_brdma2dp_mul_ready //|< i
  ,sdp_brdma2dp_alu_pd //|> o
  ,sdp_brdma2dp_alu_valid //|> o
  ,sdp_brdma2dp_mul_pd //|> o
  ,sdp_brdma2dp_mul_valid //|> o
  );
//
// SA_AUTOSA_SDP_brdma_ports.v
//
 input autosa_core_clk;
 input autosa_core_rstn;
 input [31:0] pwrbus_ram_pd;
 output sdp_b2cvif_rd_req_valid;
 input sdp_b2cvif_rd_req_ready;
 output [79 -1:0] sdp_b2cvif_rd_req_pd;
 input cvif2sdp_b_rd_rsp_valid;
 output cvif2sdp_b_rd_rsp_ready;
 input [257 -1:0] cvif2sdp_b_rd_rsp_pd;
 output sdp_b2cvif_rd_cdt_lat_fifo_pop;
 output sdp_b2mcif_rd_req_valid;
 input sdp_b2mcif_rd_req_ready;
 output [79 -1:0] sdp_b2mcif_rd_req_pd;
 input mcif2sdp_b_rd_rsp_valid;
 output mcif2sdp_b_rd_rsp_ready;
 input [257 -1:0] mcif2sdp_b_rd_rsp_pd;
 output sdp_b2mcif_rd_cdt_lat_fifo_pop;
 output sdp_brdma2dp_alu_valid;
 input sdp_brdma2dp_alu_ready;
 output [32*16:0] sdp_brdma2dp_alu_pd;
 output sdp_brdma2dp_mul_valid;
 input sdp_brdma2dp_mul_ready;
 output [32*16:0] sdp_brdma2dp_mul_pd;
 input reg2dp_brdma_data_mode;
 input reg2dp_brdma_data_size;
 input [1:0] reg2dp_brdma_data_use;
 input reg2dp_brdma_ram_type;
 input [31:0] reg2dp_bs_base_addr_high;
 input [31-5:0] reg2dp_bs_base_addr_low;
 input [31-5:0] reg2dp_bs_line_stride;
 input [31-5:0] reg2dp_bs_surface_stride;
 input [4:0] reg2dp_batch_number;
 input [12:0] reg2dp_channel;
 input [12:0] reg2dp_height;
 input reg2dp_op_en;
 input [1:0] reg2dp_out_precision;
 input reg2dp_perf_dma_en;
 input [1:0] reg2dp_proc_precision;
 input [12:0] reg2dp_width;
 input reg2dp_winograd;
 output [31:0] dp2reg_brdma_stall;
 output dp2reg_done;
 input dla_clk_ovr_on_sync;
 input global_clk_ovr_on_sync;
 input tmc2slcg_disable_clock_gating;
 input brdma_slcg_op_en;
 input brdma_disable;
 wire autosa_gated_clk;
 wire op_load;
 wire eg_done;
 reg layer_process;
 wire [15:0] ig2cq_pd;
 wire ig2cq_prdy;
 wire ig2cq_pvld;
 wire [15:0] cq2eg_pd;
 wire cq2eg_prdy;
 wire cq2eg_pvld;
 wire dma_rd_cdt_lat_fifo_pop;
 wire [79 -1:0] dma_rd_req_pd;
 wire dma_rd_req_rdy;
 wire dma_rd_req_vld;
 wire [257 -1:0] dma_rd_rsp_pd;
 wire dma_rd_rsp_rdy;
 wire dma_rd_rsp_vld;
 wire [257 -1:0] lat_fifo_rd_pd;
 wire lat_fifo_rd_pvld;
 wire lat_fifo_rd_prdy;
// Layer Switch
assign op_load = reg2dp_op_en & !layer_process;
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
  if (!autosa_core_rstn) begin
    layer_process <= 1'b0;
  end else begin
    if (op_load) begin
        layer_process <= 1'b1;
    end else if (eg_done) begin
        layer_process <= 1'b0;
    end
  end
end
assign dp2reg_done = eg_done;
//=======================================
SA_AUTOSA_SDP_BRDMA_gate u_gate (
   .autosa_core_clk (autosa_core_clk) //|< i
  ,.autosa_core_rstn (autosa_core_rstn) //|< i
  ,.brdma_disable (brdma_disable) //|< i
  ,.brdma_slcg_op_en (brdma_slcg_op_en) //|< i
  ,.dla_clk_ovr_on_sync (dla_clk_ovr_on_sync) //|< i
  ,.global_clk_ovr_on_sync (global_clk_ovr_on_sync) //|< i
  ,.tmc2slcg_disable_clock_gating (tmc2slcg_disable_clock_gating) //|< i
  ,.autosa_gated_clk (autosa_gated_clk) //|> w
  );
SA_AUTOSA_SDP_RDMA_ig u_ig (
   .autosa_core_clk (autosa_gated_clk) //|< w
  ,.autosa_core_rstn (autosa_core_rstn) //|< i
  ,.op_load (op_load) //|< w
  ,.ig2cq_pd (ig2cq_pd[15:0]) //|> w
  ,.ig2cq_pvld (ig2cq_pvld) //|> w
  ,.ig2cq_prdy (ig2cq_prdy) //|< w
  ,.dma_rd_req_pd (dma_rd_req_pd[79 -1:0]) //|> w
  ,.dma_rd_req_vld (dma_rd_req_vld) //|> w
  ,.dma_rd_req_rdy (dma_rd_req_rdy) //|< w
  ,.reg2dp_op_en (reg2dp_op_en) //|< i
  ,.reg2dp_perf_dma_en (reg2dp_perf_dma_en) //|< i
  ,.reg2dp_winograd (reg2dp_winograd) //|< i
  ,.reg2dp_channel (reg2dp_channel[12:0]) //|< i
  ,.reg2dp_height (reg2dp_height[12:0]) //|< i
  ,.reg2dp_width (reg2dp_width[12:0]) //|< i
  ,.reg2dp_proc_precision (reg2dp_proc_precision[1:0]) //|< i
  ,.reg2dp_rdma_data_mode (reg2dp_brdma_data_mode) //|< i
  ,.reg2dp_rdma_data_size (reg2dp_brdma_data_size) //|< i
  ,.reg2dp_rdma_data_use (reg2dp_brdma_data_use[1:0]) //|< i
  ,.reg2dp_base_addr_high (reg2dp_bs_base_addr_high[31:0]) //|< i
  ,.reg2dp_base_addr_low (reg2dp_bs_base_addr_low[31-5:0]) //|< i
  ,.reg2dp_line_stride (reg2dp_bs_line_stride[31-5:0]) //|< i
  ,.reg2dp_surface_stride (reg2dp_bs_surface_stride[31-5:0]) //|< i
  ,.dp2reg_rdma_stall (dp2reg_brdma_stall[31:0]) //|> o
  );
//: my $depth = 256;
//: my $width = 16;
//: print "SA_AUTOSA_SDP_BRDMA_cq_${depth}x${width}  u_cq ( \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
SA_AUTOSA_SDP_BRDMA_cq_256x16  u_cq ( 

//| eperl: generated_end (DO NOT EDIT ABOVE)
   .autosa_core_clk (autosa_gated_clk) //|< w
  ,.autosa_core_rstn (autosa_core_rstn) //|< i
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  ,.ig2cq_prdy (ig2cq_prdy) //|> w
  ,.ig2cq_pvld (ig2cq_pvld) //|< w
  ,.ig2cq_pd (ig2cq_pd[15:0]) //|< w
  ,.cq2eg_prdy (cq2eg_prdy) //|< w
  ,.cq2eg_pvld (cq2eg_pvld) //|> w
  ,.cq2eg_pd (cq2eg_pd[15:0]) //|> w
  );
SA_AUTOSA_SDP_RDMA_eg u_eg (
   .autosa_core_clk (autosa_gated_clk) //|< w
  ,.autosa_core_rstn (autosa_core_rstn) //|< i
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  ,.op_load (op_load) //|< w
  ,.eg_done (eg_done) //|> w
  ,.cq2eg_pd (cq2eg_pd[15:0]) //|< w
  ,.cq2eg_pvld (cq2eg_pvld) //|< w
  ,.cq2eg_prdy (cq2eg_prdy) //|> w
  ,.dma_rd_cdt_lat_fifo_pop (dma_rd_cdt_lat_fifo_pop) //|> w
  ,.lat_fifo_rd_pd (lat_fifo_rd_pd[257 -1:0]) //|< w
  ,.lat_fifo_rd_pvld (lat_fifo_rd_pvld) //|< w
  ,.lat_fifo_rd_prdy (lat_fifo_rd_prdy) //|> w
  ,.sdp_rdma2dp_alu_ready (sdp_brdma2dp_alu_ready) //|< i
  ,.sdp_rdma2dp_mul_ready (sdp_brdma2dp_mul_ready) //|< i
  ,.sdp_rdma2dp_alu_pd (sdp_brdma2dp_alu_pd[32*16:0]) //|> o
  ,.sdp_rdma2dp_alu_valid (sdp_brdma2dp_alu_valid) //|> o
  ,.sdp_rdma2dp_mul_pd (sdp_brdma2dp_mul_pd[32*16:0]) //|> o
  ,.sdp_rdma2dp_mul_valid (sdp_brdma2dp_mul_valid) //|> o
  ,.reg2dp_batch_number (reg2dp_batch_number[4:0]) //|< i
  ,.reg2dp_channel (reg2dp_channel[12:0]) //|< i
  ,.reg2dp_height (reg2dp_height[12:0]) //|< i
  ,.reg2dp_width (reg2dp_width[12:0]) //|< i
  ,.reg2dp_proc_precision (reg2dp_proc_precision[1:0]) //|< i
  ,.reg2dp_out_precision (reg2dp_out_precision[1:0]) //|< i
  ,.reg2dp_rdma_data_mode (reg2dp_brdma_data_mode) //|< i
  ,.reg2dp_rdma_data_size (reg2dp_brdma_data_size) //|< i
  ,.reg2dp_rdma_data_use (reg2dp_brdma_data_use[1:0]) //|< i
  );
//: my $depth = 256;
//: my $width = 257;
//: print "SA_AUTOSA_SDP_BRDMA_lat_fifo_${depth}x${width}  u_lat_fifo (\n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
SA_AUTOSA_SDP_BRDMA_lat_fifo_256x257  u_lat_fifo (

//| eperl: generated_end (DO NOT EDIT ABOVE)
   .autosa_core_clk (autosa_gated_clk)
  ,.autosa_core_rstn (autosa_core_rstn)
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
  ,.lat_wr_prdy (dma_rd_rsp_rdy)
  ,.lat_wr_pvld (dma_rd_rsp_vld)
  ,.lat_wr_pd (dma_rd_rsp_pd[257 -1:0])
  ,.lat_rd_prdy (lat_fifo_rd_prdy)
  ,.lat_rd_pvld (lat_fifo_rd_pvld)
  ,.lat_rd_pd (lat_fifo_rd_pd[257 -1:0])
  );
SA_AUTOSA_SDP_RDMA_dmaif u_SA_AUTOSA_SDP_RDMA_dmaif (
   .autosa_core_clk (autosa_gated_clk) //|< i
  ,.autosa_core_rstn (autosa_core_rstn) //|< i
  ,.sdp2cvif_rd_cdt_lat_fifo_pop (sdp_b2cvif_rd_cdt_lat_fifo_pop) //|> o
  ,.sdp2cvif_rd_req_pd (sdp_b2cvif_rd_req_pd[79 -1:0]) //|> o
  ,.sdp2cvif_rd_req_valid (sdp_b2cvif_rd_req_valid) //|> o
  ,.sdp2cvif_rd_req_ready (sdp_b2cvif_rd_req_ready) //|< i
  ,.cvif2sdp_rd_rsp_pd (cvif2sdp_b_rd_rsp_pd[257 -1:0]) //|< i
  ,.cvif2sdp_rd_rsp_valid (cvif2sdp_b_rd_rsp_valid) //|< i
  ,.cvif2sdp_rd_rsp_ready (cvif2sdp_b_rd_rsp_ready) //|> o
  ,.sdp2mcif_rd_cdt_lat_fifo_pop (sdp_b2mcif_rd_cdt_lat_fifo_pop) //|> o
  ,.sdp2mcif_rd_req_pd (sdp_b2mcif_rd_req_pd[79 -1:0]) //|> o
  ,.sdp2mcif_rd_req_valid (sdp_b2mcif_rd_req_valid) //|> o
  ,.sdp2mcif_rd_req_ready (sdp_b2mcif_rd_req_ready) //|< i
  ,.mcif2sdp_rd_rsp_pd (mcif2sdp_b_rd_rsp_pd[257 -1:0]) //|< i
  ,.mcif2sdp_rd_rsp_valid (mcif2sdp_b_rd_rsp_valid) //|< i
  ,.mcif2sdp_rd_rsp_ready (mcif2sdp_b_rd_rsp_ready) //|> o
  ,.dma_rd_req_ram_type (reg2dp_brdma_ram_type) //|< w
  ,.dma_rd_rsp_ram_type (reg2dp_brdma_ram_type) //|< w
  ,.dma_rd_req_pd (dma_rd_req_pd[79 -1:0]) //|< w
  ,.dma_rd_req_vld (dma_rd_req_vld) //|< w
  ,.dma_rd_req_rdy (dma_rd_req_rdy) //|> w
  ,.dma_rd_rsp_pd (dma_rd_rsp_pd[257 -1:0]) //|> w
  ,.dma_rd_rsp_vld (dma_rd_rsp_vld) //|> w
  ,.dma_rd_rsp_rdy (dma_rd_rsp_rdy) //|< w
  ,.dma_rd_cdt_lat_fifo_pop (dma_rd_cdt_lat_fifo_pop) //|< w
  );
endmodule // SA_AUTOSA_SDP_brdma