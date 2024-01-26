// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_apb2csb.v
module SA_AUTOSA_apb2csb (
   pclk
  ,prstn
  ,csb2autosa_ready
  ,autosa2csb_data
  ,autosa2csb_valid
  ,paddr
  ,penable
  ,psel
  ,pwdata
  ,pwrite
  ,csb2autosa_addr
  ,csb2autosa_nposted
  ,csb2autosa_valid
  ,csb2autosa_wdat
  ,csb2autosa_write
  ,prdata
  ,pready
  );
input pclk;
input prstn;
//apb interface
input psel;
input penable;
input pwrite;
input [31:0] paddr;
input [31:0] pwdata;
output [31:0] prdata;
output pready;
//csb interface
output csb2autosa_valid;
input csb2autosa_ready;
output [15:0] csb2autosa_addr;
output [31:0] csb2autosa_wdat;
output csb2autosa_write;
output csb2autosa_nposted;
input autosa2csb_valid;
input [31:0] autosa2csb_data;
//input autosa2csb_wr_complete;
reg rd_trans_low;
wire rd_trans_vld;
wire wr_trans_vld;
// synoff nets
// monitor nets
// debug nets
// tie high nets
// tie low nets
// no connect nets
// not all bits used nets
// todo nets
assign wr_trans_vld = psel & penable & pwrite;
assign rd_trans_vld = psel & penable & ~pwrite;
always @(posedge pclk or negedge prstn) begin
  if (!prstn) begin
    rd_trans_low <= 1'b0;
  end else begin
    if(autosa2csb_valid & rd_trans_low)
        rd_trans_low <= 1'b0;
    else if (csb2autosa_ready & rd_trans_vld)
        rd_trans_low <= 1'b1;
  end
end
assign csb2autosa_valid = wr_trans_vld | rd_trans_vld & ~rd_trans_low;
assign csb2autosa_addr = paddr[17:2];
assign csb2autosa_wdat = pwdata[31:0];
assign csb2autosa_write = pwrite;
assign csb2autosa_nposted = 1'b0;
assign prdata = autosa2csb_data[31:0];
assign pready = ~(wr_trans_vld & ~csb2autosa_ready | rd_trans_vld & ~autosa2csb_valid);
endmodule // SA_AUTOSA_apb2csb
