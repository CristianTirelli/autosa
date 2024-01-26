// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_BDMA_reg.v
module SA_AUTOSA_BDMA_reg (
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
  ,autosa_bdma_cfg_cmd_0_dst_ram_type
  ,autosa_bdma_cfg_cmd_0_src_ram_type
  ,autosa_bdma_cfg_dst_addr_high_0_v8
  ,autosa_bdma_cfg_dst_addr_low_0_v32
  ,autosa_bdma_cfg_dst_line_0_stride
  ,autosa_bdma_cfg_dst_surf_0_stride
  ,autosa_bdma_cfg_launch0_0_grp0_launch
  ,autosa_bdma_cfg_launch0_0_grp0_launch_trigger
  ,autosa_bdma_cfg_launch1_0_grp1_launch
  ,autosa_bdma_cfg_launch1_0_grp1_launch_trigger
  ,autosa_bdma_cfg_line_0_size
  ,autosa_bdma_cfg_line_repeat_0_number
  ,autosa_bdma_cfg_op_0_en
  ,autosa_bdma_cfg_op_0_en_trigger
  ,autosa_bdma_cfg_src_addr_high_0_v8
  ,autosa_bdma_cfg_src_addr_low_0_v32
  ,autosa_bdma_cfg_src_line_0_stride
  ,autosa_bdma_cfg_src_surf_0_stride
  ,autosa_bdma_cfg_status_0_stall_count_en
  ,autosa_bdma_cfg_surf_repeat_0_number
  ,autosa_bdma_status_0_free_slot
  ,autosa_bdma_status_0_grp0_busy
  ,autosa_bdma_status_0_grp1_busy
  ,autosa_bdma_status_0_idle
  ,autosa_bdma_status_grp0_read_stall_0_count
  ,autosa_bdma_status_grp0_write_stall_0_count
  ,autosa_bdma_status_grp1_read_stall_0_count
  ,autosa_bdma_status_grp1_write_stall_0_count
  );
wire [31:0] autosa_bdma_cfg_cmd_0_out;
wire [31:0] autosa_bdma_cfg_dst_addr_high_0_out;
wire [31:0] autosa_bdma_cfg_dst_addr_low_0_out;
wire [31:0] autosa_bdma_cfg_dst_line_0_out;
wire [31:0] autosa_bdma_cfg_dst_surf_0_out;
wire [31:0] autosa_bdma_cfg_launch0_0_out;
wire [31:0] autosa_bdma_cfg_launch1_0_out;
wire [31:0] autosa_bdma_cfg_line_0_out;
wire [31:0] autosa_bdma_cfg_line_repeat_0_out;
wire [31:0] autosa_bdma_cfg_op_0_out;
wire [31:0] autosa_bdma_cfg_src_addr_high_0_out;
wire [31:0] autosa_bdma_cfg_src_addr_low_0_out;
wire [31:0] autosa_bdma_cfg_src_line_0_out;
wire [31:0] autosa_bdma_cfg_src_surf_0_out;
wire [31:0] autosa_bdma_cfg_status_0_out;
wire [31:0] autosa_bdma_cfg_surf_repeat_0_out;
wire [31:0] autosa_bdma_status_0_out;
wire [31:0] autosa_bdma_status_grp0_read_stall_0_out;
wire [31:0] autosa_bdma_status_grp0_write_stall_0_out;
wire [31:0] autosa_bdma_status_grp1_read_stall_0_out;
wire [31:0] autosa_bdma_status_grp1_write_stall_0_out;
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
output autosa_bdma_cfg_cmd_0_dst_ram_type;
output autosa_bdma_cfg_cmd_0_src_ram_type;
output [31:0] autosa_bdma_cfg_dst_addr_high_0_v8;
output [26:0] autosa_bdma_cfg_dst_addr_low_0_v32;
output [26:0] autosa_bdma_cfg_dst_line_0_stride;
output [26:0] autosa_bdma_cfg_dst_surf_0_stride;
output autosa_bdma_cfg_launch0_0_grp0_launch;
output autosa_bdma_cfg_launch0_0_grp0_launch_trigger;
output autosa_bdma_cfg_launch1_0_grp1_launch;
output autosa_bdma_cfg_launch1_0_grp1_launch_trigger;
output [12:0] autosa_bdma_cfg_line_0_size;
output [23:0] autosa_bdma_cfg_line_repeat_0_number;
output autosa_bdma_cfg_op_0_en;
output autosa_bdma_cfg_op_0_en_trigger;
output [31:0] autosa_bdma_cfg_src_addr_high_0_v8;
output [26:0] autosa_bdma_cfg_src_addr_low_0_v32;
output [26:0] autosa_bdma_cfg_src_line_0_stride;
output [26:0] autosa_bdma_cfg_src_surf_0_stride;
output autosa_bdma_cfg_status_0_stall_count_en;
output [23:0] autosa_bdma_cfg_surf_repeat_0_number;
// Read-only register inputs
input [7:0] autosa_bdma_status_0_free_slot;
input autosa_bdma_status_0_grp0_busy;
input autosa_bdma_status_0_grp1_busy;
input autosa_bdma_status_0_idle;
input [31:0] autosa_bdma_status_grp0_read_stall_0_count;
input [31:0] autosa_bdma_status_grp0_write_stall_0_count;
input [31:0] autosa_bdma_status_grp1_read_stall_0_count;
input [31:0] autosa_bdma_status_grp1_write_stall_0_count;
// wr_mask register inputs
// rstn register inputs
// leda FM_2_23 off
reg arreggen_abort_on_invalid_wr;
reg arreggen_abort_on_rowr;
reg arreggen_dump;
// leda FM_2_23 on
reg autosa_bdma_cfg_cmd_0_dst_ram_type;
reg autosa_bdma_cfg_cmd_0_src_ram_type;
reg [31:0] autosa_bdma_cfg_dst_addr_high_0_v8;
reg [26:0] autosa_bdma_cfg_dst_addr_low_0_v32;
reg [26:0] autosa_bdma_cfg_dst_line_0_stride;
reg [26:0] autosa_bdma_cfg_dst_surf_0_stride;
reg autosa_bdma_cfg_launch0_0_grp0_launch;
reg autosa_bdma_cfg_launch1_0_grp1_launch;
reg [12:0] autosa_bdma_cfg_line_0_size;
reg [23:0] autosa_bdma_cfg_line_repeat_0_number;
reg autosa_bdma_cfg_op_0_en;
reg [31:0] autosa_bdma_cfg_src_addr_high_0_v8;
reg [26:0] autosa_bdma_cfg_src_addr_low_0_v32;
reg [26:0] autosa_bdma_cfg_src_line_0_stride;
reg [26:0] autosa_bdma_cfg_src_surf_0_stride;
reg autosa_bdma_cfg_status_0_stall_count_en;
reg [23:0] autosa_bdma_cfg_surf_repeat_0_number;
reg [31:0] reg_rd_data;
assign reg_offset_wr = {20'b0 , reg_offset};
// SCR signals
// Address decode
wire autosa_bdma_cfg_cmd_0_wren = (reg_offset_wr == (32'h4014 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_bdma_cfg_dst_addr_high_0_wren = (reg_offset_wr == (32'h400c & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_bdma_cfg_dst_addr_low_0_wren = (reg_offset_wr == (32'h4008 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_bdma_cfg_dst_line_0_wren = (reg_offset_wr == (32'h4020 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_bdma_cfg_dst_surf_0_wren = (reg_offset_wr == (32'h402c & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_bdma_cfg_launch0_0_wren = (reg_offset_wr == (32'h4034 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_bdma_cfg_launch1_0_wren = (reg_offset_wr == (32'h4038 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_bdma_cfg_line_0_wren = (reg_offset_wr == (32'h4010 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_bdma_cfg_line_repeat_0_wren = (reg_offset_wr == (32'h4018 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_bdma_cfg_op_0_wren = (reg_offset_wr == (32'h4030 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_bdma_cfg_src_addr_high_0_wren = (reg_offset_wr == (32'h4004 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_bdma_cfg_src_addr_low_0_wren = (reg_offset_wr == (32'h4000 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_bdma_cfg_src_line_0_wren = (reg_offset_wr == (32'h401c & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_bdma_cfg_src_surf_0_wren = (reg_offset_wr == (32'h4028 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_bdma_cfg_status_0_wren = (reg_offset_wr == (32'h403c & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_bdma_cfg_surf_repeat_0_wren = (reg_offset_wr == (32'h4024 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_bdma_status_0_wren = (reg_offset_wr == (32'h4040 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_bdma_status_grp0_read_stall_0_wren = (reg_offset_wr == (32'h4044 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_bdma_status_grp0_write_stall_0_wren = (reg_offset_wr == (32'h4048 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_bdma_status_grp1_read_stall_0_wren = (reg_offset_wr == (32'h404c & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_bdma_status_grp1_write_stall_0_wren = (reg_offset_wr == (32'h4050 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
assign autosa_bdma_cfg_cmd_0_out[31:0] = { 30'b0, autosa_bdma_cfg_cmd_0_dst_ram_type, autosa_bdma_cfg_cmd_0_src_ram_type };
assign autosa_bdma_cfg_dst_addr_high_0_out[31:0] = { autosa_bdma_cfg_dst_addr_high_0_v8 };
assign autosa_bdma_cfg_dst_addr_low_0_out[31:0] = { autosa_bdma_cfg_dst_addr_low_0_v32, 5'b0 };
assign autosa_bdma_cfg_dst_line_0_out[31:0] = { autosa_bdma_cfg_dst_line_0_stride, 5'b0 };
assign autosa_bdma_cfg_dst_surf_0_out[31:0] = { autosa_bdma_cfg_dst_surf_0_stride, 5'b0 };
assign autosa_bdma_cfg_launch0_0_out[31:0] = { 31'b0, autosa_bdma_cfg_launch0_0_grp0_launch };
assign autosa_bdma_cfg_launch1_0_out[31:0] = { 31'b0, autosa_bdma_cfg_launch1_0_grp1_launch };
assign autosa_bdma_cfg_line_0_out[31:0] = { 19'b0, autosa_bdma_cfg_line_0_size };
assign autosa_bdma_cfg_line_repeat_0_out[31:0] = { 8'b0, autosa_bdma_cfg_line_repeat_0_number };
assign autosa_bdma_cfg_op_0_out[31:0] = { 31'b0, autosa_bdma_cfg_op_0_en };
assign autosa_bdma_cfg_src_addr_high_0_out[31:0] = { autosa_bdma_cfg_src_addr_high_0_v8 };
assign autosa_bdma_cfg_src_addr_low_0_out[31:0] = { autosa_bdma_cfg_src_addr_low_0_v32, 5'b0 };
assign autosa_bdma_cfg_src_line_0_out[31:0] = { autosa_bdma_cfg_src_line_0_stride, 5'b0 };
assign autosa_bdma_cfg_src_surf_0_out[31:0] = { autosa_bdma_cfg_src_surf_0_stride, 5'b0 };
assign autosa_bdma_cfg_status_0_out[31:0] = { 31'b0, autosa_bdma_cfg_status_0_stall_count_en };
assign autosa_bdma_cfg_surf_repeat_0_out[31:0] = { 8'b0, autosa_bdma_cfg_surf_repeat_0_number };
assign autosa_bdma_status_0_out[31:0] = { 21'b0, autosa_bdma_status_0_grp1_busy, autosa_bdma_status_0_grp0_busy, autosa_bdma_status_0_idle, autosa_bdma_status_0_free_slot };
assign autosa_bdma_status_grp0_read_stall_0_out[31:0] = { autosa_bdma_status_grp0_read_stall_0_count };
assign autosa_bdma_status_grp0_write_stall_0_out[31:0] = { autosa_bdma_status_grp0_write_stall_0_count };
assign autosa_bdma_status_grp1_read_stall_0_out[31:0] = { autosa_bdma_status_grp1_read_stall_0_count };
assign autosa_bdma_status_grp1_write_stall_0_out[31:0] = { autosa_bdma_status_grp1_write_stall_0_count };
assign autosa_bdma_cfg_launch0_0_grp0_launch_trigger = autosa_bdma_cfg_launch0_0_wren; //(W563)
assign autosa_bdma_cfg_launch1_0_grp1_launch_trigger = autosa_bdma_cfg_launch1_0_wren; //(W563)
assign autosa_bdma_cfg_op_0_en_trigger = autosa_bdma_cfg_op_0_wren; //(W563)
assign reg_offset_rd_int = reg_offset;
// Output mux
//spyglass disable_block W338, W263
always @(
  reg_offset_rd_int
  or autosa_bdma_cfg_cmd_0_out
  or autosa_bdma_cfg_dst_addr_high_0_out
  or autosa_bdma_cfg_dst_addr_low_0_out
  or autosa_bdma_cfg_dst_line_0_out
  or autosa_bdma_cfg_dst_surf_0_out
  or autosa_bdma_cfg_launch0_0_out
  or autosa_bdma_cfg_launch1_0_out
  or autosa_bdma_cfg_line_0_out
  or autosa_bdma_cfg_line_repeat_0_out
  or autosa_bdma_cfg_op_0_out
  or autosa_bdma_cfg_src_addr_high_0_out
  or autosa_bdma_cfg_src_addr_low_0_out
  or autosa_bdma_cfg_src_line_0_out
  or autosa_bdma_cfg_src_surf_0_out
  or autosa_bdma_cfg_status_0_out
  or autosa_bdma_cfg_surf_repeat_0_out
  or autosa_bdma_status_0_out
  or autosa_bdma_status_grp0_read_stall_0_out
  or autosa_bdma_status_grp0_write_stall_0_out
  or autosa_bdma_status_grp1_read_stall_0_out
  or autosa_bdma_status_grp1_write_stall_0_out
  ) begin
  case (reg_offset_rd_int)
     (32'h4014 & 32'h00000fff): begin
                            reg_rd_data = autosa_bdma_cfg_cmd_0_out ;
                            end
     (32'h400c & 32'h00000fff): begin
                            reg_rd_data = autosa_bdma_cfg_dst_addr_high_0_out ;
                            end
     (32'h4008 & 32'h00000fff): begin
                            reg_rd_data = autosa_bdma_cfg_dst_addr_low_0_out ;
                            end
     (32'h4020 & 32'h00000fff): begin
                            reg_rd_data = autosa_bdma_cfg_dst_line_0_out ;
                            end
     (32'h402c & 32'h00000fff): begin
                            reg_rd_data = autosa_bdma_cfg_dst_surf_0_out ;
                            end
     (32'h4034 & 32'h00000fff): begin
                            reg_rd_data = autosa_bdma_cfg_launch0_0_out ;
                            end
     (32'h4038 & 32'h00000fff): begin
                            reg_rd_data = autosa_bdma_cfg_launch1_0_out ;
                            end
     (32'h4010 & 32'h00000fff): begin
                            reg_rd_data = autosa_bdma_cfg_line_0_out ;
                            end
     (32'h4018 & 32'h00000fff): begin
                            reg_rd_data = autosa_bdma_cfg_line_repeat_0_out ;
                            end
     (32'h4030 & 32'h00000fff): begin
                            reg_rd_data = autosa_bdma_cfg_op_0_out ;
                            end
     (32'h4004 & 32'h00000fff): begin
                            reg_rd_data = autosa_bdma_cfg_src_addr_high_0_out ;
                            end
     (32'h4000 & 32'h00000fff): begin
                            reg_rd_data = autosa_bdma_cfg_src_addr_low_0_out ;
                            end
     (32'h401c & 32'h00000fff): begin
                            reg_rd_data = autosa_bdma_cfg_src_line_0_out ;
                            end
     (32'h4028 & 32'h00000fff): begin
                            reg_rd_data = autosa_bdma_cfg_src_surf_0_out ;
                            end
     (32'h403c & 32'h00000fff): begin
                            reg_rd_data = autosa_bdma_cfg_status_0_out ;
                            end
     (32'h4024 & 32'h00000fff): begin
                            reg_rd_data = autosa_bdma_cfg_surf_repeat_0_out ;
                            end
     (32'h4040 & 32'h00000fff): begin
                            reg_rd_data = autosa_bdma_status_0_out ;
                            end
     (32'h4044 & 32'h00000fff): begin
                            reg_rd_data = autosa_bdma_status_grp0_read_stall_0_out ;
                            end
     (32'h4048 & 32'h00000fff): begin
                            reg_rd_data = autosa_bdma_status_grp0_write_stall_0_out ;
                            end
     (32'h404c & 32'h00000fff): begin
                            reg_rd_data = autosa_bdma_status_grp1_read_stall_0_out ;
                            end
     (32'h4050 & 32'h00000fff): begin
                            reg_rd_data = autosa_bdma_status_grp1_write_stall_0_out ;
                            end
    default: reg_rd_data = {32{1'b0}};
  endcase
end
//spyglass enable_block W338, W263
// spyglass disable_block STARC-2.10.1.6, NoConstWithXZ, W443
// Register flop declarations
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
  if (!autosa_core_rstn) begin
    autosa_bdma_cfg_cmd_0_dst_ram_type <= 1'b0;
    autosa_bdma_cfg_cmd_0_src_ram_type <= 1'b0;
    autosa_bdma_cfg_dst_addr_high_0_v8[31:0] <= 32'b00000000000000000000000000000000;
    autosa_bdma_cfg_dst_addr_low_0_v32[26:0] <= 27'b000000000000000000000000000;
    autosa_bdma_cfg_dst_line_0_stride[26:0] <= 27'b000000000000000000000000000;
    autosa_bdma_cfg_dst_surf_0_stride[26:0] <= 27'b000000000000000000000000000;
    autosa_bdma_cfg_launch0_0_grp0_launch <= 1'b0;
    autosa_bdma_cfg_launch1_0_grp1_launch <= 1'b0;
    autosa_bdma_cfg_line_0_size[12:0] <= 13'b0000000000000;
    autosa_bdma_cfg_line_repeat_0_number[23:0] <= 24'b000000000000000000000000;
    autosa_bdma_cfg_op_0_en <= 1'b0;
    autosa_bdma_cfg_src_addr_high_0_v8[31:0] <= 32'b00000000000000000000000000000000;
    autosa_bdma_cfg_src_addr_low_0_v32[26:0] <= 27'b000000000000000000000000000;
    autosa_bdma_cfg_src_line_0_stride[26:0] <= 27'b000000000000000000000000000;
    autosa_bdma_cfg_src_surf_0_stride[26:0] <= 27'b000000000000000000000000000;
    autosa_bdma_cfg_status_0_stall_count_en <= 1'b0;
    autosa_bdma_cfg_surf_repeat_0_number[23:0] <= 24'b000000000000000000000000;
  end else begin
// Register: AUTOSA_BDMA_CFG_CMD_0 Field: dst_ram_type
  if (autosa_bdma_cfg_cmd_0_wren) begin
    autosa_bdma_cfg_cmd_0_dst_ram_type <= reg_wr_data[1];
  end
// Register: AUTOSA_BDMA_CFG_CMD_0 Field: src_ram_type
  if (autosa_bdma_cfg_cmd_0_wren) begin
    autosa_bdma_cfg_cmd_0_src_ram_type <= reg_wr_data[0];
  end
// Register: AUTOSA_BDMA_CFG_DST_ADDR_HIGH_0 Field: v8
  if (autosa_bdma_cfg_dst_addr_high_0_wren) begin
    autosa_bdma_cfg_dst_addr_high_0_v8[31:0] <= reg_wr_data[31:0];
  end
// Register: AUTOSA_BDMA_CFG_DST_ADDR_LOW_0 Field: v32
  if (autosa_bdma_cfg_dst_addr_low_0_wren) begin
    autosa_bdma_cfg_dst_addr_low_0_v32[26:0] <= reg_wr_data[31:5];
  end
// Register: AUTOSA_BDMA_CFG_DST_LINE_0 Field: stride
  if (autosa_bdma_cfg_dst_line_0_wren) begin
    autosa_bdma_cfg_dst_line_0_stride[26:0] <= reg_wr_data[31:5];
  end
// Register: AUTOSA_BDMA_CFG_DST_SURF_0 Field: stride
  if (autosa_bdma_cfg_dst_surf_0_wren) begin
    autosa_bdma_cfg_dst_surf_0_stride[26:0] <= reg_wr_data[31:5];
  end
// Register: AUTOSA_BDMA_CFG_LAUNCH0_0 Field: grp0_launch
  if (autosa_bdma_cfg_launch0_0_wren) begin
    autosa_bdma_cfg_launch0_0_grp0_launch <= reg_wr_data[0];
  end
// Register: AUTOSA_BDMA_CFG_LAUNCH1_0 Field: grp1_launch
  if (autosa_bdma_cfg_launch1_0_wren) begin
    autosa_bdma_cfg_launch1_0_grp1_launch <= reg_wr_data[0];
  end
// Register: AUTOSA_BDMA_CFG_LINE_0 Field: size
  if (autosa_bdma_cfg_line_0_wren) begin
    autosa_bdma_cfg_line_0_size[12:0] <= reg_wr_data[12:0];
  end
// Register: AUTOSA_BDMA_CFG_LINE_REPEAT_0 Field: number
  if (autosa_bdma_cfg_line_repeat_0_wren) begin
    autosa_bdma_cfg_line_repeat_0_number[23:0] <= reg_wr_data[23:0];
  end
// Register: AUTOSA_BDMA_CFG_OP_0 Field: en
  if (autosa_bdma_cfg_op_0_wren) begin
    autosa_bdma_cfg_op_0_en <= reg_wr_data[0];
  end
// Register: AUTOSA_BDMA_CFG_SRC_ADDR_HIGH_0 Field: v8
  if (autosa_bdma_cfg_src_addr_high_0_wren) begin
    autosa_bdma_cfg_src_addr_high_0_v8[31:0] <= reg_wr_data[31:0];
  end
// Register: AUTOSA_BDMA_CFG_SRC_ADDR_LOW_0 Field: v32
  if (autosa_bdma_cfg_src_addr_low_0_wren) begin
    autosa_bdma_cfg_src_addr_low_0_v32[26:0] <= reg_wr_data[31:5];
  end
// Register: AUTOSA_BDMA_CFG_SRC_LINE_0 Field: stride
  if (autosa_bdma_cfg_src_line_0_wren) begin
    autosa_bdma_cfg_src_line_0_stride[26:0] <= reg_wr_data[31:5];
  end
// Register: AUTOSA_BDMA_CFG_SRC_SURF_0 Field: stride
  if (autosa_bdma_cfg_src_surf_0_wren) begin
    autosa_bdma_cfg_src_surf_0_stride[26:0] <= reg_wr_data[31:5];
  end
// Register: AUTOSA_BDMA_CFG_STATUS_0 Field: stall_count_en
  if (autosa_bdma_cfg_status_0_wren) begin
    autosa_bdma_cfg_status_0_stall_count_en <= reg_wr_data[0];
  end
// Register: AUTOSA_BDMA_CFG_SURF_REPEAT_0 Field: number
  if (autosa_bdma_cfg_surf_repeat_0_wren) begin
    autosa_bdma_cfg_surf_repeat_0_number[23:0] <= reg_wr_data[23:0];
  end
// Not generating flops for read-only field AUTOSA_BDMA_STATUS_0::free_slot
// Not generating flops for read-only field AUTOSA_BDMA_STATUS_0::grp0_busy
// Not generating flops for read-only field AUTOSA_BDMA_STATUS_0::grp1_busy
// Not generating flops for read-only field AUTOSA_BDMA_STATUS_0::idle
// Not generating flops for read-only field AUTOSA_BDMA_STATUS_GRP0_READ_STALL_0::count
// Not generating flops for read-only field AUTOSA_BDMA_STATUS_GRP0_WRITE_STALL_0::count
// Not generating flops for read-only field AUTOSA_BDMA_STATUS_GRP1_READ_STALL_0::count
// Not generating flops for read-only field AUTOSA_BDMA_STATUS_GRP1_WRITE_STALL_0::count
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
      (32'h4014 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_BDMA_CFG_CMD_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_bdma_cfg_cmd_0_out, autosa_bdma_cfg_cmd_0_out);
      (32'h400c & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_BDMA_CFG_DST_ADDR_HIGH_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_bdma_cfg_dst_addr_high_0_out, autosa_bdma_cfg_dst_addr_high_0_out);
      (32'h4008 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_BDMA_CFG_DST_ADDR_LOW_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_bdma_cfg_dst_addr_low_0_out, autosa_bdma_cfg_dst_addr_low_0_out);
      (32'h4020 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_BDMA_CFG_DST_LINE_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_bdma_cfg_dst_line_0_out, autosa_bdma_cfg_dst_line_0_out);
      (32'h402c & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_BDMA_CFG_DST_SURF_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_bdma_cfg_dst_surf_0_out, autosa_bdma_cfg_dst_surf_0_out);
      (32'h4034 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_BDMA_CFG_LAUNCH0_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_bdma_cfg_launch0_0_out, autosa_bdma_cfg_launch0_0_out);
      (32'h4038 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_BDMA_CFG_LAUNCH1_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_bdma_cfg_launch1_0_out, autosa_bdma_cfg_launch1_0_out);
      (32'h4010 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_BDMA_CFG_LINE_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_bdma_cfg_line_0_out, autosa_bdma_cfg_line_0_out);
      (32'h4018 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_BDMA_CFG_LINE_REPEAT_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_bdma_cfg_line_repeat_0_out, autosa_bdma_cfg_line_repeat_0_out);
      (32'h4030 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_BDMA_CFG_OP_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_bdma_cfg_op_0_out, autosa_bdma_cfg_op_0_out);
      (32'h4004 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_BDMA_CFG_SRC_ADDR_HIGH_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_bdma_cfg_src_addr_high_0_out, autosa_bdma_cfg_src_addr_high_0_out);
      (32'h4000 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_BDMA_CFG_SRC_ADDR_LOW_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_bdma_cfg_src_addr_low_0_out, autosa_bdma_cfg_src_addr_low_0_out);
      (32'h401c & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_BDMA_CFG_SRC_LINE_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_bdma_cfg_src_line_0_out, autosa_bdma_cfg_src_line_0_out);
      (32'h4028 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_BDMA_CFG_SRC_SURF_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_bdma_cfg_src_surf_0_out, autosa_bdma_cfg_src_surf_0_out);
      (32'h403c & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_BDMA_CFG_STATUS_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_bdma_cfg_status_0_out, autosa_bdma_cfg_status_0_out);
      (32'h4024 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_BDMA_CFG_SURF_REPEAT_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_bdma_cfg_surf_repeat_0_out, autosa_bdma_cfg_surf_repeat_0_out);
      (32'h4040 & 32'h00000fff): begin
          if (arreggen_dump) $display("%t:%m: read-only reg wr: AUTOSA_BDMA_STATUS_0 = 0x%h", $time, reg_wr_data);
          if (arreggen_abort_on_rowr) begin $display("ERROR: write to read-only register!"); $finish; end
        end
      (32'h4044 & 32'h00000fff): begin
          if (arreggen_dump) $display("%t:%m: read-only reg wr: AUTOSA_BDMA_STATUS_GRP0_READ_STALL_0 = 0x%h", $time, reg_wr_data);
          if (arreggen_abort_on_rowr) begin $display("ERROR: write to read-only register!"); $finish; end
        end
      (32'h4048 & 32'h00000fff): begin
          if (arreggen_dump) $display("%t:%m: read-only reg wr: AUTOSA_BDMA_STATUS_GRP0_WRITE_STALL_0 = 0x%h", $time, reg_wr_data);
          if (arreggen_abort_on_rowr) begin $display("ERROR: write to read-only register!"); $finish; end
        end
      (32'h404c & 32'h00000fff): begin
          if (arreggen_dump) $display("%t:%m: read-only reg wr: AUTOSA_BDMA_STATUS_GRP1_READ_STALL_0 = 0x%h", $time, reg_wr_data);
          if (arreggen_abort_on_rowr) begin $display("ERROR: write to read-only register!"); $finish; end
        end
      (32'h4050 & 32'h00000fff): begin
          if (arreggen_dump) $display("%t:%m: read-only reg wr: AUTOSA_BDMA_STATUS_GRP1_WRITE_STALL_0 = 0x%h", $time, reg_wr_data);
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
endmodule // SA_AUTOSA_BDMA_reg
