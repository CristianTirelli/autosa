// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_SDP_AUTOSAHLS_relu.v
module SA_AUTOSA_SDP_AUTOSAHLS_relu (
   data_in
  ,data_out
  );
parameter DATA_WIDTH = 32;
input [DATA_WIDTH-1:0] data_in;
output [DATA_WIDTH-1:0] data_out;
reg [DATA_WIDTH-1:0] data_out;
wire data_in_sign;
// synoff nets
// monitor nets
// debug nets
// tie high nets
// tie low nets
// no connect nets
// not all bits used nets
// todo nets
assign data_in_sign = data_in[DATA_WIDTH-1];
always @(
  data_in_sign
  or data_in
  ) begin
   if (!data_in_sign)
      data_out[((DATA_WIDTH) - 1):0] = data_in[((DATA_WIDTH) - 1):0];
   else
      data_out[((DATA_WIDTH) - 1):0] = {DATA_WIDTH{1'b0}};
end
endmodule // SA_AUTOSA_SDP_AUTOSAHLS_relu
