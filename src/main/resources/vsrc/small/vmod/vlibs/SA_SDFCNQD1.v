// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_SDFCNQD1.v
module SA_SDFCNQD1 (
  SI
 ,D
 ,SE
 ,CP
 ,CDN
 ,Q
 );
input SI ;
input D ;
input SE ;
input CP ;
input CDN ;
output Q ;
reg Q;
assign sel = SE ? SI : D;
always @(posedge CP or negedge CDN)
begin
    if(~CDN)
        Q <= 1'b0;
    else
        Q <= sel;
end
endmodule
