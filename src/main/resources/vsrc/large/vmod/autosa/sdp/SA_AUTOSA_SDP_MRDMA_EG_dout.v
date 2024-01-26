// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_SDP_MRDMA_EG_dout.v
`include "sa_simulate_x_tick.vh"
// ================================================================
// AUTOSA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_SDP_define.h
module SA_AUTOSA_SDP_MRDMA_EG_dout (
   autosa_core_clk //|< i
  ,autosa_core_rstn //|< i
  ,op_load //|< i
  ,eg_done //|> o
  ,cmd2dat_dma_pd //|< i
  ,cmd2dat_dma_pvld //|< i
  ,cmd2dat_dma_prdy //|> o
  ,pfifo0_rd_pd //|< i
  ,pfifo0_rd_pvld //|< i
  ,pfifo1_rd_pd //|< i
  ,pfifo1_rd_pvld //|< i
  ,pfifo2_rd_pd //|< i
  ,pfifo2_rd_pvld //|< i
  ,pfifo3_rd_pd //|< i
  ,pfifo3_rd_pvld //|< i
  ,pfifo0_rd_prdy //|> o
  ,pfifo1_rd_prdy //|> o
  ,pfifo2_rd_prdy //|> o
  ,pfifo3_rd_prdy //|> o
  ,sdp_mrdma2cmux_pd //|> o
  ,sdp_mrdma2cmux_valid //|> o
  ,sdp_mrdma2cmux_ready //|< i
  ,reg2dp_height //|< i
  ,reg2dp_width //|< i
  ,reg2dp_in_precision //|< i
  ,reg2dp_proc_precision //|< i
  ,reg2dp_perf_nan_inf_count_en //|< i
  ,dp2reg_status_inf_input_num //|> o
  ,dp2reg_status_nan_input_num //|> o
  );
//
// SA_AUTOSA_SDP_MRDMA_EG_dout_ports.v
//
input autosa_core_clk;
input autosa_core_rstn;
input op_load;
output eg_done;
input [12:0] reg2dp_height;
input [12:0] reg2dp_width;
input [1:0] reg2dp_in_precision;
input [1:0] reg2dp_proc_precision;
input reg2dp_perf_nan_inf_count_en;
output [31:0] dp2reg_status_inf_input_num;
output [31:0] dp2reg_status_nan_input_num;
output sdp_mrdma2cmux_valid;
input sdp_mrdma2cmux_ready;
output [32*32 +1:0] sdp_mrdma2cmux_pd;
input cmd2dat_dma_pvld;
output cmd2dat_dma_prdy;
input [14:0] cmd2dat_dma_pd;
input pfifo0_rd_pvld;
output pfifo0_rd_prdy;
input [32*8 -1:0] pfifo0_rd_pd;
input pfifo1_rd_pvld;
output pfifo1_rd_prdy;
input [32*8 -1:0] pfifo1_rd_pd;
input pfifo2_rd_pvld;
output pfifo2_rd_prdy;
input [32*8 -1:0] pfifo2_rd_pd;
input pfifo3_rd_pvld;
output pfifo3_rd_prdy;
input [32*8 -1:0] pfifo3_rd_pd;
reg eg_done;
wire cfg_di_16;
wire cfg_di_fp16;
wire cfg_di_int16;
wire cfg_di_int8;
wire cfg_do_int8;
wire cfg_mode_1x1_pack;
wire cfg_perf_nan_inf_count_en;
wire [13:0] size_of_beat;
reg [13:0] beat_cnt;
wire is_last_beat;
wire cmd2dat_dma_cube_end;
wire [13:0] cmd2dat_dma_size;
wire cmd_cube_end;
wire dat_accept;
wire dat_batch_end;
wire [32*32 -1:0] dat_data;
wire dat_layer_end;
wire [32*32 +1:0] dat_pd;
wire dat_rdy;
wire dat_vld;
wire fifo_vld;
wire pfifo0_sel;
wire pfifo1_sel;
wire pfifo2_sel;
wire pfifo3_sel;
wire [32*8 -1:0] pfifo0_rd_data;
wire [32*8 -1:0] pfifo1_rd_data;
wire [32*8 -1:0] pfifo2_rd_data;
wire [32*8 -1:0] pfifo3_rd_data;
//: my $k = 32/2;
//: foreach my $j (0..3) {
//: foreach my $i (0..${k}-1) {
//: print "wire    [15:0] pfifo${j}_data_byte${i}_16; \n";
//: }
//: }
//: foreach my $j (0..3) {
//: foreach my $i (0..${k}-1) {
//: print "wire    [31:0] pfifo${j}_data_ext_byte${i}_int16; \n";
//: print "wire    [31:0] pfifo${j}_data_ext_byte${i}_16; \n";
//: }
//: }
//: my $k = 32;
//: my $dw = $k * 8 -1;
//: foreach my $j (0..3) {
//: foreach my $i (0..${k}-1) {
//: print "wire     [7:0] pfifo${j}_data_byte${i}_8; \n";
//: }
//: }
//: foreach my $j (0..3) {
//: foreach my $i (0..${k}-1) {
//: print "wire    [31:0] pfifo${j}_data_ext_byte${i}_8; \n";
//: }
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
wire    [15:0] pfifo0_data_byte0_16; 
wire    [15:0] pfifo0_data_byte1_16; 
wire    [15:0] pfifo0_data_byte2_16; 
wire    [15:0] pfifo0_data_byte3_16; 
wire    [15:0] pfifo0_data_byte4_16; 
wire    [15:0] pfifo0_data_byte5_16; 
wire    [15:0] pfifo0_data_byte6_16; 
wire    [15:0] pfifo0_data_byte7_16; 
wire    [15:0] pfifo0_data_byte8_16; 
wire    [15:0] pfifo0_data_byte9_16; 
wire    [15:0] pfifo0_data_byte10_16; 
wire    [15:0] pfifo0_data_byte11_16; 
wire    [15:0] pfifo0_data_byte12_16; 
wire    [15:0] pfifo0_data_byte13_16; 
wire    [15:0] pfifo0_data_byte14_16; 
wire    [15:0] pfifo0_data_byte15_16; 
wire    [15:0] pfifo1_data_byte0_16; 
wire    [15:0] pfifo1_data_byte1_16; 
wire    [15:0] pfifo1_data_byte2_16; 
wire    [15:0] pfifo1_data_byte3_16; 
wire    [15:0] pfifo1_data_byte4_16; 
wire    [15:0] pfifo1_data_byte5_16; 
wire    [15:0] pfifo1_data_byte6_16; 
wire    [15:0] pfifo1_data_byte7_16; 
wire    [15:0] pfifo1_data_byte8_16; 
wire    [15:0] pfifo1_data_byte9_16; 
wire    [15:0] pfifo1_data_byte10_16; 
wire    [15:0] pfifo1_data_byte11_16; 
wire    [15:0] pfifo1_data_byte12_16; 
wire    [15:0] pfifo1_data_byte13_16; 
wire    [15:0] pfifo1_data_byte14_16; 
wire    [15:0] pfifo1_data_byte15_16; 
wire    [15:0] pfifo2_data_byte0_16; 
wire    [15:0] pfifo2_data_byte1_16; 
wire    [15:0] pfifo2_data_byte2_16; 
wire    [15:0] pfifo2_data_byte3_16; 
wire    [15:0] pfifo2_data_byte4_16; 
wire    [15:0] pfifo2_data_byte5_16; 
wire    [15:0] pfifo2_data_byte6_16; 
wire    [15:0] pfifo2_data_byte7_16; 
wire    [15:0] pfifo2_data_byte8_16; 
wire    [15:0] pfifo2_data_byte9_16; 
wire    [15:0] pfifo2_data_byte10_16; 
wire    [15:0] pfifo2_data_byte11_16; 
wire    [15:0] pfifo2_data_byte12_16; 
wire    [15:0] pfifo2_data_byte13_16; 
wire    [15:0] pfifo2_data_byte14_16; 
wire    [15:0] pfifo2_data_byte15_16; 
wire    [15:0] pfifo3_data_byte0_16; 
wire    [15:0] pfifo3_data_byte1_16; 
wire    [15:0] pfifo3_data_byte2_16; 
wire    [15:0] pfifo3_data_byte3_16; 
wire    [15:0] pfifo3_data_byte4_16; 
wire    [15:0] pfifo3_data_byte5_16; 
wire    [15:0] pfifo3_data_byte6_16; 
wire    [15:0] pfifo3_data_byte7_16; 
wire    [15:0] pfifo3_data_byte8_16; 
wire    [15:0] pfifo3_data_byte9_16; 
wire    [15:0] pfifo3_data_byte10_16; 
wire    [15:0] pfifo3_data_byte11_16; 
wire    [15:0] pfifo3_data_byte12_16; 
wire    [15:0] pfifo3_data_byte13_16; 
wire    [15:0] pfifo3_data_byte14_16; 
wire    [15:0] pfifo3_data_byte15_16; 
wire    [31:0] pfifo0_data_ext_byte0_int16; 
wire    [31:0] pfifo0_data_ext_byte0_16; 
wire    [31:0] pfifo0_data_ext_byte1_int16; 
wire    [31:0] pfifo0_data_ext_byte1_16; 
wire    [31:0] pfifo0_data_ext_byte2_int16; 
wire    [31:0] pfifo0_data_ext_byte2_16; 
wire    [31:0] pfifo0_data_ext_byte3_int16; 
wire    [31:0] pfifo0_data_ext_byte3_16; 
wire    [31:0] pfifo0_data_ext_byte4_int16; 
wire    [31:0] pfifo0_data_ext_byte4_16; 
wire    [31:0] pfifo0_data_ext_byte5_int16; 
wire    [31:0] pfifo0_data_ext_byte5_16; 
wire    [31:0] pfifo0_data_ext_byte6_int16; 
wire    [31:0] pfifo0_data_ext_byte6_16; 
wire    [31:0] pfifo0_data_ext_byte7_int16; 
wire    [31:0] pfifo0_data_ext_byte7_16; 
wire    [31:0] pfifo0_data_ext_byte8_int16; 
wire    [31:0] pfifo0_data_ext_byte8_16; 
wire    [31:0] pfifo0_data_ext_byte9_int16; 
wire    [31:0] pfifo0_data_ext_byte9_16; 
wire    [31:0] pfifo0_data_ext_byte10_int16; 
wire    [31:0] pfifo0_data_ext_byte10_16; 
wire    [31:0] pfifo0_data_ext_byte11_int16; 
wire    [31:0] pfifo0_data_ext_byte11_16; 
wire    [31:0] pfifo0_data_ext_byte12_int16; 
wire    [31:0] pfifo0_data_ext_byte12_16; 
wire    [31:0] pfifo0_data_ext_byte13_int16; 
wire    [31:0] pfifo0_data_ext_byte13_16; 
wire    [31:0] pfifo0_data_ext_byte14_int16; 
wire    [31:0] pfifo0_data_ext_byte14_16; 
wire    [31:0] pfifo0_data_ext_byte15_int16; 
wire    [31:0] pfifo0_data_ext_byte15_16; 
wire    [31:0] pfifo1_data_ext_byte0_int16; 
wire    [31:0] pfifo1_data_ext_byte0_16; 
wire    [31:0] pfifo1_data_ext_byte1_int16; 
wire    [31:0] pfifo1_data_ext_byte1_16; 
wire    [31:0] pfifo1_data_ext_byte2_int16; 
wire    [31:0] pfifo1_data_ext_byte2_16; 
wire    [31:0] pfifo1_data_ext_byte3_int16; 
wire    [31:0] pfifo1_data_ext_byte3_16; 
wire    [31:0] pfifo1_data_ext_byte4_int16; 
wire    [31:0] pfifo1_data_ext_byte4_16; 
wire    [31:0] pfifo1_data_ext_byte5_int16; 
wire    [31:0] pfifo1_data_ext_byte5_16; 
wire    [31:0] pfifo1_data_ext_byte6_int16; 
wire    [31:0] pfifo1_data_ext_byte6_16; 
wire    [31:0] pfifo1_data_ext_byte7_int16; 
wire    [31:0] pfifo1_data_ext_byte7_16; 
wire    [31:0] pfifo1_data_ext_byte8_int16; 
wire    [31:0] pfifo1_data_ext_byte8_16; 
wire    [31:0] pfifo1_data_ext_byte9_int16; 
wire    [31:0] pfifo1_data_ext_byte9_16; 
wire    [31:0] pfifo1_data_ext_byte10_int16; 
wire    [31:0] pfifo1_data_ext_byte10_16; 
wire    [31:0] pfifo1_data_ext_byte11_int16; 
wire    [31:0] pfifo1_data_ext_byte11_16; 
wire    [31:0] pfifo1_data_ext_byte12_int16; 
wire    [31:0] pfifo1_data_ext_byte12_16; 
wire    [31:0] pfifo1_data_ext_byte13_int16; 
wire    [31:0] pfifo1_data_ext_byte13_16; 
wire    [31:0] pfifo1_data_ext_byte14_int16; 
wire    [31:0] pfifo1_data_ext_byte14_16; 
wire    [31:0] pfifo1_data_ext_byte15_int16; 
wire    [31:0] pfifo1_data_ext_byte15_16; 
wire    [31:0] pfifo2_data_ext_byte0_int16; 
wire    [31:0] pfifo2_data_ext_byte0_16; 
wire    [31:0] pfifo2_data_ext_byte1_int16; 
wire    [31:0] pfifo2_data_ext_byte1_16; 
wire    [31:0] pfifo2_data_ext_byte2_int16; 
wire    [31:0] pfifo2_data_ext_byte2_16; 
wire    [31:0] pfifo2_data_ext_byte3_int16; 
wire    [31:0] pfifo2_data_ext_byte3_16; 
wire    [31:0] pfifo2_data_ext_byte4_int16; 
wire    [31:0] pfifo2_data_ext_byte4_16; 
wire    [31:0] pfifo2_data_ext_byte5_int16; 
wire    [31:0] pfifo2_data_ext_byte5_16; 
wire    [31:0] pfifo2_data_ext_byte6_int16; 
wire    [31:0] pfifo2_data_ext_byte6_16; 
wire    [31:0] pfifo2_data_ext_byte7_int16; 
wire    [31:0] pfifo2_data_ext_byte7_16; 
wire    [31:0] pfifo2_data_ext_byte8_int16; 
wire    [31:0] pfifo2_data_ext_byte8_16; 
wire    [31:0] pfifo2_data_ext_byte9_int16; 
wire    [31:0] pfifo2_data_ext_byte9_16; 
wire    [31:0] pfifo2_data_ext_byte10_int16; 
wire    [31:0] pfifo2_data_ext_byte10_16; 
wire    [31:0] pfifo2_data_ext_byte11_int16; 
wire    [31:0] pfifo2_data_ext_byte11_16; 
wire    [31:0] pfifo2_data_ext_byte12_int16; 
wire    [31:0] pfifo2_data_ext_byte12_16; 
wire    [31:0] pfifo2_data_ext_byte13_int16; 
wire    [31:0] pfifo2_data_ext_byte13_16; 
wire    [31:0] pfifo2_data_ext_byte14_int16; 
wire    [31:0] pfifo2_data_ext_byte14_16; 
wire    [31:0] pfifo2_data_ext_byte15_int16; 
wire    [31:0] pfifo2_data_ext_byte15_16; 
wire    [31:0] pfifo3_data_ext_byte0_int16; 
wire    [31:0] pfifo3_data_ext_byte0_16; 
wire    [31:0] pfifo3_data_ext_byte1_int16; 
wire    [31:0] pfifo3_data_ext_byte1_16; 
wire    [31:0] pfifo3_data_ext_byte2_int16; 
wire    [31:0] pfifo3_data_ext_byte2_16; 
wire    [31:0] pfifo3_data_ext_byte3_int16; 
wire    [31:0] pfifo3_data_ext_byte3_16; 
wire    [31:0] pfifo3_data_ext_byte4_int16; 
wire    [31:0] pfifo3_data_ext_byte4_16; 
wire    [31:0] pfifo3_data_ext_byte5_int16; 
wire    [31:0] pfifo3_data_ext_byte5_16; 
wire    [31:0] pfifo3_data_ext_byte6_int16; 
wire    [31:0] pfifo3_data_ext_byte6_16; 
wire    [31:0] pfifo3_data_ext_byte7_int16; 
wire    [31:0] pfifo3_data_ext_byte7_16; 
wire    [31:0] pfifo3_data_ext_byte8_int16; 
wire    [31:0] pfifo3_data_ext_byte8_16; 
wire    [31:0] pfifo3_data_ext_byte9_int16; 
wire    [31:0] pfifo3_data_ext_byte9_16; 
wire    [31:0] pfifo3_data_ext_byte10_int16; 
wire    [31:0] pfifo3_data_ext_byte10_16; 
wire    [31:0] pfifo3_data_ext_byte11_int16; 
wire    [31:0] pfifo3_data_ext_byte11_16; 
wire    [31:0] pfifo3_data_ext_byte12_int16; 
wire    [31:0] pfifo3_data_ext_byte12_16; 
wire    [31:0] pfifo3_data_ext_byte13_int16; 
wire    [31:0] pfifo3_data_ext_byte13_16; 
wire    [31:0] pfifo3_data_ext_byte14_int16; 
wire    [31:0] pfifo3_data_ext_byte14_16; 
wire    [31:0] pfifo3_data_ext_byte15_int16; 
wire    [31:0] pfifo3_data_ext_byte15_16; 
wire     [7:0] pfifo0_data_byte0_8; 
wire     [7:0] pfifo0_data_byte1_8; 
wire     [7:0] pfifo0_data_byte2_8; 
wire     [7:0] pfifo0_data_byte3_8; 
wire     [7:0] pfifo0_data_byte4_8; 
wire     [7:0] pfifo0_data_byte5_8; 
wire     [7:0] pfifo0_data_byte6_8; 
wire     [7:0] pfifo0_data_byte7_8; 
wire     [7:0] pfifo0_data_byte8_8; 
wire     [7:0] pfifo0_data_byte9_8; 
wire     [7:0] pfifo0_data_byte10_8; 
wire     [7:0] pfifo0_data_byte11_8; 
wire     [7:0] pfifo0_data_byte12_8; 
wire     [7:0] pfifo0_data_byte13_8; 
wire     [7:0] pfifo0_data_byte14_8; 
wire     [7:0] pfifo0_data_byte15_8; 
wire     [7:0] pfifo0_data_byte16_8; 
wire     [7:0] pfifo0_data_byte17_8; 
wire     [7:0] pfifo0_data_byte18_8; 
wire     [7:0] pfifo0_data_byte19_8; 
wire     [7:0] pfifo0_data_byte20_8; 
wire     [7:0] pfifo0_data_byte21_8; 
wire     [7:0] pfifo0_data_byte22_8; 
wire     [7:0] pfifo0_data_byte23_8; 
wire     [7:0] pfifo0_data_byte24_8; 
wire     [7:0] pfifo0_data_byte25_8; 
wire     [7:0] pfifo0_data_byte26_8; 
wire     [7:0] pfifo0_data_byte27_8; 
wire     [7:0] pfifo0_data_byte28_8; 
wire     [7:0] pfifo0_data_byte29_8; 
wire     [7:0] pfifo0_data_byte30_8; 
wire     [7:0] pfifo0_data_byte31_8; 
wire     [7:0] pfifo1_data_byte0_8; 
wire     [7:0] pfifo1_data_byte1_8; 
wire     [7:0] pfifo1_data_byte2_8; 
wire     [7:0] pfifo1_data_byte3_8; 
wire     [7:0] pfifo1_data_byte4_8; 
wire     [7:0] pfifo1_data_byte5_8; 
wire     [7:0] pfifo1_data_byte6_8; 
wire     [7:0] pfifo1_data_byte7_8; 
wire     [7:0] pfifo1_data_byte8_8; 
wire     [7:0] pfifo1_data_byte9_8; 
wire     [7:0] pfifo1_data_byte10_8; 
wire     [7:0] pfifo1_data_byte11_8; 
wire     [7:0] pfifo1_data_byte12_8; 
wire     [7:0] pfifo1_data_byte13_8; 
wire     [7:0] pfifo1_data_byte14_8; 
wire     [7:0] pfifo1_data_byte15_8; 
wire     [7:0] pfifo1_data_byte16_8; 
wire     [7:0] pfifo1_data_byte17_8; 
wire     [7:0] pfifo1_data_byte18_8; 
wire     [7:0] pfifo1_data_byte19_8; 
wire     [7:0] pfifo1_data_byte20_8; 
wire     [7:0] pfifo1_data_byte21_8; 
wire     [7:0] pfifo1_data_byte22_8; 
wire     [7:0] pfifo1_data_byte23_8; 
wire     [7:0] pfifo1_data_byte24_8; 
wire     [7:0] pfifo1_data_byte25_8; 
wire     [7:0] pfifo1_data_byte26_8; 
wire     [7:0] pfifo1_data_byte27_8; 
wire     [7:0] pfifo1_data_byte28_8; 
wire     [7:0] pfifo1_data_byte29_8; 
wire     [7:0] pfifo1_data_byte30_8; 
wire     [7:0] pfifo1_data_byte31_8; 
wire     [7:0] pfifo2_data_byte0_8; 
wire     [7:0] pfifo2_data_byte1_8; 
wire     [7:0] pfifo2_data_byte2_8; 
wire     [7:0] pfifo2_data_byte3_8; 
wire     [7:0] pfifo2_data_byte4_8; 
wire     [7:0] pfifo2_data_byte5_8; 
wire     [7:0] pfifo2_data_byte6_8; 
wire     [7:0] pfifo2_data_byte7_8; 
wire     [7:0] pfifo2_data_byte8_8; 
wire     [7:0] pfifo2_data_byte9_8; 
wire     [7:0] pfifo2_data_byte10_8; 
wire     [7:0] pfifo2_data_byte11_8; 
wire     [7:0] pfifo2_data_byte12_8; 
wire     [7:0] pfifo2_data_byte13_8; 
wire     [7:0] pfifo2_data_byte14_8; 
wire     [7:0] pfifo2_data_byte15_8; 
wire     [7:0] pfifo2_data_byte16_8; 
wire     [7:0] pfifo2_data_byte17_8; 
wire     [7:0] pfifo2_data_byte18_8; 
wire     [7:0] pfifo2_data_byte19_8; 
wire     [7:0] pfifo2_data_byte20_8; 
wire     [7:0] pfifo2_data_byte21_8; 
wire     [7:0] pfifo2_data_byte22_8; 
wire     [7:0] pfifo2_data_byte23_8; 
wire     [7:0] pfifo2_data_byte24_8; 
wire     [7:0] pfifo2_data_byte25_8; 
wire     [7:0] pfifo2_data_byte26_8; 
wire     [7:0] pfifo2_data_byte27_8; 
wire     [7:0] pfifo2_data_byte28_8; 
wire     [7:0] pfifo2_data_byte29_8; 
wire     [7:0] pfifo2_data_byte30_8; 
wire     [7:0] pfifo2_data_byte31_8; 
wire     [7:0] pfifo3_data_byte0_8; 
wire     [7:0] pfifo3_data_byte1_8; 
wire     [7:0] pfifo3_data_byte2_8; 
wire     [7:0] pfifo3_data_byte3_8; 
wire     [7:0] pfifo3_data_byte4_8; 
wire     [7:0] pfifo3_data_byte5_8; 
wire     [7:0] pfifo3_data_byte6_8; 
wire     [7:0] pfifo3_data_byte7_8; 
wire     [7:0] pfifo3_data_byte8_8; 
wire     [7:0] pfifo3_data_byte9_8; 
wire     [7:0] pfifo3_data_byte10_8; 
wire     [7:0] pfifo3_data_byte11_8; 
wire     [7:0] pfifo3_data_byte12_8; 
wire     [7:0] pfifo3_data_byte13_8; 
wire     [7:0] pfifo3_data_byte14_8; 
wire     [7:0] pfifo3_data_byte15_8; 
wire     [7:0] pfifo3_data_byte16_8; 
wire     [7:0] pfifo3_data_byte17_8; 
wire     [7:0] pfifo3_data_byte18_8; 
wire     [7:0] pfifo3_data_byte19_8; 
wire     [7:0] pfifo3_data_byte20_8; 
wire     [7:0] pfifo3_data_byte21_8; 
wire     [7:0] pfifo3_data_byte22_8; 
wire     [7:0] pfifo3_data_byte23_8; 
wire     [7:0] pfifo3_data_byte24_8; 
wire     [7:0] pfifo3_data_byte25_8; 
wire     [7:0] pfifo3_data_byte26_8; 
wire     [7:0] pfifo3_data_byte27_8; 
wire     [7:0] pfifo3_data_byte28_8; 
wire     [7:0] pfifo3_data_byte29_8; 
wire     [7:0] pfifo3_data_byte30_8; 
wire     [7:0] pfifo3_data_byte31_8; 
wire    [31:0] pfifo0_data_ext_byte0_8; 
wire    [31:0] pfifo0_data_ext_byte1_8; 
wire    [31:0] pfifo0_data_ext_byte2_8; 
wire    [31:0] pfifo0_data_ext_byte3_8; 
wire    [31:0] pfifo0_data_ext_byte4_8; 
wire    [31:0] pfifo0_data_ext_byte5_8; 
wire    [31:0] pfifo0_data_ext_byte6_8; 
wire    [31:0] pfifo0_data_ext_byte7_8; 
wire    [31:0] pfifo0_data_ext_byte8_8; 
wire    [31:0] pfifo0_data_ext_byte9_8; 
wire    [31:0] pfifo0_data_ext_byte10_8; 
wire    [31:0] pfifo0_data_ext_byte11_8; 
wire    [31:0] pfifo0_data_ext_byte12_8; 
wire    [31:0] pfifo0_data_ext_byte13_8; 
wire    [31:0] pfifo0_data_ext_byte14_8; 
wire    [31:0] pfifo0_data_ext_byte15_8; 
wire    [31:0] pfifo0_data_ext_byte16_8; 
wire    [31:0] pfifo0_data_ext_byte17_8; 
wire    [31:0] pfifo0_data_ext_byte18_8; 
wire    [31:0] pfifo0_data_ext_byte19_8; 
wire    [31:0] pfifo0_data_ext_byte20_8; 
wire    [31:0] pfifo0_data_ext_byte21_8; 
wire    [31:0] pfifo0_data_ext_byte22_8; 
wire    [31:0] pfifo0_data_ext_byte23_8; 
wire    [31:0] pfifo0_data_ext_byte24_8; 
wire    [31:0] pfifo0_data_ext_byte25_8; 
wire    [31:0] pfifo0_data_ext_byte26_8; 
wire    [31:0] pfifo0_data_ext_byte27_8; 
wire    [31:0] pfifo0_data_ext_byte28_8; 
wire    [31:0] pfifo0_data_ext_byte29_8; 
wire    [31:0] pfifo0_data_ext_byte30_8; 
wire    [31:0] pfifo0_data_ext_byte31_8; 
wire    [31:0] pfifo1_data_ext_byte0_8; 
wire    [31:0] pfifo1_data_ext_byte1_8; 
wire    [31:0] pfifo1_data_ext_byte2_8; 
wire    [31:0] pfifo1_data_ext_byte3_8; 
wire    [31:0] pfifo1_data_ext_byte4_8; 
wire    [31:0] pfifo1_data_ext_byte5_8; 
wire    [31:0] pfifo1_data_ext_byte6_8; 
wire    [31:0] pfifo1_data_ext_byte7_8; 
wire    [31:0] pfifo1_data_ext_byte8_8; 
wire    [31:0] pfifo1_data_ext_byte9_8; 
wire    [31:0] pfifo1_data_ext_byte10_8; 
wire    [31:0] pfifo1_data_ext_byte11_8; 
wire    [31:0] pfifo1_data_ext_byte12_8; 
wire    [31:0] pfifo1_data_ext_byte13_8; 
wire    [31:0] pfifo1_data_ext_byte14_8; 
wire    [31:0] pfifo1_data_ext_byte15_8; 
wire    [31:0] pfifo1_data_ext_byte16_8; 
wire    [31:0] pfifo1_data_ext_byte17_8; 
wire    [31:0] pfifo1_data_ext_byte18_8; 
wire    [31:0] pfifo1_data_ext_byte19_8; 
wire    [31:0] pfifo1_data_ext_byte20_8; 
wire    [31:0] pfifo1_data_ext_byte21_8; 
wire    [31:0] pfifo1_data_ext_byte22_8; 
wire    [31:0] pfifo1_data_ext_byte23_8; 
wire    [31:0] pfifo1_data_ext_byte24_8; 
wire    [31:0] pfifo1_data_ext_byte25_8; 
wire    [31:0] pfifo1_data_ext_byte26_8; 
wire    [31:0] pfifo1_data_ext_byte27_8; 
wire    [31:0] pfifo1_data_ext_byte28_8; 
wire    [31:0] pfifo1_data_ext_byte29_8; 
wire    [31:0] pfifo1_data_ext_byte30_8; 
wire    [31:0] pfifo1_data_ext_byte31_8; 
wire    [31:0] pfifo2_data_ext_byte0_8; 
wire    [31:0] pfifo2_data_ext_byte1_8; 
wire    [31:0] pfifo2_data_ext_byte2_8; 
wire    [31:0] pfifo2_data_ext_byte3_8; 
wire    [31:0] pfifo2_data_ext_byte4_8; 
wire    [31:0] pfifo2_data_ext_byte5_8; 
wire    [31:0] pfifo2_data_ext_byte6_8; 
wire    [31:0] pfifo2_data_ext_byte7_8; 
wire    [31:0] pfifo2_data_ext_byte8_8; 
wire    [31:0] pfifo2_data_ext_byte9_8; 
wire    [31:0] pfifo2_data_ext_byte10_8; 
wire    [31:0] pfifo2_data_ext_byte11_8; 
wire    [31:0] pfifo2_data_ext_byte12_8; 
wire    [31:0] pfifo2_data_ext_byte13_8; 
wire    [31:0] pfifo2_data_ext_byte14_8; 
wire    [31:0] pfifo2_data_ext_byte15_8; 
wire    [31:0] pfifo2_data_ext_byte16_8; 
wire    [31:0] pfifo2_data_ext_byte17_8; 
wire    [31:0] pfifo2_data_ext_byte18_8; 
wire    [31:0] pfifo2_data_ext_byte19_8; 
wire    [31:0] pfifo2_data_ext_byte20_8; 
wire    [31:0] pfifo2_data_ext_byte21_8; 
wire    [31:0] pfifo2_data_ext_byte22_8; 
wire    [31:0] pfifo2_data_ext_byte23_8; 
wire    [31:0] pfifo2_data_ext_byte24_8; 
wire    [31:0] pfifo2_data_ext_byte25_8; 
wire    [31:0] pfifo2_data_ext_byte26_8; 
wire    [31:0] pfifo2_data_ext_byte27_8; 
wire    [31:0] pfifo2_data_ext_byte28_8; 
wire    [31:0] pfifo2_data_ext_byte29_8; 
wire    [31:0] pfifo2_data_ext_byte30_8; 
wire    [31:0] pfifo2_data_ext_byte31_8; 
wire    [31:0] pfifo3_data_ext_byte0_8; 
wire    [31:0] pfifo3_data_ext_byte1_8; 
wire    [31:0] pfifo3_data_ext_byte2_8; 
wire    [31:0] pfifo3_data_ext_byte3_8; 
wire    [31:0] pfifo3_data_ext_byte4_8; 
wire    [31:0] pfifo3_data_ext_byte5_8; 
wire    [31:0] pfifo3_data_ext_byte6_8; 
wire    [31:0] pfifo3_data_ext_byte7_8; 
wire    [31:0] pfifo3_data_ext_byte8_8; 
wire    [31:0] pfifo3_data_ext_byte9_8; 
wire    [31:0] pfifo3_data_ext_byte10_8; 
wire    [31:0] pfifo3_data_ext_byte11_8; 
wire    [31:0] pfifo3_data_ext_byte12_8; 
wire    [31:0] pfifo3_data_ext_byte13_8; 
wire    [31:0] pfifo3_data_ext_byte14_8; 
wire    [31:0] pfifo3_data_ext_byte15_8; 
wire    [31:0] pfifo3_data_ext_byte16_8; 
wire    [31:0] pfifo3_data_ext_byte17_8; 
wire    [31:0] pfifo3_data_ext_byte18_8; 
wire    [31:0] pfifo3_data_ext_byte19_8; 
wire    [31:0] pfifo3_data_ext_byte20_8; 
wire    [31:0] pfifo3_data_ext_byte21_8; 
wire    [31:0] pfifo3_data_ext_byte22_8; 
wire    [31:0] pfifo3_data_ext_byte23_8; 
wire    [31:0] pfifo3_data_ext_byte24_8; 
wire    [31:0] pfifo3_data_ext_byte25_8; 
wire    [31:0] pfifo3_data_ext_byte26_8; 
wire    [31:0] pfifo3_data_ext_byte27_8; 
wire    [31:0] pfifo3_data_ext_byte28_8; 
wire    [31:0] pfifo3_data_ext_byte29_8; 
wire    [31:0] pfifo3_data_ext_byte30_8; 
wire    [31:0] pfifo3_data_ext_byte31_8; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [32*32 -1:0] pfifo_data0_16;
wire [32*32 -1:0] pfifo_data1_16;
wire [32*32 -1:0] pfifo_data2_16;
wire [32*32 -1:0] pfifo_data3_16;
wire [32*32 -1:0] pfifo_data0_8;
wire [32*32 -1:0] pfifo_data1_8;
wire [32*32 -1:0] pfifo_data2_8;
wire [32*32 -1:0] pfifo_data3_8;
reg [32*32 -1:0] pfifo_data_r;
wire [32*32 -1:0] pfifo_data;
wire pfifo_sel;
wire pfifo_vld;
wire sdp_mrdma2cmux_layer_end;
//==============
// CFG
//==============
assign cfg_di_int8 = reg2dp_in_precision == 0 ;
assign cfg_di_int16 = reg2dp_in_precision == 1 ;
assign cfg_di_fp16 = reg2dp_in_precision == 2 ;
assign cfg_di_16 = cfg_di_int16 | cfg_di_fp16;
assign cfg_do_int8 = reg2dp_proc_precision == 0 ;
assign cfg_mode_1x1_pack = (reg2dp_width==0) & (reg2dp_height==0);
assign cfg_perf_nan_inf_count_en = reg2dp_perf_nan_inf_count_en;
//pop command dat fifo //
assign cmd2dat_dma_prdy = dat_accept & is_last_beat & fifo_vld & dat_rdy;
assign cmd2dat_dma_size[13:0] = cmd2dat_dma_pd[13:0];
assign cmd2dat_dma_cube_end = cmd2dat_dma_pd[14];
assign size_of_beat = {14 {cmd2dat_dma_pvld}} & cmd2dat_dma_size;
assign cmd_cube_end = {1 {cmd2dat_dma_pvld}} & cmd2dat_dma_cube_end;
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
  if (!autosa_core_rstn) begin
    beat_cnt <= {14{1'b0}};
  end else begin
    if (dat_accept) begin
        if (is_last_beat) begin
            beat_cnt <= 0;
        end else begin
            beat_cnt <= beat_cnt + 1;
        end
    end
  end
end
assign is_last_beat = (beat_cnt==size_of_beat);
assign pfifo0_sel = beat_cnt[1:0]==0;
assign pfifo1_sel = beat_cnt[1:0]==1;
assign pfifo2_sel = beat_cnt[1:0]==2;
assign pfifo3_sel = beat_cnt[1:0]==3;
assign pfifo_vld = (pfifo3_rd_pvld & pfifo3_sel) | (pfifo2_rd_pvld & pfifo2_sel) | (pfifo1_rd_pvld & pfifo1_sel) | (pfifo0_rd_pvld & pfifo0_sel);
assign fifo_vld = pfifo_vld;
assign dat_vld = fifo_vld; //& cmd2dat_dma_pvld;
assign pfifo0_rd_prdy = dat_rdy & pfifo0_sel; //& cmd2dat_dma_pvld;
assign pfifo1_rd_prdy = dat_rdy & pfifo1_sel; //& cmd2dat_dma_pvld;
assign pfifo2_rd_prdy = dat_rdy & pfifo2_sel; //& cmd2dat_dma_pvld;
assign pfifo3_rd_prdy = dat_rdy & pfifo3_sel; //& cmd2dat_dma_pvld;
assign pfifo0_rd_data = {32*8{pfifo0_sel}} & pfifo0_rd_pd;
assign pfifo1_rd_data = {32*8{pfifo1_sel}} & pfifo1_rd_pd;
assign pfifo2_rd_data = {32*8{pfifo2_sel}} & pfifo2_rd_pd;
assign pfifo3_rd_data = {32*8{pfifo3_sel}} & pfifo3_rd_pd;
//: my $k = 32/2;
//: foreach my $j (0..3) {
//: foreach my $i (0..${k}-1) {
//: print "assign pfifo${j}_data_byte${i}_16 = pfifo${j}_rd_data[${i}*16+15:${i}*16]; \n";
//: }
//: print "\n";
//: }
//: print "\n";
//: my $k = 32/2;
//: foreach my $j (0..3) {
//: foreach my $i (0..${k}-1) {
//: print "assign pfifo${j}_data_ext_byte${i}_int16 = {{16{pfifo${j}_data_byte${i}_16[15]}}, pfifo${j}_data_byte${i}_16[15:0]}; \n";
//: }
//: print "\n";
//: }
//: print "\n";
//: my $k = 32/2;
//: foreach my $j (0..3) {
//: foreach my $i (0..${k}-1) {
//: print "assign pfifo${j}_data_ext_byte${i}_16 = pfifo${j}_data_ext_byte${i}_int16; \n";
//: }
//: }
//: print "\n";
//: my $k = 32/2;
//: my $remain = $k*32;
//: foreach my $j (0..3) {
//: print "assign pfifo_data${j}_16 = {${remain}\'h0,";
//: foreach my $i (0..${k}-2) {
//: my $ii = $k - $i -1;
//: print "pfifo${j}_data_ext_byte${ii}_16,";
//: }
//: print "pfifo${j}_data_ext_byte0_16}; \n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign pfifo0_data_byte0_16 = pfifo0_rd_data[0*16+15:0*16]; 
assign pfifo0_data_byte1_16 = pfifo0_rd_data[1*16+15:1*16]; 
assign pfifo0_data_byte2_16 = pfifo0_rd_data[2*16+15:2*16]; 
assign pfifo0_data_byte3_16 = pfifo0_rd_data[3*16+15:3*16]; 
assign pfifo0_data_byte4_16 = pfifo0_rd_data[4*16+15:4*16]; 
assign pfifo0_data_byte5_16 = pfifo0_rd_data[5*16+15:5*16]; 
assign pfifo0_data_byte6_16 = pfifo0_rd_data[6*16+15:6*16]; 
assign pfifo0_data_byte7_16 = pfifo0_rd_data[7*16+15:7*16]; 
assign pfifo0_data_byte8_16 = pfifo0_rd_data[8*16+15:8*16]; 
assign pfifo0_data_byte9_16 = pfifo0_rd_data[9*16+15:9*16]; 
assign pfifo0_data_byte10_16 = pfifo0_rd_data[10*16+15:10*16]; 
assign pfifo0_data_byte11_16 = pfifo0_rd_data[11*16+15:11*16]; 
assign pfifo0_data_byte12_16 = pfifo0_rd_data[12*16+15:12*16]; 
assign pfifo0_data_byte13_16 = pfifo0_rd_data[13*16+15:13*16]; 
assign pfifo0_data_byte14_16 = pfifo0_rd_data[14*16+15:14*16]; 
assign pfifo0_data_byte15_16 = pfifo0_rd_data[15*16+15:15*16]; 

assign pfifo1_data_byte0_16 = pfifo1_rd_data[0*16+15:0*16]; 
assign pfifo1_data_byte1_16 = pfifo1_rd_data[1*16+15:1*16]; 
assign pfifo1_data_byte2_16 = pfifo1_rd_data[2*16+15:2*16]; 
assign pfifo1_data_byte3_16 = pfifo1_rd_data[3*16+15:3*16]; 
assign pfifo1_data_byte4_16 = pfifo1_rd_data[4*16+15:4*16]; 
assign pfifo1_data_byte5_16 = pfifo1_rd_data[5*16+15:5*16]; 
assign pfifo1_data_byte6_16 = pfifo1_rd_data[6*16+15:6*16]; 
assign pfifo1_data_byte7_16 = pfifo1_rd_data[7*16+15:7*16]; 
assign pfifo1_data_byte8_16 = pfifo1_rd_data[8*16+15:8*16]; 
assign pfifo1_data_byte9_16 = pfifo1_rd_data[9*16+15:9*16]; 
assign pfifo1_data_byte10_16 = pfifo1_rd_data[10*16+15:10*16]; 
assign pfifo1_data_byte11_16 = pfifo1_rd_data[11*16+15:11*16]; 
assign pfifo1_data_byte12_16 = pfifo1_rd_data[12*16+15:12*16]; 
assign pfifo1_data_byte13_16 = pfifo1_rd_data[13*16+15:13*16]; 
assign pfifo1_data_byte14_16 = pfifo1_rd_data[14*16+15:14*16]; 
assign pfifo1_data_byte15_16 = pfifo1_rd_data[15*16+15:15*16]; 

assign pfifo2_data_byte0_16 = pfifo2_rd_data[0*16+15:0*16]; 
assign pfifo2_data_byte1_16 = pfifo2_rd_data[1*16+15:1*16]; 
assign pfifo2_data_byte2_16 = pfifo2_rd_data[2*16+15:2*16]; 
assign pfifo2_data_byte3_16 = pfifo2_rd_data[3*16+15:3*16]; 
assign pfifo2_data_byte4_16 = pfifo2_rd_data[4*16+15:4*16]; 
assign pfifo2_data_byte5_16 = pfifo2_rd_data[5*16+15:5*16]; 
assign pfifo2_data_byte6_16 = pfifo2_rd_data[6*16+15:6*16]; 
assign pfifo2_data_byte7_16 = pfifo2_rd_data[7*16+15:7*16]; 
assign pfifo2_data_byte8_16 = pfifo2_rd_data[8*16+15:8*16]; 
assign pfifo2_data_byte9_16 = pfifo2_rd_data[9*16+15:9*16]; 
assign pfifo2_data_byte10_16 = pfifo2_rd_data[10*16+15:10*16]; 
assign pfifo2_data_byte11_16 = pfifo2_rd_data[11*16+15:11*16]; 
assign pfifo2_data_byte12_16 = pfifo2_rd_data[12*16+15:12*16]; 
assign pfifo2_data_byte13_16 = pfifo2_rd_data[13*16+15:13*16]; 
assign pfifo2_data_byte14_16 = pfifo2_rd_data[14*16+15:14*16]; 
assign pfifo2_data_byte15_16 = pfifo2_rd_data[15*16+15:15*16]; 

assign pfifo3_data_byte0_16 = pfifo3_rd_data[0*16+15:0*16]; 
assign pfifo3_data_byte1_16 = pfifo3_rd_data[1*16+15:1*16]; 
assign pfifo3_data_byte2_16 = pfifo3_rd_data[2*16+15:2*16]; 
assign pfifo3_data_byte3_16 = pfifo3_rd_data[3*16+15:3*16]; 
assign pfifo3_data_byte4_16 = pfifo3_rd_data[4*16+15:4*16]; 
assign pfifo3_data_byte5_16 = pfifo3_rd_data[5*16+15:5*16]; 
assign pfifo3_data_byte6_16 = pfifo3_rd_data[6*16+15:6*16]; 
assign pfifo3_data_byte7_16 = pfifo3_rd_data[7*16+15:7*16]; 
assign pfifo3_data_byte8_16 = pfifo3_rd_data[8*16+15:8*16]; 
assign pfifo3_data_byte9_16 = pfifo3_rd_data[9*16+15:9*16]; 
assign pfifo3_data_byte10_16 = pfifo3_rd_data[10*16+15:10*16]; 
assign pfifo3_data_byte11_16 = pfifo3_rd_data[11*16+15:11*16]; 
assign pfifo3_data_byte12_16 = pfifo3_rd_data[12*16+15:12*16]; 
assign pfifo3_data_byte13_16 = pfifo3_rd_data[13*16+15:13*16]; 
assign pfifo3_data_byte14_16 = pfifo3_rd_data[14*16+15:14*16]; 
assign pfifo3_data_byte15_16 = pfifo3_rd_data[15*16+15:15*16]; 


assign pfifo0_data_ext_byte0_int16 = {{16{pfifo0_data_byte0_16[15]}}, pfifo0_data_byte0_16[15:0]}; 
assign pfifo0_data_ext_byte1_int16 = {{16{pfifo0_data_byte1_16[15]}}, pfifo0_data_byte1_16[15:0]}; 
assign pfifo0_data_ext_byte2_int16 = {{16{pfifo0_data_byte2_16[15]}}, pfifo0_data_byte2_16[15:0]}; 
assign pfifo0_data_ext_byte3_int16 = {{16{pfifo0_data_byte3_16[15]}}, pfifo0_data_byte3_16[15:0]}; 
assign pfifo0_data_ext_byte4_int16 = {{16{pfifo0_data_byte4_16[15]}}, pfifo0_data_byte4_16[15:0]}; 
assign pfifo0_data_ext_byte5_int16 = {{16{pfifo0_data_byte5_16[15]}}, pfifo0_data_byte5_16[15:0]}; 
assign pfifo0_data_ext_byte6_int16 = {{16{pfifo0_data_byte6_16[15]}}, pfifo0_data_byte6_16[15:0]}; 
assign pfifo0_data_ext_byte7_int16 = {{16{pfifo0_data_byte7_16[15]}}, pfifo0_data_byte7_16[15:0]}; 
assign pfifo0_data_ext_byte8_int16 = {{16{pfifo0_data_byte8_16[15]}}, pfifo0_data_byte8_16[15:0]}; 
assign pfifo0_data_ext_byte9_int16 = {{16{pfifo0_data_byte9_16[15]}}, pfifo0_data_byte9_16[15:0]}; 
assign pfifo0_data_ext_byte10_int16 = {{16{pfifo0_data_byte10_16[15]}}, pfifo0_data_byte10_16[15:0]}; 
assign pfifo0_data_ext_byte11_int16 = {{16{pfifo0_data_byte11_16[15]}}, pfifo0_data_byte11_16[15:0]}; 
assign pfifo0_data_ext_byte12_int16 = {{16{pfifo0_data_byte12_16[15]}}, pfifo0_data_byte12_16[15:0]}; 
assign pfifo0_data_ext_byte13_int16 = {{16{pfifo0_data_byte13_16[15]}}, pfifo0_data_byte13_16[15:0]}; 
assign pfifo0_data_ext_byte14_int16 = {{16{pfifo0_data_byte14_16[15]}}, pfifo0_data_byte14_16[15:0]}; 
assign pfifo0_data_ext_byte15_int16 = {{16{pfifo0_data_byte15_16[15]}}, pfifo0_data_byte15_16[15:0]}; 

assign pfifo1_data_ext_byte0_int16 = {{16{pfifo1_data_byte0_16[15]}}, pfifo1_data_byte0_16[15:0]}; 
assign pfifo1_data_ext_byte1_int16 = {{16{pfifo1_data_byte1_16[15]}}, pfifo1_data_byte1_16[15:0]}; 
assign pfifo1_data_ext_byte2_int16 = {{16{pfifo1_data_byte2_16[15]}}, pfifo1_data_byte2_16[15:0]}; 
assign pfifo1_data_ext_byte3_int16 = {{16{pfifo1_data_byte3_16[15]}}, pfifo1_data_byte3_16[15:0]}; 
assign pfifo1_data_ext_byte4_int16 = {{16{pfifo1_data_byte4_16[15]}}, pfifo1_data_byte4_16[15:0]}; 
assign pfifo1_data_ext_byte5_int16 = {{16{pfifo1_data_byte5_16[15]}}, pfifo1_data_byte5_16[15:0]}; 
assign pfifo1_data_ext_byte6_int16 = {{16{pfifo1_data_byte6_16[15]}}, pfifo1_data_byte6_16[15:0]}; 
assign pfifo1_data_ext_byte7_int16 = {{16{pfifo1_data_byte7_16[15]}}, pfifo1_data_byte7_16[15:0]}; 
assign pfifo1_data_ext_byte8_int16 = {{16{pfifo1_data_byte8_16[15]}}, pfifo1_data_byte8_16[15:0]}; 
assign pfifo1_data_ext_byte9_int16 = {{16{pfifo1_data_byte9_16[15]}}, pfifo1_data_byte9_16[15:0]}; 
assign pfifo1_data_ext_byte10_int16 = {{16{pfifo1_data_byte10_16[15]}}, pfifo1_data_byte10_16[15:0]}; 
assign pfifo1_data_ext_byte11_int16 = {{16{pfifo1_data_byte11_16[15]}}, pfifo1_data_byte11_16[15:0]}; 
assign pfifo1_data_ext_byte12_int16 = {{16{pfifo1_data_byte12_16[15]}}, pfifo1_data_byte12_16[15:0]}; 
assign pfifo1_data_ext_byte13_int16 = {{16{pfifo1_data_byte13_16[15]}}, pfifo1_data_byte13_16[15:0]}; 
assign pfifo1_data_ext_byte14_int16 = {{16{pfifo1_data_byte14_16[15]}}, pfifo1_data_byte14_16[15:0]}; 
assign pfifo1_data_ext_byte15_int16 = {{16{pfifo1_data_byte15_16[15]}}, pfifo1_data_byte15_16[15:0]}; 

assign pfifo2_data_ext_byte0_int16 = {{16{pfifo2_data_byte0_16[15]}}, pfifo2_data_byte0_16[15:0]}; 
assign pfifo2_data_ext_byte1_int16 = {{16{pfifo2_data_byte1_16[15]}}, pfifo2_data_byte1_16[15:0]}; 
assign pfifo2_data_ext_byte2_int16 = {{16{pfifo2_data_byte2_16[15]}}, pfifo2_data_byte2_16[15:0]}; 
assign pfifo2_data_ext_byte3_int16 = {{16{pfifo2_data_byte3_16[15]}}, pfifo2_data_byte3_16[15:0]}; 
assign pfifo2_data_ext_byte4_int16 = {{16{pfifo2_data_byte4_16[15]}}, pfifo2_data_byte4_16[15:0]}; 
assign pfifo2_data_ext_byte5_int16 = {{16{pfifo2_data_byte5_16[15]}}, pfifo2_data_byte5_16[15:0]}; 
assign pfifo2_data_ext_byte6_int16 = {{16{pfifo2_data_byte6_16[15]}}, pfifo2_data_byte6_16[15:0]}; 
assign pfifo2_data_ext_byte7_int16 = {{16{pfifo2_data_byte7_16[15]}}, pfifo2_data_byte7_16[15:0]}; 
assign pfifo2_data_ext_byte8_int16 = {{16{pfifo2_data_byte8_16[15]}}, pfifo2_data_byte8_16[15:0]}; 
assign pfifo2_data_ext_byte9_int16 = {{16{pfifo2_data_byte9_16[15]}}, pfifo2_data_byte9_16[15:0]}; 
assign pfifo2_data_ext_byte10_int16 = {{16{pfifo2_data_byte10_16[15]}}, pfifo2_data_byte10_16[15:0]}; 
assign pfifo2_data_ext_byte11_int16 = {{16{pfifo2_data_byte11_16[15]}}, pfifo2_data_byte11_16[15:0]}; 
assign pfifo2_data_ext_byte12_int16 = {{16{pfifo2_data_byte12_16[15]}}, pfifo2_data_byte12_16[15:0]}; 
assign pfifo2_data_ext_byte13_int16 = {{16{pfifo2_data_byte13_16[15]}}, pfifo2_data_byte13_16[15:0]}; 
assign pfifo2_data_ext_byte14_int16 = {{16{pfifo2_data_byte14_16[15]}}, pfifo2_data_byte14_16[15:0]}; 
assign pfifo2_data_ext_byte15_int16 = {{16{pfifo2_data_byte15_16[15]}}, pfifo2_data_byte15_16[15:0]}; 

assign pfifo3_data_ext_byte0_int16 = {{16{pfifo3_data_byte0_16[15]}}, pfifo3_data_byte0_16[15:0]}; 
assign pfifo3_data_ext_byte1_int16 = {{16{pfifo3_data_byte1_16[15]}}, pfifo3_data_byte1_16[15:0]}; 
assign pfifo3_data_ext_byte2_int16 = {{16{pfifo3_data_byte2_16[15]}}, pfifo3_data_byte2_16[15:0]}; 
assign pfifo3_data_ext_byte3_int16 = {{16{pfifo3_data_byte3_16[15]}}, pfifo3_data_byte3_16[15:0]}; 
assign pfifo3_data_ext_byte4_int16 = {{16{pfifo3_data_byte4_16[15]}}, pfifo3_data_byte4_16[15:0]}; 
assign pfifo3_data_ext_byte5_int16 = {{16{pfifo3_data_byte5_16[15]}}, pfifo3_data_byte5_16[15:0]}; 
assign pfifo3_data_ext_byte6_int16 = {{16{pfifo3_data_byte6_16[15]}}, pfifo3_data_byte6_16[15:0]}; 
assign pfifo3_data_ext_byte7_int16 = {{16{pfifo3_data_byte7_16[15]}}, pfifo3_data_byte7_16[15:0]}; 
assign pfifo3_data_ext_byte8_int16 = {{16{pfifo3_data_byte8_16[15]}}, pfifo3_data_byte8_16[15:0]}; 
assign pfifo3_data_ext_byte9_int16 = {{16{pfifo3_data_byte9_16[15]}}, pfifo3_data_byte9_16[15:0]}; 
assign pfifo3_data_ext_byte10_int16 = {{16{pfifo3_data_byte10_16[15]}}, pfifo3_data_byte10_16[15:0]}; 
assign pfifo3_data_ext_byte11_int16 = {{16{pfifo3_data_byte11_16[15]}}, pfifo3_data_byte11_16[15:0]}; 
assign pfifo3_data_ext_byte12_int16 = {{16{pfifo3_data_byte12_16[15]}}, pfifo3_data_byte12_16[15:0]}; 
assign pfifo3_data_ext_byte13_int16 = {{16{pfifo3_data_byte13_16[15]}}, pfifo3_data_byte13_16[15:0]}; 
assign pfifo3_data_ext_byte14_int16 = {{16{pfifo3_data_byte14_16[15]}}, pfifo3_data_byte14_16[15:0]}; 
assign pfifo3_data_ext_byte15_int16 = {{16{pfifo3_data_byte15_16[15]}}, pfifo3_data_byte15_16[15:0]}; 


assign pfifo0_data_ext_byte0_16 = pfifo0_data_ext_byte0_int16; 
assign pfifo0_data_ext_byte1_16 = pfifo0_data_ext_byte1_int16; 
assign pfifo0_data_ext_byte2_16 = pfifo0_data_ext_byte2_int16; 
assign pfifo0_data_ext_byte3_16 = pfifo0_data_ext_byte3_int16; 
assign pfifo0_data_ext_byte4_16 = pfifo0_data_ext_byte4_int16; 
assign pfifo0_data_ext_byte5_16 = pfifo0_data_ext_byte5_int16; 
assign pfifo0_data_ext_byte6_16 = pfifo0_data_ext_byte6_int16; 
assign pfifo0_data_ext_byte7_16 = pfifo0_data_ext_byte7_int16; 
assign pfifo0_data_ext_byte8_16 = pfifo0_data_ext_byte8_int16; 
assign pfifo0_data_ext_byte9_16 = pfifo0_data_ext_byte9_int16; 
assign pfifo0_data_ext_byte10_16 = pfifo0_data_ext_byte10_int16; 
assign pfifo0_data_ext_byte11_16 = pfifo0_data_ext_byte11_int16; 
assign pfifo0_data_ext_byte12_16 = pfifo0_data_ext_byte12_int16; 
assign pfifo0_data_ext_byte13_16 = pfifo0_data_ext_byte13_int16; 
assign pfifo0_data_ext_byte14_16 = pfifo0_data_ext_byte14_int16; 
assign pfifo0_data_ext_byte15_16 = pfifo0_data_ext_byte15_int16; 
assign pfifo1_data_ext_byte0_16 = pfifo1_data_ext_byte0_int16; 
assign pfifo1_data_ext_byte1_16 = pfifo1_data_ext_byte1_int16; 
assign pfifo1_data_ext_byte2_16 = pfifo1_data_ext_byte2_int16; 
assign pfifo1_data_ext_byte3_16 = pfifo1_data_ext_byte3_int16; 
assign pfifo1_data_ext_byte4_16 = pfifo1_data_ext_byte4_int16; 
assign pfifo1_data_ext_byte5_16 = pfifo1_data_ext_byte5_int16; 
assign pfifo1_data_ext_byte6_16 = pfifo1_data_ext_byte6_int16; 
assign pfifo1_data_ext_byte7_16 = pfifo1_data_ext_byte7_int16; 
assign pfifo1_data_ext_byte8_16 = pfifo1_data_ext_byte8_int16; 
assign pfifo1_data_ext_byte9_16 = pfifo1_data_ext_byte9_int16; 
assign pfifo1_data_ext_byte10_16 = pfifo1_data_ext_byte10_int16; 
assign pfifo1_data_ext_byte11_16 = pfifo1_data_ext_byte11_int16; 
assign pfifo1_data_ext_byte12_16 = pfifo1_data_ext_byte12_int16; 
assign pfifo1_data_ext_byte13_16 = pfifo1_data_ext_byte13_int16; 
assign pfifo1_data_ext_byte14_16 = pfifo1_data_ext_byte14_int16; 
assign pfifo1_data_ext_byte15_16 = pfifo1_data_ext_byte15_int16; 
assign pfifo2_data_ext_byte0_16 = pfifo2_data_ext_byte0_int16; 
assign pfifo2_data_ext_byte1_16 = pfifo2_data_ext_byte1_int16; 
assign pfifo2_data_ext_byte2_16 = pfifo2_data_ext_byte2_int16; 
assign pfifo2_data_ext_byte3_16 = pfifo2_data_ext_byte3_int16; 
assign pfifo2_data_ext_byte4_16 = pfifo2_data_ext_byte4_int16; 
assign pfifo2_data_ext_byte5_16 = pfifo2_data_ext_byte5_int16; 
assign pfifo2_data_ext_byte6_16 = pfifo2_data_ext_byte6_int16; 
assign pfifo2_data_ext_byte7_16 = pfifo2_data_ext_byte7_int16; 
assign pfifo2_data_ext_byte8_16 = pfifo2_data_ext_byte8_int16; 
assign pfifo2_data_ext_byte9_16 = pfifo2_data_ext_byte9_int16; 
assign pfifo2_data_ext_byte10_16 = pfifo2_data_ext_byte10_int16; 
assign pfifo2_data_ext_byte11_16 = pfifo2_data_ext_byte11_int16; 
assign pfifo2_data_ext_byte12_16 = pfifo2_data_ext_byte12_int16; 
assign pfifo2_data_ext_byte13_16 = pfifo2_data_ext_byte13_int16; 
assign pfifo2_data_ext_byte14_16 = pfifo2_data_ext_byte14_int16; 
assign pfifo2_data_ext_byte15_16 = pfifo2_data_ext_byte15_int16; 
assign pfifo3_data_ext_byte0_16 = pfifo3_data_ext_byte0_int16; 
assign pfifo3_data_ext_byte1_16 = pfifo3_data_ext_byte1_int16; 
assign pfifo3_data_ext_byte2_16 = pfifo3_data_ext_byte2_int16; 
assign pfifo3_data_ext_byte3_16 = pfifo3_data_ext_byte3_int16; 
assign pfifo3_data_ext_byte4_16 = pfifo3_data_ext_byte4_int16; 
assign pfifo3_data_ext_byte5_16 = pfifo3_data_ext_byte5_int16; 
assign pfifo3_data_ext_byte6_16 = pfifo3_data_ext_byte6_int16; 
assign pfifo3_data_ext_byte7_16 = pfifo3_data_ext_byte7_int16; 
assign pfifo3_data_ext_byte8_16 = pfifo3_data_ext_byte8_int16; 
assign pfifo3_data_ext_byte9_16 = pfifo3_data_ext_byte9_int16; 
assign pfifo3_data_ext_byte10_16 = pfifo3_data_ext_byte10_int16; 
assign pfifo3_data_ext_byte11_16 = pfifo3_data_ext_byte11_int16; 
assign pfifo3_data_ext_byte12_16 = pfifo3_data_ext_byte12_int16; 
assign pfifo3_data_ext_byte13_16 = pfifo3_data_ext_byte13_int16; 
assign pfifo3_data_ext_byte14_16 = pfifo3_data_ext_byte14_int16; 
assign pfifo3_data_ext_byte15_16 = pfifo3_data_ext_byte15_int16; 

assign pfifo_data0_16 = {512'h0,pfifo0_data_ext_byte15_16,pfifo0_data_ext_byte14_16,pfifo0_data_ext_byte13_16,pfifo0_data_ext_byte12_16,pfifo0_data_ext_byte11_16,pfifo0_data_ext_byte10_16,pfifo0_data_ext_byte9_16,pfifo0_data_ext_byte8_16,pfifo0_data_ext_byte7_16,pfifo0_data_ext_byte6_16,pfifo0_data_ext_byte5_16,pfifo0_data_ext_byte4_16,pfifo0_data_ext_byte3_16,pfifo0_data_ext_byte2_16,pfifo0_data_ext_byte1_16,pfifo0_data_ext_byte0_16}; 
assign pfifo_data1_16 = {512'h0,pfifo1_data_ext_byte15_16,pfifo1_data_ext_byte14_16,pfifo1_data_ext_byte13_16,pfifo1_data_ext_byte12_16,pfifo1_data_ext_byte11_16,pfifo1_data_ext_byte10_16,pfifo1_data_ext_byte9_16,pfifo1_data_ext_byte8_16,pfifo1_data_ext_byte7_16,pfifo1_data_ext_byte6_16,pfifo1_data_ext_byte5_16,pfifo1_data_ext_byte4_16,pfifo1_data_ext_byte3_16,pfifo1_data_ext_byte2_16,pfifo1_data_ext_byte1_16,pfifo1_data_ext_byte0_16}; 
assign pfifo_data2_16 = {512'h0,pfifo2_data_ext_byte15_16,pfifo2_data_ext_byte14_16,pfifo2_data_ext_byte13_16,pfifo2_data_ext_byte12_16,pfifo2_data_ext_byte11_16,pfifo2_data_ext_byte10_16,pfifo2_data_ext_byte9_16,pfifo2_data_ext_byte8_16,pfifo2_data_ext_byte7_16,pfifo2_data_ext_byte6_16,pfifo2_data_ext_byte5_16,pfifo2_data_ext_byte4_16,pfifo2_data_ext_byte3_16,pfifo2_data_ext_byte2_16,pfifo2_data_ext_byte1_16,pfifo2_data_ext_byte0_16}; 
assign pfifo_data3_16 = {512'h0,pfifo3_data_ext_byte15_16,pfifo3_data_ext_byte14_16,pfifo3_data_ext_byte13_16,pfifo3_data_ext_byte12_16,pfifo3_data_ext_byte11_16,pfifo3_data_ext_byte10_16,pfifo3_data_ext_byte9_16,pfifo3_data_ext_byte8_16,pfifo3_data_ext_byte7_16,pfifo3_data_ext_byte6_16,pfifo3_data_ext_byte5_16,pfifo3_data_ext_byte4_16,pfifo3_data_ext_byte3_16,pfifo3_data_ext_byte2_16,pfifo3_data_ext_byte1_16,pfifo3_data_ext_byte0_16}; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
//// int8 ///////////
//: my $k = 32;
//: foreach my $j (0..3) {
//: foreach my $i (0..${k}-1) {
//: print "assign pfifo${j}_data_byte${i}_8 = pfifo${j}_rd_data[${i}*8+7:${i}*8]; \n";
//: }
//: print "\n";
//: }
//: print "\n";
//: my $k = 32;
//: foreach my $j (0..3) {
//: foreach my $i (0..${k}-1) {
//: print "assign pfifo${j}_data_ext_byte${i}_8 = {{24{pfifo${j}_data_byte${i}_8[7]}}, pfifo${j}_data_byte${i}_8[7:0]}; \n";
//: }
//: print "\n";
//: }
//: print "\n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign pfifo0_data_byte0_8 = pfifo0_rd_data[0*8+7:0*8]; 
assign pfifo0_data_byte1_8 = pfifo0_rd_data[1*8+7:1*8]; 
assign pfifo0_data_byte2_8 = pfifo0_rd_data[2*8+7:2*8]; 
assign pfifo0_data_byte3_8 = pfifo0_rd_data[3*8+7:3*8]; 
assign pfifo0_data_byte4_8 = pfifo0_rd_data[4*8+7:4*8]; 
assign pfifo0_data_byte5_8 = pfifo0_rd_data[5*8+7:5*8]; 
assign pfifo0_data_byte6_8 = pfifo0_rd_data[6*8+7:6*8]; 
assign pfifo0_data_byte7_8 = pfifo0_rd_data[7*8+7:7*8]; 
assign pfifo0_data_byte8_8 = pfifo0_rd_data[8*8+7:8*8]; 
assign pfifo0_data_byte9_8 = pfifo0_rd_data[9*8+7:9*8]; 
assign pfifo0_data_byte10_8 = pfifo0_rd_data[10*8+7:10*8]; 
assign pfifo0_data_byte11_8 = pfifo0_rd_data[11*8+7:11*8]; 
assign pfifo0_data_byte12_8 = pfifo0_rd_data[12*8+7:12*8]; 
assign pfifo0_data_byte13_8 = pfifo0_rd_data[13*8+7:13*8]; 
assign pfifo0_data_byte14_8 = pfifo0_rd_data[14*8+7:14*8]; 
assign pfifo0_data_byte15_8 = pfifo0_rd_data[15*8+7:15*8]; 
assign pfifo0_data_byte16_8 = pfifo0_rd_data[16*8+7:16*8]; 
assign pfifo0_data_byte17_8 = pfifo0_rd_data[17*8+7:17*8]; 
assign pfifo0_data_byte18_8 = pfifo0_rd_data[18*8+7:18*8]; 
assign pfifo0_data_byte19_8 = pfifo0_rd_data[19*8+7:19*8]; 
assign pfifo0_data_byte20_8 = pfifo0_rd_data[20*8+7:20*8]; 
assign pfifo0_data_byte21_8 = pfifo0_rd_data[21*8+7:21*8]; 
assign pfifo0_data_byte22_8 = pfifo0_rd_data[22*8+7:22*8]; 
assign pfifo0_data_byte23_8 = pfifo0_rd_data[23*8+7:23*8]; 
assign pfifo0_data_byte24_8 = pfifo0_rd_data[24*8+7:24*8]; 
assign pfifo0_data_byte25_8 = pfifo0_rd_data[25*8+7:25*8]; 
assign pfifo0_data_byte26_8 = pfifo0_rd_data[26*8+7:26*8]; 
assign pfifo0_data_byte27_8 = pfifo0_rd_data[27*8+7:27*8]; 
assign pfifo0_data_byte28_8 = pfifo0_rd_data[28*8+7:28*8]; 
assign pfifo0_data_byte29_8 = pfifo0_rd_data[29*8+7:29*8]; 
assign pfifo0_data_byte30_8 = pfifo0_rd_data[30*8+7:30*8]; 
assign pfifo0_data_byte31_8 = pfifo0_rd_data[31*8+7:31*8]; 

assign pfifo1_data_byte0_8 = pfifo1_rd_data[0*8+7:0*8]; 
assign pfifo1_data_byte1_8 = pfifo1_rd_data[1*8+7:1*8]; 
assign pfifo1_data_byte2_8 = pfifo1_rd_data[2*8+7:2*8]; 
assign pfifo1_data_byte3_8 = pfifo1_rd_data[3*8+7:3*8]; 
assign pfifo1_data_byte4_8 = pfifo1_rd_data[4*8+7:4*8]; 
assign pfifo1_data_byte5_8 = pfifo1_rd_data[5*8+7:5*8]; 
assign pfifo1_data_byte6_8 = pfifo1_rd_data[6*8+7:6*8]; 
assign pfifo1_data_byte7_8 = pfifo1_rd_data[7*8+7:7*8]; 
assign pfifo1_data_byte8_8 = pfifo1_rd_data[8*8+7:8*8]; 
assign pfifo1_data_byte9_8 = pfifo1_rd_data[9*8+7:9*8]; 
assign pfifo1_data_byte10_8 = pfifo1_rd_data[10*8+7:10*8]; 
assign pfifo1_data_byte11_8 = pfifo1_rd_data[11*8+7:11*8]; 
assign pfifo1_data_byte12_8 = pfifo1_rd_data[12*8+7:12*8]; 
assign pfifo1_data_byte13_8 = pfifo1_rd_data[13*8+7:13*8]; 
assign pfifo1_data_byte14_8 = pfifo1_rd_data[14*8+7:14*8]; 
assign pfifo1_data_byte15_8 = pfifo1_rd_data[15*8+7:15*8]; 
assign pfifo1_data_byte16_8 = pfifo1_rd_data[16*8+7:16*8]; 
assign pfifo1_data_byte17_8 = pfifo1_rd_data[17*8+7:17*8]; 
assign pfifo1_data_byte18_8 = pfifo1_rd_data[18*8+7:18*8]; 
assign pfifo1_data_byte19_8 = pfifo1_rd_data[19*8+7:19*8]; 
assign pfifo1_data_byte20_8 = pfifo1_rd_data[20*8+7:20*8]; 
assign pfifo1_data_byte21_8 = pfifo1_rd_data[21*8+7:21*8]; 
assign pfifo1_data_byte22_8 = pfifo1_rd_data[22*8+7:22*8]; 
assign pfifo1_data_byte23_8 = pfifo1_rd_data[23*8+7:23*8]; 
assign pfifo1_data_byte24_8 = pfifo1_rd_data[24*8+7:24*8]; 
assign pfifo1_data_byte25_8 = pfifo1_rd_data[25*8+7:25*8]; 
assign pfifo1_data_byte26_8 = pfifo1_rd_data[26*8+7:26*8]; 
assign pfifo1_data_byte27_8 = pfifo1_rd_data[27*8+7:27*8]; 
assign pfifo1_data_byte28_8 = pfifo1_rd_data[28*8+7:28*8]; 
assign pfifo1_data_byte29_8 = pfifo1_rd_data[29*8+7:29*8]; 
assign pfifo1_data_byte30_8 = pfifo1_rd_data[30*8+7:30*8]; 
assign pfifo1_data_byte31_8 = pfifo1_rd_data[31*8+7:31*8]; 

assign pfifo2_data_byte0_8 = pfifo2_rd_data[0*8+7:0*8]; 
assign pfifo2_data_byte1_8 = pfifo2_rd_data[1*8+7:1*8]; 
assign pfifo2_data_byte2_8 = pfifo2_rd_data[2*8+7:2*8]; 
assign pfifo2_data_byte3_8 = pfifo2_rd_data[3*8+7:3*8]; 
assign pfifo2_data_byte4_8 = pfifo2_rd_data[4*8+7:4*8]; 
assign pfifo2_data_byte5_8 = pfifo2_rd_data[5*8+7:5*8]; 
assign pfifo2_data_byte6_8 = pfifo2_rd_data[6*8+7:6*8]; 
assign pfifo2_data_byte7_8 = pfifo2_rd_data[7*8+7:7*8]; 
assign pfifo2_data_byte8_8 = pfifo2_rd_data[8*8+7:8*8]; 
assign pfifo2_data_byte9_8 = pfifo2_rd_data[9*8+7:9*8]; 
assign pfifo2_data_byte10_8 = pfifo2_rd_data[10*8+7:10*8]; 
assign pfifo2_data_byte11_8 = pfifo2_rd_data[11*8+7:11*8]; 
assign pfifo2_data_byte12_8 = pfifo2_rd_data[12*8+7:12*8]; 
assign pfifo2_data_byte13_8 = pfifo2_rd_data[13*8+7:13*8]; 
assign pfifo2_data_byte14_8 = pfifo2_rd_data[14*8+7:14*8]; 
assign pfifo2_data_byte15_8 = pfifo2_rd_data[15*8+7:15*8]; 
assign pfifo2_data_byte16_8 = pfifo2_rd_data[16*8+7:16*8]; 
assign pfifo2_data_byte17_8 = pfifo2_rd_data[17*8+7:17*8]; 
assign pfifo2_data_byte18_8 = pfifo2_rd_data[18*8+7:18*8]; 
assign pfifo2_data_byte19_8 = pfifo2_rd_data[19*8+7:19*8]; 
assign pfifo2_data_byte20_8 = pfifo2_rd_data[20*8+7:20*8]; 
assign pfifo2_data_byte21_8 = pfifo2_rd_data[21*8+7:21*8]; 
assign pfifo2_data_byte22_8 = pfifo2_rd_data[22*8+7:22*8]; 
assign pfifo2_data_byte23_8 = pfifo2_rd_data[23*8+7:23*8]; 
assign pfifo2_data_byte24_8 = pfifo2_rd_data[24*8+7:24*8]; 
assign pfifo2_data_byte25_8 = pfifo2_rd_data[25*8+7:25*8]; 
assign pfifo2_data_byte26_8 = pfifo2_rd_data[26*8+7:26*8]; 
assign pfifo2_data_byte27_8 = pfifo2_rd_data[27*8+7:27*8]; 
assign pfifo2_data_byte28_8 = pfifo2_rd_data[28*8+7:28*8]; 
assign pfifo2_data_byte29_8 = pfifo2_rd_data[29*8+7:29*8]; 
assign pfifo2_data_byte30_8 = pfifo2_rd_data[30*8+7:30*8]; 
assign pfifo2_data_byte31_8 = pfifo2_rd_data[31*8+7:31*8]; 

assign pfifo3_data_byte0_8 = pfifo3_rd_data[0*8+7:0*8]; 
assign pfifo3_data_byte1_8 = pfifo3_rd_data[1*8+7:1*8]; 
assign pfifo3_data_byte2_8 = pfifo3_rd_data[2*8+7:2*8]; 
assign pfifo3_data_byte3_8 = pfifo3_rd_data[3*8+7:3*8]; 
assign pfifo3_data_byte4_8 = pfifo3_rd_data[4*8+7:4*8]; 
assign pfifo3_data_byte5_8 = pfifo3_rd_data[5*8+7:5*8]; 
assign pfifo3_data_byte6_8 = pfifo3_rd_data[6*8+7:6*8]; 
assign pfifo3_data_byte7_8 = pfifo3_rd_data[7*8+7:7*8]; 
assign pfifo3_data_byte8_8 = pfifo3_rd_data[8*8+7:8*8]; 
assign pfifo3_data_byte9_8 = pfifo3_rd_data[9*8+7:9*8]; 
assign pfifo3_data_byte10_8 = pfifo3_rd_data[10*8+7:10*8]; 
assign pfifo3_data_byte11_8 = pfifo3_rd_data[11*8+7:11*8]; 
assign pfifo3_data_byte12_8 = pfifo3_rd_data[12*8+7:12*8]; 
assign pfifo3_data_byte13_8 = pfifo3_rd_data[13*8+7:13*8]; 
assign pfifo3_data_byte14_8 = pfifo3_rd_data[14*8+7:14*8]; 
assign pfifo3_data_byte15_8 = pfifo3_rd_data[15*8+7:15*8]; 
assign pfifo3_data_byte16_8 = pfifo3_rd_data[16*8+7:16*8]; 
assign pfifo3_data_byte17_8 = pfifo3_rd_data[17*8+7:17*8]; 
assign pfifo3_data_byte18_8 = pfifo3_rd_data[18*8+7:18*8]; 
assign pfifo3_data_byte19_8 = pfifo3_rd_data[19*8+7:19*8]; 
assign pfifo3_data_byte20_8 = pfifo3_rd_data[20*8+7:20*8]; 
assign pfifo3_data_byte21_8 = pfifo3_rd_data[21*8+7:21*8]; 
assign pfifo3_data_byte22_8 = pfifo3_rd_data[22*8+7:22*8]; 
assign pfifo3_data_byte23_8 = pfifo3_rd_data[23*8+7:23*8]; 
assign pfifo3_data_byte24_8 = pfifo3_rd_data[24*8+7:24*8]; 
assign pfifo3_data_byte25_8 = pfifo3_rd_data[25*8+7:25*8]; 
assign pfifo3_data_byte26_8 = pfifo3_rd_data[26*8+7:26*8]; 
assign pfifo3_data_byte27_8 = pfifo3_rd_data[27*8+7:27*8]; 
assign pfifo3_data_byte28_8 = pfifo3_rd_data[28*8+7:28*8]; 
assign pfifo3_data_byte29_8 = pfifo3_rd_data[29*8+7:29*8]; 
assign pfifo3_data_byte30_8 = pfifo3_rd_data[30*8+7:30*8]; 
assign pfifo3_data_byte31_8 = pfifo3_rd_data[31*8+7:31*8]; 


assign pfifo0_data_ext_byte0_8 = {{24{pfifo0_data_byte0_8[7]}}, pfifo0_data_byte0_8[7:0]}; 
assign pfifo0_data_ext_byte1_8 = {{24{pfifo0_data_byte1_8[7]}}, pfifo0_data_byte1_8[7:0]}; 
assign pfifo0_data_ext_byte2_8 = {{24{pfifo0_data_byte2_8[7]}}, pfifo0_data_byte2_8[7:0]}; 
assign pfifo0_data_ext_byte3_8 = {{24{pfifo0_data_byte3_8[7]}}, pfifo0_data_byte3_8[7:0]}; 
assign pfifo0_data_ext_byte4_8 = {{24{pfifo0_data_byte4_8[7]}}, pfifo0_data_byte4_8[7:0]}; 
assign pfifo0_data_ext_byte5_8 = {{24{pfifo0_data_byte5_8[7]}}, pfifo0_data_byte5_8[7:0]}; 
assign pfifo0_data_ext_byte6_8 = {{24{pfifo0_data_byte6_8[7]}}, pfifo0_data_byte6_8[7:0]}; 
assign pfifo0_data_ext_byte7_8 = {{24{pfifo0_data_byte7_8[7]}}, pfifo0_data_byte7_8[7:0]}; 
assign pfifo0_data_ext_byte8_8 = {{24{pfifo0_data_byte8_8[7]}}, pfifo0_data_byte8_8[7:0]}; 
assign pfifo0_data_ext_byte9_8 = {{24{pfifo0_data_byte9_8[7]}}, pfifo0_data_byte9_8[7:0]}; 
assign pfifo0_data_ext_byte10_8 = {{24{pfifo0_data_byte10_8[7]}}, pfifo0_data_byte10_8[7:0]}; 
assign pfifo0_data_ext_byte11_8 = {{24{pfifo0_data_byte11_8[7]}}, pfifo0_data_byte11_8[7:0]}; 
assign pfifo0_data_ext_byte12_8 = {{24{pfifo0_data_byte12_8[7]}}, pfifo0_data_byte12_8[7:0]}; 
assign pfifo0_data_ext_byte13_8 = {{24{pfifo0_data_byte13_8[7]}}, pfifo0_data_byte13_8[7:0]}; 
assign pfifo0_data_ext_byte14_8 = {{24{pfifo0_data_byte14_8[7]}}, pfifo0_data_byte14_8[7:0]}; 
assign pfifo0_data_ext_byte15_8 = {{24{pfifo0_data_byte15_8[7]}}, pfifo0_data_byte15_8[7:0]}; 
assign pfifo0_data_ext_byte16_8 = {{24{pfifo0_data_byte16_8[7]}}, pfifo0_data_byte16_8[7:0]}; 
assign pfifo0_data_ext_byte17_8 = {{24{pfifo0_data_byte17_8[7]}}, pfifo0_data_byte17_8[7:0]}; 
assign pfifo0_data_ext_byte18_8 = {{24{pfifo0_data_byte18_8[7]}}, pfifo0_data_byte18_8[7:0]}; 
assign pfifo0_data_ext_byte19_8 = {{24{pfifo0_data_byte19_8[7]}}, pfifo0_data_byte19_8[7:0]}; 
assign pfifo0_data_ext_byte20_8 = {{24{pfifo0_data_byte20_8[7]}}, pfifo0_data_byte20_8[7:0]}; 
assign pfifo0_data_ext_byte21_8 = {{24{pfifo0_data_byte21_8[7]}}, pfifo0_data_byte21_8[7:0]}; 
assign pfifo0_data_ext_byte22_8 = {{24{pfifo0_data_byte22_8[7]}}, pfifo0_data_byte22_8[7:0]}; 
assign pfifo0_data_ext_byte23_8 = {{24{pfifo0_data_byte23_8[7]}}, pfifo0_data_byte23_8[7:0]}; 
assign pfifo0_data_ext_byte24_8 = {{24{pfifo0_data_byte24_8[7]}}, pfifo0_data_byte24_8[7:0]}; 
assign pfifo0_data_ext_byte25_8 = {{24{pfifo0_data_byte25_8[7]}}, pfifo0_data_byte25_8[7:0]}; 
assign pfifo0_data_ext_byte26_8 = {{24{pfifo0_data_byte26_8[7]}}, pfifo0_data_byte26_8[7:0]}; 
assign pfifo0_data_ext_byte27_8 = {{24{pfifo0_data_byte27_8[7]}}, pfifo0_data_byte27_8[7:0]}; 
assign pfifo0_data_ext_byte28_8 = {{24{pfifo0_data_byte28_8[7]}}, pfifo0_data_byte28_8[7:0]}; 
assign pfifo0_data_ext_byte29_8 = {{24{pfifo0_data_byte29_8[7]}}, pfifo0_data_byte29_8[7:0]}; 
assign pfifo0_data_ext_byte30_8 = {{24{pfifo0_data_byte30_8[7]}}, pfifo0_data_byte30_8[7:0]}; 
assign pfifo0_data_ext_byte31_8 = {{24{pfifo0_data_byte31_8[7]}}, pfifo0_data_byte31_8[7:0]}; 

assign pfifo1_data_ext_byte0_8 = {{24{pfifo1_data_byte0_8[7]}}, pfifo1_data_byte0_8[7:0]}; 
assign pfifo1_data_ext_byte1_8 = {{24{pfifo1_data_byte1_8[7]}}, pfifo1_data_byte1_8[7:0]}; 
assign pfifo1_data_ext_byte2_8 = {{24{pfifo1_data_byte2_8[7]}}, pfifo1_data_byte2_8[7:0]}; 
assign pfifo1_data_ext_byte3_8 = {{24{pfifo1_data_byte3_8[7]}}, pfifo1_data_byte3_8[7:0]}; 
assign pfifo1_data_ext_byte4_8 = {{24{pfifo1_data_byte4_8[7]}}, pfifo1_data_byte4_8[7:0]}; 
assign pfifo1_data_ext_byte5_8 = {{24{pfifo1_data_byte5_8[7]}}, pfifo1_data_byte5_8[7:0]}; 
assign pfifo1_data_ext_byte6_8 = {{24{pfifo1_data_byte6_8[7]}}, pfifo1_data_byte6_8[7:0]}; 
assign pfifo1_data_ext_byte7_8 = {{24{pfifo1_data_byte7_8[7]}}, pfifo1_data_byte7_8[7:0]}; 
assign pfifo1_data_ext_byte8_8 = {{24{pfifo1_data_byte8_8[7]}}, pfifo1_data_byte8_8[7:0]}; 
assign pfifo1_data_ext_byte9_8 = {{24{pfifo1_data_byte9_8[7]}}, pfifo1_data_byte9_8[7:0]}; 
assign pfifo1_data_ext_byte10_8 = {{24{pfifo1_data_byte10_8[7]}}, pfifo1_data_byte10_8[7:0]}; 
assign pfifo1_data_ext_byte11_8 = {{24{pfifo1_data_byte11_8[7]}}, pfifo1_data_byte11_8[7:0]}; 
assign pfifo1_data_ext_byte12_8 = {{24{pfifo1_data_byte12_8[7]}}, pfifo1_data_byte12_8[7:0]}; 
assign pfifo1_data_ext_byte13_8 = {{24{pfifo1_data_byte13_8[7]}}, pfifo1_data_byte13_8[7:0]}; 
assign pfifo1_data_ext_byte14_8 = {{24{pfifo1_data_byte14_8[7]}}, pfifo1_data_byte14_8[7:0]}; 
assign pfifo1_data_ext_byte15_8 = {{24{pfifo1_data_byte15_8[7]}}, pfifo1_data_byte15_8[7:0]}; 
assign pfifo1_data_ext_byte16_8 = {{24{pfifo1_data_byte16_8[7]}}, pfifo1_data_byte16_8[7:0]}; 
assign pfifo1_data_ext_byte17_8 = {{24{pfifo1_data_byte17_8[7]}}, pfifo1_data_byte17_8[7:0]}; 
assign pfifo1_data_ext_byte18_8 = {{24{pfifo1_data_byte18_8[7]}}, pfifo1_data_byte18_8[7:0]}; 
assign pfifo1_data_ext_byte19_8 = {{24{pfifo1_data_byte19_8[7]}}, pfifo1_data_byte19_8[7:0]}; 
assign pfifo1_data_ext_byte20_8 = {{24{pfifo1_data_byte20_8[7]}}, pfifo1_data_byte20_8[7:0]}; 
assign pfifo1_data_ext_byte21_8 = {{24{pfifo1_data_byte21_8[7]}}, pfifo1_data_byte21_8[7:0]}; 
assign pfifo1_data_ext_byte22_8 = {{24{pfifo1_data_byte22_8[7]}}, pfifo1_data_byte22_8[7:0]}; 
assign pfifo1_data_ext_byte23_8 = {{24{pfifo1_data_byte23_8[7]}}, pfifo1_data_byte23_8[7:0]}; 
assign pfifo1_data_ext_byte24_8 = {{24{pfifo1_data_byte24_8[7]}}, pfifo1_data_byte24_8[7:0]}; 
assign pfifo1_data_ext_byte25_8 = {{24{pfifo1_data_byte25_8[7]}}, pfifo1_data_byte25_8[7:0]}; 
assign pfifo1_data_ext_byte26_8 = {{24{pfifo1_data_byte26_8[7]}}, pfifo1_data_byte26_8[7:0]}; 
assign pfifo1_data_ext_byte27_8 = {{24{pfifo1_data_byte27_8[7]}}, pfifo1_data_byte27_8[7:0]}; 
assign pfifo1_data_ext_byte28_8 = {{24{pfifo1_data_byte28_8[7]}}, pfifo1_data_byte28_8[7:0]}; 
assign pfifo1_data_ext_byte29_8 = {{24{pfifo1_data_byte29_8[7]}}, pfifo1_data_byte29_8[7:0]}; 
assign pfifo1_data_ext_byte30_8 = {{24{pfifo1_data_byte30_8[7]}}, pfifo1_data_byte30_8[7:0]}; 
assign pfifo1_data_ext_byte31_8 = {{24{pfifo1_data_byte31_8[7]}}, pfifo1_data_byte31_8[7:0]}; 

assign pfifo2_data_ext_byte0_8 = {{24{pfifo2_data_byte0_8[7]}}, pfifo2_data_byte0_8[7:0]}; 
assign pfifo2_data_ext_byte1_8 = {{24{pfifo2_data_byte1_8[7]}}, pfifo2_data_byte1_8[7:0]}; 
assign pfifo2_data_ext_byte2_8 = {{24{pfifo2_data_byte2_8[7]}}, pfifo2_data_byte2_8[7:0]}; 
assign pfifo2_data_ext_byte3_8 = {{24{pfifo2_data_byte3_8[7]}}, pfifo2_data_byte3_8[7:0]}; 
assign pfifo2_data_ext_byte4_8 = {{24{pfifo2_data_byte4_8[7]}}, pfifo2_data_byte4_8[7:0]}; 
assign pfifo2_data_ext_byte5_8 = {{24{pfifo2_data_byte5_8[7]}}, pfifo2_data_byte5_8[7:0]}; 
assign pfifo2_data_ext_byte6_8 = {{24{pfifo2_data_byte6_8[7]}}, pfifo2_data_byte6_8[7:0]}; 
assign pfifo2_data_ext_byte7_8 = {{24{pfifo2_data_byte7_8[7]}}, pfifo2_data_byte7_8[7:0]}; 
assign pfifo2_data_ext_byte8_8 = {{24{pfifo2_data_byte8_8[7]}}, pfifo2_data_byte8_8[7:0]}; 
assign pfifo2_data_ext_byte9_8 = {{24{pfifo2_data_byte9_8[7]}}, pfifo2_data_byte9_8[7:0]}; 
assign pfifo2_data_ext_byte10_8 = {{24{pfifo2_data_byte10_8[7]}}, pfifo2_data_byte10_8[7:0]}; 
assign pfifo2_data_ext_byte11_8 = {{24{pfifo2_data_byte11_8[7]}}, pfifo2_data_byte11_8[7:0]}; 
assign pfifo2_data_ext_byte12_8 = {{24{pfifo2_data_byte12_8[7]}}, pfifo2_data_byte12_8[7:0]}; 
assign pfifo2_data_ext_byte13_8 = {{24{pfifo2_data_byte13_8[7]}}, pfifo2_data_byte13_8[7:0]}; 
assign pfifo2_data_ext_byte14_8 = {{24{pfifo2_data_byte14_8[7]}}, pfifo2_data_byte14_8[7:0]}; 
assign pfifo2_data_ext_byte15_8 = {{24{pfifo2_data_byte15_8[7]}}, pfifo2_data_byte15_8[7:0]}; 
assign pfifo2_data_ext_byte16_8 = {{24{pfifo2_data_byte16_8[7]}}, pfifo2_data_byte16_8[7:0]}; 
assign pfifo2_data_ext_byte17_8 = {{24{pfifo2_data_byte17_8[7]}}, pfifo2_data_byte17_8[7:0]}; 
assign pfifo2_data_ext_byte18_8 = {{24{pfifo2_data_byte18_8[7]}}, pfifo2_data_byte18_8[7:0]}; 
assign pfifo2_data_ext_byte19_8 = {{24{pfifo2_data_byte19_8[7]}}, pfifo2_data_byte19_8[7:0]}; 
assign pfifo2_data_ext_byte20_8 = {{24{pfifo2_data_byte20_8[7]}}, pfifo2_data_byte20_8[7:0]}; 
assign pfifo2_data_ext_byte21_8 = {{24{pfifo2_data_byte21_8[7]}}, pfifo2_data_byte21_8[7:0]}; 
assign pfifo2_data_ext_byte22_8 = {{24{pfifo2_data_byte22_8[7]}}, pfifo2_data_byte22_8[7:0]}; 
assign pfifo2_data_ext_byte23_8 = {{24{pfifo2_data_byte23_8[7]}}, pfifo2_data_byte23_8[7:0]}; 
assign pfifo2_data_ext_byte24_8 = {{24{pfifo2_data_byte24_8[7]}}, pfifo2_data_byte24_8[7:0]}; 
assign pfifo2_data_ext_byte25_8 = {{24{pfifo2_data_byte25_8[7]}}, pfifo2_data_byte25_8[7:0]}; 
assign pfifo2_data_ext_byte26_8 = {{24{pfifo2_data_byte26_8[7]}}, pfifo2_data_byte26_8[7:0]}; 
assign pfifo2_data_ext_byte27_8 = {{24{pfifo2_data_byte27_8[7]}}, pfifo2_data_byte27_8[7:0]}; 
assign pfifo2_data_ext_byte28_8 = {{24{pfifo2_data_byte28_8[7]}}, pfifo2_data_byte28_8[7:0]}; 
assign pfifo2_data_ext_byte29_8 = {{24{pfifo2_data_byte29_8[7]}}, pfifo2_data_byte29_8[7:0]}; 
assign pfifo2_data_ext_byte30_8 = {{24{pfifo2_data_byte30_8[7]}}, pfifo2_data_byte30_8[7:0]}; 
assign pfifo2_data_ext_byte31_8 = {{24{pfifo2_data_byte31_8[7]}}, pfifo2_data_byte31_8[7:0]}; 

assign pfifo3_data_ext_byte0_8 = {{24{pfifo3_data_byte0_8[7]}}, pfifo3_data_byte0_8[7:0]}; 
assign pfifo3_data_ext_byte1_8 = {{24{pfifo3_data_byte1_8[7]}}, pfifo3_data_byte1_8[7:0]}; 
assign pfifo3_data_ext_byte2_8 = {{24{pfifo3_data_byte2_8[7]}}, pfifo3_data_byte2_8[7:0]}; 
assign pfifo3_data_ext_byte3_8 = {{24{pfifo3_data_byte3_8[7]}}, pfifo3_data_byte3_8[7:0]}; 
assign pfifo3_data_ext_byte4_8 = {{24{pfifo3_data_byte4_8[7]}}, pfifo3_data_byte4_8[7:0]}; 
assign pfifo3_data_ext_byte5_8 = {{24{pfifo3_data_byte5_8[7]}}, pfifo3_data_byte5_8[7:0]}; 
assign pfifo3_data_ext_byte6_8 = {{24{pfifo3_data_byte6_8[7]}}, pfifo3_data_byte6_8[7:0]}; 
assign pfifo3_data_ext_byte7_8 = {{24{pfifo3_data_byte7_8[7]}}, pfifo3_data_byte7_8[7:0]}; 
assign pfifo3_data_ext_byte8_8 = {{24{pfifo3_data_byte8_8[7]}}, pfifo3_data_byte8_8[7:0]}; 
assign pfifo3_data_ext_byte9_8 = {{24{pfifo3_data_byte9_8[7]}}, pfifo3_data_byte9_8[7:0]}; 
assign pfifo3_data_ext_byte10_8 = {{24{pfifo3_data_byte10_8[7]}}, pfifo3_data_byte10_8[7:0]}; 
assign pfifo3_data_ext_byte11_8 = {{24{pfifo3_data_byte11_8[7]}}, pfifo3_data_byte11_8[7:0]}; 
assign pfifo3_data_ext_byte12_8 = {{24{pfifo3_data_byte12_8[7]}}, pfifo3_data_byte12_8[7:0]}; 
assign pfifo3_data_ext_byte13_8 = {{24{pfifo3_data_byte13_8[7]}}, pfifo3_data_byte13_8[7:0]}; 
assign pfifo3_data_ext_byte14_8 = {{24{pfifo3_data_byte14_8[7]}}, pfifo3_data_byte14_8[7:0]}; 
assign pfifo3_data_ext_byte15_8 = {{24{pfifo3_data_byte15_8[7]}}, pfifo3_data_byte15_8[7:0]}; 
assign pfifo3_data_ext_byte16_8 = {{24{pfifo3_data_byte16_8[7]}}, pfifo3_data_byte16_8[7:0]}; 
assign pfifo3_data_ext_byte17_8 = {{24{pfifo3_data_byte17_8[7]}}, pfifo3_data_byte17_8[7:0]}; 
assign pfifo3_data_ext_byte18_8 = {{24{pfifo3_data_byte18_8[7]}}, pfifo3_data_byte18_8[7:0]}; 
assign pfifo3_data_ext_byte19_8 = {{24{pfifo3_data_byte19_8[7]}}, pfifo3_data_byte19_8[7:0]}; 
assign pfifo3_data_ext_byte20_8 = {{24{pfifo3_data_byte20_8[7]}}, pfifo3_data_byte20_8[7:0]}; 
assign pfifo3_data_ext_byte21_8 = {{24{pfifo3_data_byte21_8[7]}}, pfifo3_data_byte21_8[7:0]}; 
assign pfifo3_data_ext_byte22_8 = {{24{pfifo3_data_byte22_8[7]}}, pfifo3_data_byte22_8[7:0]}; 
assign pfifo3_data_ext_byte23_8 = {{24{pfifo3_data_byte23_8[7]}}, pfifo3_data_byte23_8[7:0]}; 
assign pfifo3_data_ext_byte24_8 = {{24{pfifo3_data_byte24_8[7]}}, pfifo3_data_byte24_8[7:0]}; 
assign pfifo3_data_ext_byte25_8 = {{24{pfifo3_data_byte25_8[7]}}, pfifo3_data_byte25_8[7:0]}; 
assign pfifo3_data_ext_byte26_8 = {{24{pfifo3_data_byte26_8[7]}}, pfifo3_data_byte26_8[7:0]}; 
assign pfifo3_data_ext_byte27_8 = {{24{pfifo3_data_byte27_8[7]}}, pfifo3_data_byte27_8[7:0]}; 
assign pfifo3_data_ext_byte28_8 = {{24{pfifo3_data_byte28_8[7]}}, pfifo3_data_byte28_8[7:0]}; 
assign pfifo3_data_ext_byte29_8 = {{24{pfifo3_data_byte29_8[7]}}, pfifo3_data_byte29_8[7:0]}; 
assign pfifo3_data_ext_byte30_8 = {{24{pfifo3_data_byte30_8[7]}}, pfifo3_data_byte30_8[7:0]}; 
assign pfifo3_data_ext_byte31_8 = {{24{pfifo3_data_byte31_8[7]}}, pfifo3_data_byte31_8[7:0]}; 



//| eperl: generated_end (DO NOT EDIT ABOVE)
// INT8, concate
//: my $k = 32;
//: foreach my $j (0..3) {
//: print "assign pfifo_data${j}_8 = {";
//: foreach my $i (0..${k}-2) {
//: my $ii = $k - $i -1;
//: print "pfifo${j}_data_ext_byte${ii}_8,";
//: }
//: print "pfifo${j}_data_ext_byte0_8}; \n";
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)
assign pfifo_data0_8 = {pfifo0_data_ext_byte31_8,pfifo0_data_ext_byte30_8,pfifo0_data_ext_byte29_8,pfifo0_data_ext_byte28_8,pfifo0_data_ext_byte27_8,pfifo0_data_ext_byte26_8,pfifo0_data_ext_byte25_8,pfifo0_data_ext_byte24_8,pfifo0_data_ext_byte23_8,pfifo0_data_ext_byte22_8,pfifo0_data_ext_byte21_8,pfifo0_data_ext_byte20_8,pfifo0_data_ext_byte19_8,pfifo0_data_ext_byte18_8,pfifo0_data_ext_byte17_8,pfifo0_data_ext_byte16_8,pfifo0_data_ext_byte15_8,pfifo0_data_ext_byte14_8,pfifo0_data_ext_byte13_8,pfifo0_data_ext_byte12_8,pfifo0_data_ext_byte11_8,pfifo0_data_ext_byte10_8,pfifo0_data_ext_byte9_8,pfifo0_data_ext_byte8_8,pfifo0_data_ext_byte7_8,pfifo0_data_ext_byte6_8,pfifo0_data_ext_byte5_8,pfifo0_data_ext_byte4_8,pfifo0_data_ext_byte3_8,pfifo0_data_ext_byte2_8,pfifo0_data_ext_byte1_8,pfifo0_data_ext_byte0_8}; 
assign pfifo_data1_8 = {pfifo1_data_ext_byte31_8,pfifo1_data_ext_byte30_8,pfifo1_data_ext_byte29_8,pfifo1_data_ext_byte28_8,pfifo1_data_ext_byte27_8,pfifo1_data_ext_byte26_8,pfifo1_data_ext_byte25_8,pfifo1_data_ext_byte24_8,pfifo1_data_ext_byte23_8,pfifo1_data_ext_byte22_8,pfifo1_data_ext_byte21_8,pfifo1_data_ext_byte20_8,pfifo1_data_ext_byte19_8,pfifo1_data_ext_byte18_8,pfifo1_data_ext_byte17_8,pfifo1_data_ext_byte16_8,pfifo1_data_ext_byte15_8,pfifo1_data_ext_byte14_8,pfifo1_data_ext_byte13_8,pfifo1_data_ext_byte12_8,pfifo1_data_ext_byte11_8,pfifo1_data_ext_byte10_8,pfifo1_data_ext_byte9_8,pfifo1_data_ext_byte8_8,pfifo1_data_ext_byte7_8,pfifo1_data_ext_byte6_8,pfifo1_data_ext_byte5_8,pfifo1_data_ext_byte4_8,pfifo1_data_ext_byte3_8,pfifo1_data_ext_byte2_8,pfifo1_data_ext_byte1_8,pfifo1_data_ext_byte0_8}; 
assign pfifo_data2_8 = {pfifo2_data_ext_byte31_8,pfifo2_data_ext_byte30_8,pfifo2_data_ext_byte29_8,pfifo2_data_ext_byte28_8,pfifo2_data_ext_byte27_8,pfifo2_data_ext_byte26_8,pfifo2_data_ext_byte25_8,pfifo2_data_ext_byte24_8,pfifo2_data_ext_byte23_8,pfifo2_data_ext_byte22_8,pfifo2_data_ext_byte21_8,pfifo2_data_ext_byte20_8,pfifo2_data_ext_byte19_8,pfifo2_data_ext_byte18_8,pfifo2_data_ext_byte17_8,pfifo2_data_ext_byte16_8,pfifo2_data_ext_byte15_8,pfifo2_data_ext_byte14_8,pfifo2_data_ext_byte13_8,pfifo2_data_ext_byte12_8,pfifo2_data_ext_byte11_8,pfifo2_data_ext_byte10_8,pfifo2_data_ext_byte9_8,pfifo2_data_ext_byte8_8,pfifo2_data_ext_byte7_8,pfifo2_data_ext_byte6_8,pfifo2_data_ext_byte5_8,pfifo2_data_ext_byte4_8,pfifo2_data_ext_byte3_8,pfifo2_data_ext_byte2_8,pfifo2_data_ext_byte1_8,pfifo2_data_ext_byte0_8}; 
assign pfifo_data3_8 = {pfifo3_data_ext_byte31_8,pfifo3_data_ext_byte30_8,pfifo3_data_ext_byte29_8,pfifo3_data_ext_byte28_8,pfifo3_data_ext_byte27_8,pfifo3_data_ext_byte26_8,pfifo3_data_ext_byte25_8,pfifo3_data_ext_byte24_8,pfifo3_data_ext_byte23_8,pfifo3_data_ext_byte22_8,pfifo3_data_ext_byte21_8,pfifo3_data_ext_byte20_8,pfifo3_data_ext_byte19_8,pfifo3_data_ext_byte18_8,pfifo3_data_ext_byte17_8,pfifo3_data_ext_byte16_8,pfifo3_data_ext_byte15_8,pfifo3_data_ext_byte14_8,pfifo3_data_ext_byte13_8,pfifo3_data_ext_byte12_8,pfifo3_data_ext_byte11_8,pfifo3_data_ext_byte10_8,pfifo3_data_ext_byte9_8,pfifo3_data_ext_byte8_8,pfifo3_data_ext_byte7_8,pfifo3_data_ext_byte6_8,pfifo3_data_ext_byte5_8,pfifo3_data_ext_byte4_8,pfifo3_data_ext_byte3_8,pfifo3_data_ext_byte2_8,pfifo3_data_ext_byte1_8,pfifo3_data_ext_byte0_8}; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
//=====PERF COUNT BEG=============
assign dp2reg_status_inf_input_num = 32'h0;
assign dp2reg_status_nan_input_num = 32'h0;
//=====PERF COUNT END=============
always @(
  pfifo0_sel
  or pfifo1_sel
  or pfifo2_sel
  or pfifo3_sel
  or cfg_di_16
  or pfifo_data0_8
  or pfifo_data1_8
  or pfifo_data2_8
  or pfifo_data3_8
  or pfifo_data0_16
  or pfifo_data1_16
  or pfifo_data2_16
  or pfifo_data3_16
  ) begin
//spyglass disable_block W171 W226
    case (1'b1)
     pfifo0_sel: pfifo_data_r = cfg_di_16 ? pfifo_data0_16 : pfifo_data0_8;
     pfifo1_sel: pfifo_data_r = cfg_di_16 ? pfifo_data1_16 : pfifo_data1_8;
     pfifo2_sel: pfifo_data_r = cfg_di_16 ? pfifo_data2_16 : pfifo_data2_8;
     pfifo3_sel: pfifo_data_r = cfg_di_16 ? pfifo_data3_16 : pfifo_data3_8;
    default : begin
                pfifo_data_r[32*32 -1:0] = {(32*32){`x_or_0}};
              end
    endcase
//spyglass enable_block W171 W226
end
assign dat_data = pfifo_data_r;
assign dat_accept = dat_vld & dat_rdy;
assign dat_layer_end = cmd_cube_end & is_last_beat;
assign dat_batch_end = cmd_cube_end & is_last_beat;
assign dat_pd[32*32 -1:0] = dat_data[32*32 -1:0];
assign dat_pd[32*32] = dat_batch_end ;
assign dat_pd[32*32 +1] = dat_layer_end ;
SA_AUTOSA_SDP_MRDMA_EG_DOUT_pipe_p1 pipe_p1 (
   .autosa_core_clk (autosa_core_clk)
  ,.autosa_core_rstn (autosa_core_rstn)
  ,.dat_pd (dat_pd[32*32 +1:0])
  ,.dat_vld (dat_vld)
  ,.sdp_mrdma2cmux_ready (sdp_mrdma2cmux_ready)
  ,.dat_rdy (dat_rdy)
  ,.sdp_mrdma2cmux_pd (sdp_mrdma2cmux_pd[32*32 +1:0])
  ,.sdp_mrdma2cmux_valid (sdp_mrdma2cmux_valid)
  );
assign sdp_mrdma2cmux_layer_end = sdp_mrdma2cmux_pd[32*32 +1];
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
  if (!autosa_core_rstn) begin
    eg_done <= 1'b0;
  end else begin
  eg_done <= sdp_mrdma2cmux_layer_end & sdp_mrdma2cmux_valid & sdp_mrdma2cmux_ready;
  end
end
//Shift-left - unsigned shift argument one bit more
endmodule // SA_AUTOSA_SDP_MRDMA_EG_dout
// **************************************************************************************************************
// Generated by ::pipe -m -bc -is sdp_mrdma2cmux_pd (sdp_mrdma2cmux_valid, sdp_mrdma2cmux_ready) <= dat_pd[32*32 +1:0] (dat_vld,dat_rdy)
// **************************************************************************************************************
module SA_AUTOSA_SDP_MRDMA_EG_DOUT_pipe_p1 (
   autosa_core_clk
  ,autosa_core_rstn
  ,dat_pd
  ,dat_vld
  ,dat_rdy
  ,sdp_mrdma2cmux_pd
  ,sdp_mrdma2cmux_valid
  ,sdp_mrdma2cmux_ready
  );
input autosa_core_clk;
input autosa_core_rstn;
input [32*32 +1:0] dat_pd;
input dat_vld;
output dat_rdy;
output [32*32 +1:0] sdp_mrdma2cmux_pd;
output sdp_mrdma2cmux_valid;
input sdp_mrdma2cmux_ready;
//: my $dw = 32*32 +2;
//: &eperl::pipe("-is -wid $dw -do sdp_mrdma2cmux_pd -vo sdp_mrdma2cmux_valid -ri sdp_mrdma2cmux_ready -di dat_pd -vi dat_vld -ro dat_rdy");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg dat_rdy;
reg skid_flop_dat_rdy;
reg skid_flop_dat_vld;
reg [1026-1:0] skid_flop_dat_pd;
reg pipe_skid_dat_vld;
reg [1026-1:0] pipe_skid_dat_pd;
// Wire
wire skid_dat_vld;
wire [1026-1:0] skid_dat_pd;
wire skid_dat_rdy;
wire pipe_skid_dat_rdy;
wire sdp_mrdma2cmux_valid;
wire [1026-1:0] sdp_mrdma2cmux_pd;
// Code
// SKID READY
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
   if (!autosa_core_rstn) begin
       dat_rdy <= 1'b1;
       skid_flop_dat_rdy <= 1'b1;
   end else begin
       dat_rdy <= skid_dat_rdy;
       skid_flop_dat_rdy <= skid_dat_rdy;
   end
end

// SKID VALID
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        skid_flop_dat_vld <= 1'b0;
    end else begin
        if (skid_flop_dat_rdy) begin
            skid_flop_dat_vld <= dat_vld;
        end
   end
end
assign skid_dat_vld = (skid_flop_dat_rdy) ? dat_vld : skid_flop_dat_vld;

// SKID DATA
always @(posedge autosa_core_clk) begin
    if (skid_flop_dat_rdy & dat_vld) begin
        skid_flop_dat_pd[1026-1:0] <= dat_pd[1026-1:0];
    end
end
assign skid_dat_pd[1026-1:0] = (skid_flop_dat_rdy) ? dat_pd[1026-1:0] : skid_flop_dat_pd[1026-1:0];


// PIPE READY
assign skid_dat_rdy = pipe_skid_dat_rdy || !pipe_skid_dat_vld;

// PIPE VALID
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        pipe_skid_dat_vld <= 1'b0;
    end else begin
        if (skid_dat_rdy) begin
            pipe_skid_dat_vld <= skid_dat_vld;
        end
    end
end

// PIPE DATA
always @(posedge autosa_core_clk) begin
    if (skid_dat_rdy && skid_dat_vld) begin
        pipe_skid_dat_pd[1026-1:0] <= skid_dat_pd[1026-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_dat_rdy = sdp_mrdma2cmux_ready;
assign sdp_mrdma2cmux_valid = pipe_skid_dat_vld;
assign sdp_mrdma2cmux_pd = pipe_skid_dat_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule // SA_AUTOSA_SDP_MRDMA_EG_DOUT_pipe_p1