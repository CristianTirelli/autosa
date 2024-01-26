// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_CMAC_REG_single.v
module SA_AUTOSA_CMAC_REG_single (
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
  ,producer
  ,consumer
  ,status_0
  ,status_1
  );
wire [31:0] autosa_cmac_a_s_pointer_0_out;
wire [31:0] autosa_cmac_a_s_status_0_out;
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
output producer;
// Read-only register inputs
input consumer;
input [1:0] status_0;
input [1:0] status_1;
// wr_mask register inputs
// rstn register inputs
// leda FM_2_23 off
reg arreggen_abort_on_invalid_wr;
reg arreggen_abort_on_rowr;
reg arreggen_dump;
// leda FM_2_23 on
reg producer;
reg [31:0] reg_rd_data;
assign reg_offset_wr = {20'b0 , reg_offset};
// SCR signals
// Address decode
wire autosa_cmac_a_s_pointer_0_wren = (reg_offset_wr == (32'h7004 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_cmac_a_s_status_0_wren = (reg_offset_wr == (32'h7000 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
assign autosa_cmac_a_s_pointer_0_out[31:0] = { 15'b0, consumer, 15'b0, producer };
assign autosa_cmac_a_s_status_0_out[31:0] = { 14'b0, status_1, 14'b0, status_0 };
assign reg_offset_rd_int = reg_offset;
// Output mux
//spyglass disable_block W338, W263
always @(
  reg_offset_rd_int
  or autosa_cmac_a_s_pointer_0_out
  or autosa_cmac_a_s_status_0_out
  ) begin
  case (reg_offset_rd_int)
     (32'h7004 & 32'h00000fff): begin
                            reg_rd_data = autosa_cmac_a_s_pointer_0_out ;
                            end
     (32'h7000 & 32'h00000fff): begin
                            reg_rd_data = autosa_cmac_a_s_status_0_out ;
                            end
    default: reg_rd_data = {32{1'b0}};
  endcase
end
//spyglass enable_block W338, W263
// spyglass disable_block STARC-2.10.1.6, NoConstWithXZ, W443
// Register flop declarations
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
  if (!autosa_core_rstn) begin
    producer <= 1'b0;
  end else begin
// Not generating flops for read-only field AUTOSA_CMAC_A_S_POINTER_0::consumer
// Register: AUTOSA_CMAC_A_S_POINTER_0 Field: producer
  if (autosa_cmac_a_s_pointer_0_wren) begin
    producer <= reg_wr_data[0];
  end
// Not generating flops for read-only field AUTOSA_CMAC_A_S_STATUS_0::status_0
// Not generating flops for read-only field AUTOSA_CMAC_A_S_STATUS_0::status_1
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
      (32'h7004 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CMAC_A_S_POINTER_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_cmac_a_s_pointer_0_out, autosa_cmac_a_s_pointer_0_out);
      (32'h7000 & 32'h00000fff): begin
          if (arreggen_dump) $display("%t:%m: read-only reg wr: AUTOSA_CMAC_A_S_STATUS_0 = 0x%h", $time, reg_wr_data);
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
endmodule // SA_AUTOSA_CMAC_REG_single
