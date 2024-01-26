// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================

module autosa_large
(
    input core_clk,
    input rstn,
    input csb_rstn,

    output dla_intr,
    // dbb AXI
    output autosa_core2dbb_aw_awvalid,
    input autosa_core2dbb_aw_awready,
    output [7:0] autosa_core2dbb_aw_awid,
    output [3:0] autosa_core2dbb_aw_awlen,
    output [2:0] autosa_core2dbb_aw_awsize,
    output [64 -1:0] autosa_core2dbb_aw_awaddr,
    output autosa_core2dbb_w_wvalid,
    input autosa_core2dbb_w_wready,
    output [256 -1:0] autosa_core2dbb_w_wdata,
    output [256/8-1:0] autosa_core2dbb_w_wstrb,
    output autosa_core2dbb_w_wlast,
    output autosa_core2dbb_ar_arvalid,
    input autosa_core2dbb_ar_arready,
    output [7:0] autosa_core2dbb_ar_arid,
    output [3:0] autosa_core2dbb_ar_arlen,
    output [2:0] autosa_core2dbb_ar_arsize,
    output [64 -1:0] autosa_core2dbb_ar_araddr,
    input autosa_core2dbb_b_bvalid,
    output autosa_core2dbb_b_bready,
    input [7:0] autosa_core2dbb_b_bid,
    input autosa_core2dbb_r_rvalid,
    output autosa_core2dbb_r_rready,
    input [7:0] autosa_core2dbb_r_rid,
    input autosa_core2dbb_r_rlast,
    input [256 -1:0] autosa_core2dbb_r_rdata,
    // cvsram AXI
    output autosa_core2cvsram_aw_awvalid,
    input autosa_core2cvsram_aw_awready,
    output [7:0] autosa_core2cvsram_aw_awid,
    output [3:0] autosa_core2cvsram_aw_awlen,
    output [2:0] autosa_core2cvsram_aw_awsize,
    output [64 -1:0] autosa_core2cvsram_aw_awaddr,
    output autosa_core2cvsram_w_wvalid,
    input autosa_core2cvsram_w_wready,
    output [256 -1:0] autosa_core2cvsram_w_wdata,
    output [256/8-1:0] autosa_core2cvsram_w_wstrb,
    output autosa_core2cvsram_w_wlast,
    input autosa_core2cvsram_b_bvalid,
    output autosa_core2cvsram_b_bready,
    input [7:0] autosa_core2cvsram_b_bid,
    output autosa_core2cvsram_ar_arvalid,
    input autosa_core2cvsram_ar_arready,
    output [7:0] autosa_core2cvsram_ar_arid,
    output [3:0] autosa_core2cvsram_ar_arlen,
    output [2:0] autosa_core2cvsram_ar_arsize,
    output [64 -1:0] autosa_core2cvsram_ar_araddr,
    input autosa_core2cvsram_r_rvalid,
    output autosa_core2cvsram_r_rready,
    input [7:0] autosa_core2cvsram_r_rid,
    input autosa_core2cvsram_r_rlast,
    input [256 -1:0] autosa_core2cvsram_r_rdata,
    // cfg APB
    input psel,
    input penable,
    input pwrite,
    input [31:0] paddr,
    input [31:0] pwdata,
    output [31:0] prdata,
    output pready
);

wire        m_csb2autosa_valid;
wire        m_csb2autosa_ready;
wire [15:0] m_csb2autosa_addr;
wire [31:0] m_csb2autosa_wdat;
wire        m_csb2autosa_write;
wire        m_csb2autosa_nposted;
wire        m_autosa2csb_valid;
wire [31:0] m_autosa2csb_data;

wire csb_clk;
assign csb_clk = core_clk;

SA_AUTOSA_apb2csb apb2csb (
   .pclk                  (csb_clk)
  ,.prstn                 (csb_rstn)
  ,.csb2autosa_ready       (m_csb2autosa_ready)
  ,.autosa2csb_data        (m_autosa2csb_data)
  ,.autosa2csb_valid       (m_autosa2csb_valid)
  ,.paddr                 (paddr)
  ,.penable               (penable)
  ,.psel                  (psel)
  ,.pwdata                (pwdata)
  ,.pwrite                (pwrite)
  ,.csb2autosa_addr        (m_csb2autosa_addr)
  ,.csb2autosa_nposted     (m_csb2autosa_nposted)
  ,.csb2autosa_valid       (m_csb2autosa_valid)
  ,.csb2autosa_wdat        (m_csb2autosa_wdat)
  ,.csb2autosa_write       (m_csb2autosa_write)
  ,.prdata                (prdata)
  ,.pready                (pready)
);


SA_autosa autosa_top (
   .dla_core_clk                    (core_clk)
  ,.dla_csb_clk                     (csb_clk)
  ,.global_clk_ovr_on               (1'b0)
  ,.tmc2slcg_disable_clock_gating   (1'b0)
  ,.dla_reset_rstn                  (rstn)
  ,.direct_reset_                   (1'b1)
  ,.test_mode                       (1'b0)
  ,.csb2autosa_valid                 (m_csb2autosa_valid)
  ,.csb2autosa_ready                 (m_csb2autosa_ready)
  ,.csb2autosa_addr                  (m_csb2autosa_addr)
  ,.csb2autosa_wdat                  (m_csb2autosa_wdat)
  ,.csb2autosa_write                 (m_csb2autosa_write)
  ,.csb2autosa_nposted               (m_csb2autosa_nposted)
  ,.autosa2csb_valid                 (m_autosa2csb_valid)
  ,.autosa2csb_data                  (m_autosa2csb_data)
  ,.autosa2csb_wr_complete           () //FIXME: no such port in apb2csb
  ,.autosa_core2dbb_aw_awvalid       (autosa_core2dbb_aw_awvalid)
  ,.autosa_core2dbb_aw_awready       (autosa_core2dbb_aw_awready)
  ,.autosa_core2dbb_aw_awaddr        (autosa_core2dbb_aw_awaddr)
  ,.autosa_core2dbb_aw_awid          (autosa_core2dbb_aw_awid)
  ,.autosa_core2dbb_aw_awlen         (autosa_core2dbb_aw_awlen)
  ,.autosa_core2dbb_w_wvalid         (autosa_core2dbb_w_wvalid)
  ,.autosa_core2dbb_w_wready         (autosa_core2dbb_w_wready)
  ,.autosa_core2dbb_w_wdata          (autosa_core2dbb_w_wdata)
  ,.autosa_core2dbb_w_wstrb          (autosa_core2dbb_w_wstrb)
  ,.autosa_core2dbb_w_wlast          (autosa_core2dbb_w_wlast)
  ,.autosa_core2dbb_b_bvalid         (autosa_core2dbb_b_bvalid)
  ,.autosa_core2dbb_b_bready         (autosa_core2dbb_b_bready)
  ,.autosa_core2dbb_b_bid            (autosa_core2dbb_b_bid)
  ,.autosa_core2dbb_ar_arvalid       (autosa_core2dbb_ar_arvalid)
  ,.autosa_core2dbb_ar_arready       (autosa_core2dbb_ar_arready)
  ,.autosa_core2dbb_ar_araddr        (autosa_core2dbb_ar_araddr)
  ,.autosa_core2dbb_ar_arid          (autosa_core2dbb_ar_arid)
  ,.autosa_core2dbb_ar_arlen         (autosa_core2dbb_ar_arlen)
  ,.autosa_core2dbb_r_rvalid         (autosa_core2dbb_r_rvalid)
  ,.autosa_core2dbb_r_rready         (autosa_core2dbb_r_rready)
  ,.autosa_core2dbb_r_rid            (autosa_core2dbb_r_rid)
  ,.autosa_core2dbb_r_rlast          (autosa_core2dbb_r_rlast)
  ,.autosa_core2dbb_r_rdata          (autosa_core2dbb_r_rdata)

  ,.autosa_core2cvsram_aw_awvalid    (autosa_core2cvsram_aw_awvalid)
  ,.autosa_core2cvsram_aw_awready    (autosa_core2cvsram_aw_awready)
  ,.autosa_core2cvsram_aw_awaddr     (autosa_core2cvsram_aw_awaddr)
  ,.autosa_core2cvsram_aw_awid       (autosa_core2cvsram_aw_awid)
  ,.autosa_core2cvsram_aw_awlen      (autosa_core2cvsram_aw_awlen)
  ,.autosa_core2cvsram_w_wvalid      (autosa_core2cvsram_w_wvalid)
  ,.autosa_core2cvsram_w_wready      (autosa_core2cvsram_w_wready)
  ,.autosa_core2cvsram_w_wdata       (autosa_core2cvsram_w_wdata)
  ,.autosa_core2cvsram_w_wstrb       (autosa_core2cvsram_w_wstrb)
  ,.autosa_core2cvsram_w_wlast       (autosa_core2cvsram_w_wlast)
  ,.autosa_core2cvsram_b_bvalid      (autosa_core2cvsram_b_bvalid)
  ,.autosa_core2cvsram_b_bready      (autosa_core2cvsram_b_bready)
  ,.autosa_core2cvsram_b_bid         (autosa_core2cvsram_b_bid)
  ,.autosa_core2cvsram_ar_arvalid    (autosa_core2cvsram_ar_arvalid)
  ,.autosa_core2cvsram_ar_arready    (autosa_core2cvsram_ar_arready)
  ,.autosa_core2cvsram_ar_araddr     (autosa_core2cvsram_ar_araddr)
  ,.autosa_core2cvsram_ar_arid       (autosa_core2cvsram_ar_arid)
  ,.autosa_core2cvsram_ar_arlen      (autosa_core2cvsram_ar_arlen)
  ,.autosa_core2cvsram_r_rvalid      (autosa_core2cvsram_r_rvalid)
  ,.autosa_core2cvsram_r_rready      (autosa_core2cvsram_r_rready)
  ,.autosa_core2cvsram_r_rid         (autosa_core2cvsram_r_rid)
  ,.autosa_core2cvsram_r_rlast       (autosa_core2cvsram_r_rlast)
  ,.autosa_core2cvsram_r_rdata       (autosa_core2cvsram_r_rdata)

  ,.dla_intr                        (dla_intr)
  ,.autosa_pwrbus_ram_c_pd           (32'b0)
  ,.autosa_pwrbus_ram_ma_pd          (32'b0)
  ,.autosa_pwrbus_ram_mb_pd          (32'b0)
  ,.autosa_pwrbus_ram_p_pd           (32'b0)
  ,.autosa_pwrbus_ram_o_pd           (32'b0)
  ,.autosa_pwrbus_ram_a_pd           (32'b0)
); // autosa_top

assign autosa_core2dbb_aw_awsize = 3'b101;
assign autosa_core2dbb_ar_arsize = 3'b101;
assign autosa_core2cvsram_aw_awsize = 3'b101;
assign autosa_core2cvsram_ar_arsize = 3'b101;

endmodule
