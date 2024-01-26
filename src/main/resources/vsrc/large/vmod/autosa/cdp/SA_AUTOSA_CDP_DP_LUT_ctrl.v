// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_CDP_DP_LUT_ctrl.v
// ================================================================
// AUTOSA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_CDP_define.h
///////////////////////////////////////////////////
//#ifdef AUTOSA_FEATURE_DATA_TYPE_INT8
//#if ( AUTOSA_CDP_THROUGHPUT  ==  8 )
//    #define LARGE_FIFO_RAM
//#endif
//#if ( AUTOSA_CDP_THROUGHPUT == 1 )
//    #define SMALL_FIFO_RAM
//#endif
//#endif
module SA_AUTOSA_CDP_DP_LUT_ctrl (
   autosa_core_clk //|< i
  ,autosa_core_rstn //|< i
  ,dp2lut_prdy //|< i
  ,reg2dp_lut_le_function //|< i
  ,reg2dp_lut_le_index_offset //|< i
  ,reg2dp_lut_le_index_select //|< i
  ,reg2dp_lut_le_start_high //|< i
  ,reg2dp_lut_le_start_low //|< i
  ,reg2dp_lut_lo_index_select //|< i
  ,reg2dp_lut_lo_start_high //|< i
  ,reg2dp_lut_lo_start_low //|< i
  ,reg2dp_sqsum_bypass //|< i
  ,sum2itp_pd //|< i
  ,sum2itp_pvld //|< i
  ,sum2sync_prdy //|< i
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: ,dp2lut_X_entry_${m}
//: ,dp2lut_Xinfo_${m}
//: ,dp2lut_Y_entry_${m}
//: ,dp2lut_Yinfo_${m}
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,dp2lut_X_entry_0
,dp2lut_Xinfo_0
,dp2lut_Y_entry_0
,dp2lut_Yinfo_0

,dp2lut_X_entry_1
,dp2lut_Xinfo_1
,dp2lut_Y_entry_1
,dp2lut_Yinfo_1

,dp2lut_X_entry_2
,dp2lut_Xinfo_2
,dp2lut_Y_entry_2
,dp2lut_Yinfo_2

,dp2lut_X_entry_3
,dp2lut_Xinfo_3
,dp2lut_Y_entry_3
,dp2lut_Yinfo_3

,dp2lut_X_entry_4
,dp2lut_Xinfo_4
,dp2lut_Y_entry_4
,dp2lut_Yinfo_4

,dp2lut_X_entry_5
,dp2lut_Xinfo_5
,dp2lut_Y_entry_5
,dp2lut_Yinfo_5

,dp2lut_X_entry_6
,dp2lut_Xinfo_6
,dp2lut_Y_entry_6
,dp2lut_Yinfo_6

,dp2lut_X_entry_7
,dp2lut_Xinfo_7
,dp2lut_Y_entry_7
,dp2lut_Yinfo_7

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,dp2lut_pvld //|> o
  ,sum2itp_prdy //|> o
  ,sum2sync_pd //|> o
  ,sum2sync_pvld //|> o
  );
////////////////////////////////////////////////////////////////////////////////////////
//parameter pINT8_BW = 9;//int8 bitwidth after icvt
//parameter pPP_BW = (pINT8_BW + pINT8_BW) -1 + 4;
////////////////////////////////////////////////////////////////////////////////////////
input autosa_core_clk;
input autosa_core_rstn;
input reg2dp_lut_le_function;
input [7:0] reg2dp_lut_le_index_offset;
input [7:0] reg2dp_lut_le_index_select;
input [5:0] reg2dp_lut_le_start_high;
input [31:0] reg2dp_lut_le_start_low;
input [7:0] reg2dp_lut_lo_index_select;
input [5:0] reg2dp_lut_lo_start_high;
input [31:0] reg2dp_lut_lo_start_low;
input reg2dp_sqsum_bypass;
//: my $tp=8;
//: my $icvto=(8 +1);
//: my $sqsumo = $icvto *2 -1+4; ##(${tp}*2) -1 is for x^2, +4 is after 9 lrn
//: print "input  [${tp}*${sqsumo}-1:0] sum2itp_pd;  \n";
//: print "output [${tp}*${sqsumo}-1:0] sum2sync_pd; \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
input  [8*21-1:0] sum2itp_pd;  
output [8*21-1:0] sum2sync_pd; 

//| eperl: generated_end (DO NOT EDIT ABOVE)
input sum2itp_pvld;
output sum2itp_prdy;
//: my $k = 8;
//: foreach my $m (0..$k-1) {
//: print qq(
//: output [9:0] dp2lut_X_entry_${m};
//: output [17:0] dp2lut_Xinfo_${m};
//: output [9:0] dp2lut_Y_entry_${m};
//: output [17:0] dp2lut_Yinfo_${m};
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

output [9:0] dp2lut_X_entry_0;
output [17:0] dp2lut_Xinfo_0;
output [9:0] dp2lut_Y_entry_0;
output [17:0] dp2lut_Yinfo_0;

output [9:0] dp2lut_X_entry_1;
output [17:0] dp2lut_Xinfo_1;
output [9:0] dp2lut_Y_entry_1;
output [17:0] dp2lut_Yinfo_1;

output [9:0] dp2lut_X_entry_2;
output [17:0] dp2lut_Xinfo_2;
output [9:0] dp2lut_Y_entry_2;
output [17:0] dp2lut_Yinfo_2;

output [9:0] dp2lut_X_entry_3;
output [17:0] dp2lut_Xinfo_3;
output [9:0] dp2lut_Y_entry_3;
output [17:0] dp2lut_Yinfo_3;

output [9:0] dp2lut_X_entry_4;
output [17:0] dp2lut_Xinfo_4;
output [9:0] dp2lut_Y_entry_4;
output [17:0] dp2lut_Yinfo_4;

output [9:0] dp2lut_X_entry_5;
output [17:0] dp2lut_Xinfo_5;
output [9:0] dp2lut_Y_entry_5;
output [17:0] dp2lut_Yinfo_5;

output [9:0] dp2lut_X_entry_6;
output [17:0] dp2lut_Xinfo_6;
output [9:0] dp2lut_Y_entry_6;
output [17:0] dp2lut_Yinfo_6;

output [9:0] dp2lut_X_entry_7;
output [17:0] dp2lut_Xinfo_7;
output [9:0] dp2lut_Y_entry_7;
output [17:0] dp2lut_Yinfo_7;

//| eperl: generated_end (DO NOT EDIT ABOVE)
output dp2lut_pvld;
input dp2lut_prdy;
output sum2sync_pvld;
input sum2sync_prdy;
////////////////////////////////////////////////////////////////////////////////////////
//: my $tp=8;
//: my $icvto=(8 +1);
//: my $sqsumo = $icvto *2 -1+4;
//: foreach my $m (0..${tp}-1) {
//: print qq(
//: wire [17:0] dp2lut_X_info_$m;
//: wire [9:0] dp2lut_X_pd_$m;
//: wire [17:0] dp2lut_Y_info_$m;
//: wire [9:0] dp2lut_Y_pd_$m;
//: wire [${sqsumo}-1:0] sum2itp_pd_$m;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [17:0] dp2lut_X_info_0;
wire [9:0] dp2lut_X_pd_0;
wire [17:0] dp2lut_Y_info_0;
wire [9:0] dp2lut_Y_pd_0;
wire [21-1:0] sum2itp_pd_0;

wire [17:0] dp2lut_X_info_1;
wire [9:0] dp2lut_X_pd_1;
wire [17:0] dp2lut_Y_info_1;
wire [9:0] dp2lut_Y_pd_1;
wire [21-1:0] sum2itp_pd_1;

wire [17:0] dp2lut_X_info_2;
wire [9:0] dp2lut_X_pd_2;
wire [17:0] dp2lut_Y_info_2;
wire [9:0] dp2lut_Y_pd_2;
wire [21-1:0] sum2itp_pd_2;

wire [17:0] dp2lut_X_info_3;
wire [9:0] dp2lut_X_pd_3;
wire [17:0] dp2lut_Y_info_3;
wire [9:0] dp2lut_Y_pd_3;
wire [21-1:0] sum2itp_pd_3;

wire [17:0] dp2lut_X_info_4;
wire [9:0] dp2lut_X_pd_4;
wire [17:0] dp2lut_Y_info_4;
wire [9:0] dp2lut_Y_pd_4;
wire [21-1:0] sum2itp_pd_4;

wire [17:0] dp2lut_X_info_5;
wire [9:0] dp2lut_X_pd_5;
wire [17:0] dp2lut_Y_info_5;
wire [9:0] dp2lut_Y_pd_5;
wire [21-1:0] sum2itp_pd_5;

wire [17:0] dp2lut_X_info_6;
wire [9:0] dp2lut_X_pd_6;
wire [17:0] dp2lut_Y_info_6;
wire [9:0] dp2lut_Y_pd_6;
wire [21-1:0] sum2itp_pd_6;

wire [17:0] dp2lut_X_info_7;
wire [9:0] dp2lut_X_pd_7;
wire [17:0] dp2lut_Y_info_7;
wire [9:0] dp2lut_Y_pd_7;
wire [21-1:0] sum2itp_pd_7;

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire [8 -1:0] dp2lut_rdy;
wire [8 -1:0] dp2lut_vld;
wire [8 -1:0] sum2itp_rdy;
wire [8 -1:0] sum2itp_vld;
////////////////////////////////////////////////////////////////////////////////////////
assign sum2itp_prdy = (&sum2itp_rdy) & sum2sync_prdy;
//////////////////////////////////////////////////////////////////////
//from intp_ctrl input port to sync fifo for interpolation
assign sum2sync_pvld = sum2itp_pvld & (&sum2itp_rdy);
assign sum2sync_pd = sum2itp_pd;
///////////////////////////////////////////
//: my $tp=8;
//: my $icvto=(8 +1);
//: my $sqsumo = $icvto *2 -1+4;
//: foreach my $m (0..${tp} -1) {
//: print qq(
//: assign sum2itp_vld[$m] = sum2itp_pvld & sum2sync_prdy
//: );
//: foreach my $j (0..${tp} -1) {
//: if(${j} != ${m}) {
//: print qq(
//: & sum2itp_rdy[$j]
//: );
//: }
//: }
//: print qq(
//: ;
//: );
//: print qq(
//: assign sum2itp_pd_${m} = sum2itp_pd[${sqsumo}*${m}+${sqsumo}-1:${sqsumo}*${m}];
//: SA_AUTOSA_CDP_DP_LUT_CTRL_unit u_LUT_CTRL_unit$m (
//: .autosa_core_clk (autosa_core_clk)
//: ,.autosa_core_rstn (autosa_core_rstn)
//: ,.sum2itp_pd (sum2itp_pd_${m})
//: ,.sum2itp_pvld (sum2itp_vld[${m}])
//: ,.sum2itp_prdy (sum2itp_rdy[${m}])
//: ,.reg2dp_lut_le_function (reg2dp_lut_le_function)
//: ,.reg2dp_lut_le_index_offset (reg2dp_lut_le_index_offset[7:0])
//: ,.reg2dp_lut_le_index_select (reg2dp_lut_le_index_select[7:0])
//: ,.reg2dp_lut_le_start_high (reg2dp_lut_le_start_high[5:0])
//: ,.reg2dp_lut_le_start_low (reg2dp_lut_le_start_low[31:0])
//: ,.reg2dp_lut_lo_index_select (reg2dp_lut_lo_index_select[7:0])
//: ,.reg2dp_lut_lo_start_high (reg2dp_lut_lo_start_high[5:0])
//: ,.reg2dp_lut_lo_start_low (reg2dp_lut_lo_start_low[31:0])
//: ,.reg2dp_sqsum_bypass (reg2dp_sqsum_bypass)
//: ,.dp2lut_X_info (dp2lut_X_info_${m})
//: ,.dp2lut_X_pd (dp2lut_X_pd_${m})
//: ,.dp2lut_Y_info (dp2lut_Y_info_${m})
//: ,.dp2lut_Y_pd (dp2lut_Y_pd_${m})
//: ,.dp2lut_pvld (dp2lut_vld[${m}])
//: ,.dp2lut_prdy (dp2lut_rdy[${m}])
//: );
//: );
//: }
//: my $k = 8;
//: foreach my $m (0..$k -1) {
//: print qq(
//: assign dp2lut_X_entry_$m = dp2lut_X_pd_$m;
//: assign dp2lut_Y_entry_$m = dp2lut_Y_pd_$m;
//: assign dp2lut_Xinfo_$m = dp2lut_X_info_$m;
//: assign dp2lut_Yinfo_$m = dp2lut_Y_info_$m;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign sum2itp_vld[0] = sum2itp_pvld & sum2sync_prdy

& sum2itp_rdy[1]

& sum2itp_rdy[2]

& sum2itp_rdy[3]

& sum2itp_rdy[4]

& sum2itp_rdy[5]

& sum2itp_rdy[6]

& sum2itp_rdy[7]

;

assign sum2itp_pd_0 = sum2itp_pd[21*0+21-1:21*0];
SA_AUTOSA_CDP_DP_LUT_CTRL_unit u_LUT_CTRL_unit0 (
.autosa_core_clk (autosa_core_clk)
,.autosa_core_rstn (autosa_core_rstn)
,.sum2itp_pd (sum2itp_pd_0)
,.sum2itp_pvld (sum2itp_vld[0])
,.sum2itp_prdy (sum2itp_rdy[0])
,.reg2dp_lut_le_function (reg2dp_lut_le_function)
,.reg2dp_lut_le_index_offset (reg2dp_lut_le_index_offset[7:0])
,.reg2dp_lut_le_index_select (reg2dp_lut_le_index_select[7:0])
,.reg2dp_lut_le_start_high (reg2dp_lut_le_start_high[5:0])
,.reg2dp_lut_le_start_low (reg2dp_lut_le_start_low[31:0])
,.reg2dp_lut_lo_index_select (reg2dp_lut_lo_index_select[7:0])
,.reg2dp_lut_lo_start_high (reg2dp_lut_lo_start_high[5:0])
,.reg2dp_lut_lo_start_low (reg2dp_lut_lo_start_low[31:0])
,.reg2dp_sqsum_bypass (reg2dp_sqsum_bypass)
,.dp2lut_X_info (dp2lut_X_info_0)
,.dp2lut_X_pd (dp2lut_X_pd_0)
,.dp2lut_Y_info (dp2lut_Y_info_0)
,.dp2lut_Y_pd (dp2lut_Y_pd_0)
,.dp2lut_pvld (dp2lut_vld[0])
,.dp2lut_prdy (dp2lut_rdy[0])
);

assign sum2itp_vld[1] = sum2itp_pvld & sum2sync_prdy

& sum2itp_rdy[0]

& sum2itp_rdy[2]

& sum2itp_rdy[3]

& sum2itp_rdy[4]

& sum2itp_rdy[5]

& sum2itp_rdy[6]

& sum2itp_rdy[7]

;

assign sum2itp_pd_1 = sum2itp_pd[21*1+21-1:21*1];
SA_AUTOSA_CDP_DP_LUT_CTRL_unit u_LUT_CTRL_unit1 (
.autosa_core_clk (autosa_core_clk)
,.autosa_core_rstn (autosa_core_rstn)
,.sum2itp_pd (sum2itp_pd_1)
,.sum2itp_pvld (sum2itp_vld[1])
,.sum2itp_prdy (sum2itp_rdy[1])
,.reg2dp_lut_le_function (reg2dp_lut_le_function)
,.reg2dp_lut_le_index_offset (reg2dp_lut_le_index_offset[7:0])
,.reg2dp_lut_le_index_select (reg2dp_lut_le_index_select[7:0])
,.reg2dp_lut_le_start_high (reg2dp_lut_le_start_high[5:0])
,.reg2dp_lut_le_start_low (reg2dp_lut_le_start_low[31:0])
,.reg2dp_lut_lo_index_select (reg2dp_lut_lo_index_select[7:0])
,.reg2dp_lut_lo_start_high (reg2dp_lut_lo_start_high[5:0])
,.reg2dp_lut_lo_start_low (reg2dp_lut_lo_start_low[31:0])
,.reg2dp_sqsum_bypass (reg2dp_sqsum_bypass)
,.dp2lut_X_info (dp2lut_X_info_1)
,.dp2lut_X_pd (dp2lut_X_pd_1)
,.dp2lut_Y_info (dp2lut_Y_info_1)
,.dp2lut_Y_pd (dp2lut_Y_pd_1)
,.dp2lut_pvld (dp2lut_vld[1])
,.dp2lut_prdy (dp2lut_rdy[1])
);

assign sum2itp_vld[2] = sum2itp_pvld & sum2sync_prdy

& sum2itp_rdy[0]

& sum2itp_rdy[1]

& sum2itp_rdy[3]

& sum2itp_rdy[4]

& sum2itp_rdy[5]

& sum2itp_rdy[6]

& sum2itp_rdy[7]

;

assign sum2itp_pd_2 = sum2itp_pd[21*2+21-1:21*2];
SA_AUTOSA_CDP_DP_LUT_CTRL_unit u_LUT_CTRL_unit2 (
.autosa_core_clk (autosa_core_clk)
,.autosa_core_rstn (autosa_core_rstn)
,.sum2itp_pd (sum2itp_pd_2)
,.sum2itp_pvld (sum2itp_vld[2])
,.sum2itp_prdy (sum2itp_rdy[2])
,.reg2dp_lut_le_function (reg2dp_lut_le_function)
,.reg2dp_lut_le_index_offset (reg2dp_lut_le_index_offset[7:0])
,.reg2dp_lut_le_index_select (reg2dp_lut_le_index_select[7:0])
,.reg2dp_lut_le_start_high (reg2dp_lut_le_start_high[5:0])
,.reg2dp_lut_le_start_low (reg2dp_lut_le_start_low[31:0])
,.reg2dp_lut_lo_index_select (reg2dp_lut_lo_index_select[7:0])
,.reg2dp_lut_lo_start_high (reg2dp_lut_lo_start_high[5:0])
,.reg2dp_lut_lo_start_low (reg2dp_lut_lo_start_low[31:0])
,.reg2dp_sqsum_bypass (reg2dp_sqsum_bypass)
,.dp2lut_X_info (dp2lut_X_info_2)
,.dp2lut_X_pd (dp2lut_X_pd_2)
,.dp2lut_Y_info (dp2lut_Y_info_2)
,.dp2lut_Y_pd (dp2lut_Y_pd_2)
,.dp2lut_pvld (dp2lut_vld[2])
,.dp2lut_prdy (dp2lut_rdy[2])
);

assign sum2itp_vld[3] = sum2itp_pvld & sum2sync_prdy

& sum2itp_rdy[0]

& sum2itp_rdy[1]

& sum2itp_rdy[2]

& sum2itp_rdy[4]

& sum2itp_rdy[5]

& sum2itp_rdy[6]

& sum2itp_rdy[7]

;

assign sum2itp_pd_3 = sum2itp_pd[21*3+21-1:21*3];
SA_AUTOSA_CDP_DP_LUT_CTRL_unit u_LUT_CTRL_unit3 (
.autosa_core_clk (autosa_core_clk)
,.autosa_core_rstn (autosa_core_rstn)
,.sum2itp_pd (sum2itp_pd_3)
,.sum2itp_pvld (sum2itp_vld[3])
,.sum2itp_prdy (sum2itp_rdy[3])
,.reg2dp_lut_le_function (reg2dp_lut_le_function)
,.reg2dp_lut_le_index_offset (reg2dp_lut_le_index_offset[7:0])
,.reg2dp_lut_le_index_select (reg2dp_lut_le_index_select[7:0])
,.reg2dp_lut_le_start_high (reg2dp_lut_le_start_high[5:0])
,.reg2dp_lut_le_start_low (reg2dp_lut_le_start_low[31:0])
,.reg2dp_lut_lo_index_select (reg2dp_lut_lo_index_select[7:0])
,.reg2dp_lut_lo_start_high (reg2dp_lut_lo_start_high[5:0])
,.reg2dp_lut_lo_start_low (reg2dp_lut_lo_start_low[31:0])
,.reg2dp_sqsum_bypass (reg2dp_sqsum_bypass)
,.dp2lut_X_info (dp2lut_X_info_3)
,.dp2lut_X_pd (dp2lut_X_pd_3)
,.dp2lut_Y_info (dp2lut_Y_info_3)
,.dp2lut_Y_pd (dp2lut_Y_pd_3)
,.dp2lut_pvld (dp2lut_vld[3])
,.dp2lut_prdy (dp2lut_rdy[3])
);

assign sum2itp_vld[4] = sum2itp_pvld & sum2sync_prdy

& sum2itp_rdy[0]

& sum2itp_rdy[1]

& sum2itp_rdy[2]

& sum2itp_rdy[3]

& sum2itp_rdy[5]

& sum2itp_rdy[6]

& sum2itp_rdy[7]

;

assign sum2itp_pd_4 = sum2itp_pd[21*4+21-1:21*4];
SA_AUTOSA_CDP_DP_LUT_CTRL_unit u_LUT_CTRL_unit4 (
.autosa_core_clk (autosa_core_clk)
,.autosa_core_rstn (autosa_core_rstn)
,.sum2itp_pd (sum2itp_pd_4)
,.sum2itp_pvld (sum2itp_vld[4])
,.sum2itp_prdy (sum2itp_rdy[4])
,.reg2dp_lut_le_function (reg2dp_lut_le_function)
,.reg2dp_lut_le_index_offset (reg2dp_lut_le_index_offset[7:0])
,.reg2dp_lut_le_index_select (reg2dp_lut_le_index_select[7:0])
,.reg2dp_lut_le_start_high (reg2dp_lut_le_start_high[5:0])
,.reg2dp_lut_le_start_low (reg2dp_lut_le_start_low[31:0])
,.reg2dp_lut_lo_index_select (reg2dp_lut_lo_index_select[7:0])
,.reg2dp_lut_lo_start_high (reg2dp_lut_lo_start_high[5:0])
,.reg2dp_lut_lo_start_low (reg2dp_lut_lo_start_low[31:0])
,.reg2dp_sqsum_bypass (reg2dp_sqsum_bypass)
,.dp2lut_X_info (dp2lut_X_info_4)
,.dp2lut_X_pd (dp2lut_X_pd_4)
,.dp2lut_Y_info (dp2lut_Y_info_4)
,.dp2lut_Y_pd (dp2lut_Y_pd_4)
,.dp2lut_pvld (dp2lut_vld[4])
,.dp2lut_prdy (dp2lut_rdy[4])
);

assign sum2itp_vld[5] = sum2itp_pvld & sum2sync_prdy

& sum2itp_rdy[0]

& sum2itp_rdy[1]

& sum2itp_rdy[2]

& sum2itp_rdy[3]

& sum2itp_rdy[4]

& sum2itp_rdy[6]

& sum2itp_rdy[7]

;

assign sum2itp_pd_5 = sum2itp_pd[21*5+21-1:21*5];
SA_AUTOSA_CDP_DP_LUT_CTRL_unit u_LUT_CTRL_unit5 (
.autosa_core_clk (autosa_core_clk)
,.autosa_core_rstn (autosa_core_rstn)
,.sum2itp_pd (sum2itp_pd_5)
,.sum2itp_pvld (sum2itp_vld[5])
,.sum2itp_prdy (sum2itp_rdy[5])
,.reg2dp_lut_le_function (reg2dp_lut_le_function)
,.reg2dp_lut_le_index_offset (reg2dp_lut_le_index_offset[7:0])
,.reg2dp_lut_le_index_select (reg2dp_lut_le_index_select[7:0])
,.reg2dp_lut_le_start_high (reg2dp_lut_le_start_high[5:0])
,.reg2dp_lut_le_start_low (reg2dp_lut_le_start_low[31:0])
,.reg2dp_lut_lo_index_select (reg2dp_lut_lo_index_select[7:0])
,.reg2dp_lut_lo_start_high (reg2dp_lut_lo_start_high[5:0])
,.reg2dp_lut_lo_start_low (reg2dp_lut_lo_start_low[31:0])
,.reg2dp_sqsum_bypass (reg2dp_sqsum_bypass)
,.dp2lut_X_info (dp2lut_X_info_5)
,.dp2lut_X_pd (dp2lut_X_pd_5)
,.dp2lut_Y_info (dp2lut_Y_info_5)
,.dp2lut_Y_pd (dp2lut_Y_pd_5)
,.dp2lut_pvld (dp2lut_vld[5])
,.dp2lut_prdy (dp2lut_rdy[5])
);

assign sum2itp_vld[6] = sum2itp_pvld & sum2sync_prdy

& sum2itp_rdy[0]

& sum2itp_rdy[1]

& sum2itp_rdy[2]

& sum2itp_rdy[3]

& sum2itp_rdy[4]

& sum2itp_rdy[5]

& sum2itp_rdy[7]

;

assign sum2itp_pd_6 = sum2itp_pd[21*6+21-1:21*6];
SA_AUTOSA_CDP_DP_LUT_CTRL_unit u_LUT_CTRL_unit6 (
.autosa_core_clk (autosa_core_clk)
,.autosa_core_rstn (autosa_core_rstn)
,.sum2itp_pd (sum2itp_pd_6)
,.sum2itp_pvld (sum2itp_vld[6])
,.sum2itp_prdy (sum2itp_rdy[6])
,.reg2dp_lut_le_function (reg2dp_lut_le_function)
,.reg2dp_lut_le_index_offset (reg2dp_lut_le_index_offset[7:0])
,.reg2dp_lut_le_index_select (reg2dp_lut_le_index_select[7:0])
,.reg2dp_lut_le_start_high (reg2dp_lut_le_start_high[5:0])
,.reg2dp_lut_le_start_low (reg2dp_lut_le_start_low[31:0])
,.reg2dp_lut_lo_index_select (reg2dp_lut_lo_index_select[7:0])
,.reg2dp_lut_lo_start_high (reg2dp_lut_lo_start_high[5:0])
,.reg2dp_lut_lo_start_low (reg2dp_lut_lo_start_low[31:0])
,.reg2dp_sqsum_bypass (reg2dp_sqsum_bypass)
,.dp2lut_X_info (dp2lut_X_info_6)
,.dp2lut_X_pd (dp2lut_X_pd_6)
,.dp2lut_Y_info (dp2lut_Y_info_6)
,.dp2lut_Y_pd (dp2lut_Y_pd_6)
,.dp2lut_pvld (dp2lut_vld[6])
,.dp2lut_prdy (dp2lut_rdy[6])
);

assign sum2itp_vld[7] = sum2itp_pvld & sum2sync_prdy

& sum2itp_rdy[0]

& sum2itp_rdy[1]

& sum2itp_rdy[2]

& sum2itp_rdy[3]

& sum2itp_rdy[4]

& sum2itp_rdy[5]

& sum2itp_rdy[6]

;

assign sum2itp_pd_7 = sum2itp_pd[21*7+21-1:21*7];
SA_AUTOSA_CDP_DP_LUT_CTRL_unit u_LUT_CTRL_unit7 (
.autosa_core_clk (autosa_core_clk)
,.autosa_core_rstn (autosa_core_rstn)
,.sum2itp_pd (sum2itp_pd_7)
,.sum2itp_pvld (sum2itp_vld[7])
,.sum2itp_prdy (sum2itp_rdy[7])
,.reg2dp_lut_le_function (reg2dp_lut_le_function)
,.reg2dp_lut_le_index_offset (reg2dp_lut_le_index_offset[7:0])
,.reg2dp_lut_le_index_select (reg2dp_lut_le_index_select[7:0])
,.reg2dp_lut_le_start_high (reg2dp_lut_le_start_high[5:0])
,.reg2dp_lut_le_start_low (reg2dp_lut_le_start_low[31:0])
,.reg2dp_lut_lo_index_select (reg2dp_lut_lo_index_select[7:0])
,.reg2dp_lut_lo_start_high (reg2dp_lut_lo_start_high[5:0])
,.reg2dp_lut_lo_start_low (reg2dp_lut_lo_start_low[31:0])
,.reg2dp_sqsum_bypass (reg2dp_sqsum_bypass)
,.dp2lut_X_info (dp2lut_X_info_7)
,.dp2lut_X_pd (dp2lut_X_pd_7)
,.dp2lut_Y_info (dp2lut_Y_info_7)
,.dp2lut_Y_pd (dp2lut_Y_pd_7)
,.dp2lut_pvld (dp2lut_vld[7])
,.dp2lut_prdy (dp2lut_rdy[7])
);

assign dp2lut_X_entry_0 = dp2lut_X_pd_0;
assign dp2lut_Y_entry_0 = dp2lut_Y_pd_0;
assign dp2lut_Xinfo_0 = dp2lut_X_info_0;
assign dp2lut_Yinfo_0 = dp2lut_Y_info_0;

assign dp2lut_X_entry_1 = dp2lut_X_pd_1;
assign dp2lut_Y_entry_1 = dp2lut_Y_pd_1;
assign dp2lut_Xinfo_1 = dp2lut_X_info_1;
assign dp2lut_Yinfo_1 = dp2lut_Y_info_1;

assign dp2lut_X_entry_2 = dp2lut_X_pd_2;
assign dp2lut_Y_entry_2 = dp2lut_Y_pd_2;
assign dp2lut_Xinfo_2 = dp2lut_X_info_2;
assign dp2lut_Yinfo_2 = dp2lut_Y_info_2;

assign dp2lut_X_entry_3 = dp2lut_X_pd_3;
assign dp2lut_Y_entry_3 = dp2lut_Y_pd_3;
assign dp2lut_Xinfo_3 = dp2lut_X_info_3;
assign dp2lut_Yinfo_3 = dp2lut_Y_info_3;

assign dp2lut_X_entry_4 = dp2lut_X_pd_4;
assign dp2lut_Y_entry_4 = dp2lut_Y_pd_4;
assign dp2lut_Xinfo_4 = dp2lut_X_info_4;
assign dp2lut_Yinfo_4 = dp2lut_Y_info_4;

assign dp2lut_X_entry_5 = dp2lut_X_pd_5;
assign dp2lut_Y_entry_5 = dp2lut_Y_pd_5;
assign dp2lut_Xinfo_5 = dp2lut_X_info_5;
assign dp2lut_Yinfo_5 = dp2lut_Y_info_5;

assign dp2lut_X_entry_6 = dp2lut_X_pd_6;
assign dp2lut_Y_entry_6 = dp2lut_Y_pd_6;
assign dp2lut_Xinfo_6 = dp2lut_X_info_6;
assign dp2lut_Yinfo_6 = dp2lut_Y_info_6;

assign dp2lut_X_entry_7 = dp2lut_X_pd_7;
assign dp2lut_Y_entry_7 = dp2lut_Y_pd_7;
assign dp2lut_Xinfo_7 = dp2lut_X_info_7;
assign dp2lut_Yinfo_7 = dp2lut_Y_info_7;

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign dp2lut_pvld = &dp2lut_vld;
//: my $k = 8;
//: foreach my $m (0..$k -1) {
//: print qq(
//: assign dp2lut_rdy[${m}] = dp2lut_prdy
//: );
//: foreach my $j (0..$k -1) {
//: if(${j} != ${m}) {
//: print qq(
//: & dp2lut_vld[$j]
//: );
//: }
//: }
//: print qq(
//: ;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign dp2lut_rdy[0] = dp2lut_prdy

& dp2lut_vld[1]

& dp2lut_vld[2]

& dp2lut_vld[3]

& dp2lut_vld[4]

& dp2lut_vld[5]

& dp2lut_vld[6]

& dp2lut_vld[7]

;

assign dp2lut_rdy[1] = dp2lut_prdy

& dp2lut_vld[0]

& dp2lut_vld[2]

& dp2lut_vld[3]

& dp2lut_vld[4]

& dp2lut_vld[5]

& dp2lut_vld[6]

& dp2lut_vld[7]

;

assign dp2lut_rdy[2] = dp2lut_prdy

& dp2lut_vld[0]

& dp2lut_vld[1]

& dp2lut_vld[3]

& dp2lut_vld[4]

& dp2lut_vld[5]

& dp2lut_vld[6]

& dp2lut_vld[7]

;

assign dp2lut_rdy[3] = dp2lut_prdy

& dp2lut_vld[0]

& dp2lut_vld[1]

& dp2lut_vld[2]

& dp2lut_vld[4]

& dp2lut_vld[5]

& dp2lut_vld[6]

& dp2lut_vld[7]

;

assign dp2lut_rdy[4] = dp2lut_prdy

& dp2lut_vld[0]

& dp2lut_vld[1]

& dp2lut_vld[2]

& dp2lut_vld[3]

& dp2lut_vld[5]

& dp2lut_vld[6]

& dp2lut_vld[7]

;

assign dp2lut_rdy[5] = dp2lut_prdy

& dp2lut_vld[0]

& dp2lut_vld[1]

& dp2lut_vld[2]

& dp2lut_vld[3]

& dp2lut_vld[4]

& dp2lut_vld[6]

& dp2lut_vld[7]

;

assign dp2lut_rdy[6] = dp2lut_prdy

& dp2lut_vld[0]

& dp2lut_vld[1]

& dp2lut_vld[2]

& dp2lut_vld[3]

& dp2lut_vld[4]

& dp2lut_vld[5]

& dp2lut_vld[7]

;

assign dp2lut_rdy[7] = dp2lut_prdy

& dp2lut_vld[0]

& dp2lut_vld[1]

& dp2lut_vld[2]

& dp2lut_vld[3]

& dp2lut_vld[4]

& dp2lut_vld[5]

& dp2lut_vld[6]

;

//| eperl: generated_end (DO NOT EDIT ABOVE)
///////////////////////////////////////////
endmodule // SA_AUTOSA_CDP_DP_LUT_ctrl
