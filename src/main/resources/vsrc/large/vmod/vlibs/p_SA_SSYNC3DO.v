// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: p_SA_SSYNC3DO.v
module p_SA_SSYNC3DO (
  clk
 ,d
 ,q
 );
//---------------------------------------
//IO DECLARATIONS
input clk ;
input d ;
output q ;
reg q, d1, d0;
always @(posedge clk)
begin
    {q,d1,d0} <= {d1,d0,d};
end
endmodule
