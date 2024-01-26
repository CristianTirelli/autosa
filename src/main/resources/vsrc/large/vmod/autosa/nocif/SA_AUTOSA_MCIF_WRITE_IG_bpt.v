// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_AUTOSA_MCIF_WRITE_IG_bpt.v
// ================================================================
// AUTOSA Open Source Project
// 
// Copyright(c 2016 - 2017 NVIDIA Corporation.  Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with 
// this distribution for more information.
// ================================================================
`include "sa_simulate_x_tick.vh"
module SA_AUTOSA_MCIF_WRITE_IG_bpt (
   autosa_core_clk //|< i
  ,autosa_core_rstn //|< i
  ,pwrbus_ram_pd //|< i
  ,dma2bpt_req_valid //|< i
  ,dma2bpt_req_ready //|> o
  ,dma2bpt_req_pd //|< i
  ,bpt2arb_cmd_valid //|> o
  ,bpt2arb_cmd_ready //|< i
  ,bpt2arb_cmd_pd //|> o
  ,bpt2arb_dat_valid //|> o
  ,bpt2arb_dat_ready //|< i
  ,bpt2arb_dat_pd //|> o
  ,axid //|< i
  );
//
// SA_AUTOSA_MCIF_WRITE_IG_bpt_ports.v
//
input autosa_core_clk;
input autosa_core_rstn;
input [31:0] pwrbus_ram_pd;
input [3:0] axid;
input dma2bpt_req_valid;
output dma2bpt_req_ready;
input [258 -1:0] dma2bpt_req_pd;
output bpt2arb_cmd_valid;
input bpt2arb_cmd_ready;
output [64 +13 -1:0] bpt2arb_cmd_pd;
output bpt2arb_dat_valid;
input bpt2arb_dat_ready;
output [258 -2:0] bpt2arb_dat_pd;
reg cmd_en;
reg dat_en;
wire [258 -1:0] ipipe_pd;
wire [258 -1:0] ipipe_pd_p;
wire ipipe_rdy;
wire ipipe_rdy_p;
wire ipipe_vld;
wire ipipe_vld_p;
wire [78 -1:0] ipipe_cmd_pd;
wire ipipe_cmd_vld;
wire ipipe_cmd_rdy;
wire [78 -1:0] in_cmd_pd;
wire [78 -1:0] in_cmd_vld_pd;
wire in_cmd_vld;
wire in_cmd_rdy;
wire [64 -1:0] in_cmd_addr;
wire [13 -1:0] in_cmd_size;
wire in_cmd_require_ack;
wire [1 -1:0] dfifo_wr_mask;
wire [256 -1:0] dfifo_wr_data;
wire dfifo_wr_prdy;
wire dfifo_wr_pvld;
wire [256 -1:0] dfifo_rd_data;
wire dfifo_rd_pvld;
wire dfifo_rd_prdy;
reg [64 -1:0] out_addr;
wire [2:0] out_size;
reg [2:0] out_size_tmp;
reg [13 -1:0] req_count;
reg [13 -1:0] req_num;
reg [2:0] beat_count;
wire [2:0] beat_size;
wire is_last_beat;
wire bpt2arb_cmd_accept;
wire bpt2arb_dat_accept;
wire [0 -1:0] stt_offset;
wire [0 -1:0] size_offset;
wire [0 -1:0] end_offset;
wire [0 -1:0] ftran_size_tmp;
wire [0 -1:0] ltran_size_tmp;
wire [2:0] ftran_size;
wire [2:0] ltran_size;
wire [13 -1:0] mtran_num;
wire in_size_is_even;
wire in_size_is_odd;
wire is_ftran;
wire is_ltran;
wire is_mtran;
wire is_single_tran;
wire is_swizzle;
wire large_req_grow;
wire mon_end_offset_c;
wire [64 -1:0] out_cmd_addr;
wire [3:0] out_cmd_axid;
wire out_cmd_ftran;
wire out_cmd_inc;
wire out_cmd_ltran;
wire out_cmd_odd;
wire out_cmd_require_ack;
wire [2:0] out_cmd_size;
wire out_cmd_swizzle;
wire [2:0] out_cmd_user_size;
wire out_cmd_vld;
wire [256 -1:0] out_dat_data;
wire [1 -1:0] out_dat_mask;
wire out_dat_vld;
//==================
// 1st Stage: REQ PIPE
SA_AUTOSA_MCIF_WRITE_IG_BPT_pipe_p1 pipe_p1 (
   .autosa_core_clk (autosa_core_clk) //|< i
  ,.autosa_core_rstn (autosa_core_rstn) //|< i
  ,.dma2bpt_req_pd (dma2bpt_req_pd)
  ,.dma2bpt_req_valid (dma2bpt_req_valid) //|< i
  ,.dma2bpt_req_ready (dma2bpt_req_ready) //|> o
  ,.ipipe_pd_p (ipipe_pd_p)
  ,.ipipe_vld_p (ipipe_vld_p) //|> w
  ,.ipipe_rdy_p (ipipe_rdy_p) //|< w
  );
SA_AUTOSA_MCIF_WRITE_IG_BPT_pipe_p2 pipe_p2 (
   .autosa_core_clk (autosa_core_clk) //|< i
  ,.autosa_core_rstn (autosa_core_rstn) //|< i
  ,.ipipe_pd_p (ipipe_pd_p)
  ,.ipipe_vld_p (ipipe_vld_p) //|< w
  ,.ipipe_rdy_p (ipipe_rdy_p) //|> w
  ,.ipipe_pd (ipipe_pd)
  ,.ipipe_vld (ipipe_vld) //|> w
  ,.ipipe_rdy (ipipe_rdy) //|< w
  );
assign ipipe_cmd_vld = ipipe_vld && (ipipe_pd[258 -1]== 0);
assign dfifo_wr_pvld = ipipe_vld && (ipipe_pd[258 -1]== 1);
assign dfifo_wr_data = ipipe_pd[256 -1:0];
assign dfifo_wr_mask = ipipe_pd[256 +1 -1:256];
assign ipipe_rdy = (ipipe_cmd_vld & ipipe_cmd_rdy) || (dfifo_wr_pvld & dfifo_wr_prdy);
assign ipipe_cmd_pd[78 -1:0] = ipipe_pd[78 -1:0];
SA_AUTOSA_MCIF_WRITE_IG_BPT_pipe_p3 pipe_p3 (
   .autosa_core_clk (autosa_core_clk) //|< i
  ,.autosa_core_rstn (autosa_core_rstn) //|< i
  ,.ipipe_cmd_pd (ipipe_cmd_pd)
  ,.ipipe_cmd_vld (ipipe_cmd_vld) //|< w
  ,.ipipe_cmd_rdy (ipipe_cmd_rdy) //|> w
  ,.in_cmd_pd (in_cmd_pd)
  ,.in_cmd_vld (in_cmd_vld) //|> w
  ,.in_cmd_rdy (in_cmd_rdy) //|< w
  );
assign in_cmd_rdy = is_ltran & is_last_beat & bpt2arb_dat_accept;
assign in_cmd_vld_pd = {78{in_cmd_vld}} & in_cmd_pd;
assign in_cmd_addr[64 -1:0] = in_cmd_vld_pd[64 -1:0];
assign in_cmd_size[13 -1:0] = in_cmd_vld_pd[78 -2:64];
assign in_cmd_require_ack = in_cmd_vld_pd[78 -1];
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass disable_block NoWidthInBasedNum-ML
// spyglass disable_block STARC-2.10.3.2a
// spyglass disable_block STARC05-2.1.3.1
// spyglass disable_block STARC-2.1.4.6
// spyglass disable_block W116
// spyglass disable_block W154
// spyglass disable_block W239
// spyglass disable_block W362
// spyglass disable_block WRN_58
// spyglass disable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
`ifdef ASSERT_ON
`ifdef FV_ASSERT_ON
`define ASSERT_RESET autosa_core_rstn
`else
`ifdef SYNTHESIS
`define ASSERT_RESET autosa_core_rstn
`else
`ifdef ASSERT_OFF_RESET_IS_X
`define ASSERT_RESET ((1'bx === autosa_core_rstn) ? 1'b0 : autosa_core_rstn)
`else
`define ASSERT_RESET ((1'bx === autosa_core_rstn) ? 1'b1 : autosa_core_rstn)
`endif // ASSERT_OFF_RESET_IS_X
`endif // SYNTHESIS
`endif // FV_ASSERT_ON
// VCS coverage off
  wire cond_zzz_assert_always_1x = (in_cmd_addr[5 -1:0] == 0);
  sa_assert_always #(0,0,"lower LSB should always be 0") zzz_assert_always_1x (.clk(autosa_core_clk), .reset_(`ASSERT_RESET), .test_expr(cond_zzz_assert_always_1x)); // spyglass disable W504 SelfDeterminedExpr-ML 
// VCS coverage on
`undef ASSERT_RESET
`endif // ASSERT_ON
`ifdef SPYGLASS_ASSERT_ON
`else
// spyglass enable_block NoWidthInBasedNum-ML
// spyglass enable_block STARC-2.10.3.2a
// spyglass enable_block STARC05-2.1.3.1
// spyglass enable_block STARC-2.1.4.6
// spyglass enable_block W116
// spyglass enable_block W154
// spyglass enable_block W239
// spyglass enable_block W362
// spyglass enable_block WRN_58
// spyglass enable_block WRN_61
`endif // SPYGLASS_ASSERT_ON
SA_AUTOSA_MCIF_WRITE_IG_BPT_dfifo u_dfifo (
   .autosa_core_clk (autosa_core_clk) //|< i
  ,.autosa_core_rstn (autosa_core_rstn) //|< i
  ,.dfifo_wr_pvld (dfifo_wr_pvld) //|< w
  ,.dfifo_wr_prdy (dfifo_wr_prdy) //|> w
  ,.dfifo_wr_pd (dfifo_wr_data)
  ,.dfifo_rd_prdy (dfifo_rd_prdy) //|< w
  ,.dfifo_rd_pvld (dfifo_rd_pvld) //|> w
  ,.dfifo_rd_pd (dfifo_rd_data)
  );
//==================
// in_cmd analysis to determine how to pop data from dFIFO
assign ftran_size[2:0] = 3'b0;
assign ltran_size[2:0] = 3'b0;
assign mtran_num = in_cmd_size - 1;
assign dfifo_rd_prdy = dat_en & bpt2arb_dat_ready;
// DATA FIFO read side: valid
assign out_dat_vld = dat_en & dfifo_rd_pvld;
assign out_dat_data = dfifo_rd_data;
assign out_dat_mask = dfifo_rd_pvld; //dfifo_rd_mask;
assign beat_size = out_size;
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
  if (!autosa_core_rstn) begin
    cmd_en <= 1'b1;
    dat_en <= 1'b0;
  end else begin
    if (bpt2arb_cmd_accept) begin
        cmd_en <= 1'b0;
        dat_en <= 1'b1;
    end else if (bpt2arb_dat_accept & is_last_beat) begin
        cmd_en <= 1'b1;
        dat_en <= 1'b0;
    end
  end
end
//================
// Beat Count: to count data per split req
//================
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
  if (!autosa_core_rstn) begin
    beat_count <= {2{1'b0}};
  end else begin
    if (bpt2arb_dat_accept) begin
        if (is_last_beat) begin
            beat_count <= 0;
        end else begin
            beat_count <= beat_count + 1;
        end
    end
  end
end
assign is_last_beat = (beat_count==beat_size);
// in AXI format
//================
// bsp out: size: this is in unit of 64B, including masked 32B data
//================
assign out_size = 3'h0;
//================
// bpt2arb: addr
//================
always @(posedge autosa_core_clk) begin
    if (bpt2arb_cmd_accept) begin
        if (is_ftran) begin
            out_addr <= in_cmd_addr + ((ftran_size+1)<<5);
        end else begin
            out_addr <= out_addr + (1<<5); //256;
        end
    end
end
//================
// tran count
//================
always @( * ) begin
       req_num = in_cmd_size;
end
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
  if (!autosa_core_rstn) begin
    req_count <= {13{1'b0}};
  end else begin
    if (bpt2arb_dat_accept & is_last_beat) begin
        if (is_ltran) begin
            req_count <= 0;
        end else begin
            req_count <= req_count + 1;
        end
    end
  end
end
assign is_ftran = (req_count==0);
assign is_mtran = (req_count>0 && req_count<req_num);
assign is_ltran = (req_count==req_num);
assign out_cmd_vld = cmd_en & in_cmd_vld;
assign out_cmd_addr = (is_ftran) ? in_cmd_addr : out_addr;
assign out_cmd_size = out_size;
assign out_cmd_inc = 1'b0;
assign out_cmd_swizzle = 1'b0;
assign out_cmd_odd = 1'b0;
assign out_cmd_ftran = is_ftran;
assign out_cmd_ltran = is_ltran;
assign out_cmd_axid = axid;
assign out_cmd_require_ack = in_cmd_require_ack & is_ltran;
assign bpt2arb_cmd_pd[3:0] = out_cmd_axid[3:0];
assign bpt2arb_cmd_pd[4] = out_cmd_require_ack ;
assign bpt2arb_cmd_pd[64 +4:5] = out_cmd_addr[64 -1:0];
assign bpt2arb_cmd_pd[64 +7:64 +5] = out_cmd_size[2:0];
assign bpt2arb_cmd_pd[64 +8] = out_cmd_swizzle ;
assign bpt2arb_cmd_pd[64 +9] = out_cmd_odd ;
assign bpt2arb_cmd_pd[64 +10] = out_cmd_inc ;
assign bpt2arb_cmd_pd[64 +11] = out_cmd_ltran ;
assign bpt2arb_cmd_pd[64 +12] = out_cmd_ftran ;
assign bpt2arb_dat_pd[256 -1:0] = out_dat_data[256 -1:0];
assign bpt2arb_dat_pd[256 +1 -1:256] = out_dat_mask[1 -1:0];
assign bpt2arb_cmd_valid = out_cmd_vld;
assign bpt2arb_dat_valid = out_dat_vld;
assign bpt2arb_cmd_accept = bpt2arb_cmd_valid & bpt2arb_cmd_ready;
assign bpt2arb_dat_accept = bpt2arb_dat_valid & bpt2arb_dat_ready;
endmodule // SA_AUTOSA_MCIF_WRITE_IG_bpt
// **************************************************************************************************************
// Generated by ::pipe -m -bc -is ipipe_pd_p (ipipe_vld_p,ipipe_rdy_p) <= dma2bpt_req_pd[258 -1:0] (dma2bpt_req_valid,dma2bpt_req_ready)
// **************************************************************************************************************
module SA_AUTOSA_MCIF_WRITE_IG_BPT_pipe_p1 (
   autosa_core_clk
  ,autosa_core_rstn
  ,dma2bpt_req_pd
  ,dma2bpt_req_valid
  ,ipipe_rdy_p
  ,dma2bpt_req_ready
  ,ipipe_pd_p
  ,ipipe_vld_p
  );
input autosa_core_clk;
input autosa_core_rstn;
input [258 -1:0] dma2bpt_req_pd;
input dma2bpt_req_valid;
input ipipe_rdy_p;
output dma2bpt_req_ready;
output [258 -1:0] ipipe_pd_p;
output ipipe_vld_p;
//: my $k = 258;
//: &eperl::pipe(" -wid $k -is -do ipipe_pd_p -vo ipipe_vld_p -ri ipipe_rdy_p -di dma2bpt_req_pd -vi dma2bpt_req_valid -ro dma2bpt_req_ready ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg dma2bpt_req_ready;
reg skid_flop_dma2bpt_req_ready;
reg skid_flop_dma2bpt_req_valid;
reg [258-1:0] skid_flop_dma2bpt_req_pd;
reg pipe_skid_dma2bpt_req_valid;
reg [258-1:0] pipe_skid_dma2bpt_req_pd;
// Wire
wire skid_dma2bpt_req_valid;
wire [258-1:0] skid_dma2bpt_req_pd;
wire skid_dma2bpt_req_ready;
wire pipe_skid_dma2bpt_req_ready;
wire ipipe_vld_p;
wire [258-1:0] ipipe_pd_p;
// Code
// SKID READY
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
   if (!autosa_core_rstn) begin
       dma2bpt_req_ready <= 1'b1;
       skid_flop_dma2bpt_req_ready <= 1'b1;
   end else begin
       dma2bpt_req_ready <= skid_dma2bpt_req_ready;
       skid_flop_dma2bpt_req_ready <= skid_dma2bpt_req_ready;
   end
end

// SKID VALID
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        skid_flop_dma2bpt_req_valid <= 1'b0;
    end else begin
        if (skid_flop_dma2bpt_req_ready) begin
            skid_flop_dma2bpt_req_valid <= dma2bpt_req_valid;
        end
   end
end
assign skid_dma2bpt_req_valid = (skid_flop_dma2bpt_req_ready) ? dma2bpt_req_valid : skid_flop_dma2bpt_req_valid;

// SKID DATA
always @(posedge autosa_core_clk) begin
    if (skid_flop_dma2bpt_req_ready & dma2bpt_req_valid) begin
        skid_flop_dma2bpt_req_pd[258-1:0] <= dma2bpt_req_pd[258-1:0];
    end
end
assign skid_dma2bpt_req_pd[258-1:0] = (skid_flop_dma2bpt_req_ready) ? dma2bpt_req_pd[258-1:0] : skid_flop_dma2bpt_req_pd[258-1:0];


// PIPE READY
assign skid_dma2bpt_req_ready = pipe_skid_dma2bpt_req_ready || !pipe_skid_dma2bpt_req_valid;

// PIPE VALID
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        pipe_skid_dma2bpt_req_valid <= 1'b0;
    end else begin
        if (skid_dma2bpt_req_ready) begin
            pipe_skid_dma2bpt_req_valid <= skid_dma2bpt_req_valid;
        end
    end
end

// PIPE DATA
always @(posedge autosa_core_clk) begin
    if (skid_dma2bpt_req_ready && skid_dma2bpt_req_valid) begin
        pipe_skid_dma2bpt_req_pd[258-1:0] <= skid_dma2bpt_req_pd[258-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_dma2bpt_req_ready = ipipe_rdy_p;
assign ipipe_vld_p = pipe_skid_dma2bpt_req_valid;
assign ipipe_pd_p = pipe_skid_dma2bpt_req_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule // SA_AUTOSA_MCIF_WRITE_IG_BPT_pipe_p1
// **************************************************************************************************************
// Generated by ::pipe -m -bc -is ipipe_pd (ipipe_vld,ipipe_rdy) <= ipipe_pd_p[258 -1:0] (ipipe_vld_p,ipipe_rdy_p)
// **************************************************************************************************************
module SA_AUTOSA_MCIF_WRITE_IG_BPT_pipe_p2 (
   autosa_core_clk
  ,autosa_core_rstn
  ,ipipe_pd_p
  ,ipipe_rdy
  ,ipipe_vld_p
  ,ipipe_pd
  ,ipipe_rdy_p
  ,ipipe_vld
  );
input autosa_core_clk;
input autosa_core_rstn;
input [258 -1:0] ipipe_pd_p;
input ipipe_rdy;
input ipipe_vld_p;
output [258 -1:0] ipipe_pd;
output ipipe_rdy_p;
output ipipe_vld;
//: my $k = 258;
//: &eperl::pipe(" -wid $k -is -do ipipe_pd -vo ipipe_vld -ri ipipe_rdy -di ipipe_pd_p -vi ipipe_vld_p -ro ipipe_rdy_p ");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg ipipe_rdy_p;
reg skid_flop_ipipe_rdy_p;
reg skid_flop_ipipe_vld_p;
reg [258-1:0] skid_flop_ipipe_pd_p;
reg pipe_skid_ipipe_vld_p;
reg [258-1:0] pipe_skid_ipipe_pd_p;
// Wire
wire skid_ipipe_vld_p;
wire [258-1:0] skid_ipipe_pd_p;
wire skid_ipipe_rdy_p;
wire pipe_skid_ipipe_rdy_p;
wire ipipe_vld;
wire [258-1:0] ipipe_pd;
// Code
// SKID READY
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
   if (!autosa_core_rstn) begin
       ipipe_rdy_p <= 1'b1;
       skid_flop_ipipe_rdy_p <= 1'b1;
   end else begin
       ipipe_rdy_p <= skid_ipipe_rdy_p;
       skid_flop_ipipe_rdy_p <= skid_ipipe_rdy_p;
   end
end

// SKID VALID
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        skid_flop_ipipe_vld_p <= 1'b0;
    end else begin
        if (skid_flop_ipipe_rdy_p) begin
            skid_flop_ipipe_vld_p <= ipipe_vld_p;
        end
   end
end
assign skid_ipipe_vld_p = (skid_flop_ipipe_rdy_p) ? ipipe_vld_p : skid_flop_ipipe_vld_p;

// SKID DATA
always @(posedge autosa_core_clk) begin
    if (skid_flop_ipipe_rdy_p & ipipe_vld_p) begin
        skid_flop_ipipe_pd_p[258-1:0] <= ipipe_pd_p[258-1:0];
    end
end
assign skid_ipipe_pd_p[258-1:0] = (skid_flop_ipipe_rdy_p) ? ipipe_pd_p[258-1:0] : skid_flop_ipipe_pd_p[258-1:0];


// PIPE READY
assign skid_ipipe_rdy_p = pipe_skid_ipipe_rdy_p || !pipe_skid_ipipe_vld_p;

// PIPE VALID
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        pipe_skid_ipipe_vld_p <= 1'b0;
    end else begin
        if (skid_ipipe_rdy_p) begin
            pipe_skid_ipipe_vld_p <= skid_ipipe_vld_p;
        end
    end
end

// PIPE DATA
always @(posedge autosa_core_clk) begin
    if (skid_ipipe_rdy_p && skid_ipipe_vld_p) begin
        pipe_skid_ipipe_pd_p[258-1:0] <= skid_ipipe_pd_p[258-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_ipipe_rdy_p = ipipe_rdy;
assign ipipe_vld = pipe_skid_ipipe_vld_p;
assign ipipe_pd = pipe_skid_ipipe_pd_p;

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule // SA_AUTOSA_MCIF_WRITE_IG_BPT_pipe_p2
// **************************************************************************************************************
// Generated by ::pipe -m -bc in_cmd_pd (in_cmd_vld,in_cmd_rdy) <= ipipe_cmd_pd[78 -1:0] (ipipe_cmd_vld,ipipe_cmd_rdy)
// **************************************************************************************************************
module SA_AUTOSA_MCIF_WRITE_IG_BPT_pipe_p3 (
   autosa_core_clk
  ,autosa_core_rstn
  ,in_cmd_rdy
  ,ipipe_cmd_pd
  ,ipipe_cmd_vld
  ,in_cmd_pd
  ,in_cmd_vld
  ,ipipe_cmd_rdy
  );
input autosa_core_clk;
input autosa_core_rstn;
input in_cmd_rdy;
input [78 -1:0] ipipe_cmd_pd;
input ipipe_cmd_vld;
output [78 -1:0] in_cmd_pd;
output in_cmd_vld;
output ipipe_cmd_rdy;
//: my $k = 78;
//: &eperl::pipe(" -wid $k -do in_cmd_pd -vo in_cmd_vld -ri in_cmd_rdy -di ipipe_cmd_pd -vi ipipe_cmd_vld -ro ipipe_cmd_rdy");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg pipe_ipipe_cmd_vld;
reg [78-1:0] pipe_ipipe_cmd_pd;
// Wire
wire ipipe_cmd_rdy;
wire pipe_ipipe_cmd_rdy;
wire in_cmd_vld;
wire [78-1:0] in_cmd_pd;
// Code
// PIPE READY
assign ipipe_cmd_rdy = pipe_ipipe_cmd_rdy || !pipe_ipipe_cmd_vld;

// PIPE VALID
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        pipe_ipipe_cmd_vld <= 1'b0;
    end else begin
        if (ipipe_cmd_rdy) begin
            pipe_ipipe_cmd_vld <= ipipe_cmd_vld;
        end
    end
end

// PIPE DATA
always @(posedge autosa_core_clk) begin
    if (ipipe_cmd_rdy && ipipe_cmd_vld) begin
        pipe_ipipe_cmd_pd[78-1:0] <= ipipe_cmd_pd[78-1:0];
    end
end


// PIPE OUTPUT
assign pipe_ipipe_cmd_rdy = in_cmd_rdy;
assign in_cmd_vld = pipe_ipipe_cmd_vld;
assign in_cmd_pd = pipe_ipipe_cmd_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule // SA_AUTOSA_MCIF_WRITE_IG_BPT_pipe_p3
module SA_AUTOSA_MCIF_WRITE_IG_BPT_dfifo (
      autosa_core_clk
    , autosa_core_rstn
    , dfifo_wr_prdy
    , dfifo_wr_pvld
    , dfifo_wr_pd
    , dfifo_rd_prdy
    , dfifo_rd_pvld
    , dfifo_rd_pd
    );
input autosa_core_clk;
input autosa_core_rstn;
output dfifo_wr_prdy;
input dfifo_wr_pvld;
input [256 -1:0] dfifo_wr_pd;
input dfifo_rd_prdy;
output dfifo_rd_pvld;
output [256 -1:0] dfifo_rd_pd;
//: my $k = 256;
//: &eperl::pipe(" -wid $k -is -do dfifo_rd_pd -vo dfifo_rd_pvld -ri dfifo_rd_prdy -di dfifo_wr_pd -vi dfifo_wr_pvld -ro dfifo_wr_prdy");
//| eperl: generated_beg (DO NOT EDIT BELOW)
// Reg
reg dfifo_wr_prdy;
reg skid_flop_dfifo_wr_prdy;
reg skid_flop_dfifo_wr_pvld;
reg [256-1:0] skid_flop_dfifo_wr_pd;
reg pipe_skid_dfifo_wr_pvld;
reg [256-1:0] pipe_skid_dfifo_wr_pd;
// Wire
wire skid_dfifo_wr_pvld;
wire [256-1:0] skid_dfifo_wr_pd;
wire skid_dfifo_wr_prdy;
wire pipe_skid_dfifo_wr_prdy;
wire dfifo_rd_pvld;
wire [256-1:0] dfifo_rd_pd;
// Code
// SKID READY
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
   if (!autosa_core_rstn) begin
       dfifo_wr_prdy <= 1'b1;
       skid_flop_dfifo_wr_prdy <= 1'b1;
   end else begin
       dfifo_wr_prdy <= skid_dfifo_wr_prdy;
       skid_flop_dfifo_wr_prdy <= skid_dfifo_wr_prdy;
   end
end

// SKID VALID
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        skid_flop_dfifo_wr_pvld <= 1'b0;
    end else begin
        if (skid_flop_dfifo_wr_prdy) begin
            skid_flop_dfifo_wr_pvld <= dfifo_wr_pvld;
        end
   end
end
assign skid_dfifo_wr_pvld = (skid_flop_dfifo_wr_prdy) ? dfifo_wr_pvld : skid_flop_dfifo_wr_pvld;

// SKID DATA
always @(posedge autosa_core_clk) begin
    if (skid_flop_dfifo_wr_prdy & dfifo_wr_pvld) begin
        skid_flop_dfifo_wr_pd[256-1:0] <= dfifo_wr_pd[256-1:0];
    end
end
assign skid_dfifo_wr_pd[256-1:0] = (skid_flop_dfifo_wr_prdy) ? dfifo_wr_pd[256-1:0] : skid_flop_dfifo_wr_pd[256-1:0];


// PIPE READY
assign skid_dfifo_wr_prdy = pipe_skid_dfifo_wr_prdy || !pipe_skid_dfifo_wr_pvld;

// PIPE VALID
always @(posedge autosa_core_clk or negedge autosa_core_rstn) begin
    if (!autosa_core_rstn) begin
        pipe_skid_dfifo_wr_pvld <= 1'b0;
    end else begin
        if (skid_dfifo_wr_prdy) begin
            pipe_skid_dfifo_wr_pvld <= skid_dfifo_wr_pvld;
        end
    end
end

// PIPE DATA
always @(posedge autosa_core_clk) begin
    if (skid_dfifo_wr_prdy && skid_dfifo_wr_pvld) begin
        pipe_skid_dfifo_wr_pd[256-1:0] <= skid_dfifo_wr_pd[256-1:0];
    end
end


// PIPE OUTPUT
assign pipe_skid_dfifo_wr_prdy = dfifo_rd_prdy;
assign dfifo_rd_pvld = pipe_skid_dfifo_wr_pvld;
assign dfifo_rd_pd = pipe_skid_dfifo_wr_pd;

//| eperl: generated_end (DO NOT EDIT ABOVE)
endmodule
