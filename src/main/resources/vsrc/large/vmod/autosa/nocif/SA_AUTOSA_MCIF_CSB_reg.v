// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_MCIF_CSB_reg.v
module SA_AUTOSA_MCIF_CSB_reg (
   reg_rd_data
  ,reg_offset
// verilint 498 off
// leda UNUSED_DEC off
  ,reg_wr_data
// verilint 498 on
// leda UNUSED_DEC on
  ,reg_wr_en
  ,autosa_core_clk
  ,autosa_core_rstn
  ,rd_os_cnt
  ,wr_os_cnt
  ,rd_weight_bdma
  ,rd_weight_cdp
  ,rd_weight_pdp
  ,rd_weight_sdp
  ,rd_weight_cdma_dat
  ,rd_weight_sdp_b
  ,rd_weight_sdp_e
  ,rd_weight_sdp_n
  ,rd_weight_cdma_wt
  ,rd_weight_rbk
  ,rd_weight_rsv_0
  ,rd_weight_rsv_1
  ,wr_weight_bdma
  ,wr_weight_cdp
  ,wr_weight_pdp
  ,wr_weight_sdp
  ,wr_weight_rbk
  ,wr_weight_rsv_0
  ,wr_weight_rsv_1
  ,wr_weight_rsv_2
  ,idle
  );
wire [31:0] autosa_mcif_cfg_outstanding_cnt_0_out;
wire [31:0] autosa_mcif_cfg_rd_weight_0_0_out;
wire [31:0] autosa_mcif_cfg_rd_weight_1_0_out;
wire [31:0] autosa_mcif_cfg_rd_weight_2_0_out;
wire [31:0] autosa_mcif_cfg_wr_weight_0_0_out;
wire [31:0] autosa_mcif_cfg_wr_weight_1_0_out;
wire [31:0] autosa_mcif_status_0_out;
wire [11:0] reg_offset_rd_int;
wire [31:0] reg_offset_wr;
// Register control interface
output [31:0] reg_rd_data;
input [11:0] reg_offset;
input [31:0] reg_wr_data; //(UNUSED_DEC)
input reg_wr_en;
input autosa_core_clk;
input autosa_core_rstn;
// Writable register flop/trigger outputs
output [7:0] rd_os_cnt;
output [7:0] wr_os_cnt;
output [7:0] rd_weight_bdma;
output [7:0] rd_weight_cdp;
output [7:0] rd_weight_pdp;
output [7:0] rd_weight_sdp;
output [7:0] rd_weight_cdma_dat;
output [7:0] rd_weight_sdp_b;
output [7:0] rd_weight_sdp_e;
output [7:0] rd_weight_sdp_n;
output [7:0] rd_weight_cdma_wt;
output [7:0] rd_weight_rbk;
output [7:0] rd_weight_rsv_0;
output [7:0] rd_weight_rsv_1;
output [7:0] wr_weight_bdma;
output [7:0] wr_weight_cdp;
output [7:0] wr_weight_pdp;
output [7:0] wr_weight_sdp;
output [7:0] wr_weight_rbk;
output [7:0] wr_weight_rsv_0;
output [7:0] wr_weight_rsv_1;
output [7:0] wr_weight_rsv_2;
// Read-only register inputs
input idle;
// wr_mask register inputs
// rstn register inputs
// leda FM_2_23 off
reg arreggen_abort_on_invalid_wr;
reg arreggen_abort_on_rowr;
reg arreggen_dump;
// leda FM_2_23 on
reg [7:0] rd_os_cnt;
reg [7:0] rd_weight_bdma;
reg [7:0] rd_weight_cdma_dat;
reg [7:0] rd_weight_cdma_wt;
reg [7:0] rd_weight_cdp;
reg [7:0] rd_weight_pdp;
reg [7:0] rd_weight_rbk;
reg [7:0] rd_weight_rsv_0;
reg [7:0] rd_weight_rsv_1;
reg [7:0] rd_weight_sdp;
reg [7:0] rd_weight_sdp_b;
reg [7:0] rd_weight_sdp_e;
reg [7:0] rd_weight_sdp_n;
reg [31:0] reg_rd_data;
reg [7:0] wr_os_cnt;
reg [7:0] wr_weight_bdma;
reg [7:0] wr_weight_cdp;
reg [7:0] wr_weight_pdp;
reg [7:0] wr_weight_rbk;
reg [7:0] wr_weight_rsv_0;
reg [7:0] wr_weight_rsv_1;
reg [7:0] wr_weight_rsv_2;
reg [7:0] wr_weight_sdp;
assign reg_offset_wr = {20'b0 , reg_offset};
// SCR signals
// Address decode
wire autosa_mcif_cfg_outstanding_cnt_0_wren = (reg_offset_wr == (32'h2014 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_mcif_cfg_rd_weight_0_0_wren = (reg_offset_wr == (32'h2000 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_mcif_cfg_rd_weight_1_0_wren = (reg_offset_wr == (32'h2004 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_mcif_cfg_rd_weight_2_0_wren = (reg_offset_wr == (32'h2008 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_mcif_cfg_wr_weight_0_0_wren = (reg_offset_wr == (32'h200c & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_mcif_cfg_wr_weight_1_0_wren = (reg_offset_wr == (32'h2010 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_mcif_status_0_wren = (reg_offset_wr == (32'h2018 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
assign autosa_mcif_cfg_outstanding_cnt_0_out[31:0] = { 16'b0, wr_os_cnt, rd_os_cnt };
assign autosa_mcif_cfg_rd_weight_0_0_out[31:0] = { rd_weight_cdp, rd_weight_pdp, rd_weight_sdp, rd_weight_bdma };
assign autosa_mcif_cfg_rd_weight_1_0_out[31:0] = { rd_weight_cdma_dat, rd_weight_sdp_e, rd_weight_sdp_n, rd_weight_sdp_b };
assign autosa_mcif_cfg_rd_weight_2_0_out[31:0] = { rd_weight_rsv_0, rd_weight_rsv_1, rd_weight_rbk, rd_weight_cdma_wt };
assign autosa_mcif_cfg_wr_weight_0_0_out[31:0] = { wr_weight_cdp, wr_weight_pdp, wr_weight_sdp, wr_weight_bdma };
assign autosa_mcif_cfg_wr_weight_1_0_out[31:0] = { wr_weight_rsv_0, wr_weight_rsv_1, wr_weight_rsv_2, wr_weight_rbk };
assign autosa_mcif_status_0_out[31:0] = { 23'b0, idle, 8'b0 };
assign reg_offset_rd_int = reg_offset;
// Output mux
//spyglass disable_block W338, W263
always @(
  reg_offset_rd_int
  or autosa_mcif_cfg_outstanding_cnt_0_out
  or autosa_mcif_cfg_rd_weight_0_0_out
  or autosa_mcif_cfg_rd_weight_1_0_out
  or autosa_mcif_cfg_rd_weight_2_0_out
  or autosa_mcif_cfg_wr_weight_0_0_out
  or autosa_mcif_cfg_wr_weight_1_0_out
  or autosa_mcif_status_0_out
  ) begin
  case (reg_offset_rd_int)
     (32'h2014 & 32'h00000fff): begin
                            reg_rd_data = autosa_mcif_cfg_outstanding_cnt_0_out ;
                            end
     (32'h2000 & 32'h00000fff): begin
                            reg_rd_data = autosa_mcif_cfg_rd_weight_0_0_out ;
                            end
     (32'h2004 & 32'h00000fff): begin
                            reg_rd_data = autosa_mcif_cfg_rd_weight_1_0_out ;
                            end
     (32'h2008 & 32'h00000fff): begin
                            reg_rd_data = autosa_mcif_cfg_rd_weight_2_0_out ;
                            end
     (32'h200c & 32'h00000fff): begin
                            reg_rd_data = autosa_mcif_cfg_wr_weight_0_0_out ;
                            end
     (32'h2010 & 32'h00000fff): begin
                            reg_rd_data = autosa_mcif_cfg_wr_weight_1_0_out ;
                            end
     (32'h2018 & 32'h00000fff): begin
                            reg_rd_data = autosa_mcif_status_0_out ;
                            end
    default: reg_rd_data = {32{1'b0}};
  endcase
end
//spyglass enable_block W338, W263
// spyglass disable_block STARC-2.10.1.6, NoConstWithXZ, W443
// Register flop declarations
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
  if (!autosa_core_rstn) begin
    rd_os_cnt[7:0] <= 8'b11111111;
    wr_os_cnt[7:0] <= 8'b11111111;
    rd_weight_bdma[7:0] <= 8'b00000001;
    rd_weight_cdp[7:0] <= 8'b00000001;
    rd_weight_pdp[7:0] <= 8'b00000001;
    rd_weight_sdp[7:0] <= 8'b00000001;
    rd_weight_cdma_dat[7:0] <= 8'b00000001;
    rd_weight_sdp_b[7:0] <= 8'b00000001;
    rd_weight_sdp_e[7:0] <= 8'b00000001;
    rd_weight_sdp_n[7:0] <= 8'b00000001;
    rd_weight_cdma_wt[7:0] <= 8'b00000001;
    rd_weight_rbk[7:0] <= 8'b00000001;
    rd_weight_rsv_0[7:0] <= 8'b00000001;
    rd_weight_rsv_1[7:0] <= 8'b00000001;
    wr_weight_bdma[7:0] <= 8'b00000001;
    wr_weight_cdp[7:0] <= 8'b00000001;
    wr_weight_pdp[7:0] <= 8'b00000001;
    wr_weight_sdp[7:0] <= 8'b00000001;
    wr_weight_rbk[7:0] <= 8'b00000001;
    wr_weight_rsv_0[7:0] <= 8'b00000001;
    wr_weight_rsv_1[7:0] <= 8'b00000001;
    wr_weight_rsv_2[7:0] <= 8'b00000001;
  end else begin
// Register: AUTOSA_MCIF_CFG_OUTSTANDING_CNT_0 Field: rd_os_cnt
  if (autosa_mcif_cfg_outstanding_cnt_0_wren) begin
    rd_os_cnt[7:0] <= reg_wr_data[7:0];
  end
// Register: AUTOSA_MCIF_CFG_OUTSTANDING_CNT_0 Field: wr_os_cnt
  if (autosa_mcif_cfg_outstanding_cnt_0_wren) begin
    wr_os_cnt[7:0] <= reg_wr_data[15:8];
  end
// Register: AUTOSA_MCIF_CFG_RD_WEIGHT_0_0 Field: rd_weight_bdma
  if (autosa_mcif_cfg_rd_weight_0_0_wren) begin
    rd_weight_bdma[7:0] <= reg_wr_data[7:0];
  end
// Register: AUTOSA_MCIF_CFG_RD_WEIGHT_0_0 Field: rd_weight_cdp
  if (autosa_mcif_cfg_rd_weight_0_0_wren) begin
    rd_weight_cdp[7:0] <= reg_wr_data[31:24];
  end
// Register: AUTOSA_MCIF_CFG_RD_WEIGHT_0_0 Field: rd_weight_pdp
  if (autosa_mcif_cfg_rd_weight_0_0_wren) begin
    rd_weight_pdp[7:0] <= reg_wr_data[23:16];
  end
// Register: AUTOSA_MCIF_CFG_RD_WEIGHT_0_0 Field: rd_weight_sdp
  if (autosa_mcif_cfg_rd_weight_0_0_wren) begin
    rd_weight_sdp[7:0] <= reg_wr_data[15:8];
  end
// Register: AUTOSA_MCIF_CFG_RD_WEIGHT_1_0 Field: rd_weight_cdma_dat
  if (autosa_mcif_cfg_rd_weight_1_0_wren) begin
    rd_weight_cdma_dat[7:0] <= reg_wr_data[31:24];
  end
// Register: AUTOSA_MCIF_CFG_RD_WEIGHT_1_0 Field: rd_weight_sdp_b
  if (autosa_mcif_cfg_rd_weight_1_0_wren) begin
    rd_weight_sdp_b[7:0] <= reg_wr_data[7:0];
  end
// Register: AUTOSA_MCIF_CFG_RD_WEIGHT_1_0 Field: rd_weight_sdp_e
  if (autosa_mcif_cfg_rd_weight_1_0_wren) begin
    rd_weight_sdp_e[7:0] <= reg_wr_data[23:16];
  end
// Register: AUTOSA_MCIF_CFG_RD_WEIGHT_1_0 Field: rd_weight_sdp_n
  if (autosa_mcif_cfg_rd_weight_1_0_wren) begin
    rd_weight_sdp_n[7:0] <= reg_wr_data[15:8];
  end
// Register: AUTOSA_MCIF_CFG_RD_WEIGHT_2_0 Field: rd_weight_cdma_wt
  if (autosa_mcif_cfg_rd_weight_2_0_wren) begin
    rd_weight_cdma_wt[7:0] <= reg_wr_data[7:0];
  end
// Register: AUTOSA_MCIF_CFG_RD_WEIGHT_2_0 Field: rd_weight_rbk
  if (autosa_mcif_cfg_rd_weight_2_0_wren) begin
    rd_weight_rbk[7:0] <= reg_wr_data[15:8];
  end
// Register: AUTOSA_MCIF_CFG_RD_WEIGHT_2_0 Field: rd_weight_rsv_0
  if (autosa_mcif_cfg_rd_weight_2_0_wren) begin
    rd_weight_rsv_0[7:0] <= reg_wr_data[31:24];
  end
// Register: AUTOSA_MCIF_CFG_RD_WEIGHT_2_0 Field: rd_weight_rsv_1
  if (autosa_mcif_cfg_rd_weight_2_0_wren) begin
    rd_weight_rsv_1[7:0] <= reg_wr_data[23:16];
  end
// Register: AUTOSA_MCIF_CFG_WR_WEIGHT_0_0 Field: wr_weight_bdma
  if (autosa_mcif_cfg_wr_weight_0_0_wren) begin
    wr_weight_bdma[7:0] <= reg_wr_data[7:0];
  end
// Register: AUTOSA_MCIF_CFG_WR_WEIGHT_0_0 Field: wr_weight_cdp
  if (autosa_mcif_cfg_wr_weight_0_0_wren) begin
    wr_weight_cdp[7:0] <= reg_wr_data[31:24];
  end
// Register: AUTOSA_MCIF_CFG_WR_WEIGHT_0_0 Field: wr_weight_pdp
  if (autosa_mcif_cfg_wr_weight_0_0_wren) begin
    wr_weight_pdp[7:0] <= reg_wr_data[23:16];
  end
// Register: AUTOSA_MCIF_CFG_WR_WEIGHT_0_0 Field: wr_weight_sdp
  if (autosa_mcif_cfg_wr_weight_0_0_wren) begin
    wr_weight_sdp[7:0] <= reg_wr_data[15:8];
  end
// Register: AUTOSA_MCIF_CFG_WR_WEIGHT_1_0 Field: wr_weight_rbk
  if (autosa_mcif_cfg_wr_weight_1_0_wren) begin
    wr_weight_rbk[7:0] <= reg_wr_data[7:0];
  end
// Register: AUTOSA_MCIF_CFG_WR_WEIGHT_1_0 Field: wr_weight_rsv_0
  if (autosa_mcif_cfg_wr_weight_1_0_wren) begin
    wr_weight_rsv_0[7:0] <= reg_wr_data[31:24];
  end
// Register: AUTOSA_MCIF_CFG_WR_WEIGHT_1_0 Field: wr_weight_rsv_1
  if (autosa_mcif_cfg_wr_weight_1_0_wren) begin
    wr_weight_rsv_1[7:0] <= reg_wr_data[23:16];
  end
// Register: AUTOSA_MCIF_CFG_WR_WEIGHT_1_0 Field: wr_weight_rsv_2
  if (autosa_mcif_cfg_wr_weight_1_0_wren) begin
    wr_weight_rsv_2[7:0] <= reg_wr_data[15:8];
  end
// Not generating flops for read-only field AUTOSA_MCIF_STATUS_0::idle
  end
end
// spyglass enable_block STARC-2.10.1.6, NoConstWithXZ, W443
// synopsys translate_off
// VCS coverage off
initial begin
  arreggen_dump = $test$plusargs("arreggen_dump_wr");
  arreggen_abort_on_rowr = $test$plusargs("arreggen_abort_on_rowr");
  arreggen_abort_on_invalid_wr = $test$plusargs("arreggen_abort_on_invalid_wr");
`ifdef VERILATOR
`else
  $timeformat(-9, 2, "ns", 15);
`endif
end
always @(posedge autosa_core_clk) begin
  if (reg_wr_en) begin
    case(reg_offset)
      (32'h2014 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_MCIF_CFG_OUTSTANDING_CNT_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_mcif_cfg_outstanding_cnt_0_out, autosa_mcif_cfg_outstanding_cnt_0_out);
      (32'h2000 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_MCIF_CFG_RD_WEIGHT_0_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_mcif_cfg_rd_weight_0_0_out, autosa_mcif_cfg_rd_weight_0_0_out);
      (32'h2004 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_MCIF_CFG_RD_WEIGHT_1_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_mcif_cfg_rd_weight_1_0_out, autosa_mcif_cfg_rd_weight_1_0_out);
      (32'h2008 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_MCIF_CFG_RD_WEIGHT_2_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_mcif_cfg_rd_weight_2_0_out, autosa_mcif_cfg_rd_weight_2_0_out);
      (32'h200c & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_MCIF_CFG_WR_WEIGHT_0_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_mcif_cfg_wr_weight_0_0_out, autosa_mcif_cfg_wr_weight_0_0_out);
      (32'h2010 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_MCIF_CFG_WR_WEIGHT_1_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_mcif_cfg_wr_weight_1_0_out, autosa_mcif_cfg_wr_weight_1_0_out);
      (32'h2018 & 32'h00000fff): begin
          if (arreggen_dump) $display("%t:%m: read-only reg wr: AUTOSA_MCIF_STATUS_0 = 0x%h", $time, reg_wr_data);
          if (arreggen_abort_on_rowr) begin $display("ERROR: write to read-only register!"); $finish; end
        end
      default: begin
          if (arreggen_dump) $display("%t:%m: reg wr: Unknown register (0x%h) = 0x%h", $time, reg_offset, reg_wr_data);
          if (arreggen_abort_on_invalid_wr) begin $display("ERROR: write to undefined register!"); $finish; end
        end
    endcase
  end
end
// VCS coverage on
// synopsys translate_on
endmodule // SA_AUTOSA_MCIF_CSB_reg
