// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_LNQD1PO4.v
module SA_LNQD1PO4 (
  D
 ,EN
 ,Q
 );
input D ;
input EN ;
output Q ;
reg Q;
always @(negedge EN)
    Q <= D;
endmodule
