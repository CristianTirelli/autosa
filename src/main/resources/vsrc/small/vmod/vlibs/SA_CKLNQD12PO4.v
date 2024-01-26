// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_CKLNQD12PO4.v
module SA_CKLNQD12PO4 (
  TE
 ,E
 ,CP
 ,Q
 );
input TE ;
input E ;
input CP ;
output Q ;
reg qd;
always @(negedge CP)
    qd <= TE | E;
assign Q = CP & qd;
endmodule
