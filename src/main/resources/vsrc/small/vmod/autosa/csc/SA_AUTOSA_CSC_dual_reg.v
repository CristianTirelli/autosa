// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_CSC_dual_reg.v
module SA_AUTOSA_CSC_dual_reg (
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
  ,atomics
  ,data_bank
  ,weight_bank
  ,batches
  ,cosa_x_stride_ext
  ,cosa_y_stride_ext
  ,cya
  ,datain_format
  ,datain_height_ext
  ,datain_width_ext
  ,datain_channel_ext
  ,dataout_height
  ,dataout_width
  ,dataout_channel
  ,x_dilation_ext
  ,y_dilation_ext
  ,entries
  ,cosa_mode
  ,data_reuse
  ,in_precision
  ,proc_precision
  ,skip_data_rls
  ,skip_weight_rls
  ,weight_reuse
  ,op_en_trigger
  ,y_extension
  ,pra_truncate
  ,rls_slices
  ,weight_bytes
  ,weight_format
  ,weight_height_ext
  ,weight_width_ext
  ,weight_channel_ext
  ,weight_kernel
  ,wmb_bytes
  ,pad_left
  ,pad_top
  ,pad_value
  ,op_en
  );
wire [31:0] autosa_csc_d_atomics_0_out;
wire [31:0] autosa_csc_d_bank_0_out;
wire [31:0] autosa_csc_d_batch_number_0_out;
wire [31:0] autosa_csc_d_cosa_stride_ext_0_out;
wire [31:0] autosa_csc_d_cya_0_out;
wire [31:0] autosa_csc_d_datain_format_0_out;
wire [31:0] autosa_csc_d_datain_size_ext_0_0_out;
wire [31:0] autosa_csc_d_datain_size_ext_1_0_out;
wire [31:0] autosa_csc_d_dataout_size_0_0_out;
wire [31:0] autosa_csc_d_dataout_size_1_0_out;
wire [31:0] autosa_csc_d_dilation_ext_0_out;
wire [31:0] autosa_csc_d_entry_per_slice_0_out;
wire [31:0] autosa_csc_d_misc_cfg_0_out;
wire [31:0] autosa_csc_d_op_enable_0_out;
wire [31:0] autosa_csc_d_post_y_extension_0_out;
wire [31:0] autosa_csc_d_pra_cfg_0_out;
wire [31:0] autosa_csc_d_release_0_out;
wire [31:0] autosa_csc_d_weight_bytes_0_out;
wire [31:0] autosa_csc_d_weight_format_0_out;
wire [31:0] autosa_csc_d_weight_size_ext_0_0_out;
wire [31:0] autosa_csc_d_weight_size_ext_1_0_out;
wire [31:0] autosa_csc_d_wmb_bytes_0_out;
wire [31:0] autosa_csc_d_zero_padding_0_out;
wire [31:0] autosa_csc_d_zero_padding_value_0_out;
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
output [20:0] atomics;
output [4:0] data_bank;
output [4:0] weight_bank;
output [4:0] batches;
output [2:0] cosa_x_stride_ext;
output [2:0] cosa_y_stride_ext;
output [31:0] cya;
output datain_format;
output [12:0] datain_height_ext;
output [12:0] datain_width_ext;
output [12:0] datain_channel_ext;
output [12:0] dataout_height;
output [12:0] dataout_width;
output [12:0] dataout_channel;
output [4:0] x_dilation_ext;
output [4:0] y_dilation_ext;
output [13:0] entries;
output cosa_mode;
output data_reuse;
output [1:0] in_precision;
output [1:0] proc_precision;
output skip_data_rls;
output skip_weight_rls;
output weight_reuse;
output op_en_trigger;
output [1:0] y_extension;
output [1:0] pra_truncate;
output [11:0] rls_slices;
output [31:0] weight_bytes;
output weight_format;
output [4:0] weight_height_ext;
output [4:0] weight_width_ext;
output [12:0] weight_channel_ext;
output [12:0] weight_kernel;
output [27:0] wmb_bytes;
output [4:0] pad_left;
output [4:0] pad_top;
output [15:0] pad_value;
// Read-only register inputs
input op_en;
// wr_mask register inputs
// rstn register inputs
// leda FM_2_23 off
reg arreggen_abort_on_invalid_wr;
reg arreggen_abort_on_rowr;
reg arreggen_dump;
// leda FM_2_23 on
reg [20:0] atomics;
reg [4:0] batches;
reg cosa_mode;
reg [2:0] cosa_x_stride_ext;
reg [2:0] cosa_y_stride_ext;
reg [31:0] cya;
reg [4:0] data_bank;
reg data_reuse;
reg [12:0] datain_channel_ext;
reg datain_format;
reg [12:0] datain_height_ext;
reg [12:0] datain_width_ext;
reg [12:0] dataout_channel;
reg [12:0] dataout_height;
reg [12:0] dataout_width;
reg [13:0] entries;
reg [1:0] in_precision;
reg [4:0] pad_left;
reg [4:0] pad_top;
reg [15:0] pad_value;
reg [1:0] pra_truncate;
reg [1:0] proc_precision;
reg [31:0] reg_rd_data;
reg [11:0] rls_slices;
reg skip_data_rls;
reg skip_weight_rls;
reg [4:0] weight_bank;
reg [31:0] weight_bytes;
reg [12:0] weight_channel_ext;
reg weight_format;
reg [4:0] weight_height_ext;
reg [12:0] weight_kernel;
reg weight_reuse;
reg [4:0] weight_width_ext;
reg [27:0] wmb_bytes;
reg [4:0] x_dilation_ext;
reg [4:0] y_dilation_ext;
reg [1:0] y_extension;
assign reg_offset_wr = {20'b0 , reg_offset};
// SCR signals
// Address decode
wire autosa_csc_d_atomics_0_wren = (reg_offset_wr == (32'h6044 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_csc_d_bank_0_wren = (reg_offset_wr == (32'h605c & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_csc_d_batch_number_0_wren = (reg_offset_wr == (32'h601c & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_csc_d_cosa_stride_ext_0_wren = (reg_offset_wr == (32'h604c & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_csc_d_cya_0_wren = (reg_offset_wr == (32'h6064 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_csc_d_datain_format_0_wren = (reg_offset_wr == (32'h6010 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_csc_d_datain_size_ext_0_0_wren = (reg_offset_wr == (32'h6014 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_csc_d_datain_size_ext_1_0_wren = (reg_offset_wr == (32'h6018 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_csc_d_dataout_size_0_0_wren = (reg_offset_wr == (32'h603c & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_csc_d_dataout_size_1_0_wren = (reg_offset_wr == (32'h6040 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_csc_d_dilation_ext_0_wren = (reg_offset_wr == (32'h6050 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_csc_d_entry_per_slice_0_wren = (reg_offset_wr == (32'h6024 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_csc_d_misc_cfg_0_wren = (reg_offset_wr == (32'h600c & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_csc_d_op_enable_0_wren = (reg_offset_wr == (32'h6008 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_csc_d_post_y_extension_0_wren = (reg_offset_wr == (32'h6020 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_csc_d_pra_cfg_0_wren = (reg_offset_wr == (32'h6060 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_csc_d_release_0_wren = (reg_offset_wr == (32'h6048 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_csc_d_weight_bytes_0_wren = (reg_offset_wr == (32'h6034 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_csc_d_weight_format_0_wren = (reg_offset_wr == (32'h6028 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_csc_d_weight_size_ext_0_0_wren = (reg_offset_wr == (32'h602c & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_csc_d_weight_size_ext_1_0_wren = (reg_offset_wr == (32'h6030 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_csc_d_wmb_bytes_0_wren = (reg_offset_wr == (32'h6038 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_csc_d_zero_padding_0_wren = (reg_offset_wr == (32'h6054 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
wire autosa_csc_d_zero_padding_value_0_wren = (reg_offset_wr == (32'h6058 & 32'h00000fff)) & reg_wr_en ; //spyglass disable UnloadedNet-ML //(W528)
assign autosa_csc_d_atomics_0_out[31:0] = { 11'b0, atomics };
assign autosa_csc_d_bank_0_out[31:0] = { 11'b0, weight_bank, 11'b0, data_bank };
assign autosa_csc_d_batch_number_0_out[31:0] = { 27'b0, batches };
assign autosa_csc_d_cosa_stride_ext_0_out[31:0] = { 13'b0, cosa_y_stride_ext, 13'b0, cosa_x_stride_ext };
assign autosa_csc_d_cya_0_out[31:0] = { cya };
assign autosa_csc_d_datain_format_0_out[31:0] = { 31'b0, datain_format };
assign autosa_csc_d_datain_size_ext_0_0_out[31:0] = { 3'b0, datain_height_ext, 3'b0, datain_width_ext };
assign autosa_csc_d_datain_size_ext_1_0_out[31:0] = { 19'b0, datain_channel_ext };
assign autosa_csc_d_dataout_size_0_0_out[31:0] = { 3'b0, dataout_height, 3'b0, dataout_width };
assign autosa_csc_d_dataout_size_1_0_out[31:0] = { 19'b0, dataout_channel };
assign autosa_csc_d_dilation_ext_0_out[31:0] = { 11'b0, y_dilation_ext, 11'b0, x_dilation_ext };
assign autosa_csc_d_entry_per_slice_0_out[31:0] = { 18'b0, entries };
assign autosa_csc_d_misc_cfg_0_out[31:0] = { 3'b0, skip_weight_rls, 3'b0, skip_data_rls, 3'b0, weight_reuse, 3'b0, data_reuse, 2'b0, proc_precision, 2'b0, in_precision, 7'b0, cosa_mode };
assign autosa_csc_d_op_enable_0_out[31:0] = { 31'b0, op_en };
assign autosa_csc_d_post_y_extension_0_out[31:0] = { 30'b0, y_extension };
assign autosa_csc_d_pra_cfg_0_out[31:0] = { 30'b0, pra_truncate };
assign autosa_csc_d_release_0_out[31:0] = { 20'b0, rls_slices };
assign autosa_csc_d_weight_bytes_0_out[31:0] = weight_bytes;
assign autosa_csc_d_weight_format_0_out[31:0] = { 31'b0, weight_format };
assign autosa_csc_d_weight_size_ext_0_0_out[31:0] = { 11'b0, weight_height_ext, 11'b0, weight_width_ext };
assign autosa_csc_d_weight_size_ext_1_0_out[31:0] = { 3'b0, weight_kernel, 3'b0, weight_channel_ext };
assign autosa_csc_d_wmb_bytes_0_out[31:0] = { 4'b0, wmb_bytes};
assign autosa_csc_d_zero_padding_0_out[31:0] = { 11'b0, pad_top, 11'b0, pad_left };
assign autosa_csc_d_zero_padding_value_0_out[31:0] = { 16'b0, pad_value };
assign op_en_trigger = autosa_csc_d_op_enable_0_wren; //(W563)
assign reg_offset_rd_int = reg_offset;
// Output mux
//spyglass disable_block W338, W263
always @(
  reg_offset_rd_int
  or autosa_csc_d_atomics_0_out
  or autosa_csc_d_bank_0_out
  or autosa_csc_d_batch_number_0_out
  or autosa_csc_d_cosa_stride_ext_0_out
  or autosa_csc_d_cya_0_out
  or autosa_csc_d_datain_format_0_out
  or autosa_csc_d_datain_size_ext_0_0_out
  or autosa_csc_d_datain_size_ext_1_0_out
  or autosa_csc_d_dataout_size_0_0_out
  or autosa_csc_d_dataout_size_1_0_out
  or autosa_csc_d_dilation_ext_0_out
  or autosa_csc_d_entry_per_slice_0_out
  or autosa_csc_d_misc_cfg_0_out
  or autosa_csc_d_op_enable_0_out
  or autosa_csc_d_post_y_extension_0_out
  or autosa_csc_d_pra_cfg_0_out
  or autosa_csc_d_release_0_out
  or autosa_csc_d_weight_bytes_0_out
  or autosa_csc_d_weight_format_0_out
  or autosa_csc_d_weight_size_ext_0_0_out
  or autosa_csc_d_weight_size_ext_1_0_out
  or autosa_csc_d_wmb_bytes_0_out
  or autosa_csc_d_zero_padding_0_out
  or autosa_csc_d_zero_padding_value_0_out
  ) begin
  case (reg_offset_rd_int)
     (32'h6044 & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_atomics_0_out ;
                            end
     (32'h605c & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_bank_0_out ;
                            end
     (32'h601c & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_batch_number_0_out ;
                            end
     (32'h604c & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_cosa_stride_ext_0_out ;
                            end
     (32'h6064 & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_cya_0_out ;
                            end
     (32'h6010 & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_datain_format_0_out ;
                            end
     (32'h6014 & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_datain_size_ext_0_0_out ;
                            end
     (32'h6018 & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_datain_size_ext_1_0_out ;
                            end
     (32'h603c & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_dataout_size_0_0_out ;
                            end
     (32'h6040 & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_dataout_size_1_0_out ;
                            end
     (32'h6050 & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_dilation_ext_0_out ;
                            end
     (32'h6024 & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_entry_per_slice_0_out ;
                            end
     (32'h600c & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_misc_cfg_0_out ;
                            end
     (32'h6008 & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_op_enable_0_out ;
                            end
     (32'h6020 & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_post_y_extension_0_out ;
                            end
     (32'h6060 & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_pra_cfg_0_out ;
                            end
     (32'h6048 & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_release_0_out ;
                            end
     (32'h6034 & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_weight_bytes_0_out ;
                            end
     (32'h6028 & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_weight_format_0_out ;
                            end
     (32'h602c & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_weight_size_ext_0_0_out ;
                            end
     (32'h6030 & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_weight_size_ext_1_0_out ;
                            end
     (32'h6038 & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_wmb_bytes_0_out ;
                            end
     (32'h6054 & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_zero_padding_0_out ;
                            end
     (32'h6058 & 32'h00000fff): begin
                            reg_rd_data = autosa_csc_d_zero_padding_value_0_out ;
                            end
    default: reg_rd_data = {32{1'b0}};
  endcase
end
//spyglass enable_block W338, W263
// spyglass disable_block STARC-2.10.1.6, NoConstWithXZ, W443
// Register flop declarations
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
  if (!autosa_core_rstn) begin
    atomics[20:0] <= 21'b000000000000000000001;
    data_bank[4:0] <= 5'b00000;
    weight_bank[4:0] <= 5'b00000;
    batches[4:0] <= 5'b00000;
    cosa_x_stride_ext[2:0] <= 3'b000;
    cosa_y_stride_ext[2:0] <= 3'b000;
    cya[31:0] <= 32'b00000000000000000000000000000000;
    datain_format <= 1'b0;
    datain_height_ext[12:0] <= 13'b0000000000000;
    datain_width_ext[12:0] <= 13'b0000000000000;
    datain_channel_ext[12:0] <= 13'b0000000000000;
    dataout_height[12:0] <= 13'b0000000000000;
    dataout_width[12:0] <= 13'b0000000000000;
    dataout_channel[12:0] <= 13'b0000000000000;
    x_dilation_ext[4:0] <= 5'b00000;
    y_dilation_ext[4:0] <= 5'b00000;
    entries[13:0] <= 14'b00000000000000;
    cosa_mode <= 1'b0;
    data_reuse <= 1'b0;
    in_precision[1:0] <= 2'b01;
    proc_precision[1:0] <= 2'b01;
    skip_data_rls <= 1'b0;
    skip_weight_rls <= 1'b0;
    weight_reuse <= 1'b0;
    y_extension[1:0] <= 2'b00;
    pra_truncate[1:0] <= 2'b00;
    rls_slices[11:0] <= 12'b000000000001;
    weight_bytes[31:0] <= 32'b00000000000000000000000000000000;
    weight_format <= 1'b0;
    weight_height_ext[4:0] <= 5'b00000;
    weight_width_ext[4:0] <= 5'b00000;
    weight_channel_ext[12:0] <= 13'b0000000000000;
    weight_kernel[12:0] <= 13'b0000000000000;
    wmb_bytes[27:0] <= 28'b0000000000000000000000000000;
    pad_left[4:0] <= 5'b00000;
    pad_top[4:0] <= 5'b00000;
    pad_value[15:0] <= 16'b0000000000000000;
  end else begin
// Register: AUTOSA_CSC_D_ATOMICS_0 Field: atomics
  if (autosa_csc_d_atomics_0_wren) begin
    atomics[20:0] <= reg_wr_data[20:0];
  end
// Register: AUTOSA_CSC_D_BANK_0 Field: data_bank
  if (autosa_csc_d_bank_0_wren) begin
    data_bank[4:0] <= reg_wr_data[4:0];
  end
// Register: AUTOSA_CSC_D_BANK_0 Field: weight_bank
  if (autosa_csc_d_bank_0_wren) begin
    weight_bank[4:0] <= reg_wr_data[20:16];
  end
// Register: AUTOSA_CSC_D_BATCH_NUMBER_0 Field: batches
  if (autosa_csc_d_batch_number_0_wren) begin
    batches[4:0] <= reg_wr_data[4:0];
  end
// Register: AUTOSA_CSC_D_COSA_STRIDE_EXT_0 Field: cosa_x_stride_ext
  if (autosa_csc_d_cosa_stride_ext_0_wren) begin
    cosa_x_stride_ext[2:0] <= reg_wr_data[2:0];
  end
// Register: AUTOSA_CSC_D_COSA_STRIDE_EXT_0 Field: cosa_y_stride_ext
  if (autosa_csc_d_cosa_stride_ext_0_wren) begin
    cosa_y_stride_ext[2:0] <= reg_wr_data[18:16];
  end
// Register: AUTOSA_CSC_D_CYA_0 Field: cya
  if (autosa_csc_d_cya_0_wren) begin
    cya[31:0] <= reg_wr_data[31:0];
  end
// Register: AUTOSA_CSC_D_DATAIN_FORMAT_0 Field: datain_format
  if (autosa_csc_d_datain_format_0_wren) begin
    datain_format <= reg_wr_data[0];
  end
// Register: AUTOSA_CSC_D_DATAIN_SIZE_EXT_0_0 Field: datain_height_ext
  if (autosa_csc_d_datain_size_ext_0_0_wren) begin
    datain_height_ext[12:0] <= reg_wr_data[28:16];
  end
// Register: AUTOSA_CSC_D_DATAIN_SIZE_EXT_0_0 Field: datain_width_ext
  if (autosa_csc_d_datain_size_ext_0_0_wren) begin
    datain_width_ext[12:0] <= reg_wr_data[12:0];
  end
// Register: AUTOSA_CSC_D_DATAIN_SIZE_EXT_1_0 Field: datain_channel_ext
  if (autosa_csc_d_datain_size_ext_1_0_wren) begin
    datain_channel_ext[12:0] <= reg_wr_data[12:0];
  end
// Register: AUTOSA_CSC_D_DATAOUT_SIZE_0_0 Field: dataout_height
  if (autosa_csc_d_dataout_size_0_0_wren) begin
    dataout_height[12:0] <= reg_wr_data[28:16];
  end
// Register: AUTOSA_CSC_D_DATAOUT_SIZE_0_0 Field: dataout_width
  if (autosa_csc_d_dataout_size_0_0_wren) begin
    dataout_width[12:0] <= reg_wr_data[12:0];
  end
// Register: AUTOSA_CSC_D_DATAOUT_SIZE_1_0 Field: dataout_channel
  if (autosa_csc_d_dataout_size_1_0_wren) begin
    dataout_channel[12:0] <= reg_wr_data[12:0];
  end
// Register: AUTOSA_CSC_D_DILATION_EXT_0 Field: x_dilation_ext
  if (autosa_csc_d_dilation_ext_0_wren) begin
    x_dilation_ext[4:0] <= reg_wr_data[4:0];
  end
// Register: AUTOSA_CSC_D_DILATION_EXT_0 Field: y_dilation_ext
  if (autosa_csc_d_dilation_ext_0_wren) begin
    y_dilation_ext[4:0] <= reg_wr_data[20:16];
  end
// Register: AUTOSA_CSC_D_ENTRY_PER_SLICE_0 Field: entries
  if (autosa_csc_d_entry_per_slice_0_wren) begin
    entries[13:0] <= reg_wr_data[13:0];
  end
// Register: AUTOSA_CSC_D_MISC_CFG_0 Field: cosa_mode
  if (autosa_csc_d_misc_cfg_0_wren) begin
    cosa_mode <= reg_wr_data[0];
  end
// Register: AUTOSA_CSC_D_MISC_CFG_0 Field: data_reuse
  if (autosa_csc_d_misc_cfg_0_wren) begin
    data_reuse <= reg_wr_data[16];
  end
// Register: AUTOSA_CSC_D_MISC_CFG_0 Field: in_precision
  if (autosa_csc_d_misc_cfg_0_wren) begin
    in_precision[1:0] <= reg_wr_data[9:8];
  end
// Register: AUTOSA_CSC_D_MISC_CFG_0 Field: proc_precision
  if (autosa_csc_d_misc_cfg_0_wren) begin
    proc_precision[1:0] <= reg_wr_data[13:12];
  end
// Register: AUTOSA_CSC_D_MISC_CFG_0 Field: skip_data_rls
  if (autosa_csc_d_misc_cfg_0_wren) begin
    skip_data_rls <= reg_wr_data[24];
  end
// Register: AUTOSA_CSC_D_MISC_CFG_0 Field: skip_weight_rls
  if (autosa_csc_d_misc_cfg_0_wren) begin
    skip_weight_rls <= reg_wr_data[28];
  end
// Register: AUTOSA_CSC_D_MISC_CFG_0 Field: weight_reuse
  if (autosa_csc_d_misc_cfg_0_wren) begin
    weight_reuse <= reg_wr_data[20];
  end
// Not generating flops for field AUTOSA_CSC_D_OP_ENABLE_0::op_en (to be implemented outside)
// Register: AUTOSA_CSC_D_POST_Y_EXTENSION_0 Field: y_extension
  if (autosa_csc_d_post_y_extension_0_wren) begin
    y_extension[1:0] <= reg_wr_data[1:0];
  end
// Register: AUTOSA_CSC_D_PRA_CFG_0 Field: pra_truncate
  if (autosa_csc_d_pra_cfg_0_wren) begin
    pra_truncate[1:0] <= reg_wr_data[1:0];
  end
// Register: AUTOSA_CSC_D_RELEASE_0 Field: rls_slices
  if (autosa_csc_d_release_0_wren) begin
    rls_slices[11:0] <= reg_wr_data[11:0];
  end
// Register: AUTOSA_CSC_D_WEIGHT_BYTES_0 Field: weight_bytes
  if (autosa_csc_d_weight_bytes_0_wren) begin
    weight_bytes[31:0] <= reg_wr_data[31:0];
  end
// Register: AUTOSA_CSC_D_WEIGHT_FORMAT_0 Field: weight_format
  if (autosa_csc_d_weight_format_0_wren) begin
    weight_format <= reg_wr_data[0];
  end
// Register: AUTOSA_CSC_D_WEIGHT_SIZE_EXT_0_0 Field: weight_height_ext
  if (autosa_csc_d_weight_size_ext_0_0_wren) begin
    weight_height_ext[4:0] <= reg_wr_data[20:16];
  end
// Register: AUTOSA_CSC_D_WEIGHT_SIZE_EXT_0_0 Field: weight_width_ext
  if (autosa_csc_d_weight_size_ext_0_0_wren) begin
    weight_width_ext[4:0] <= reg_wr_data[4:0];
  end
// Register: AUTOSA_CSC_D_WEIGHT_SIZE_EXT_1_0 Field: weight_channel_ext
  if (autosa_csc_d_weight_size_ext_1_0_wren) begin
    weight_channel_ext[12:0] <= reg_wr_data[12:0];
  end
// Register: AUTOSA_CSC_D_WEIGHT_SIZE_EXT_1_0 Field: weight_kernel
  if (autosa_csc_d_weight_size_ext_1_0_wren) begin
    weight_kernel[12:0] <= reg_wr_data[28:16];
  end
// Register: AUTOSA_CSC_D_WMB_BYTES_0 Field: wmb_bytes
  if (autosa_csc_d_wmb_bytes_0_wren) begin
    wmb_bytes[27:0] <= reg_wr_data[27:0];
  end
// Register: AUTOSA_CSC_D_ZERO_PADDING_0 Field: pad_left
  if (autosa_csc_d_zero_padding_0_wren) begin
    pad_left[4:0] <= reg_wr_data[4:0];
  end
// Register: AUTOSA_CSC_D_ZERO_PADDING_0 Field: pad_top
  if (autosa_csc_d_zero_padding_0_wren) begin
    pad_top[4:0] <= reg_wr_data[20:16];
  end
// Register: AUTOSA_CSC_D_ZERO_PADDING_VALUE_0 Field: pad_value
  if (autosa_csc_d_zero_padding_value_0_wren) begin
    pad_value[15:0] <= reg_wr_data[15:0];
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
      (32'h6044 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_ATOMICS_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_atomics_0_out, autosa_csc_d_atomics_0_out);
      (32'h605c & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_BANK_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_bank_0_out, autosa_csc_d_bank_0_out);
      (32'h601c & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_BATCH_NUMBER_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_batch_number_0_out, autosa_csc_d_batch_number_0_out);
      (32'h604c & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_COSA_STRIDE_EXT_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_cosa_stride_ext_0_out, autosa_csc_d_cosa_stride_ext_0_out);
      (32'h6064 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_CYA_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_cya_0_out, autosa_csc_d_cya_0_out);
      (32'h6010 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_DATAIN_FORMAT_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_datain_format_0_out, autosa_csc_d_datain_format_0_out);
      (32'h6014 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_DATAIN_SIZE_EXT_0_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_datain_size_ext_0_0_out, autosa_csc_d_datain_size_ext_0_0_out);
      (32'h6018 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_DATAIN_SIZE_EXT_1_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_datain_size_ext_1_0_out, autosa_csc_d_datain_size_ext_1_0_out);
      (32'h603c & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_DATAOUT_SIZE_0_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_dataout_size_0_0_out, autosa_csc_d_dataout_size_0_0_out);
      (32'h6040 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_DATAOUT_SIZE_1_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_dataout_size_1_0_out, autosa_csc_d_dataout_size_1_0_out);
      (32'h6050 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_DILATION_EXT_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_dilation_ext_0_out, autosa_csc_d_dilation_ext_0_out);
      (32'h6024 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_ENTRY_PER_SLICE_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_entry_per_slice_0_out, autosa_csc_d_entry_per_slice_0_out);
      (32'h600c & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_MISC_CFG_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_misc_cfg_0_out, autosa_csc_d_misc_cfg_0_out);
      (32'h6008 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_OP_ENABLE_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_op_enable_0_out, autosa_csc_d_op_enable_0_out);
      (32'h6020 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_POST_Y_EXTENSION_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_post_y_extension_0_out, autosa_csc_d_post_y_extension_0_out);
      (32'h6060 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_PRA_CFG_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_pra_cfg_0_out, autosa_csc_d_pra_cfg_0_out);
      (32'h6048 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_RELEASE_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_release_0_out, autosa_csc_d_release_0_out);
      (32'h6034 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_WEIGHT_BYTES_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_weight_bytes_0_out, autosa_csc_d_weight_bytes_0_out);
      (32'h6028 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_WEIGHT_FORMAT_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_weight_format_0_out, autosa_csc_d_weight_format_0_out);
      (32'h602c & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_WEIGHT_SIZE_EXT_0_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_weight_size_ext_0_0_out, autosa_csc_d_weight_size_ext_0_0_out);
      (32'h6030 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_WEIGHT_SIZE_EXT_1_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_weight_size_ext_1_0_out, autosa_csc_d_weight_size_ext_1_0_out);
      (32'h6038 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_WMB_BYTES_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_wmb_bytes_0_out, autosa_csc_d_wmb_bytes_0_out);
      (32'h6054 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_ZERO_PADDING_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_zero_padding_0_out, autosa_csc_d_zero_padding_0_out);
      (32'h6058 & 32'h00000fff): if (arreggen_dump) $display("%t:%m: reg wr: AUTOSA_CSC_D_ZERO_PADDING_VALUE_0 = 0x%h (old value: 0x%h, 0x%b))", $time, reg_wr_data, autosa_csc_d_zero_padding_value_0_out, autosa_csc_d_zero_padding_value_0_out);
      default: begin
          if (arreggen_dump) $display("%t:%m: reg wr: Unknown register (0x%h) = 0x%h", $time, reg_offset, reg_wr_data);
          if (arreggen_abort_on_invalid_wr) begin $display("ERROR: write to undefined register!"); $finish; end
        end
    endcase
  end
end
// VCS coverage on
// synopsys translate_on
endmodule // SA_AUTOSA_CSC_dual_reg
