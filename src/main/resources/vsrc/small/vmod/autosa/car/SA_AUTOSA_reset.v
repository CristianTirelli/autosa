// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_reset.v
module SA_AUTOSA_reset (
   dla_reset_rstn //|< i
  ,direct_reset_ //|< i
  ,test_mode //|< i
  ,synced_rstn //|> o
  ,autosa_clk //|< i
  );
//
// SA_AUTOSA_reset_ports.v
//
input dla_reset_rstn;
input direct_reset_;
input test_mode;
output synced_rstn;
input autosa_clk;
  sa_sync_reset sa_sync_reset_synced_rstn (
     .clk (autosa_clk) //|< i
    ,.inreset_ (dla_reset_rstn) //|< i
    ,.direct_reset_ (direct_reset_) //|< i
    ,.test_mode (test_mode) //|< i
    ,.outreset_ (synced_rstn) //|> o
    );
//&Instance sa_sync3d_reset u_vi_sa_sync_reset;
// &Connect inreset_ dla_reset_rstn;
// &Connect test_mode test_mode;
// &Connect direct_reset_ direct_reset_;
// &Connect clk autosa_clk;
// &Connect outreset_ synced_rstn;
endmodule // SA_AUTOSA_reset
