// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_PGAOPV_INVD2PO4.v
module SA_PGAOPV_INVD2PO4 (
  I
 ,ZN
 );
input I ;
output ZN ;
assign ZN = ~I;
endmodule
