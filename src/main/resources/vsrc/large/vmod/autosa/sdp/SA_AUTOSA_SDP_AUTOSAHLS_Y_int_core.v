// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_SDP_AUTOSAHLS_Y_int_core.v
// ================================================================
// AUTOSA Open Source Project
// 
// Copyright(c) 2016 - 2017 NVIDIA Corporation.  Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_SDP_define.h
module SA_AUTOSA_SDP_AUTOSAHLS_Y_int_core (
   cfg_alu_algo //|< i
  ,cfg_alu_bypass //|< i
  ,cfg_alu_op //|< i
  ,cfg_alu_src //|< i
  ,cfg_mul_bypass //|< i
  ,cfg_mul_op //|< i
  ,cfg_mul_prelu //|< i
  ,cfg_mul_src //|< i
  ,cfg_mul_truncate //|< i
  ,chn_alu_op //|< i
  ,chn_alu_op_pvld //|< i
  ,chn_data_in //|< i
  ,chn_in_pvld //|< i
  ,chn_mul_op //|< i
  ,chn_mul_op_pvld //|< i
  ,chn_out_prdy //|< i
  ,autosa_core_clk //|< i
  ,autosa_core_rstn //|< i
  ,chn_alu_op_prdy //|> o
  ,chn_data_out //|> o
  ,chn_in_prdy //|> o
  ,chn_mul_op_prdy //|> o
  ,chn_out_pvld //|> o
  );
input [1:0] cfg_alu_algo;
input cfg_alu_bypass;
input [31:0] cfg_alu_op;
input cfg_alu_src;
input cfg_mul_bypass;
input [31:0] cfg_mul_op;
input cfg_mul_prelu;
input cfg_mul_src;
input [9:0] cfg_mul_truncate;
input [32*4 -1:0] chn_alu_op;
input chn_alu_op_pvld;
input [32*4 -1:0] chn_data_in;
input chn_in_pvld;
input [32*4 -1:0] chn_mul_op;
input chn_mul_op_pvld;
input chn_out_prdy;
output chn_alu_op_prdy;
output [32*4 -1:0] chn_data_out;
output chn_in_prdy;
output chn_mul_op_prdy;
output chn_out_pvld;
input autosa_core_clk;
input autosa_core_rstn;
//: my $k=4;
//: foreach my $i (0..${k}-1) {
//: print qq(
//: wire [31:0] chn_alu_op_${i};
//: wire chn_alu_op_prdy_${i};
//: wire [31:0] chn_data_in_${i};
//: wire [31:0] chn_data_out_${i};
//: wire chn_in_prdy_${i};
//: wire [31:0] chn_mul_op_${i};
//: wire chn_mul_op_prdy_${i};
//: wire chn_out_pvld_${i};
//: wire [31:0] mul_data_out_${i};
//: wire mul_out_prdy_${i};
//: wire mul_out_pvld_${i};
//:
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

wire [31:0] chn_alu_op_0;
wire chn_alu_op_prdy_0;
wire [31:0] chn_data_in_0;
wire [31:0] chn_data_out_0;
wire chn_in_prdy_0;
wire [31:0] chn_mul_op_0;
wire chn_mul_op_prdy_0;
wire chn_out_pvld_0;
wire [31:0] mul_data_out_0;
wire mul_out_prdy_0;
wire mul_out_pvld_0;


wire [31:0] chn_alu_op_1;
wire chn_alu_op_prdy_1;
wire [31:0] chn_data_in_1;
wire [31:0] chn_data_out_1;
wire chn_in_prdy_1;
wire [31:0] chn_mul_op_1;
wire chn_mul_op_prdy_1;
wire chn_out_pvld_1;
wire [31:0] mul_data_out_1;
wire mul_out_prdy_1;
wire mul_out_pvld_1;


wire [31:0] chn_alu_op_2;
wire chn_alu_op_prdy_2;
wire [31:0] chn_data_in_2;
wire [31:0] chn_data_out_2;
wire chn_in_prdy_2;
wire [31:0] chn_mul_op_2;
wire chn_mul_op_prdy_2;
wire chn_out_pvld_2;
wire [31:0] mul_data_out_2;
wire mul_out_prdy_2;
wire mul_out_pvld_2;


wire [31:0] chn_alu_op_3;
wire chn_alu_op_prdy_3;
wire [31:0] chn_data_in_3;
wire [31:0] chn_data_out_3;
wire chn_in_prdy_3;
wire [31:0] chn_mul_op_3;
wire chn_mul_op_prdy_3;
wire chn_out_pvld_3;
wire [31:0] mul_data_out_3;
wire mul_out_prdy_3;
wire mul_out_pvld_3;


//| eperl: generated_end (DO NOT EDIT ABOVE)
assign chn_in_prdy = chn_in_prdy_0;
assign chn_alu_op_prdy = chn_alu_op_prdy_0;
assign chn_mul_op_prdy = chn_mul_op_prdy_0;
assign chn_out_pvld = chn_out_pvld_0;
//: my $k=4;
//: foreach my $i (0..${k}-1) {
//: print qq(
//: assign chn_data_in_${i}= chn_data_in[32*${i}+31:32*${i}];
//: assign chn_alu_op_${i} = chn_alu_op[32*${i}+31:32*${i}];
//: assign chn_mul_op_${i} = chn_mul_op[32*${i}+31:32*${i}];
//: assign chn_data_out[32*${i}+31:32*${i}] = chn_data_out_${i};
//:
//: SA_AUTOSA_SDP_AUTOSAHLS_Y_int_mul u_sdp_y_core_mul_${i} (
//: .cfg_mul_bypass (cfg_mul_bypass)
//: ,.cfg_mul_op (cfg_mul_op[31:0])
//: ,.cfg_mul_prelu (cfg_mul_prelu)
//: ,.cfg_mul_src (cfg_mul_src)
//: ,.cfg_mul_truncate (cfg_mul_truncate[9:0])
//: ,.chn_in_pvld (chn_in_pvld)
//: ,.chn_mul_in (chn_data_in_${i}[31:0])
//: ,.chn_mul_op (chn_mul_op_${i}[31:0])
//: ,.chn_mul_op_pvld (chn_mul_op_pvld)
//: ,.mul_out_prdy (mul_out_prdy_${i})
//: ,.autosa_core_clk (autosa_core_clk)
//: ,.autosa_core_rstn (autosa_core_rstn)
//: ,.chn_in_prdy (chn_in_prdy_${i})
//: ,.chn_mul_op_prdy (chn_mul_op_prdy_${i})
//: ,.mul_data_out (mul_data_out_${i}[31:0])
//: ,.mul_out_pvld (mul_out_pvld_${i})
//: );
//:
//: SA_AUTOSA_SDP_AUTOSAHLS_Y_int_alu u_sdp_y_core_alu_${i} (
//: .alu_data_in (mul_data_out_${i}[31:0])
//: ,.alu_in_pvld (mul_out_pvld_${i})
//: ,.alu_out_prdy (chn_out_prdy)
//: ,.cfg_alu_algo (cfg_alu_algo[1:0])
//: ,.cfg_alu_bypass (cfg_alu_bypass)
//: ,.cfg_alu_op (cfg_alu_op[31:0])
//: ,.cfg_alu_src (cfg_alu_src)
//: ,.chn_alu_op (chn_alu_op_${i}[31:0])
//: ,.chn_alu_op_pvld (chn_alu_op_pvld)
//: ,.autosa_core_clk (autosa_core_clk)
//: ,.autosa_core_rstn (autosa_core_rstn)
//: ,.alu_data_out (chn_data_out_${i}[31:0])
//: ,.alu_in_prdy (mul_out_prdy_${i})
//: ,.alu_out_pvld (chn_out_pvld_${i})
//: ,.chn_alu_op_prdy (chn_alu_op_prdy_${i})
//: );
//:
//: );
//: }
//| eperl: generated_beg (DO NOT EDIT BELOW)

assign chn_data_in_0= chn_data_in[32*0+31:32*0];
assign chn_alu_op_0 = chn_alu_op[32*0+31:32*0];
assign chn_mul_op_0 = chn_mul_op[32*0+31:32*0];
assign chn_data_out[32*0+31:32*0] = chn_data_out_0;

SA_AUTOSA_SDP_AUTOSAHLS_Y_int_mul u_sdp_y_core_mul_0 (
.cfg_mul_bypass (cfg_mul_bypass)
,.cfg_mul_op (cfg_mul_op[31:0])
,.cfg_mul_prelu (cfg_mul_prelu)
,.cfg_mul_src (cfg_mul_src)
,.cfg_mul_truncate (cfg_mul_truncate[9:0])
,.chn_in_pvld (chn_in_pvld)
,.chn_mul_in (chn_data_in_0[31:0])
,.chn_mul_op (chn_mul_op_0[31:0])
,.chn_mul_op_pvld (chn_mul_op_pvld)
,.mul_out_prdy (mul_out_prdy_0)
,.autosa_core_clk (autosa_core_clk)
,.autosa_core_rstn (autosa_core_rstn)
,.chn_in_prdy (chn_in_prdy_0)
,.chn_mul_op_prdy (chn_mul_op_prdy_0)
,.mul_data_out (mul_data_out_0[31:0])
,.mul_out_pvld (mul_out_pvld_0)
);

SA_AUTOSA_SDP_AUTOSAHLS_Y_int_alu u_sdp_y_core_alu_0 (
.alu_data_in (mul_data_out_0[31:0])
,.alu_in_pvld (mul_out_pvld_0)
,.alu_out_prdy (chn_out_prdy)
,.cfg_alu_algo (cfg_alu_algo[1:0])
,.cfg_alu_bypass (cfg_alu_bypass)
,.cfg_alu_op (cfg_alu_op[31:0])
,.cfg_alu_src (cfg_alu_src)
,.chn_alu_op (chn_alu_op_0[31:0])
,.chn_alu_op_pvld (chn_alu_op_pvld)
,.autosa_core_clk (autosa_core_clk)
,.autosa_core_rstn (autosa_core_rstn)
,.alu_data_out (chn_data_out_0[31:0])
,.alu_in_prdy (mul_out_prdy_0)
,.alu_out_pvld (chn_out_pvld_0)
,.chn_alu_op_prdy (chn_alu_op_prdy_0)
);


assign chn_data_in_1= chn_data_in[32*1+31:32*1];
assign chn_alu_op_1 = chn_alu_op[32*1+31:32*1];
assign chn_mul_op_1 = chn_mul_op[32*1+31:32*1];
assign chn_data_out[32*1+31:32*1] = chn_data_out_1;

SA_AUTOSA_SDP_AUTOSAHLS_Y_int_mul u_sdp_y_core_mul_1 (
.cfg_mul_bypass (cfg_mul_bypass)
,.cfg_mul_op (cfg_mul_op[31:0])
,.cfg_mul_prelu (cfg_mul_prelu)
,.cfg_mul_src (cfg_mul_src)
,.cfg_mul_truncate (cfg_mul_truncate[9:0])
,.chn_in_pvld (chn_in_pvld)
,.chn_mul_in (chn_data_in_1[31:0])
,.chn_mul_op (chn_mul_op_1[31:0])
,.chn_mul_op_pvld (chn_mul_op_pvld)
,.mul_out_prdy (mul_out_prdy_1)
,.autosa_core_clk (autosa_core_clk)
,.autosa_core_rstn (autosa_core_rstn)
,.chn_in_prdy (chn_in_prdy_1)
,.chn_mul_op_prdy (chn_mul_op_prdy_1)
,.mul_data_out (mul_data_out_1[31:0])
,.mul_out_pvld (mul_out_pvld_1)
);

SA_AUTOSA_SDP_AUTOSAHLS_Y_int_alu u_sdp_y_core_alu_1 (
.alu_data_in (mul_data_out_1[31:0])
,.alu_in_pvld (mul_out_pvld_1)
,.alu_out_prdy (chn_out_prdy)
,.cfg_alu_algo (cfg_alu_algo[1:0])
,.cfg_alu_bypass (cfg_alu_bypass)
,.cfg_alu_op (cfg_alu_op[31:0])
,.cfg_alu_src (cfg_alu_src)
,.chn_alu_op (chn_alu_op_1[31:0])
,.chn_alu_op_pvld (chn_alu_op_pvld)
,.autosa_core_clk (autosa_core_clk)
,.autosa_core_rstn (autosa_core_rstn)
,.alu_data_out (chn_data_out_1[31:0])
,.alu_in_prdy (mul_out_prdy_1)
,.alu_out_pvld (chn_out_pvld_1)
,.chn_alu_op_prdy (chn_alu_op_prdy_1)
);


assign chn_data_in_2= chn_data_in[32*2+31:32*2];
assign chn_alu_op_2 = chn_alu_op[32*2+31:32*2];
assign chn_mul_op_2 = chn_mul_op[32*2+31:32*2];
assign chn_data_out[32*2+31:32*2] = chn_data_out_2;

SA_AUTOSA_SDP_AUTOSAHLS_Y_int_mul u_sdp_y_core_mul_2 (
.cfg_mul_bypass (cfg_mul_bypass)
,.cfg_mul_op (cfg_mul_op[31:0])
,.cfg_mul_prelu (cfg_mul_prelu)
,.cfg_mul_src (cfg_mul_src)
,.cfg_mul_truncate (cfg_mul_truncate[9:0])
,.chn_in_pvld (chn_in_pvld)
,.chn_mul_in (chn_data_in_2[31:0])
,.chn_mul_op (chn_mul_op_2[31:0])
,.chn_mul_op_pvld (chn_mul_op_pvld)
,.mul_out_prdy (mul_out_prdy_2)
,.autosa_core_clk (autosa_core_clk)
,.autosa_core_rstn (autosa_core_rstn)
,.chn_in_prdy (chn_in_prdy_2)
,.chn_mul_op_prdy (chn_mul_op_prdy_2)
,.mul_data_out (mul_data_out_2[31:0])
,.mul_out_pvld (mul_out_pvld_2)
);

SA_AUTOSA_SDP_AUTOSAHLS_Y_int_alu u_sdp_y_core_alu_2 (
.alu_data_in (mul_data_out_2[31:0])
,.alu_in_pvld (mul_out_pvld_2)
,.alu_out_prdy (chn_out_prdy)
,.cfg_alu_algo (cfg_alu_algo[1:0])
,.cfg_alu_bypass (cfg_alu_bypass)
,.cfg_alu_op (cfg_alu_op[31:0])
,.cfg_alu_src (cfg_alu_src)
,.chn_alu_op (chn_alu_op_2[31:0])
,.chn_alu_op_pvld (chn_alu_op_pvld)
,.autosa_core_clk (autosa_core_clk)
,.autosa_core_rstn (autosa_core_rstn)
,.alu_data_out (chn_data_out_2[31:0])
,.alu_in_prdy (mul_out_prdy_2)
,.alu_out_pvld (chn_out_pvld_2)
,.chn_alu_op_prdy (chn_alu_op_prdy_2)
);


assign chn_data_in_3= chn_data_in[32*3+31:32*3];
assign chn_alu_op_3 = chn_alu_op[32*3+31:32*3];
assign chn_mul_op_3 = chn_mul_op[32*3+31:32*3];
assign chn_data_out[32*3+31:32*3] = chn_data_out_3;

SA_AUTOSA_SDP_AUTOSAHLS_Y_int_mul u_sdp_y_core_mul_3 (
.cfg_mul_bypass (cfg_mul_bypass)
,.cfg_mul_op (cfg_mul_op[31:0])
,.cfg_mul_prelu (cfg_mul_prelu)
,.cfg_mul_src (cfg_mul_src)
,.cfg_mul_truncate (cfg_mul_truncate[9:0])
,.chn_in_pvld (chn_in_pvld)
,.chn_mul_in (chn_data_in_3[31:0])
,.chn_mul_op (chn_mul_op_3[31:0])
,.chn_mul_op_pvld (chn_mul_op_pvld)
,.mul_out_prdy (mul_out_prdy_3)
,.autosa_core_clk (autosa_core_clk)
,.autosa_core_rstn (autosa_core_rstn)
,.chn_in_prdy (chn_in_prdy_3)
,.chn_mul_op_prdy (chn_mul_op_prdy_3)
,.mul_data_out (mul_data_out_3[31:0])
,.mul_out_pvld (mul_out_pvld_3)
);

SA_AUTOSA_SDP_AUTOSAHLS_Y_int_alu u_sdp_y_core_alu_3 (
.alu_data_in (mul_data_out_3[31:0])
,.alu_in_pvld (mul_out_pvld_3)
,.alu_out_prdy (chn_out_prdy)
,.cfg_alu_algo (cfg_alu_algo[1:0])
,.cfg_alu_bypass (cfg_alu_bypass)
,.cfg_alu_op (cfg_alu_op[31:0])
,.cfg_alu_src (cfg_alu_src)
,.chn_alu_op (chn_alu_op_3[31:0])
,.chn_alu_op_pvld (chn_alu_op_pvld)
,.autosa_core_clk (autosa_core_clk)
,.autosa_core_rstn (autosa_core_rstn)
,.alu_data_out (chn_data_out_3[31:0])
,.alu_in_prdy (mul_out_prdy_3)
,.alu_out_pvld (chn_out_pvld_3)
,.chn_alu_op_prdy (chn_alu_op_prdy_3)
);


//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule // SA_AUTOSA_SDP_AUTOSAHLS_Y_int_core
