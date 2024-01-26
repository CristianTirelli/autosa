// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_csb_master.v
`include "sa_simulate_x_tick.vh"
module SA_AUTOSA_csb_master (
   autosa_core_clk //|< i
  ,autosa_core_rstn //|< i
  ,autosa_falcon_clk //|< i
  ,autosa_falcon_rstn //|< i
  ,pwrbus_ram_pd //|< i
  ,csb2autosa_valid //|< i
  ,csb2autosa_ready //|> o
  ,csb2autosa_addr //|< i
  ,csb2autosa_wdat //|< i
  ,csb2autosa_write //|< i
  ,csb2autosa_nposted //|< i
  ,autosa2csb_valid //|> o
  ,autosa2csb_data //|> o
  ,autosa2csb_wr_complete //|> o
  ,csb2cfgrom_req_pvld //|> o
  ,csb2cfgrom_req_prdy //|< i
  ,csb2cfgrom_req_pd //|> o
  ,cfgrom2csb_resp_valid //|< i
  ,cfgrom2csb_resp_pd //|< i
  ,csb2glb_req_pvld //|> o
  ,csb2glb_req_prdy //|< i
  ,csb2glb_req_pd //|> o
  ,glb2csb_resp_valid //|< i
  ,glb2csb_resp_pd //|< i
  ,csb2mcif_req_pvld //|> o
  ,csb2mcif_req_prdy //|< i
  ,csb2mcif_req_pd //|> o
  ,mcif2csb_resp_valid //|< i
  ,mcif2csb_resp_pd //|< i
  ,csb2cdma_req_pvld //|> o
  ,csb2cdma_req_prdy //|< i
  ,csb2cdma_req_pd //|> o
  ,cdma2csb_resp_valid //|< i
  ,cdma2csb_resp_pd //|< i
  ,csb2csc_req_pvld //|> o
  ,csb2csc_req_prdy //|< i
  ,csb2csc_req_pd //|> o
  ,csc2csb_resp_valid //|< i
  ,csc2csb_resp_pd //|< i
  ,csb2cmac_a_req_pvld //|> o
  ,csb2cmac_a_req_prdy //|< i
  ,csb2cmac_a_req_pd //|> o
  ,cmac_a2csb_resp_valid //|< i
  ,cmac_a2csb_resp_pd //|< i
  ,csb2cmac_b_req_pvld //|> o
  ,csb2cmac_b_req_prdy //|< i
  ,csb2cmac_b_req_pd //|> o
  ,cmac_b2csb_resp_valid //|< i
  ,cmac_b2csb_resp_pd //|< i
  ,csb2cacc_req_pvld //|> o
  ,csb2cacc_req_prdy //|< i
  ,csb2cacc_req_pd //|> o
  ,cacc2csb_resp_valid //|< i
  ,cacc2csb_resp_pd //|< i
  ,csb2sdp_rdma_req_pvld //|> o
  ,csb2sdp_rdma_req_prdy //|< i
  ,csb2sdp_rdma_req_pd //|> o
  ,sdp_rdma2csb_resp_valid //|< i
  ,sdp_rdma2csb_resp_pd //|< i
  ,csb2sdp_req_pvld //|> o
  ,csb2sdp_req_prdy //|< i
  ,csb2sdp_req_pd //|> o
  ,sdp2csb_resp_valid //|< i
  ,sdp2csb_resp_pd //|< i
  ,csb2pdp_rdma_req_pvld //|> o
  ,csb2pdp_rdma_req_prdy //|< i
  ,csb2pdp_rdma_req_pd //|> o
  ,pdp_rdma2csb_resp_valid //|< i
  ,pdp_rdma2csb_resp_pd //|< i
  ,csb2pdp_req_pvld //|> o
  ,csb2pdp_req_prdy //|< i
  ,csb2pdp_req_pd //|> o
  ,pdp2csb_resp_valid //|< i
  ,pdp2csb_resp_pd //|< i
  ,csb2cdp_rdma_req_pvld //|> o
  ,csb2cdp_rdma_req_prdy //|< i
  ,csb2cdp_rdma_req_pd //|> o
  ,cdp_rdma2csb_resp_valid //|< i
  ,cdp_rdma2csb_resp_pd //|< i
  ,csb2cdp_req_pvld //|> o
  ,csb2cdp_req_prdy //|< i
  ,csb2cdp_req_pd //|> o
  ,cdp2csb_resp_valid //|< i
  ,cdp2csb_resp_pd //|< i
  );
//
// SA_AUTOSA_csb_master_ports.v
//
input autosa_core_clk;
input autosa_core_rstn;
input autosa_falcon_clk; /* csb2autosa, autosa2csb, autosa2csb_wr */
input autosa_falcon_rstn; /* csb2autosa, autosa2csb, autosa2csb_wr */
input [31:0] pwrbus_ram_pd;
input csb2autosa_valid; /* data valid */
output csb2autosa_ready; /* data return handshake */
input [15:0] csb2autosa_addr;
input [31:0] csb2autosa_wdat;
input csb2autosa_write;
input csb2autosa_nposted;
output autosa2csb_valid; /* data valid */
output [31:0] autosa2csb_data;
output autosa2csb_wr_complete;
output csb2cfgrom_req_pvld; /* data valid */
input csb2cfgrom_req_prdy; /* data return handshake */
output [62:0] csb2cfgrom_req_pd;
input cfgrom2csb_resp_valid; /* data valid */
input [33:0] cfgrom2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
output csb2glb_req_pvld; /* data valid */
input csb2glb_req_prdy; /* data return handshake */
output [62:0] csb2glb_req_pd;
input glb2csb_resp_valid; /* data valid */
input [33:0] glb2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
output csb2mcif_req_pvld; /* data valid */
input csb2mcif_req_prdy; /* data return handshake */
output [62:0] csb2mcif_req_pd;
input mcif2csb_resp_valid; /* data valid */
input [33:0] mcif2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
output csb2cdma_req_pvld; /* data valid */
input csb2cdma_req_prdy; /* data return handshake */
output [62:0] csb2cdma_req_pd;
input cdma2csb_resp_valid; /* data valid */
input [33:0] cdma2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
output csb2csc_req_pvld; /* data valid */
input csb2csc_req_prdy; /* data return handshake */
output [62:0] csb2csc_req_pd;
input csc2csb_resp_valid; /* data valid */
input [33:0] csc2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
output csb2cmac_a_req_pvld; /* data valid */
input csb2cmac_a_req_prdy; /* data return handshake */
output [62:0] csb2cmac_a_req_pd;
input cmac_a2csb_resp_valid; /* data valid */
input [33:0] cmac_a2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
output csb2cmac_b_req_pvld; /* data valid */
input csb2cmac_b_req_prdy; /* data return handshake */
output [62:0] csb2cmac_b_req_pd;
input cmac_b2csb_resp_valid; /* data valid */
input [33:0] cmac_b2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
output csb2cacc_req_pvld; /* data valid */
input csb2cacc_req_prdy; /* data return handshake */
output [62:0] csb2cacc_req_pd;
input cacc2csb_resp_valid; /* data valid */
input [33:0] cacc2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
output csb2sdp_rdma_req_pvld; /* data valid */
input csb2sdp_rdma_req_prdy; /* data return handshake */
output [62:0] csb2sdp_rdma_req_pd;
input sdp_rdma2csb_resp_valid; /* data valid */
input [33:0] sdp_rdma2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
output csb2sdp_req_pvld; /* data valid */
input csb2sdp_req_prdy; /* data return handshake */
output [62:0] csb2sdp_req_pd;
input sdp2csb_resp_valid; /* data valid */
input [33:0] sdp2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
output csb2pdp_rdma_req_pvld; /* data valid */
input csb2pdp_rdma_req_prdy; /* data return handshake */
output [62:0] csb2pdp_rdma_req_pd;
input pdp_rdma2csb_resp_valid; /* data valid */
input [33:0] pdp_rdma2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
output csb2pdp_req_pvld; /* data valid */
input csb2pdp_req_prdy; /* data return handshake */
output [62:0] csb2pdp_req_pd;
input pdp2csb_resp_valid; /* data valid */
input [33:0] pdp2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
output csb2cdp_rdma_req_pvld; /* data valid */
input csb2cdp_rdma_req_prdy; /* data return handshake */
output [62:0] csb2cdp_rdma_req_pd;
input cdp_rdma2csb_resp_valid; /* data valid */
input [33:0] cdp_rdma2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
output csb2cdp_req_pvld; /* data valid */
input csb2cdp_req_prdy; /* data return handshake */
output [62:0] csb2cdp_req_pd;
input cdp2csb_resp_valid; /* data valid */
input [33:0] cdp2csb_resp_pd; /* pkt_id_width=1 pkt_widths=33,33  */
/////////////////////////////////////////////////////////////////
reg [49:0] csb2cfgrom_req_pd_tmp;
reg csb2cfgrom_req_pvld;
reg cfgrom_req_pvld;
reg [33:0] cfgrom_resp_pd;
reg cfgrom_resp_valid;
wire csb2cfgrom_req_en;
wire csb2cfgrom_req_pvld_w;
wire cfgrom_req_pvld_w;
reg [49:0] csb2glb_req_pd_tmp;
reg csb2glb_req_pvld;
reg glb_req_pvld;
reg [33:0] glb_resp_pd;
reg glb_resp_valid;
wire csb2glb_req_en;
wire csb2glb_req_pvld_w;
wire glb_req_pvld_w;
reg [49:0] csb2mcif_req_pd_tmp;
reg csb2mcif_req_pvld;
reg mcif_req_pvld;
reg [33:0] mcif_resp_pd;
reg mcif_resp_valid;
wire csb2mcif_req_en;
wire csb2mcif_req_pvld_w;
wire mcif_req_pvld_w;
reg [49:0] csb2cdma_req_pd_tmp;
reg csb2cdma_req_pvld;
reg cdma_req_pvld;
reg [33:0] cdma_resp_pd;
reg cdma_resp_valid;
wire csb2cdma_req_en;
wire csb2cdma_req_pvld_w;
wire cdma_req_pvld_w;
reg [49:0] csb2csc_req_pd_tmp;
reg csb2csc_req_pvld;
reg csc_req_pvld;
reg [33:0] csc_resp_pd;
reg csc_resp_valid;
wire csb2csc_req_en;
wire csb2csc_req_pvld_w;
wire csc_req_pvld_w;
reg [49:0] csb2cmac_a_req_pd_tmp;
reg csb2cmac_a_req_pvld;
reg cmac_a_req_pvld;
reg [33:0] cmac_a_resp_pd;
reg cmac_a_resp_valid;
wire csb2cmac_a_req_en;
wire csb2cmac_a_req_pvld_w;
wire cmac_a_req_pvld_w;
reg [49:0] csb2cmac_b_req_pd_tmp;
reg csb2cmac_b_req_pvld;
reg cmac_b_req_pvld;
reg [33:0] cmac_b_resp_pd;
reg cmac_b_resp_valid;
wire csb2cmac_b_req_en;
wire csb2cmac_b_req_pvld_w;
wire cmac_b_req_pvld_w;
reg [49:0] csb2cacc_req_pd_tmp;
reg csb2cacc_req_pvld;
reg cacc_req_pvld;
reg [33:0] cacc_resp_pd;
reg cacc_resp_valid;
wire csb2cacc_req_en;
wire csb2cacc_req_pvld_w;
wire cacc_req_pvld_w;
reg [49:0] csb2sdp_rdma_req_pd_tmp;
reg csb2sdp_rdma_req_pvld;
reg sdp_rdma_req_pvld;
reg [33:0] sdp_rdma_resp_pd;
reg sdp_rdma_resp_valid;
wire csb2sdp_rdma_req_en;
wire csb2sdp_rdma_req_pvld_w;
wire sdp_rdma_req_pvld_w;
reg [49:0] csb2sdp_req_pd_tmp;
reg csb2sdp_req_pvld;
reg sdp_req_pvld;
reg [33:0] sdp_resp_pd;
reg sdp_resp_valid;
wire csb2sdp_req_en;
wire csb2sdp_req_pvld_w;
wire sdp_req_pvld_w;
reg [49:0] csb2pdp_rdma_req_pd_tmp;
reg csb2pdp_rdma_req_pvld;
reg pdp_rdma_req_pvld;
reg [33:0] pdp_rdma_resp_pd;
reg pdp_rdma_resp_valid;
wire csb2pdp_rdma_req_en;
wire csb2pdp_rdma_req_pvld_w;
wire pdp_rdma_req_pvld_w;
reg [49:0] csb2pdp_req_pd_tmp;
reg csb2pdp_req_pvld;
reg pdp_req_pvld;
reg [33:0] pdp_resp_pd;
reg pdp_resp_valid;
wire csb2pdp_req_en;
wire csb2pdp_req_pvld_w;
wire pdp_req_pvld_w;
reg [49:0] csb2cdp_rdma_req_pd_tmp;
reg csb2cdp_rdma_req_pvld;
reg cdp_rdma_req_pvld;
reg [33:0] cdp_rdma_resp_pd;
reg cdp_rdma_resp_valid;
wire csb2cdp_rdma_req_en;
wire csb2cdp_rdma_req_pvld_w;
wire cdp_rdma_req_pvld_w;
reg [49:0] csb2cdp_req_pd_tmp;
reg csb2cdp_req_pvld;
reg cdp_req_pvld;
reg [33:0] cdp_resp_pd;
reg cdp_resp_valid;
wire csb2cdp_req_en;
wire csb2cdp_req_pvld_w;
wire cdp_req_pvld_w;
reg csb2dummy_req_nposted;
reg csb2dummy_req_pvld;
reg csb2dummy_req_read;
reg dummy_resp_type;
reg dummy_resp_valid;
wire dummy_req_pvld_w;
wire dummy_resp_error;
wire [33:0] dummy_resp_pd;
wire [31:0] dummy_resp_rdat;
wire dummy_resp_type_w;
wire dummy_resp_valid_w;
wire [33:0] dummy_rresp_pd;
wire [33:0] dummy_wresp_pd;
reg [49:0] core_req_pd_d1;
reg [31:0] autosa2csb_data;
reg autosa2csb_valid;
reg autosa2csb_wr_complete;
wire [17:0] addr_mask;
wire [17:0] core_byte_addr;
wire [15:0] core_req_addr;
wire core_req_nposted;
wire [49:0] core_req_pd;
wire core_req_pop_valid;
wire core_req_prdy;
wire core_req_pvld;
wire core_req_write;
wire [33:0] core_resp_pd;
wire core_resp_prdy;
wire core_resp_pvld;
wire [49:0] csb2autosa_pd;
wire [33:0] autosa2csb_resp_pd;
wire autosa2csb_resp_pvld;
wire autosa2csb_rresp_is_valid;
wire [31:0] autosa2csb_rresp_rdat;
wire autosa2csb_wresp_is_valid;
wire select_cfgrom;
wire select_glb;
wire select_mcif;
wire select_cvif;
wire select_bdma;
wire select_cacc;
wire select_cdma;
wire select_cdp;
wire select_cdp_rdma;
wire select_cmac_a;
wire select_cmac_b;
wire select_csc;
wire select_dummy;
wire select_pdp;
wire select_pdp_rdma;
wire select_rbk;
wire select_sdp;
wire select_sdp_rdma;
////////////////////////////////////////////////////////////////////////
// CSB interface to async FIFO //
////////////////////////////////////////////////////////////////////////
assign csb2autosa_pd[49:0] = {csb2autosa_nposted,csb2autosa_write,csb2autosa_wdat,csb2autosa_addr};
SA_AUTOSA_CSB_MASTER_falcon2csb_fifo u_fifo_csb2autosa (
   .wr_clk (autosa_falcon_clk) //|< i
  ,.wr_reset_ (autosa_falcon_rstn) //|< i
  ,.wr_ready (csb2autosa_ready) //|> o
  ,.wr_req (csb2autosa_valid) //|< i
  ,.wr_data (csb2autosa_pd[49:0]) //|< w
  ,.rd_clk (autosa_core_clk) //|< i
  ,.rd_reset_ (autosa_core_rstn) //|< i
  ,.rd_ready (core_req_prdy) //|< w
  ,.rd_req (core_req_pvld) //|> w
  ,.rd_data (core_req_pd[49:0]) //|> w
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);
assign core_req_prdy = 1'b1;
SA_AUTOSA_CSB_MASTER_csb2falcon_fifo u_fifo_autosa2csb (
   .wr_clk (autosa_core_clk) //|< i
  ,.wr_reset_ (autosa_core_rstn) //|< i
  ,.wr_ready (core_resp_prdy) //|> w *
  ,.wr_req (core_resp_pvld) //|< w
  ,.wr_data (core_resp_pd[33:0]) //|< w
  ,.rd_clk (autosa_falcon_clk) //|< i
  ,.rd_reset_ (autosa_falcon_rstn) //|< i
  ,.rd_ready (1'b1) //|< ?
  ,.rd_req (autosa2csb_resp_pvld) //|> w
  ,.rd_data (autosa2csb_resp_pd[33:0]) //|> w
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
);
assign autosa2csb_rresp_rdat[31:0] = autosa2csb_resp_pd[31:0];
assign autosa2csb_rresp_is_valid = (autosa2csb_resp_pvld && (autosa2csb_resp_pd[33:33] == 1'd0));
assign autosa2csb_wresp_is_valid = (autosa2csb_resp_pvld && (autosa2csb_resp_pd[33:33] == 1'd1));
always @(posedge autosa_falcon_clk or negedge autosa_falcon_rstn) begin
    if (!autosa_falcon_rstn) begin
        autosa2csb_valid <= 1'b0;
    end else begin
        autosa2csb_valid <= autosa2csb_rresp_is_valid;
    end
end
always @(posedge autosa_falcon_clk or negedge autosa_falcon_rstn) begin
    if (!autosa_falcon_rstn) begin
        autosa2csb_data <= {32{1'b0}};
    end else begin
        if(autosa2csb_rresp_is_valid)
        begin
            autosa2csb_data <= autosa2csb_rresp_rdat;
        end
    end
end
always @(posedge autosa_falcon_clk or negedge autosa_falcon_rstn) begin
    if (!autosa_falcon_rstn) begin
        autosa2csb_wr_complete <= 1'b0;
    end else begin
        autosa2csb_wr_complete <= autosa2csb_wresp_is_valid;
    end
end
////////////////////////////////////////////////////////////////////////
// Distribute request and gather response //
////////////////////////////////////////////////////////////////////////
assign core_req_addr = core_req_pd[15:0];
assign core_req_write = core_req_pd[48];
assign core_req_nposted = core_req_pd[49];
assign core_req_pop_valid = core_req_pvld & core_req_prdy;
//core_req_addr is word aligned while address from arautosa is byte aligned.
assign core_byte_addr = {core_req_addr, 2'b0};
always @(posedge autosa_core_clk) begin
    if ((core_req_pvld & core_req_prdy) == 1'b1) begin
        core_req_pd_d1 <= core_req_pd;
    end
end
assign addr_mask = {{16 -10{1'b1}},{12{1'b0}}};
//////////////// for CFGROM ////////////////
assign select_cfgrom = ((core_byte_addr & addr_mask) == 32'h00000000);
assign cfgrom_req_pvld_w = (core_req_pop_valid & select_cfgrom) ? 1'b1 :
                        (csb2cfgrom_req_prdy | ~csb2cfgrom_req_pvld) ? 1'b0 :
                        cfgrom_req_pvld;
assign csb2cfgrom_req_pvld_w = cfgrom_req_pvld ? 1'b1 :
                            csb2cfgrom_req_prdy ? 1'b0 :
                            csb2cfgrom_req_pvld;
assign csb2cfgrom_req_en = cfgrom_req_pvld & (csb2cfgrom_req_prdy | ~csb2cfgrom_req_pvld);
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        cfgrom_req_pvld <= 1'b0;
    end else begin
        cfgrom_req_pvld <= cfgrom_req_pvld_w;
    end
end
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        csb2cfgrom_req_pvld <= 1'b0;
    end else begin
        csb2cfgrom_req_pvld <= csb2cfgrom_req_pvld_w;
    end
end
always @(posedge autosa_core_clk) begin
    if ((csb2cfgrom_req_en) == 1'b1) begin
        csb2cfgrom_req_pd_tmp <= core_req_pd_d1;
    end
end
assign csb2cfgrom_req_pd ={7'h0,csb2cfgrom_req_pd_tmp[49:16],6'h0,csb2cfgrom_req_pd_tmp[15:0]};
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        cfgrom_resp_valid <= 1'b0;
    end else begin
        cfgrom_resp_valid <= cfgrom2csb_resp_valid;
    end
end
always @(posedge autosa_core_clk) begin
    if ((cfgrom2csb_resp_valid) == 1'b1) begin
        cfgrom_resp_pd <= cfgrom2csb_resp_pd;
    end
end
//////////////// for GLB ////////////////
assign select_glb = ((core_byte_addr & addr_mask) == 32'h00001000);
assign glb_req_pvld_w = (core_req_pop_valid & select_glb) ? 1'b1 :
                        (csb2glb_req_prdy | ~csb2glb_req_pvld) ? 1'b0 :
                        glb_req_pvld;
assign csb2glb_req_pvld_w = glb_req_pvld ? 1'b1 :
                            csb2glb_req_prdy ? 1'b0 :
                            csb2glb_req_pvld;
assign csb2glb_req_en = glb_req_pvld & (csb2glb_req_prdy | ~csb2glb_req_pvld);
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        glb_req_pvld <= 1'b0;
    end else begin
        glb_req_pvld <= glb_req_pvld_w;
    end
end
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        csb2glb_req_pvld <= 1'b0;
    end else begin
        csb2glb_req_pvld <= csb2glb_req_pvld_w;
    end
end
always @(posedge autosa_core_clk) begin
    if ((csb2glb_req_en) == 1'b1) begin
        csb2glb_req_pd_tmp <= core_req_pd_d1;
    end
end
assign csb2glb_req_pd ={7'h0,csb2glb_req_pd_tmp[49:16],6'h0,csb2glb_req_pd_tmp[15:0]};
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        glb_resp_valid <= 1'b0;
    end else begin
        glb_resp_valid <= glb2csb_resp_valid;
    end
end
always @(posedge autosa_core_clk) begin
    if ((glb2csb_resp_valid) == 1'b1) begin
        glb_resp_pd <= glb2csb_resp_pd;
    end
end
//////////////// for MCIF ////////////////
assign select_mcif = ((core_byte_addr & addr_mask) == 32'h00002000);
assign mcif_req_pvld_w = (core_req_pop_valid & select_mcif) ? 1'b1 :
                         (csb2mcif_req_prdy | ~csb2mcif_req_pvld) ? 1'b0 :
                         mcif_req_pvld;
assign csb2mcif_req_pvld_w = mcif_req_pvld ? 1'b1 :
                             csb2mcif_req_prdy ? 1'b0 :
                             csb2mcif_req_pvld;
assign csb2mcif_req_en = mcif_req_pvld & (csb2mcif_req_prdy | ~csb2mcif_req_pvld);
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        mcif_req_pvld <= 1'b0;
    end else begin
        mcif_req_pvld <= mcif_req_pvld_w;
    end
end
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        csb2mcif_req_pvld <= 1'b0;
    end else begin
        csb2mcif_req_pvld <= csb2mcif_req_pvld_w;
    end
end
always @(posedge autosa_core_clk) begin
    if ((csb2mcif_req_en) == 1'b1) begin
        csb2mcif_req_pd_tmp <= core_req_pd_d1;
    end
end
assign csb2mcif_req_pd ={7'h0,csb2mcif_req_pd_tmp[49:16],6'h0,csb2mcif_req_pd_tmp[15:0]};
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        mcif_resp_valid <= 1'b0;
    end else begin
        mcif_resp_valid <= mcif2csb_resp_valid;
    end
end
always @(posedge autosa_core_clk) begin
    if ((mcif2csb_resp_valid) == 1'b1) begin
        mcif_resp_pd <= mcif2csb_resp_pd;
    end
end
assign select_bdma = 1'b0;
//////////////// for CDMA ////////////////
//#ifdef BASEADDR_FOR_FULL
//assign select_cdma = ((core_byte_addr & addr_mask) == 32'h00005000);
//#else
assign select_cdma = ((core_byte_addr & addr_mask) == 32'h00003000);
//#endif
assign cdma_req_pvld_w = (core_req_pop_valid & select_cdma) ? 1'b1 :
                         (csb2cdma_req_prdy | ~csb2cdma_req_pvld) ? 1'b0 :
                         cdma_req_pvld;
assign csb2cdma_req_pvld_w = cdma_req_pvld ? 1'b1 :
                             csb2cdma_req_prdy ? 1'b0 :
                             csb2cdma_req_pvld;
assign csb2cdma_req_en = cdma_req_pvld & (csb2cdma_req_prdy | ~csb2cdma_req_pvld);
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        cdma_req_pvld <= 1'b0;
    end else begin
        cdma_req_pvld <= cdma_req_pvld_w;
    end
end
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        csb2cdma_req_pvld <= 1'b0;
    end else begin
        csb2cdma_req_pvld <= csb2cdma_req_pvld_w;
    end
end
always @(posedge autosa_core_clk) begin
    if ((csb2cdma_req_en) == 1'b1) begin
        csb2cdma_req_pd_tmp <= core_req_pd_d1;
    end
end
assign csb2cdma_req_pd ={7'h0,csb2cdma_req_pd_tmp[49:16],6'h0,csb2cdma_req_pd_tmp[15:0]};
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        cdma_resp_valid <= 1'b0;
    end else begin
        cdma_resp_valid <= cdma2csb_resp_valid;
    end
end
always @(posedge autosa_core_clk) begin
    if ((cdma2csb_resp_valid) == 1'b1) begin
        cdma_resp_pd <= cdma2csb_resp_pd;
    end
end
//////////////// for CSC ////////////////
//#ifdef BASEADDR_FOR_FULL
//assign select_csc = ((core_byte_addr & addr_mask) == 32'h00006000);
//#else
assign select_csc = ((core_byte_addr & addr_mask) == 32'h00004000);
//#endif
assign csc_req_pvld_w = (core_req_pop_valid & select_csc) ? 1'b1 :
                        (csb2csc_req_prdy | ~csb2csc_req_pvld) ? 1'b0 :
                        csc_req_pvld;
assign csb2csc_req_pvld_w = csc_req_pvld ? 1'b1 :
                            csb2csc_req_prdy ? 1'b0 :
                            csb2csc_req_pvld;
assign csb2csc_req_en = csc_req_pvld & (csb2csc_req_prdy | ~csb2csc_req_pvld);
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        csc_req_pvld <= 1'b0;
    end else begin
        csc_req_pvld <= csc_req_pvld_w;
    end
end
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        csb2csc_req_pvld <= 1'b0;
    end else begin
        csb2csc_req_pvld <= csb2csc_req_pvld_w;
    end
end
always @(posedge autosa_core_clk) begin
    if ((csb2csc_req_en) == 1'b1) begin
        csb2csc_req_pd_tmp <= core_req_pd_d1;
    end
end
assign csb2csc_req_pd ={7'h0,csb2csc_req_pd_tmp[49:16],6'h0,csb2csc_req_pd_tmp[15:0]};
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        csc_resp_valid <= 1'b0;
    end else begin
        csc_resp_valid <= csc2csb_resp_valid;
    end
end
always @(posedge autosa_core_clk) begin
    if ((csc2csb_resp_valid) == 1'b1) begin
        csc_resp_pd <= csc2csb_resp_pd;
    end
end
//////////////// for CMAC_A ////////////////
//#ifdef BASEADDR_FOR_FULL
//assign select_cmac_a = ((core_byte_addr & addr_mask) == 32'h00007000);
//#else
assign select_cmac_a = ((core_byte_addr & addr_mask) == 32'h00005000);
//#endif
assign cmac_a_req_pvld_w = (core_req_pop_valid & select_cmac_a) ? 1'b1 :
                           (csb2cmac_a_req_prdy | ~csb2cmac_a_req_pvld) ? 1'b0 :
                           cmac_a_req_pvld;
assign csb2cmac_a_req_pvld_w = cmac_a_req_pvld ? 1'b1 :
                               csb2cmac_a_req_prdy ? 1'b0 :
                               csb2cmac_a_req_pvld;
assign csb2cmac_a_req_en = cmac_a_req_pvld & (csb2cmac_a_req_prdy | ~csb2cmac_a_req_pvld);
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        cmac_a_req_pvld <= 1'b0;
    end else begin
        cmac_a_req_pvld <= cmac_a_req_pvld_w;
    end
end
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        csb2cmac_a_req_pvld <= 1'b0;
    end else begin
        csb2cmac_a_req_pvld <= csb2cmac_a_req_pvld_w;
    end
end
always @(posedge autosa_core_clk) begin
    if ((csb2cmac_a_req_en) == 1'b1) begin
        csb2cmac_a_req_pd_tmp <= core_req_pd_d1;
    end
end
assign csb2cmac_a_req_pd ={7'h0,csb2cmac_a_req_pd_tmp[49:16],6'h0,csb2cmac_a_req_pd_tmp[15:0]};
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        cmac_a_resp_valid <= 1'b0;
    end else begin
        cmac_a_resp_valid <= cmac_a2csb_resp_valid;
    end
end
always @(posedge autosa_core_clk) begin
    if ((cmac_a2csb_resp_valid) == 1'b1) begin
        cmac_a_resp_pd <= cmac_a2csb_resp_pd;
    end
end
//////////////// for CMAC_B ////////////////
//#ifdef BASEADDR_FOR_FULL
//assign select_cmac_b = ((core_byte_addr & addr_mask) == 32'h00008000);
//#else
assign select_cmac_b = ((core_byte_addr & addr_mask) == 32'h00006000);
//#endif
assign cmac_b_req_pvld_w = (core_req_pop_valid & select_cmac_b) ? 1'b1 :
                           (csb2cmac_b_req_prdy | ~csb2cmac_b_req_pvld) ? 1'b0 :
                           cmac_b_req_pvld;
assign csb2cmac_b_req_pvld_w = cmac_b_req_pvld ? 1'b1 :
                               csb2cmac_b_req_prdy ? 1'b0 :
                               csb2cmac_b_req_pvld;
assign csb2cmac_b_req_en = cmac_b_req_pvld & (csb2cmac_b_req_prdy | ~csb2cmac_b_req_pvld);
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        cmac_b_req_pvld <= 1'b0;
    end else begin
        cmac_b_req_pvld <= cmac_b_req_pvld_w;
    end
end
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        csb2cmac_b_req_pvld <= 1'b0;
    end else begin
        csb2cmac_b_req_pvld <= csb2cmac_b_req_pvld_w;
    end
end
always @(posedge autosa_core_clk) begin
    if ((csb2cmac_b_req_en) == 1'b1) begin
        csb2cmac_b_req_pd_tmp <= core_req_pd_d1;
    end
end
assign csb2cmac_b_req_pd ={7'h0,csb2cmac_b_req_pd_tmp[49:16],6'h0,csb2cmac_b_req_pd_tmp[15:0]};
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        cmac_b_resp_valid <= 1'b0;
    end else begin
        cmac_b_resp_valid <= cmac_b2csb_resp_valid;
    end
end
always @(posedge autosa_core_clk) begin
    if ((cmac_b2csb_resp_valid) == 1'b1) begin
        cmac_b_resp_pd <= cmac_b2csb_resp_pd;
    end
end
//////////////// for CACC ////////////////
//#ifdef BASEADDR_FOR_FULL
//assign select_cacc = ((core_byte_addr & addr_mask) == 32'h00009000);
//#else
assign select_cacc = ((core_byte_addr & addr_mask) == 32'h00007000);
//#endif
assign cacc_req_pvld_w = (core_req_pop_valid & select_cacc) ? 1'b1 :
                         (csb2cacc_req_prdy | ~csb2cacc_req_pvld) ? 1'b0 :
                         cacc_req_pvld;
assign csb2cacc_req_pvld_w = cacc_req_pvld ? 1'b1 :
                             csb2cacc_req_prdy ? 1'b0 :
                             csb2cacc_req_pvld;
assign csb2cacc_req_en = cacc_req_pvld & (csb2cacc_req_prdy | ~csb2cacc_req_pvld);
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        cacc_req_pvld <= 1'b0;
    end else begin
        cacc_req_pvld <= cacc_req_pvld_w;
    end
end
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        csb2cacc_req_pvld <= 1'b0;
    end else begin
        csb2cacc_req_pvld <= csb2cacc_req_pvld_w;
    end
end
always @(posedge autosa_core_clk) begin
    if ((csb2cacc_req_en) == 1'b1) begin
        csb2cacc_req_pd_tmp <= core_req_pd_d1;
    end
end
assign csb2cacc_req_pd ={7'h0,csb2cacc_req_pd_tmp[49:16],6'h0,csb2cacc_req_pd_tmp[15:0]};
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        cacc_resp_valid <= 1'b0;
    end else begin
        cacc_resp_valid <= cacc2csb_resp_valid;
    end
end
always @(posedge autosa_core_clk) begin
    if ((cacc2csb_resp_valid) == 1'b1) begin
        cacc_resp_pd <= cacc2csb_resp_pd;
    end
end
//////////////// for SDP_RDMA ////////////////
//#ifdef BASEADDR_FOR_FULL
//assign select_sdp_rdma = ((core_byte_addr & addr_mask) == 32'h0000a000);
//#else
assign select_sdp_rdma = ((core_byte_addr & addr_mask) == 32'h00008000);
//#endif
assign sdp_rdma_req_pvld_w = (core_req_pop_valid & select_sdp_rdma) ? 1'b1 :
                             (csb2sdp_rdma_req_prdy | ~csb2sdp_rdma_req_pvld) ? 1'b0 :
                             sdp_rdma_req_pvld;
assign csb2sdp_rdma_req_pvld_w = sdp_rdma_req_pvld ? 1'b1 :
                                 csb2sdp_rdma_req_prdy ? 1'b0 :
                                 csb2sdp_rdma_req_pvld;
assign csb2sdp_rdma_req_en = sdp_rdma_req_pvld & (csb2sdp_rdma_req_prdy | ~csb2sdp_rdma_req_pvld);
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        sdp_rdma_req_pvld <= 1'b0;
    end else begin
        sdp_rdma_req_pvld <= sdp_rdma_req_pvld_w;
    end
end
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        csb2sdp_rdma_req_pvld <= 1'b0;
    end else begin
        csb2sdp_rdma_req_pvld <= csb2sdp_rdma_req_pvld_w;
    end
end
always @(posedge autosa_core_clk) begin
    if ((csb2sdp_rdma_req_en) == 1'b1) begin
        csb2sdp_rdma_req_pd_tmp <= core_req_pd_d1;
    end
end
assign csb2sdp_rdma_req_pd ={7'h0,csb2sdp_rdma_req_pd_tmp[49:16],6'h0,csb2sdp_rdma_req_pd_tmp[15:0]};
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        sdp_rdma_resp_valid <= 1'b0;
    end else begin
        sdp_rdma_resp_valid <= sdp_rdma2csb_resp_valid;
    end
end
always @(posedge autosa_core_clk) begin
    if ((sdp_rdma2csb_resp_valid) == 1'b1) begin
        sdp_rdma_resp_pd <= sdp_rdma2csb_resp_pd;
    end
end
//////////////// for SDP ////////////////
//#ifdef BASEADDR_FOR_FULL
//assign select_sdp = ((core_byte_addr & addr_mask) == 32'h0000b000);
//#else
assign select_sdp = ((core_byte_addr & addr_mask) == 32'h00009000);
//#endif
assign sdp_req_pvld_w = (core_req_pop_valid & select_sdp) ? 1'b1 :
                        (csb2sdp_req_prdy | ~csb2sdp_req_pvld) ? 1'b0 :
                        sdp_req_pvld;
assign csb2sdp_req_pvld_w = sdp_req_pvld ? 1'b1 :
                            csb2sdp_req_prdy ? 1'b0 :
                            csb2sdp_req_pvld;
assign csb2sdp_req_en = sdp_req_pvld & (csb2sdp_req_prdy | ~csb2sdp_req_pvld);
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        sdp_req_pvld <= 1'b0;
    end else begin
        sdp_req_pvld <= sdp_req_pvld_w;
    end
end
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        csb2sdp_req_pvld <= 1'b0;
    end else begin
        csb2sdp_req_pvld <= csb2sdp_req_pvld_w;
    end
end
always @(posedge autosa_core_clk) begin
    if ((csb2sdp_req_en) == 1'b1) begin
        csb2sdp_req_pd_tmp <= core_req_pd_d1;
    end
end
assign csb2sdp_req_pd ={7'h0,csb2sdp_req_pd_tmp[49:16],6'h0,csb2sdp_req_pd_tmp[15:0]};
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        sdp_resp_valid <= 1'b0;
    end else begin
        sdp_resp_valid <= sdp2csb_resp_valid;
    end
end
always @(posedge autosa_core_clk) begin
    if ((sdp2csb_resp_valid) == 1'b1) begin
        sdp_resp_pd <= sdp2csb_resp_pd;
    end
end
//////////////// for PDP_RDMA ////////////////
//#ifdef BASEADDR_FOR_FULL
//assign select_pdp_rdma = ((core_byte_addr & addr_mask) == 32'h0000c000);
//#else
assign select_pdp_rdma = ((core_byte_addr & addr_mask) == 32'h0000a000);
//#endif
assign pdp_rdma_req_pvld_w = (core_req_pop_valid & select_pdp_rdma) ? 1'b1 :
                             (csb2pdp_rdma_req_prdy | ~csb2pdp_rdma_req_pvld) ? 1'b0 :
                             pdp_rdma_req_pvld;
assign csb2pdp_rdma_req_pvld_w = pdp_rdma_req_pvld ? 1'b1 :
                                 csb2pdp_rdma_req_prdy ? 1'b0 :
                                 csb2pdp_rdma_req_pvld;
assign csb2pdp_rdma_req_en = pdp_rdma_req_pvld & (csb2pdp_rdma_req_prdy | ~csb2pdp_rdma_req_pvld);
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        pdp_rdma_req_pvld <= 1'b0;
    end else begin
        pdp_rdma_req_pvld <= pdp_rdma_req_pvld_w;
    end
end
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        csb2pdp_rdma_req_pvld <= 1'b0;
    end else begin
        csb2pdp_rdma_req_pvld <= csb2pdp_rdma_req_pvld_w;
    end
end
always @(posedge autosa_core_clk) begin
    if ((csb2pdp_rdma_req_en) == 1'b1) begin
        csb2pdp_rdma_req_pd_tmp <= core_req_pd_d1;
    end
end
assign csb2pdp_rdma_req_pd ={7'h0,csb2pdp_rdma_req_pd_tmp[49:16],6'h0,csb2pdp_rdma_req_pd_tmp[15:0]};
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        pdp_rdma_resp_valid <= 1'b0;
    end else begin
        pdp_rdma_resp_valid <= pdp_rdma2csb_resp_valid;
    end
end
always @(posedge autosa_core_clk) begin
    if ((pdp_rdma2csb_resp_valid) == 1'b1) begin
        pdp_rdma_resp_pd <= pdp_rdma2csb_resp_pd;
    end
end
//////////////// for PDP ////////////////
//#ifdef BASEADDR_FOR_FULL
//assign select_pdp = ((core_byte_addr & addr_mask) == 32'h0000d000);
//#else
assign select_pdp = ((core_byte_addr & addr_mask) == 32'h0000b000);
//#endif
assign pdp_req_pvld_w = (core_req_pop_valid & select_pdp) ? 1'b1 :
                        (csb2pdp_req_prdy | ~csb2pdp_req_pvld) ? 1'b0 :
                        pdp_req_pvld;
assign csb2pdp_req_pvld_w = pdp_req_pvld ? 1'b1 :
                            csb2pdp_req_prdy ? 1'b0 :
                            csb2pdp_req_pvld;
assign csb2pdp_req_en = pdp_req_pvld & (csb2pdp_req_prdy | ~csb2pdp_req_pvld);
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        pdp_req_pvld <= 1'b0;
    end else begin
        pdp_req_pvld <= pdp_req_pvld_w;
    end
end
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        csb2pdp_req_pvld <= 1'b0;
    end else begin
        csb2pdp_req_pvld <= csb2pdp_req_pvld_w;
    end
end
always @(posedge autosa_core_clk) begin
    if ((csb2pdp_req_en) == 1'b1) begin
        csb2pdp_req_pd_tmp <= core_req_pd_d1;
    end
end
assign csb2pdp_req_pd ={7'h0,csb2pdp_req_pd_tmp[49:16],6'h0,csb2pdp_req_pd_tmp[15:0]};
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        pdp_resp_valid <= 1'b0;
    end else begin
        pdp_resp_valid <= pdp2csb_resp_valid;
    end
end
always @(posedge autosa_core_clk) begin
    if ((pdp2csb_resp_valid) == 1'b1) begin
        pdp_resp_pd <= pdp2csb_resp_pd;
    end
end
//////////////// for CDP_RDMA ////////////////
//#ifdef BASEADDR_FOR_FULL
//assign select_cdp_rdma = ((core_byte_addr & addr_mask) == 32'h0000e000);
//#else
assign select_cdp_rdma = ((core_byte_addr & addr_mask) == 32'h0000c000);
//#endif
assign cdp_rdma_req_pvld_w = (core_req_pop_valid & select_cdp_rdma) ? 1'b1 :
                             (csb2cdp_rdma_req_prdy | ~csb2cdp_rdma_req_pvld) ? 1'b0 :
                             cdp_rdma_req_pvld;
assign csb2cdp_rdma_req_pvld_w = cdp_rdma_req_pvld ? 1'b1 :
                                 csb2cdp_rdma_req_prdy ? 1'b0 :
                                 csb2cdp_rdma_req_pvld;
assign csb2cdp_rdma_req_en = cdp_rdma_req_pvld & (csb2cdp_rdma_req_prdy | ~csb2cdp_rdma_req_pvld);
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        cdp_rdma_req_pvld <= 1'b0;
    end else begin
        cdp_rdma_req_pvld <= cdp_rdma_req_pvld_w;
    end
end
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        csb2cdp_rdma_req_pvld <= 1'b0;
    end else begin
        csb2cdp_rdma_req_pvld <= csb2cdp_rdma_req_pvld_w;
    end
end
always @(posedge autosa_core_clk) begin
    if ((csb2cdp_rdma_req_en) == 1'b1) begin
        csb2cdp_rdma_req_pd_tmp <= core_req_pd_d1;
    end
end
assign csb2cdp_rdma_req_pd ={7'h0,csb2cdp_rdma_req_pd_tmp[49:16],6'h0,csb2cdp_rdma_req_pd_tmp[15:0]};
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        cdp_rdma_resp_valid <= 1'b0;
    end else begin
        cdp_rdma_resp_valid <= cdp_rdma2csb_resp_valid;
    end
end
always @(posedge autosa_core_clk) begin
    if ((cdp_rdma2csb_resp_valid) == 1'b1) begin
        cdp_rdma_resp_pd <= cdp_rdma2csb_resp_pd;
    end
end
//////////////// for CDP ////////////////
//#ifdef BASEADDR_FOR_FULL
//assign select_cdp = ((core_byte_addr & addr_mask) == 32'h0000f000);
//#else
assign select_cdp = ((core_byte_addr & addr_mask) == 32'h0000d000);
//#endif
assign cdp_req_pvld_w = (core_req_pop_valid & select_cdp) ? 1'b1 :
                        (csb2cdp_req_prdy | ~csb2cdp_req_pvld) ? 1'b0 :
                        cdp_req_pvld;
assign csb2cdp_req_pvld_w = cdp_req_pvld ? 1'b1 :
                            csb2cdp_req_prdy ? 1'b0 :
                            csb2cdp_req_pvld;
assign csb2cdp_req_en = cdp_req_pvld & (csb2cdp_req_prdy | ~csb2cdp_req_pvld);
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        cdp_req_pvld <= 1'b0;
    end else begin
        cdp_req_pvld <= cdp_req_pvld_w;
    end
end
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        csb2cdp_req_pvld <= 1'b0;
    end else begin
        csb2cdp_req_pvld <= csb2cdp_req_pvld_w;
    end
end
always @(posedge autosa_core_clk) begin
    if ((csb2cdp_req_en) == 1'b1) begin
        csb2cdp_req_pd_tmp <= core_req_pd_d1;
    end
end
assign csb2cdp_req_pd ={7'h0,csb2cdp_req_pd_tmp[49:16],6'h0,csb2cdp_req_pd_tmp[15:0]};
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        cdp_resp_valid <= 1'b0;
    end else begin
        cdp_resp_valid <= cdp2csb_resp_valid;
    end
end
always @(posedge autosa_core_clk) begin
    if ((cdp2csb_resp_valid) == 1'b1) begin
        cdp_resp_pd <= cdp2csb_resp_pd;
    end
end
assign select_rbk = 1'b0;
//////////////// for DUMMY ////////////////
////////////////// dummy client //////////////////////
assign select_dummy = ~(select_cfgrom
                      | select_glb
                      | select_mcif
                      | select_bdma
                      | select_cdma
                      | select_csc
                      | select_cmac_a
                      | select_cmac_b
                      | select_cacc
                      | select_sdp_rdma
                      | select_sdp
                      | select_pdp_rdma
                      | select_pdp
                      | select_cdp
                      | select_cdp_rdma
                      | select_rbk);
assign dummy_req_pvld_w = (core_req_pop_valid & select_dummy);
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        csb2dummy_req_pvld <= 1'b0;
    end else begin
        csb2dummy_req_pvld <= dummy_req_pvld_w;
    end
end
always @(posedge autosa_core_clk) begin
    if ((dummy_req_pvld_w) == 1'b1) begin
        csb2dummy_req_nposted <= core_req_nposted;
    end
end
always @(posedge autosa_core_clk) begin
    if ((dummy_req_pvld_w) == 1'b1) begin
        csb2dummy_req_read <= ~core_req_write;
    end
end
assign dummy_rresp_pd[31:0] = dummy_resp_rdat[31:0];
assign dummy_rresp_pd[32] = dummy_resp_error ;
assign dummy_rresp_pd[33:33] = 1'd0 /* PKT_autosa_xx2csb_resp_dla_xx2csb_rd_erpt_ID  */ ;
assign dummy_wresp_pd[31:0] = dummy_resp_rdat[31:0];
assign dummy_wresp_pd[32] = dummy_resp_error ;
assign dummy_wresp_pd[33:33] = 1'd1 /* PKT_autosa_xx2csb_resp_dla_xx2csb_wr_erpt_ID  */ ;
assign dummy_resp_rdat = {32 {1'b0}};
assign dummy_resp_error = 1'b0;
assign dummy_resp_valid_w = csb2dummy_req_pvld & (csb2dummy_req_nposted | csb2dummy_req_read);
assign dummy_resp_type_w = ~csb2dummy_req_read & csb2dummy_req_nposted;
assign dummy_resp_pd = dummy_resp_type ? dummy_wresp_pd : dummy_rresp_pd;
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        dummy_resp_valid <= 1'b0;
    end else begin
        dummy_resp_valid <= dummy_resp_valid_w;
    end
end
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        dummy_resp_type <= 1'b0;
    end else begin
        if ((dummy_resp_valid_w) == 1'b1) begin
            dummy_resp_type <= dummy_resp_type_w;
        end
    end
end
//////////////// assimble ////////////////
assign core_resp_pd = ( ({34 {cfgrom_resp_valid}} & cfgrom_resp_pd)
                      | ({34 {glb_resp_valid}} & glb_resp_pd)
                      | ({34 {mcif_resp_valid}} & mcif_resp_pd)
                      | ({34 {cdma_resp_valid}} & cdma_resp_pd)
                      | ({34 {csc_resp_valid}} & csc_resp_pd)
                      | ({34 {cmac_a_resp_valid}} & cmac_a_resp_pd)
                      | ({34 {cmac_b_resp_valid}} & cmac_b_resp_pd)
                      | ({34 {cacc_resp_valid}} & cacc_resp_pd)
                      | ({34 {sdp_rdma_resp_valid}} & sdp_rdma_resp_pd)
                      | ({34 {sdp_resp_valid}} & sdp_resp_pd)
                      | ({34 {pdp_rdma_resp_valid}} & pdp_rdma_resp_pd)
                      | ({34 {pdp_resp_valid}} & pdp_resp_pd)
                      | ({34 {cdp_resp_valid}} & cdp_resp_pd)
                      | ({34 {cdp_rdma_resp_valid}} & cdp_rdma_resp_pd)
                      | ({34 {dummy_resp_valid}} & dummy_resp_pd));
assign core_resp_pvld = cfgrom_resp_valid |
                        glb_resp_valid |
                        mcif_resp_valid |
                        cdma_resp_valid |
                        csc_resp_valid |
                        cmac_a_resp_valid |
                        cmac_b_resp_valid |
                        cacc_resp_valid |
                        sdp_rdma_resp_valid |
                        sdp_resp_valid |
                        pdp_rdma_resp_valid |
                        pdp_resp_valid |
                        cdp_rdma_resp_valid |
                        cdp_resp_valid |
                        dummy_resp_valid;
//////////////////////////////////////////////////////////////
///// functional point                                   /////
//////////////////////////////////////////////////////////////
//VCS coverage off
`ifndef DISABLE_FUNCPOINT
  `ifdef ENABLE_FUNCPOINT
    reg funcpoint_cover_off;
    initial begin
        if ( $test$plusargs( "cover_off" ) ) begin
            funcpoint_cover_off = 1'b1;
        end else begin
            funcpoint_cover_off = 1'b0;
        end
    end
    property csb_master__read_dummy_client__0_cov;
        disable iff((autosa_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge autosa_core_clk)
        (core_req_pop_valid & ~core_req_write & select_dummy);
    endproperty
// Cover 0 : "(core_req_pop_valid & ~core_req_write & select_dummy)"
    FUNCPOINT_csb_master__read_dummy_client__0_COV : cover property (csb_master__read_dummy_client__0_cov);
  `endif
`endif
//VCS coverage on
//VCS coverage off
`ifndef DISABLE_FUNCPOINT
  `ifdef ENABLE_FUNCPOINT
    property csb_master__posted_write_dummy_client__1_cov;
        disable iff((autosa_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge autosa_core_clk)
        (core_req_pop_valid & core_req_write & ~core_req_nposted & select_dummy);
    endproperty
// Cover 1 : "(core_req_pop_valid & core_req_write & ~core_req_nposted & select_dummy)"
    FUNCPOINT_csb_master__posted_write_dummy_client__1_COV : cover property (csb_master__posted_write_dummy_client__1_cov);
  `endif
`endif
//VCS coverage on
//VCS coverage off
`ifndef DISABLE_FUNCPOINT
  `ifdef ENABLE_FUNCPOINT
    property csb_master__non_posted_dummy_client__2_cov;
        disable iff((autosa_core_rstn !== 1) || funcpoint_cover_off)
        @(posedge autosa_core_clk)
        (core_req_pop_valid & core_req_write & core_req_nposted & select_dummy);
    endproperty
// Cover 2 : "(core_req_pop_valid & core_req_write & core_req_nposted & select_dummy)"
    FUNCPOINT_csb_master__non_posted_dummy_client__2_COV : cover property (csb_master__non_posted_dummy_client__2_cov);
  `endif
`endif
//VCS coverage on
////////////////////////////////////////////////////////////////////////
// Assertion //
////////////////////////////////////////////////////////////////////////
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML
// spyglass disable_block STARC-2.10.3.2a
// spyglass disable_block STARC05-2.1.3.1
// spyglass disable_block STARC-2.1.4.6
// spyglass disable_block W116
// spyglass disable_block W154
// spyglass disable_block W239
// spyglass disable_block W362
// spyglass disable_block WRN_58
// spyglass disable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET autosa_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET autosa_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === autosa_core_rstn) ? 1'b0 : autosa_core_rstn)
`else
`define ASSERT_RESET ((1'bx === autosa_core_rstn) ? 1'b1 : autosa_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
`ifndef SYNTHESIS
// VCS coverage off
  sa_assert_no_x #(0,1,0,"No X's allowed on control signals") zzz_assert_no_x_2x (autosa_core_clk, `ASSERT_RESET, 1'd1, (^(dummy_resp_valid_w))); // spyglass disable W504 SelfDeterminedExpr-ML 
  sa_assert_never #(0,0,"Error! core response fifo block!") zzz_assert_never_1x (autosa_core_clk, `ASSERT_RESET, (core_resp_pvld & ~core_resp_prdy)); // spyglass disable W504 SelfDeterminedExpr-ML 
  sa_assert_zero_one_hot #(0,19,0,"Error! Multiple response!") zzz_assert_zero_one_hot_3x (autosa_core_clk, `ASSERT_RESET, {cfgrom2csb_resp_valid,
                                                                                                                             glb2csb_resp_valid,
                                                                                                                             mcif2csb_resp_valid,
                                                                                                                             bdma2csb_resp_valid,
                                                                                                                             cdma2csb_resp_valid,
                                                                                                                             csc2csb_resp_valid,
                                                                                                                             cmac_a2csb_resp_valid,
                                                                                                                             cmac_b2csb_resp_valid,
                                                                                                                             cacc2csb_resp_valid,
                                                                                                                             sdp_rdma2csb_resp_valid,
                                                                                                                             sdp2csb_resp_valid,
                                                                                                                             pdp_rdma2csb_resp_valid,
                                                                                                                             pdp2csb_resp_valid,
                                                                                                                             cdp_rdma2csb_resp_valid,
                                                                                                                             cdp2csb_resp_valid,
                                                                                                                             rbk2csb_resp_valid,
                                                                                                                             dummy_resp_valid}); // spyglass disable W504 SelfDeterminedExpr-ML 
// VCS coverage on
`endif
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML
// spyglass enable_block STARC-2.10.3.2a
// spyglass enable_block STARC05-2.1.3.1
// spyglass enable_block STARC-2.1.4.6
// spyglass enable_block W116
// spyglass enable_block W154
// spyglass enable_block W239
// spyglass enable_block W362
// spyglass enable_block WRN_58
// spyglass enable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
endmodule // SA_AUTOSA_csb_master
