// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_CDP_dp.v
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
module SA_AUTOSA_CDP_dp (
   autosa_core_clk //|< i
  ,autosa_core_rstn //|< i
  ,cdp_dp2wdma_ready //|< i
  ,cdp_rdma2dp_pd //|< i
  ,cdp_rdma2dp_valid //|< i
  ,dp2reg_done //|< i
  ,autosa_core_clk_orig //|< i
  ,pwrbus_ram_pd //|< i
  ,reg2dp_datin_offset //|< i
  ,reg2dp_datin_scale //|< i
  ,reg2dp_datin_shifter //|< i
  ,reg2dp_datout_offset //|< i
  ,reg2dp_datout_scale //|< i
  ,reg2dp_datout_shifter //|< i
  ,reg2dp_lut_access_type //|< i
  ,reg2dp_lut_addr //|< i
  ,reg2dp_lut_data //|< i
  ,reg2dp_lut_data_trigger //|< i
  ,reg2dp_lut_hybrid_priority //|< i
  ,reg2dp_lut_le_end_high //|< i
  ,reg2dp_lut_le_end_low //|< i
  ,reg2dp_lut_le_function //|< i
  ,reg2dp_lut_le_index_offset //|< i
  ,reg2dp_lut_le_index_select //|< i
  ,reg2dp_lut_le_slope_oflow_scale //|< i
  ,reg2dp_lut_le_slope_oflow_shift //|< i
  ,reg2dp_lut_le_slope_uflow_scale //|< i
  ,reg2dp_lut_le_slope_uflow_shift //|< i
  ,reg2dp_lut_le_start_high //|< i
  ,reg2dp_lut_le_start_low //|< i
  ,reg2dp_lut_lo_end_high //|< i
  ,reg2dp_lut_lo_end_low //|< i
  ,reg2dp_lut_lo_index_select //|< i
  ,reg2dp_lut_lo_slope_oflow_scale //|< i
  ,reg2dp_lut_lo_slope_oflow_shift //|< i
  ,reg2dp_lut_lo_slope_uflow_scale //|< i
  ,reg2dp_lut_lo_slope_uflow_shift //|< i
  ,reg2dp_lut_lo_start_high //|< i
  ,reg2dp_lut_lo_start_low //|< i
  ,reg2dp_lut_oflow_priority //|< i
  ,reg2dp_lut_table_id //|< i
  ,reg2dp_lut_uflow_priority //|< i
  ,reg2dp_mul_bypass //|< i
  ,reg2dp_normalz_len //|< i
  ,reg2dp_sqsum_bypass //|< i
  ,cdp_dp2wdma_pd //|> o
  ,cdp_dp2wdma_valid //|> o
  ,cdp_rdma2dp_ready //|> o
  ,dp2reg_d0_out_saturation //|> o
  ,dp2reg_d0_perf_lut_hybrid //|> o
  ,dp2reg_d0_perf_lut_le_hit //|> o
  ,dp2reg_d0_perf_lut_lo_hit //|> o
  ,dp2reg_d0_perf_lut_oflow //|> o
  ,dp2reg_d0_perf_lut_uflow //|> o
  ,dp2reg_d1_out_saturation //|> o
  ,dp2reg_d1_perf_lut_hybrid //|> o
  ,dp2reg_d1_perf_lut_le_hit //|> o
  ,dp2reg_d1_perf_lut_lo_hit //|> o
  ,dp2reg_d1_perf_lut_oflow //|> o
  ,dp2reg_d1_perf_lut_uflow //|> o
  ,dp2reg_lut_data //|> o
  );
///////////////////////////////////////////////////////
///////////////////////////////////////////////////////
//&Clock autosa_core_clk;
//&Reset autosa_core_rstn;
input [31:0] pwrbus_ram_pd;
input dp2reg_done;
input [15:0] reg2dp_datin_offset;
input [15:0] reg2dp_datin_scale;
input [4:0] reg2dp_datin_shifter;
input [31:0] reg2dp_datout_offset;
input [15:0] reg2dp_datout_scale;
input [5:0] reg2dp_datout_shifter;
input reg2dp_lut_access_type;
input [9:0] reg2dp_lut_addr;
input [15:0] reg2dp_lut_data;
input reg2dp_lut_data_trigger;
input reg2dp_lut_hybrid_priority;
input [5:0] reg2dp_lut_le_end_high;
input [31:0] reg2dp_lut_le_end_low;
input reg2dp_lut_le_function;
input [7:0] reg2dp_lut_le_index_offset;
input [7:0] reg2dp_lut_le_index_select;
input [15:0] reg2dp_lut_le_slope_oflow_scale;
input [4:0] reg2dp_lut_le_slope_oflow_shift;
input [15:0] reg2dp_lut_le_slope_uflow_scale;
input [4:0] reg2dp_lut_le_slope_uflow_shift;
input [5:0] reg2dp_lut_le_start_high;
input [31:0] reg2dp_lut_le_start_low;
input [5:0] reg2dp_lut_lo_end_high;
input [31:0] reg2dp_lut_lo_end_low;
input [7:0] reg2dp_lut_lo_index_select;
input [15:0] reg2dp_lut_lo_slope_oflow_scale;
input [4:0] reg2dp_lut_lo_slope_oflow_shift;
input [15:0] reg2dp_lut_lo_slope_uflow_scale;
input [4:0] reg2dp_lut_lo_slope_uflow_shift;
input [5:0] reg2dp_lut_lo_start_high;
input [31:0] reg2dp_lut_lo_start_low;
input reg2dp_lut_oflow_priority;
input reg2dp_lut_table_id;
input reg2dp_lut_uflow_priority;
input reg2dp_mul_bypass;
input [1:0] reg2dp_normalz_len;
input reg2dp_sqsum_bypass;
output [31:0] dp2reg_d0_out_saturation;
output [31:0] dp2reg_d0_perf_lut_hybrid;
output [31:0] dp2reg_d0_perf_lut_le_hit;
output [31:0] dp2reg_d0_perf_lut_lo_hit;
output [31:0] dp2reg_d0_perf_lut_oflow;
output [31:0] dp2reg_d0_perf_lut_uflow;
output [31:0] dp2reg_d1_out_saturation;
output [31:0] dp2reg_d1_perf_lut_hybrid;
output [31:0] dp2reg_d1_perf_lut_le_hit;
output [31:0] dp2reg_d1_perf_lut_lo_hit;
output [31:0] dp2reg_d1_perf_lut_oflow;
output [31:0] dp2reg_d1_perf_lut_uflow;
output [15:0] dp2reg_lut_data;
//
// SA_AUTOSA_CDP_core_ports.v
//
input autosa_core_clk;
input autosa_core_rstn;
input cdp_rdma2dp_valid; /* data valid */
output cdp_rdma2dp_ready; /* data return handshake */
input [1*8 +24:0] cdp_rdma2dp_pd;
output cdp_dp2wdma_valid; /* data valid */
input cdp_dp2wdma_ready; /* data return handshake */
output [1*8 +16:0] cdp_dp2wdma_pd;
input autosa_core_clk_orig;
///////////////////////////////////////////////////////////////////
reg sqsum_bypass_en;
//: my $icvto = (8 +1);
//: my $k = 1;
//: print qq(
//: wire [${k}*${icvto}+16:0] bufin_pd;
//: wire [${k}*${icvto}+16:0] cvt2buf_pd;
//: wire [${k}*${icvto}+16:0] cvt2sync_pd;
//: wire [${k}*(${icvto}*2+3)-1:0] cvtin_out_int8_ext;
//: wire [${k}*(${icvto}*2+3)-1:0] lutctrl_in_pd;
//: wire [${k}*(${icvto}+16)-1:0] mul2ocvt_pd;
//: wire [${k}*(${icvto}*2+3)-1:0] sum2itp_pd;
//: wire [${k}*(${icvto}*2+3)-1:0] sum2sync_pd;
//: wire [${k}*(${icvto}*2+3)-1:0] sa_sync2itp_pd;
//: wire [${k}*${icvto}-1:0] sa_sync2mul_pd;
//: );
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [1*9+16:0] bufin_pd;
wire [1*9+16:0] cvt2buf_pd;
wire [1*9+16:0] cvt2sync_pd;
wire [1*(9*2+3)-1:0] cvtin_out_int8_ext;
wire [1*(9*2+3)-1:0] lutctrl_in_pd;
wire [1*(9+16)-1:0] mul2ocvt_pd;
wire [1*(9*2+3)-1:0] sum2itp_pd;
wire [1*(9*2+3)-1:0] sum2sync_pd;
wire [1*(9*2+3)-1:0] sa_sync2itp_pd;
wire [1*9-1:0] sa_sync2mul_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire bufin_prdy;
wire bufin_pvld;
wire cvt2buf_prdy;
wire cvt2buf_pvld;
wire cvt2sync_prdy;
wire cvt2sync_pvld;
//: my $k = 1;
//: my $icvto = (8 +1);
//: foreach my $m (0..$k-1) {
//: print qq(
//: wire [${icvto}-1:0] cvtin_out_int8_$m;
//: wire [9:0] dp2lut_X_entry_${m} ;
//: wire [17:0] dp2lut_Xinfo_${m} ;
//: wire [9:0] dp2lut_Y_entry_${m} ;
//: wire [17:0] dp2lut_Yinfo_${m} ;
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [9-1:0] cvtin_out_int8_0;
wire [9:0] dp2lut_X_entry_0 ;
wire [17:0] dp2lut_Xinfo_0 ;
wire [9:0] dp2lut_Y_entry_0 ;
wire [17:0] dp2lut_Yinfo_0 ;

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire dp2lut_prdy;
wire dp2lut_pvld;
//: my $k = 1;
//: foreach my $m (0..$k-1) {
//: print qq(
//: wire [16:0] intp2mul_pd_$m;
//: wire [31:0] lut2intp_X_data_${m}0;
//: wire [16:0] lut2intp_X_data_${m}0_17b;
//: wire [31:0] lut2intp_X_data_${m}1;
//: wire [19:0] lut2intp_X_info_${m};
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [16:0] intp2mul_pd_0;
wire [31:0] lut2intp_X_data_00;
wire [16:0] lut2intp_X_data_00_17b;
wire [31:0] lut2intp_X_data_01;
wire [19:0] lut2intp_X_info_0;

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire intp2mul_prdy;
wire intp2mul_pvld;
wire [1 -1:0] lut2intp_X_sel;
wire [1 -1:0] lut2intp_Y_sel;
wire lut2intp_prdy;
wire lut2intp_pvld;
wire lutctrl_in_pvld;
wire mul2ocvt_prdy;
wire mul2ocvt_pvld;
//: my $icvto = (8 +1);
//: my $tp = 1;
//: my $k = (${tp}+8)*${icvto}+17;
//: print "wire   [${k}-1:0] normalz_buf_data;  \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
wire   [98-1:0] normalz_buf_data;  

//| eperl: generated_end (DO NOT EDIT ABOVE)
wire normalz_buf_data_prdy;
wire normalz_buf_data_pvld;
wire sum2itp_prdy;
wire sum2itp_pvld;
wire sum2sync_prdy;
wire sum2sync_pvld;
wire sa_sync2itp_prdy;
wire sa_sync2itp_pvld;
wire sa_sync2mul_prdy;
wire sa_sync2mul_pvld;
wire [16:0] sa_sync2ocvt_pd;
wire sa_sync2ocvt_prdy;
wire sa_sync2ocvt_pvld;
///////////////////////////////////////////////////////
assign dp2reg_d0_out_saturation = 32'd0;//for spyglass
assign dp2reg_d1_out_saturation = 32'd0;//for spyglass
/////////////////////////////
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
  if (!autosa_core_rstn) begin
    sqsum_bypass_en <= 1'b0;
  end else begin
  sqsum_bypass_en <= reg2dp_sqsum_bypass == 1'h1;
  end
end
//===== convertor_in Instance========
assign cvt2buf_prdy = sqsum_bypass_en ? sum2itp_prdy : bufin_prdy;
SA_AUTOSA_CDP_DP_cvtin u_SA_AUTOSA_CDP_DP_cvtin (
   .autosa_core_clk (autosa_core_clk)
  ,.autosa_core_rstn (autosa_core_rstn)
  ,.cdp_rdma2dp_pd (cdp_rdma2dp_pd)
  ,.cdp_rdma2dp_valid (cdp_rdma2dp_valid)
  ,.cvt2buf_prdy (cvt2buf_prdy)
  ,.cvt2sync_prdy (cvt2sync_prdy)
  ,.reg2dp_datin_offset (reg2dp_datin_offset[15:0])
  ,.reg2dp_datin_scale (reg2dp_datin_scale[15:0])
  ,.reg2dp_datin_shifter (reg2dp_datin_shifter[4:0])
  ,.cdp_rdma2dp_ready (cdp_rdma2dp_ready)
  ,.cvt2buf_pd (cvt2buf_pd)
  ,.cvt2buf_pvld (cvt2buf_pvld)
  ,.cvt2sync_pd (cvt2sync_pd)
  ,.cvt2sync_pvld (cvt2sync_pvld)
  );
//===== sync fifo Instance========
SA_AUTOSA_CDP_DP_syncfifo u_SA_AUTOSA_CDP_DP_syncfifo (
   .autosa_core_clk (autosa_core_clk)
  ,.autosa_core_rstn (autosa_core_rstn)
  ,.cvt2sync_pd (cvt2sync_pd)
  ,.cvt2sync_pvld (cvt2sync_pvld)
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0])
  ,.sum2sync_pd (sum2sync_pd)
  ,.sum2sync_pvld (sum2sync_pvld)
  ,.sa_sync2itp_prdy (sa_sync2itp_prdy)
  ,.sa_sync2mul_prdy (sa_sync2mul_prdy)
  ,.sa_sync2ocvt_prdy (sa_sync2ocvt_prdy)
  ,.cvt2sync_prdy (cvt2sync_prdy)
  ,.sum2sync_prdy (sum2sync_prdy)
  ,.sa_sync2itp_pd (sa_sync2itp_pd)
  ,.sa_sync2itp_pvld (sa_sync2itp_pvld)
  ,.sa_sync2mul_pd (sa_sync2mul_pd)
  ,.sa_sync2mul_pvld (sa_sync2mul_pvld)
  ,.sa_sync2ocvt_pd (sa_sync2ocvt_pd[16:0])
  ,.sa_sync2ocvt_pvld (sa_sync2ocvt_pvld)
  );
//===== Buffer_in Instance========
assign bufin_pd = sqsum_bypass_en ? 0 : cvt2buf_pd;
assign bufin_pvld = sqsum_bypass_en ? 0 : cvt2buf_pvld;
//: if(1 >= 4) {
//: print qq(
//: SA_AUTOSA_CDP_DP_bufferin u_SA_AUTOSA_CDP_DP_bufferin (
//: .autosa_core_clk (autosa_core_clk)
//: ,.autosa_core_rstn (autosa_core_rstn)
//: ,.cdp_rdma2dp_pd (bufin_pd)
//: ,.cdp_rdma2dp_valid (bufin_pvld)
//: ,.normalz_buf_data_prdy (normalz_buf_data_prdy)
//: ,.cdp_rdma2dp_ready (bufin_prdy)
//: ,.normalz_buf_data (normalz_buf_data)
//: ,.normalz_buf_data_pvld (normalz_buf_data_pvld)
//: );
//: );
//: } elsif(1 < 4) {
//: print qq(
//: SA_AUTOSA_CDP_DP_bufferin_tp1 u_SA_AUTOSA_CDP_DP_bufferin (
//: .autosa_core_clk (autosa_core_clk)
//: ,.autosa_core_rstn (autosa_core_rstn)
//: ,.cdp_rdma2dp_pd (bufin_pd)
//: ,.cdp_rdma2dp_valid (bufin_pvld)
//: ,.normalz_buf_data_prdy (normalz_buf_data_prdy)
//: ,.cdp_rdma2dp_ready (bufin_prdy)
//: ,.normalz_buf_data (normalz_buf_data)
//: ,.normalz_buf_data_pvld (normalz_buf_data_pvld)
//: );
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

SA_AUTOSA_CDP_DP_bufferin_tp1 u_SA_AUTOSA_CDP_DP_bufferin (
.autosa_core_clk (autosa_core_clk)
,.autosa_core_rstn (autosa_core_rstn)
,.cdp_rdma2dp_pd (bufin_pd)
,.cdp_rdma2dp_valid (bufin_pvld)
,.normalz_buf_data_prdy (normalz_buf_data_prdy)
,.cdp_rdma2dp_ready (bufin_prdy)
,.normalz_buf_data (normalz_buf_data)
,.normalz_buf_data_pvld (normalz_buf_data_pvld)
);

//| eperl: generated_end (DO NOT EDIT ABOVE)
//===== sigma squre Instance========
SA_AUTOSA_CDP_DP_sum u_SA_AUTOSA_CDP_DP_sum (
   .autosa_core_clk (autosa_core_clk)
  ,.autosa_core_rstn (autosa_core_rstn)
  ,.normalz_buf_data (normalz_buf_data)
  ,.normalz_buf_data_pvld (normalz_buf_data_pvld)
  ,.reg2dp_normalz_len (reg2dp_normalz_len[1:0])
  ,.sum2itp_prdy (sum2itp_prdy)
  ,.normalz_buf_data_prdy (normalz_buf_data_prdy)
  ,.sum2itp_pd (sum2itp_pd)
  ,.sum2itp_pvld (sum2itp_pvld)
  );
//===== LUT controller Instance========
//: my $icvto = (8 +1);
//: my $k = 1;
//: foreach my $m (0..$k-1) {
//: print qq(
//: assign cvtin_out_int8_$m = cvt2buf_pd[${m}*${icvto}+${icvto}-1:${m}*${icvto}];
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign cvtin_out_int8_0 = cvt2buf_pd[0*9+9-1:0*9];

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign cvtin_out_int8_ext = {
//: my $k = 1;
//: my $icvto = (8 +1);
//: if($k > 1) {
//: foreach my $m (0..$k-2) {
//: my $ss = $k -$m -1;
//: print qq(
//: {{(${icvto}+3){cvtin_out_int8_${ss}[${icvto}-1]}}, cvtin_out_int8_${ss}},
//: );
//: }
//: }
//: print "{{(${icvto}+3){cvtin_out_int8_0[${icvto}-1]}}, cvtin_out_int8_0}};  \n";
//| eperl: generated_beg (DO NOT EDIT BELOW)
{{(9+3){cvtin_out_int8_0[9-1]}}, cvtin_out_int8_0}};  

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign lutctrl_in_pd = sqsum_bypass_en ? cvtin_out_int8_ext : sum2itp_pd;
assign lutctrl_in_pvld = sqsum_bypass_en ? cvt2buf_pvld : sum2itp_pvld;
SA_AUTOSA_CDP_DP_LUT_ctrl u_SA_AUTOSA_CDP_DP_LUT_ctrl (
   .autosa_core_clk (autosa_core_clk) //|< i
  ,.autosa_core_rstn (autosa_core_rstn) //|< i
  ,.dp2lut_prdy (dp2lut_prdy) //|< w
  ,.reg2dp_lut_le_function (reg2dp_lut_le_function) //|< i
  ,.reg2dp_lut_le_index_offset (reg2dp_lut_le_index_offset[7:0]) //|< i
  ,.reg2dp_lut_le_index_select (reg2dp_lut_le_index_select[7:0]) //|< i
  ,.reg2dp_lut_le_start_high (reg2dp_lut_le_start_high[5:0]) //|< i
  ,.reg2dp_lut_le_start_low (reg2dp_lut_le_start_low[31:0]) //|< i
  ,.reg2dp_lut_lo_index_select (reg2dp_lut_lo_index_select[7:0]) //|< i
  ,.reg2dp_lut_lo_start_high (reg2dp_lut_lo_start_high[5:0]) //|< i
  ,.reg2dp_lut_lo_start_low (reg2dp_lut_lo_start_low[31:0]) //|< i
  ,.reg2dp_sqsum_bypass (reg2dp_sqsum_bypass) //|< i
  ,.sum2itp_pd (lutctrl_in_pd) //|< w
  ,.sum2itp_pvld (lutctrl_in_pvld) //|< w
  ,.sum2sync_prdy (sum2sync_prdy) //|< w
//: my $k = 1;
//: foreach my $m (0..$k-1) {
//: print qq(
//: ,.dp2lut_X_entry_${m} (dp2lut_X_entry_${m} )
//: ,.dp2lut_Xinfo_${m} (dp2lut_Xinfo_${m} )
//: ,.dp2lut_Y_entry_${m} (dp2lut_Y_entry_${m} )
//: ,.dp2lut_Yinfo_${m} (dp2lut_Yinfo_${m} )
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.dp2lut_X_entry_0 (dp2lut_X_entry_0 )
,.dp2lut_Xinfo_0 (dp2lut_Xinfo_0 )
,.dp2lut_Y_entry_0 (dp2lut_Y_entry_0 )
,.dp2lut_Yinfo_0 (dp2lut_Yinfo_0 )

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.dp2lut_pvld (dp2lut_pvld) //|> w
  ,.sum2itp_prdy (sum2itp_prdy) //|> w
  ,.sum2sync_pd (sum2sync_pd) //|> w
  ,.sum2sync_pvld (sum2sync_pvld) //|> w
  );
//===== LUT Instance========
SA_AUTOSA_CDP_DP_lut u_SA_AUTOSA_CDP_DP_lut (
   .autosa_core_clk (autosa_core_clk) //|< i
  ,.autosa_core_clk_orig (autosa_core_clk_orig) //|< i
  ,.autosa_core_rstn (autosa_core_rstn) //|< i
//: my $k = 1;
//: foreach my $m (0..$k-1) {
//: print qq(
//: ,.dp2lut_X_entry_${m} (dp2lut_X_entry_${m} )
//: ,.dp2lut_Xinfo_${m} (dp2lut_Xinfo_${m} )
//: ,.dp2lut_Y_entry_${m} (dp2lut_Y_entry_${m} )
//: ,.dp2lut_Yinfo_${m} (dp2lut_Yinfo_${m} )
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.dp2lut_X_entry_0 (dp2lut_X_entry_0 )
,.dp2lut_Xinfo_0 (dp2lut_Xinfo_0 )
,.dp2lut_Y_entry_0 (dp2lut_Y_entry_0 )
,.dp2lut_Yinfo_0 (dp2lut_Yinfo_0 )

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.dp2lut_pvld (dp2lut_pvld) //|< w
  ,.lut2intp_prdy (lut2intp_prdy) //|< w
  ,.reg2dp_lut_access_type (reg2dp_lut_access_type) //|< i
  ,.reg2dp_lut_addr (reg2dp_lut_addr[9:0]) //|< i
  ,.reg2dp_lut_data (reg2dp_lut_data[15:0]) //|< i
  ,.reg2dp_lut_data_trigger (reg2dp_lut_data_trigger) //|< i
  ,.reg2dp_lut_hybrid_priority (reg2dp_lut_hybrid_priority) //|< i
  ,.reg2dp_lut_oflow_priority (reg2dp_lut_oflow_priority) //|< i
  ,.reg2dp_lut_table_id (reg2dp_lut_table_id) //|< i
  ,.reg2dp_lut_uflow_priority (reg2dp_lut_uflow_priority) //|< i
  ,.dp2lut_prdy (dp2lut_prdy) //|> w
  ,.dp2reg_lut_data (dp2reg_lut_data[15:0]) //|> o
//: my $k = 1;
//: foreach my $m (0..$k-1) {
//: print qq(
//: ,.lut2intp_X_data_${m}0 (lut2intp_X_data_${m}0 )
//: ,.lut2intp_X_data_${m}0_17b (lut2intp_X_data_${m}0_17b )
//: ,.lut2intp_X_data_${m}1 (lut2intp_X_data_${m}1 )
//: ,.lut2intp_X_info_${m} (lut2intp_X_info_${m} )
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.lut2intp_X_data_00 (lut2intp_X_data_00 )
,.lut2intp_X_data_00_17b (lut2intp_X_data_00_17b )
,.lut2intp_X_data_01 (lut2intp_X_data_01 )
,.lut2intp_X_info_0 (lut2intp_X_info_0 )

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.lut2intp_X_sel (lut2intp_X_sel) //|> w
  ,.lut2intp_Y_sel (lut2intp_Y_sel) //|> w
  ,.lut2intp_pvld (lut2intp_pvld) //|> w
  );
//===== interpolator Instance========
SA_AUTOSA_CDP_DP_intp u_SA_AUTOSA_CDP_DP_intp (
   .autosa_core_clk (autosa_core_clk) //|< i
  ,.autosa_core_rstn (autosa_core_rstn) //|< i
  ,.dp2reg_done (dp2reg_done) //|< i
  ,.intp2mul_prdy (intp2mul_prdy) //|< w
//: my $k = 1;
//: foreach my $m (0..$k-1) {
//: print qq(
//: ,.lut2intp_X_data_${m}0 (lut2intp_X_data_${m}0 )
//: ,.lut2intp_X_data_${m}0_17b (lut2intp_X_data_${m}0_17b )
//: ,.lut2intp_X_data_${m}1 (lut2intp_X_data_${m}1 )
//: ,.lut2intp_X_info_${m} (lut2intp_X_info_${m} )
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.lut2intp_X_data_00 (lut2intp_X_data_00 )
,.lut2intp_X_data_00_17b (lut2intp_X_data_00_17b )
,.lut2intp_X_data_01 (lut2intp_X_data_01 )
,.lut2intp_X_info_0 (lut2intp_X_info_0 )

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.lut2intp_X_sel (lut2intp_X_sel) //|< w
  ,.lut2intp_Y_sel (lut2intp_Y_sel) //|< w
  ,.lut2intp_pvld (lut2intp_pvld) //|< w
  ,.pwrbus_ram_pd (pwrbus_ram_pd[31:0]) //|< i
  ,.reg2dp_lut_le_end_high (reg2dp_lut_le_end_high[5:0]) //|< i
  ,.reg2dp_lut_le_end_low (reg2dp_lut_le_end_low[31:0]) //|< i
  ,.reg2dp_lut_le_function (reg2dp_lut_le_function) //|< i
  ,.reg2dp_lut_le_index_offset (reg2dp_lut_le_index_offset[7:0]) //|< i
  ,.reg2dp_lut_le_slope_oflow_scale (reg2dp_lut_le_slope_oflow_scale[15:0]) //|< i
  ,.reg2dp_lut_le_slope_oflow_shift (reg2dp_lut_le_slope_oflow_shift[4:0]) //|< i
  ,.reg2dp_lut_le_slope_uflow_scale (reg2dp_lut_le_slope_uflow_scale[15:0]) //|< i
  ,.reg2dp_lut_le_slope_uflow_shift (reg2dp_lut_le_slope_uflow_shift[4:0]) //|< i
  ,.reg2dp_lut_le_start_high (reg2dp_lut_le_start_high[5:0]) //|< i
  ,.reg2dp_lut_le_start_low (reg2dp_lut_le_start_low[31:0]) //|< i
  ,.reg2dp_lut_lo_end_high (reg2dp_lut_lo_end_high[5:0]) //|< i
  ,.reg2dp_lut_lo_end_low (reg2dp_lut_lo_end_low[31:0]) //|< i
  ,.reg2dp_lut_lo_slope_oflow_scale (reg2dp_lut_lo_slope_oflow_scale[15:0]) //|< i
  ,.reg2dp_lut_lo_slope_oflow_shift (reg2dp_lut_lo_slope_oflow_shift[4:0]) //|< i
  ,.reg2dp_lut_lo_slope_uflow_scale (reg2dp_lut_lo_slope_uflow_scale[15:0]) //|< i
  ,.reg2dp_lut_lo_slope_uflow_shift (reg2dp_lut_lo_slope_uflow_shift[4:0]) //|< i
  ,.reg2dp_lut_lo_start_high (reg2dp_lut_lo_start_high[5:0]) //|< i
  ,.reg2dp_lut_lo_start_low (reg2dp_lut_lo_start_low[31:0]) //|< i
  ,.reg2dp_sqsum_bypass (reg2dp_sqsum_bypass) //|< i
  ,.sa_sync2itp_pd (sa_sync2itp_pd ) //|< w
  ,.sa_sync2itp_pvld (sa_sync2itp_pvld) //|< w
  ,.dp2reg_d0_perf_lut_hybrid (dp2reg_d0_perf_lut_hybrid[31:0]) //|> o
  ,.dp2reg_d0_perf_lut_le_hit (dp2reg_d0_perf_lut_le_hit[31:0]) //|> o
  ,.dp2reg_d0_perf_lut_lo_hit (dp2reg_d0_perf_lut_lo_hit[31:0]) //|> o
  ,.dp2reg_d0_perf_lut_oflow (dp2reg_d0_perf_lut_oflow[31:0]) //|> o
  ,.dp2reg_d0_perf_lut_uflow (dp2reg_d0_perf_lut_uflow[31:0]) //|> o
  ,.dp2reg_d1_perf_lut_hybrid (dp2reg_d1_perf_lut_hybrid[31:0]) //|> o
  ,.dp2reg_d1_perf_lut_le_hit (dp2reg_d1_perf_lut_le_hit[31:0]) //|> o
  ,.dp2reg_d1_perf_lut_lo_hit (dp2reg_d1_perf_lut_lo_hit[31:0]) //|> o
  ,.dp2reg_d1_perf_lut_oflow (dp2reg_d1_perf_lut_oflow[31:0]) //|> o
  ,.dp2reg_d1_perf_lut_uflow (dp2reg_d1_perf_lut_uflow[31:0]) //|> o
//: my $k = 1;
//: foreach my $m (0..$k-1) {
//: print qq(
//: ,.intp2mul_pd_$m (intp2mul_pd_${m}[16:0]) //|> w
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.intp2mul_pd_0 (intp2mul_pd_0[16:0]) //|> w

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.intp2mul_pvld (intp2mul_pvld) //|> w
  ,.lut2intp_prdy (lut2intp_prdy) //|> w
  ,.sa_sync2itp_prdy (sa_sync2itp_prdy) //|> w
  );
//===== DP multiple Instance========
SA_AUTOSA_CDP_DP_mul u_SA_AUTOSA_CDP_DP_mul (
   .autosa_core_clk (autosa_core_clk) //|< i
  ,.autosa_core_rstn (autosa_core_rstn) //|< i
//: my $k = 1;
//: foreach my $m (0..$k-1) {
//: print qq(
//: ,.intp2mul_pd_$m (intp2mul_pd_${m}[16:0]) //|> w
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

,.intp2mul_pd_0 (intp2mul_pd_0[16:0]) //|> w

//| eperl: generated_end (DO NOT EDIT ABOVE)
  ,.intp2mul_pvld (intp2mul_pvld) //|< w
  ,.mul2ocvt_prdy (mul2ocvt_prdy) //|< w
  ,.reg2dp_mul_bypass (reg2dp_mul_bypass) //|< i
  ,.sa_sync2mul_pd (sa_sync2mul_pd) //|< w
  ,.sa_sync2mul_pvld (sa_sync2mul_pvld) //|< w
  ,.intp2mul_prdy (intp2mul_prdy) //|> w
  ,.mul2ocvt_pd (mul2ocvt_pd) //|> w
  ,.mul2ocvt_pvld (mul2ocvt_pvld) //|> w
  ,.sa_sync2mul_prdy (sa_sync2mul_prdy) //|> w
  );
//===== convertor_out Instance========
SA_AUTOSA_CDP_DP_cvtout u_SA_AUTOSA_CDP_DP_cvtout (
   .autosa_core_clk (autosa_core_clk) //|< i
  ,.autosa_core_rstn (autosa_core_rstn) //|< i
  ,.cvtout_prdy (cdp_dp2wdma_ready) //|< i
  ,.mul2ocvt_pd (mul2ocvt_pd) //|< w
  ,.mul2ocvt_pvld (mul2ocvt_pvld) //|< w
  ,.reg2dp_datout_offset (reg2dp_datout_offset[31:0]) //|< i
  ,.reg2dp_datout_scale (reg2dp_datout_scale[15:0]) //|< i
  ,.reg2dp_datout_shifter (reg2dp_datout_shifter[5:0]) //|< i
  ,.sa_sync2ocvt_pd (sa_sync2ocvt_pd[16:0]) //|< w
  ,.sa_sync2ocvt_pvld (sa_sync2ocvt_pvld) //|< w
  ,.cvtout_pd (cdp_dp2wdma_pd) //|> o
  ,.cvtout_pvld (cdp_dp2wdma_valid) //|> o
  ,.mul2ocvt_prdy (mul2ocvt_prdy) //|> w
  ,.sa_sync2ocvt_prdy (sa_sync2ocvt_prdy) //|> w
  );
////==============
////OBS signals
////==============
//assign obs_bus_cdp_rdma2dp_vld = cdp_rdma2dp_valid;
//assign obs_bus_cdp_rdma2dp_rdy = cdp_rdma2dp_ready;
//assign obs_bus_cdp_icvt_vld = cvt2buf_pvld;
//assign obs_bus_cdp_icvt_rdy = cvt2buf_prdy;
//assign obs_bus_cdp_buf_vld = normalz_buf_data_pvld;
//assign obs_bus_cdp_buf_rdy = normalz_buf_data_prdy;
//assign obs_bus_cdp_sum_vld = sum2itp_pvld;
//assign obs_bus_cdp_sum_rdy = sum2itp_prdy;
//assign obs_bus_cdp_lutctrl_vld = dp2lut_pvld;
//assign obs_bus_cdp_lutctrl_rdy = dp2lut_prdy;
//assign obs_bus_cdp_intp_vld = intp2mul_pvld;
//assign obs_bus_cdp_intp_rdy = intp2mul_prdy;
//assign obs_bus_cdp_ocvt_vld = cdp_dp2wdma_valid;
//assign obs_bus_cdp_ocvt_rdy = cdp_dp2wdma_ready;
endmodule // SA_AUTOSA_CDP_dp
