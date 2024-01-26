// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_MUX2D4.v
module SA_MUX2D4 (
  I0
 ,I1
 ,S
 ,Z
 );
input I0 ;
input I1 ;
input S ;
output Z ;
assign Z = S ? I1 : I0;
endmodule
