// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_CACC_dual_reg.v
module SA_AUTOSA_CACC_dual_reg (
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
  ,batches
  ,clip_truncate
  ,cya
  ,dataout_addr
  ,line_packed
  ,surf_packed
  ,dataout_height
  ,dataout_width
  ,dataout_channel
  ,line_stride
  ,cosa_mode
  ,proc_precision
  ,op_en_trigger
  ,surf_stride
  ,op_en
  ,sat_count
  );
wire [31:0] autosa_cacc_d_batch_number_0_out;
wire [31:0] autosa_cacc_d_clip_cfg_0_out;
wire [31:0] autosa_cacc_d_cya_0_out;
wire [31:0] autosa_cacc_d_dataout_addr_0_out;
wire [31:0] autosa_cacc_d_dataout_map_0_out;
wire [31:0] autosa_cacc_d_dataout_size_0_0_out;
wire [31:0] autosa_cacc_d_dataout_size_1_0_out;
wire [31:0] autosa_cacc_d_line_stride_0_out;
wire [31:0] autosa_cacc_d_misc_cfg_0_out;
wire [31:0] autosa_cacc_d_op_enable_0_out;
wire [31:0] autosa_cacc_d_out_saturation_0_out;
wire [31:0] autosa_cacc_d_surf_stride_0_out;
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
output [4:0] batches;
output [4:0] clip_truncate;
output [31:0] cya;
output [31:0] dataout_addr;
output line_packed;
output surf_packed;
output [12:0] dataout_height;
output [12:0] dataout_width;
output [12:0] dataout_channel;
output [23:0] line_stride;
output cosa_mode;
output [1:0] proc_precision;
output op_en_trigger;
output [23:0] surf_stride;
// Read-only register inputs
input op_en;
input [31:0] sat_count;
// wr_mask register inputs
// rstn register inputs
// leda FM_2_23 off
reg arreggen_abort_on_invalid_wr;
reg arreggen_abort_on_rowr;
reg arreggen_dump;
// leda FM_2_23 on
reg [4:0] batches;
reg [4:0] clip_truncate;
reg cosa_mode;
reg [31:0] cya;
reg [31:0] dataout_addr;
reg [12:0] dataout_channel;
reg [12:0] dataout_height;
reg [12:0] dataout_width;
reg line_packed;
reg [23:0] line_stride;
reg [1:0] proc_precision;
reg [31:0] reg_rd_data;
reg surf_packed;
reg [23:0] surf_stride;
assign reg_offset_wr = {20'b0 , reg_offset};
// SCR signals
// Address decode
wire autosa_cacc_d_batch_number_0_wren = (reg_offset_wr == (32'h901c & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_cacc_d_clip_cfg_0_wren = (reg_offset_wr == (32'h902c & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_cacc_d_cya_0_wren = (reg_offset_wr == (32'h9034 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_cacc_d_dataout_addr_0_wren = (reg_offset_wr == (32'h9018 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_cacc_d_dataout_map_0_wren = (reg_offset_wr == (32'h9028 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_cacc_d_dataout_size_0_0_wren = (reg_offset_wr == (32'h9010 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_cacc_d_dataout_size_1_0_wren = (reg_offset_wr == (32'h9014 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_cacc_d_line_stride_0_wren = (reg_offset_wr == (32'h9020 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_cacc_d_misc_cfg_0_wren = (reg_offset_wr == (32'h900c & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_cacc_d_op_enable_0_wren = (reg_offset_wr == (32'h9008 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_cacc_d_out_saturation_0_wren = (reg_offset_wr == (32'h9030 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_cacc_d_surf_stride_0_wren = (reg_offset_wr == (32'h9024 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
assign autosa_cacc_d_batch_number_0_out[31:0] = { 27'b0, batches };
assign autosa_cacc_d_clip_cfg_0_out[31:0] = { 27'b0, clip_truncate };
assign autosa_cacc_d_cya_0_out[31:0] = { cya };
assign autosa_cacc_d_dataout_addr_0_out[31:0] = { dataout_addr};
assign autosa_cacc_d_dataout_map_0_out[31:0] = { 15'b0, surf_packed, 15'b0, line_packed };
assign autosa_cacc_d_dataout_size_0_0_out[31:0] = { 3'b0, dataout_height, 3'b0, dataout_width };
assign autosa_cacc_d_dataout_size_1_0_out[31:0] = { 19'b0, dataout_channel };
assign autosa_cacc_d_line_stride_0_out[31:0] = { 8'b0, line_stride};
assign autosa_cacc_d_misc_cfg_0_out[31:0] = { 18'b0, proc_precision, 11'b0, cosa_mode };
assign autosa_cacc_d_op_enable_0_out[31:0] = { 31'b0, op_en };
assign autosa_cacc_d_out_saturation_0_out[31:0] = { sat_count };
assign autosa_cacc_d_surf_stride_0_out[31:0] = { 8'b0, surf_stride};
assign op_en_trigger = autosa_cacc_d_op_enable_0_wren; //(W563)
assign reg_offset_rd_int = reg_offset;
// Output mux
//spyglass disable_block W338, W263
always @(
  reg_offset_rd_int
  or autosa_cacc_d_batch_number_0_out
  or autosa_cacc_d_clip_cfg_0_out
  or autosa_cacc_d_cya_0_out
  or autosa_cacc_d_dataout_addr_0_out
  or autosa_cacc_d_dataout_map_0_out
  or autosa_cacc_d_dataout_size_0_0_out
  or autosa_cacc_d_dataout_size_1_0_out
  or autosa_cacc_d_line_stride_0_out
  or autosa_cacc_d_misc_cfg_0_out
  or autosa_cacc_d_op_enable_0_out
  or autosa_cacc_d_out_saturation_0_out
  or autosa_cacc_d_surf_stride_0_out
  ) begin
  case (reg_offset_rd_int)
     (32'h901c & 32'h00000fff): begin
                            reg_rd_data = autosa_cacc_d_batch_number_0_out ;
                            end
     (32'h902c & 32'h00000fff): begin
                            reg_rd_data = autosa_cacc_d_clip_cfg_0_out ;
                            end
     (32'h9034 & 32'h00000fff): begin
                            reg_rd_data = autosa_cacc_d_cya_0_out ;
                            end
     (32'h9018 & 32'h00000fff): begin
                            reg_rd_data = autosa_cacc_d_dataout_addr_0_out ;
                            end
     (32'h9028 & 32'h00000fff): begin
                            reg_rd_data = autosa_cacc_d_dataout_map_0_out ;
                            end
     (32'h9010 & 32'h00000fff): begin
                            reg_rd_data = autosa_cacc_d_dataout_size_0_0_out ;
                            end
     (32'h9014 & 32'h00000fff): begin
                            reg_rd_data = autosa_cacc_d_dataout_size_1_0_out ;
                            end
     (32'h9020 & 32'h00000fff): begin
                            reg_rd_data = autosa_cacc_d_line_stride_0_out ;
                            end
     (32'h900c & 32'h00000fff): begin
                            reg_rd_data = autosa_cacc_d_misc_cfg_0_out ;
                            end
     (32'h9008 & 32'h00000fff): begin
                            reg_rd_data = autosa_cacc_d_op_enable_0_out ;
                            end
     (32'h9030 & 32'h00000fff): begin
                            reg_rd_data = autosa_cacc_d_out_saturation_0_out ;
                            end
     (32'h9024 & 32'h00000fff): begin
                            reg_rd_data = autosa_cacc_d_surf_stride_0_out ;
                            end
    default: reg_rd_data = {32{1'b0}};
  endcase
end
//spyglass enable_block W338, W263
// spyglass disable_block STARC-2.10.1.6, NoConstWithXZ, W443
// Register flop declarations
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
  if (!autosa_core_rstn) begin
    batches[4:0] <= 5'b00000;
    clip_truncate[4:0] <= 5'b00000;
    cya[31:0] <= 32'b00000000000000000000000000000000;
    dataout_addr[31:0] <= 32'h0;
    line_packed <= 1'b0;
    surf_packed <= 1'b0;
    dataout_height[12:0] <= 13'b0000000000000;
    dataout_width[12:0] <= 13'b0000000000000;
    dataout_channel[12:0] <= 13'b0000000000000;
    line_stride[23:0] <= 24'b000000000000000000000000;
    cosa_mode <= 1'b0;
    proc_precision[1:0] <= 2'b01;
    surf_stride[23:0] <= 24'b000000000000000000000000;
  end else begin
// Register: AUTOSA_CACC_D_BATCH_NUMBER_0 Field: batches
  if (autosa_cacc_d_batch_number_0_wren) begin
    batches[4:0] <= reg_wr_data[4:0];
  end
// Register: AUTOSA_CACC_D_CLIP_CFG_0 Field: clip_truncate
  if (autosa_cacc_d_clip_cfg_0_wren) begin
    clip_truncate[4:0] <= reg_wr_data[4:0];
  end
// Register: AUTOSA_CACC_D_CYA_0 Field: cya
  if (autosa_cacc_d_cya_0_wren) begin
    cya[31:0] <= reg_wr_data[31:0];
  end
// Register: AUTOSA_CACC_D_DATAOUT_ADDR_0 Field: dataout_addr
  if (autosa_cacc_d_dataout_addr_0_wren) begin
    dataout_addr[31:0] <= reg_wr_data[31:0];
  end
// Register: AUTOSA_CACC_D_DATAOUT_MAP_0 Field: line_packed
  if (autosa_cacc_d_dataout_map_0_wren) begin
    line_packed <= reg_wr_data[0];
  end
// Register: AUTOSA_CACC_D_DATAOUT_MAP_0 Field: surf_packed
  if (autosa_cacc_d_dataout_map_0_wren) begin
    surf_packed <= reg_wr_data[16];
  end
// Register: AUTOSA_CACC_D_DATAOUT_SIZE_0_0 Field: dataout_height
  if (autosa_cacc_d_dataout_size_0_0_wren) begin
    dataout_height[12:0] <= reg_wr_data[28:16];
  end
// Register: AUTOSA_CACC_D_DATAOUT_SIZE_0_0 Field: dataout_width
  if (autosa_cacc_d_dataout_size_0_0_wren) begin
    dataout_width[12:0] <= reg_wr_data[12:0];
  end
// Register: AUTOSA_CACC_D_DATAOUT_SIZE_1_0 Field: dataout_channel
  if (autosa_cacc_d_dataout_size_1_0_wren) begin
    dataout_channel[12:0] <= reg_wr_data[12:0];
  end
// Register: AUTOSA_CACC_D_LINE_STRIDE_0 Field: line_stride
  if (autosa_cacc_d_line_stride_0_wren) begin
    line_stride[23:0] <= reg_wr_data[23:0];
  end
// Register: AUTOSA_CACC_D_MISC_CFG_0 Field: cosa_mode
  if (autosa_cacc_d_misc_cfg_0_wren) begin
    cosa_mode <= reg_wr_data[0];
  end
// Register: AUTOSA_CACC_D_MISC_CFG_0 Field: proc_precision
  if (autosa_cacc_d_misc_cfg_0_wren) begin
    proc_precision[1:0] <= reg_wr_data[13:12];
  end
// Not generating flops for field AUTOSA_CACC_D_OP_ENABLE_0::op_en (to be implemented outside)
// Not generating flops for read-only field AUTOSA_CACC_D_OUT_SATURATION_0::sat_count
// Register: AUTOSA_CACC_D_SURF_STRIDE_0 Field: surf_stride
  if (autosa_cacc_d_surf_stride_0_wren) begin
    surf_stride[23:0] <= reg_wr_data[23:0];
  end
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
      (32'h901c & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CACC_D_BATCH_NUMBER_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_cacc_d_batch_number_0_out, autosa_cacc_d_batch_number_0_out);
      (32'h902c & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CACC_D_CLIP_CFG_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_cacc_d_clip_cfg_0_out, autosa_cacc_d_clip_cfg_0_out);
      (32'h9034 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CACC_D_CYA_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_cacc_d_cya_0_out, autosa_cacc_d_cya_0_out);
      (32'h9018 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CACC_D_DATAOUT_ADDR_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_cacc_d_dataout_addr_0_out, autosa_cacc_d_dataout_addr_0_out);
      (32'h9028 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CACC_D_DATAOUT_MAP_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_cacc_d_dataout_map_0_out, autosa_cacc_d_dataout_map_0_out);
      (32'h9010 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CACC_D_DATAOUT_SIZE_0_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_cacc_d_dataout_size_0_0_out, autosa_cacc_d_dataout_size_0_0_out);
      (32'h9014 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CACC_D_DATAOUT_SIZE_1_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_cacc_d_dataout_size_1_0_out, autosa_cacc_d_dataout_size_1_0_out);
      (32'h9020 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CACC_D_LINE_STRIDE_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_cacc_d_line_stride_0_out, autosa_cacc_d_line_stride_0_out);
      (32'h900c & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CACC_D_MISC_CFG_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_cacc_d_misc_cfg_0_out, autosa_cacc_d_misc_cfg_0_out);
      (32'h9008 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CACC_D_OP_ENABLE_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_cacc_d_op_enable_0_out, autosa_cacc_d_op_enable_0_out);
      (32'h9030 & 32'h00000fff): begin
          if (arreggen_dump) $display("%t:%m: read-only reg wr: AUTOSA_CACC_D_OUT_SATURATION_0 = 0x%h", $time, reg_wr_data);
          if (arreggen_abort_on_rowr) begin $display("ERROR: write to read-only register!"); $finish; end
        end
      (32'h9024 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CACC_D_SURF_STRIDE_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_cacc_d_surf_stride_0_out, autosa_cacc_d_surf_stride_0_out);
      default: begin
          if (arreggen_dump) $display("%t:%m: reg wr: Unknown register (0x%h) = 0x%h", $time, reg_offset, reg_wr_data);
          if (arreggen_abort_on_invalid_wr) begin $display("ERROR: write to undefined register!"); $finish; end
        end
    endcase
  end
end
// VCS coverage on
// synopsys translate_on
endmodule // SA_AUTOSA_CACC_dual_reg
