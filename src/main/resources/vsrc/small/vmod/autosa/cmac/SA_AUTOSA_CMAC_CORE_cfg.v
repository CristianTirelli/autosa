// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_CMAC_CORE_cfg.v
module SA_AUTOSA_CMAC_CORE_cfg (
   autosa_core_clk
  ,autosa_core_rstn
  ,dp2reg_done
  ,reg2dp_cosa_mode
  ,reg2dp_op_en
  ,cfg_is_wg
  ,cfg_reg_en
  );
input autosa_core_clk;
input autosa_core_rstn;
input dp2reg_done;
input reg2dp_cosa_mode;
input reg2dp_op_en;
output cfg_is_wg;
output cfg_reg_en;
wire cfg_is_wg_w;
wire cfg_reg_en_w;
//: &eperl::flop(" -q  op_en_d1  -d \"reg2dp_op_en\" -clk autosa_core_clk -rst autosa_core_rstn ");
//: &eperl::flop(" -q  op_done_d1  -d \"dp2reg_done\" -clk autosa_core_clk -rst autosa_core_rstn ");
//: &eperl::flop(" -q  cfg_reg_en  -d \"cfg_reg_en_w\" -clk autosa_core_clk -rst autosa_core_rstn ");
//: &eperl::flop(" -q  cfg_is_wg  -d \"cfg_is_wg_w\" -clk autosa_core_clk -rst autosa_core_rstn ");
//: &eperl::flop(" -q  cfg_reg_en_d1  -d \"cfg_reg_en\" -clk autosa_core_clk -rst autosa_core_rstn ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
reg  op_en_d1;
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
   if (!autosa_core_rstn) begin
       op_en_d1 <= 'b0;
   end else begin
       op_en_d1 <= reg2dp_op_en;
   end
end
reg  op_done_d1;
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
   if (!autosa_core_rstn) begin
       op_done_d1 <= 'b0;
   end else begin
       op_done_d1 <= dp2reg_done;
   end
end
reg  cfg_reg_en;
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
   if (!autosa_core_rstn) begin
       cfg_reg_en <= 'b0;
   end else begin
       cfg_reg_en <= cfg_reg_en_w;
   end
end
reg  cfg_is_wg;
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
   if (!autosa_core_rstn) begin
       cfg_is_wg <= 'b0;
   end else begin
       cfg_is_wg <= cfg_is_wg_w;
   end
end
reg  cfg_reg_en_d1;
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
   if (!autosa_core_rstn) begin
       cfg_reg_en_d1 <= 'b0;
   end else begin
       cfg_reg_en_d1 <= cfg_reg_en;
   end
end

//| eperl: generated_end (DO NOT EDIT ABOVE)
assign cfg_reg_en_w = (~op_en_d1 | op_done_d1) & reg2dp_op_en;
assign cfg_is_wg_w = 1'b0;
endmodule // SA_AUTOSA_CMAC_CORE_cfg
