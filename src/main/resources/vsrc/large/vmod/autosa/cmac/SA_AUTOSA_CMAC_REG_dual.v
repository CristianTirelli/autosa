// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_CMAC_REG_dual.v
module SA_AUTOSA_CMAC_REG_dual (
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
  ,cosa_mode
  ,proc_precision
  ,op_en_trigger
  ,op_en
  );
wire [31:0] autosa_cmac_a_d_misc_cfg_0_out;
wire [31:0] autosa_cmac_a_d_op_enable_0_out;
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
output cosa_mode;
output [1:0] proc_precision;
output op_en_trigger;
// Read-only register inputs
input op_en;
// wr_mask register inputs
// rstn register inputs
// leda FM_2_23 off
reg arreggen_abort_on_invalid_wr;
reg arreggen_abort_on_rowr;
reg arreggen_dump;
// leda FM_2_23 on
reg cosa_mode;
reg [1:0] proc_precision;
reg [31:0] reg_rd_data;
assign reg_offset_wr = {20'b0 , reg_offset};
// SCR signals
// Address decode
wire autosa_cmac_a_d_misc_cfg_0_wren = (reg_offset_wr == (32'h700c & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_cmac_a_d_op_enable_0_wren = (reg_offset_wr == (32'h7008 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
assign autosa_cmac_a_d_misc_cfg_0_out[31:0] = { 18'b0, proc_precision, 11'b0, cosa_mode };
assign autosa_cmac_a_d_op_enable_0_out[31:0] = { 31'b0, op_en };
assign op_en_trigger = autosa_cmac_a_d_op_enable_0_wren; //(W563)
assign reg_offset_rd_int = reg_offset;
// Output mux
//spyglass disable_block W338, W263
always @(
  reg_offset_rd_int
  or autosa_cmac_a_d_misc_cfg_0_out
  or autosa_cmac_a_d_op_enable_0_out
  ) begin
  case (reg_offset_rd_int)
     (32'h700c & 32'h00000fff): begin
                            reg_rd_data = autosa_cmac_a_d_misc_cfg_0_out ;
                            end
     (32'h7008 & 32'h00000fff): begin
                            reg_rd_data = autosa_cmac_a_d_op_enable_0_out ;
                            end
    default: reg_rd_data = {32{1'b0}};
  endcase
end
//spyglass enable_block W338, W263
// spyglass disable_block STARC-2.10.1.6, NoConstWithXZ, W443
// Register flop declarations
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
  if (!autosa_core_rstn) begin
    cosa_mode <= 1'b0;
    proc_precision[1:0] <= 2'b01;
  end else begin
// Register: AUTOSA_CMAC_A_D_MISC_CFG_0 Field: cosa_mode
  if (autosa_cmac_a_d_misc_cfg_0_wren) begin
    cosa_mode <= reg_wr_data[0];
  end
// Register: AUTOSA_CMAC_A_D_MISC_CFG_0 Field: proc_precision
  if (autosa_cmac_a_d_misc_cfg_0_wren) begin
    proc_precision[1:0] <= reg_wr_data[13:12];
  end
// Not generating flops for field AUTOSA_CMAC_A_D_OP_ENABLE_0::op_en (to be implemented outside)
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
      (32'h700c & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CMAC_A_D_MISC_CFG_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_cmac_a_d_misc_cfg_0_out, autosa_cmac_a_d_misc_cfg_0_out);
      (32'h7008 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CMAC_A_D_OP_ENABLE_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_cmac_a_d_op_enable_0_out, autosa_cmac_a_d_op_enable_0_out);
      default: begin
          if (arreggen_dump) $display("%t:%m: reg wr: Unknown register (0x%h) = 0x%h", $time, reg_offset, reg_wr_data);
          if (arreggen_abort_on_invalid_wr) begin $display("ERROR: write to undefined register!"); $finish; end
        end
    endcase
  end
end
// VCS coverage on
// synopsys translate_on
endmodule // SA_AUTOSA_CMAC_REG_dual
