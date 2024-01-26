// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_SDP_RDMA_dmaif.v
// ================================================================
// AUTOSA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_SDP_define.h
module SA_AUTOSA_SDP_RDMA_dmaif (
   autosa_core_clk //|< i
  ,autosa_core_rstn //|< i
  ,sdp2mcif_rd_req_pd //|> o
  ,sdp2mcif_rd_req_valid //|> o
  ,sdp2mcif_rd_req_ready //|< i
  ,mcif2sdp_rd_rsp_pd //|< i
  ,mcif2sdp_rd_rsp_valid //|< i
  ,mcif2sdp_rd_rsp_ready //|> o
  ,sdp2mcif_rd_cdt_lat_fifo_pop //|> o
  ,dma_rd_req_ram_type //|< i
  ,dma_rd_req_pd //|< i
  ,dma_rd_req_vld //|< i
  ,dma_rd_req_rdy //|> o
  ,dma_rd_rsp_ram_type //|< i
  ,dma_rd_rsp_pd //|> o
  ,dma_rd_rsp_vld //|> o
  ,dma_rd_rsp_rdy //|< i
  ,dma_rd_cdt_lat_fifo_pop //|< i
  );
input autosa_core_clk;
input autosa_core_rstn;
output [47 -1:0] sdp2mcif_rd_req_pd;
output sdp2mcif_rd_req_valid;
input sdp2mcif_rd_req_ready;
input [65 -1:0] mcif2sdp_rd_rsp_pd;
input mcif2sdp_rd_rsp_valid;
output mcif2sdp_rd_rsp_ready;
output sdp2mcif_rd_cdt_lat_fifo_pop;
input dma_rd_req_ram_type;
input dma_rd_req_vld;
output dma_rd_req_rdy;
input [47 -1:0] dma_rd_req_pd;
input dma_rd_rsp_ram_type;
output [65 -1:0] dma_rd_rsp_pd;
output dma_rd_rsp_vld;
input dma_rd_rsp_rdy;
input dma_rd_cdt_lat_fifo_pop;
reg sdp2mcif_rd_cdt_lat_fifo_pop;
SA_AUTOSA_DMAIF_rdreq SA_AUTOSA_SDP_RDMA_rdreq(
  .autosa_core_clk (autosa_core_clk )
 ,.autosa_core_rstn (autosa_core_rstn )
 ,.reg2dp_src_ram_type (dma_rd_req_ram_type)
 ,.mcif_rd_req_pd (sdp2mcif_rd_req_pd )
 ,.mcif_rd_req_valid (sdp2mcif_rd_req_valid)
 ,.mcif_rd_req_ready (sdp2mcif_rd_req_ready)
 ,.dmaif_rd_req_pd (dma_rd_req_pd )
 ,.dmaif_rd_req_vld (dma_rd_req_vld )
 ,.dmaif_rd_req_rdy (dma_rd_req_rdy )
);
SA_AUTOSA_DMAIF_rdrsp SA_AUTOSA_SDP_RDMA_rdrsp(
   .autosa_core_clk (autosa_core_clk )
  ,.autosa_core_rstn (autosa_core_rstn )
  ,.mcif_rd_rsp_pd (mcif2sdp_rd_rsp_pd )
  ,.mcif_rd_rsp_valid (mcif2sdp_rd_rsp_valid )
  ,.mcif_rd_rsp_ready (mcif2sdp_rd_rsp_ready )
  ,.dmaif_rd_rsp_pd (dma_rd_rsp_pd )
  ,.dmaif_rd_rsp_pvld (dma_rd_rsp_vld )
  ,.dmaif_rd_rsp_prdy (dma_rd_rsp_rdy )
);
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
  if (!autosa_core_rstn) begin
    sdp2mcif_rd_cdt_lat_fifo_pop <= 1'b0;
  end else begin
  sdp2mcif_rd_cdt_lat_fifo_pop <= dma_rd_cdt_lat_fifo_pop & (dma_rd_rsp_ram_type == 1'b1);
  end
end
endmodule
