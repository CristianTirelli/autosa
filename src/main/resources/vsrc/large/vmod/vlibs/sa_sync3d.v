// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: sa_sync3d.v
module sa_sync3d ( d, clk, q);
input d, clk;
output q;
    p_SA_SSYNC3DO SA_GENERIC_CELL( .d(d), .clk(clk), .q(q) );
// synopsys dc_script_begin
// synopsys dc_script_end
//g2c if {[find / -null_ok -subdesign sa_sync3d] != {} } { set_attr preserve 1 [find / -subdesign sa_sync3d] }
endmodule
