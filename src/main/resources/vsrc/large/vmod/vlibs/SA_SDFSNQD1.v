// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_SDFSNQD1.v
module SA_SDFSNQD1 (
  SI
 ,D
 ,SE
 ,CP
 ,SDN
 ,Q
 );
input SI ;
input D ;
input SE ;
input CP ;
input SDN ;
output Q ;
reg Q;
assign sel = SE ? SI : D;
always @(posedge CP or negedge SDN)
begin
    if(~SDN)
        Q <= 1'b1;
    else
        Q <= sel;
end
endmodule
