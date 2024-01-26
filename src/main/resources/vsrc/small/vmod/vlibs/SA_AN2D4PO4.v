// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_AN2D4PO4.v
module SA_AN2D4PO4(
A1,
A2,
Z
);
input A1,A2;
output Z;
assign Z = A1 & A2;
endmodule
