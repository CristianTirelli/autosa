// ==============================================================
// Generated by Vitis HLS v2023.2
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps 

module kernel0_PE_wrapper (
        ap_clk,
        ap_rst,
        ap_start,
        start_full_n,
        ap_done,
        ap_continue,
        ap_idle,
        ap_ready,
        start_out,
        start_write,
        fifo_A_PE_0_0_dout,
        fifo_A_PE_0_0_num_data_valid,
        fifo_A_PE_0_0_fifo_cap,
        fifo_A_PE_0_0_empty_n,
        fifo_A_PE_0_0_read,
        fifo_A_PE_0_1_din,
        fifo_A_PE_0_1_num_data_valid,
        fifo_A_PE_0_1_fifo_cap,
        fifo_A_PE_0_1_full_n,
        fifo_A_PE_0_1_write,
        fifo_B_PE_0_0_dout,
        fifo_B_PE_0_0_num_data_valid,
        fifo_B_PE_0_0_fifo_cap,
        fifo_B_PE_0_0_empty_n,
        fifo_B_PE_0_0_read,
        fifo_B_PE_1_0_din,
        fifo_B_PE_1_0_num_data_valid,
        fifo_B_PE_1_0_fifo_cap,
        fifo_B_PE_1_0_full_n,
        fifo_B_PE_1_0_write,
        fifo_C_drain_PE_0_0_din,
        fifo_C_drain_PE_0_0_num_data_valid,
        fifo_C_drain_PE_0_0_fifo_cap,
        fifo_C_drain_PE_0_0_full_n,
        fifo_C_drain_PE_0_0_write
);

parameter    ap_ST_fsm_state1 = 2'd1;
parameter    ap_ST_fsm_state2 = 2'd2;

input   ap_clk;
input   ap_rst;
input   ap_start;
input   start_full_n;
output   ap_done;
input   ap_continue;
output   ap_idle;
output   ap_ready;
output   start_out;
output   start_write;
input  [63:0] fifo_A_PE_0_0_dout;
input  [2:0] fifo_A_PE_0_0_num_data_valid;
input  [2:0] fifo_A_PE_0_0_fifo_cap;
input   fifo_A_PE_0_0_empty_n;
output   fifo_A_PE_0_0_read;
output  [63:0] fifo_A_PE_0_1_din;
input  [2:0] fifo_A_PE_0_1_num_data_valid;
input  [2:0] fifo_A_PE_0_1_fifo_cap;
input   fifo_A_PE_0_1_full_n;
output   fifo_A_PE_0_1_write;
input  [63:0] fifo_B_PE_0_0_dout;
input  [2:0] fifo_B_PE_0_0_num_data_valid;
input  [2:0] fifo_B_PE_0_0_fifo_cap;
input   fifo_B_PE_0_0_empty_n;
output   fifo_B_PE_0_0_read;
output  [63:0] fifo_B_PE_1_0_din;
input  [2:0] fifo_B_PE_1_0_num_data_valid;
input  [2:0] fifo_B_PE_1_0_fifo_cap;
input   fifo_B_PE_1_0_full_n;
output   fifo_B_PE_1_0_write;
output  [31:0] fifo_C_drain_PE_0_0_din;
input  [2:0] fifo_C_drain_PE_0_0_num_data_valid;
input  [2:0] fifo_C_drain_PE_0_0_fifo_cap;
input   fifo_C_drain_PE_0_0_full_n;
output   fifo_C_drain_PE_0_0_write;

reg ap_done;
reg ap_idle;
reg start_write;
reg fifo_A_PE_0_0_read;
reg fifo_A_PE_0_1_write;
reg fifo_B_PE_0_0_read;
reg fifo_B_PE_1_0_write;
reg fifo_C_drain_PE_0_0_write;

reg    real_start;
reg    start_once_reg;
reg    ap_done_reg;
(* fsm_encoding = "none" *) reg   [1:0] ap_CS_fsm;
wire    ap_CS_fsm_state1;
reg    internal_ap_ready;
wire    grp_PE_fu_30_ap_start;
wire    grp_PE_fu_30_ap_done;
wire    grp_PE_fu_30_ap_idle;
wire    grp_PE_fu_30_ap_ready;
wire    grp_PE_fu_30_fifo_A_PE_1_12_read;
wire    grp_PE_fu_30_fifo_B_PE_1_1_read;
wire   [63:0] grp_PE_fu_30_fifo_B_PE_2_1_din;
wire    grp_PE_fu_30_fifo_B_PE_2_1_write;
wire   [63:0] grp_PE_fu_30_fifo_A_PE_1_2_din;
wire    grp_PE_fu_30_fifo_A_PE_1_2_write;
wire   [31:0] grp_PE_fu_30_fifo_C_drain_PE_1_1_din;
wire    grp_PE_fu_30_fifo_C_drain_PE_1_1_write;
reg    grp_PE_fu_30_ap_start_reg;
reg    ap_block_state1_ignore_call10;
wire    ap_CS_fsm_state2;
reg   [1:0] ap_NS_fsm;
reg    ap_block_state1;
reg    ap_ST_fsm_state1_blk;
reg    ap_ST_fsm_state2_blk;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 start_once_reg = 1'b0;
#0 ap_done_reg = 1'b0;
#0 ap_CS_fsm = 2'd1;
#0 grp_PE_fu_30_ap_start_reg = 1'b0;
end

kernel0_PE grp_PE_fu_30(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(grp_PE_fu_30_ap_start),
    .ap_done(grp_PE_fu_30_ap_done),
    .ap_idle(grp_PE_fu_30_ap_idle),
    .ap_ready(grp_PE_fu_30_ap_ready),
    .fifo_A_PE_1_12_dout(fifo_A_PE_0_0_dout),
    .fifo_A_PE_1_12_num_data_valid(3'd0),
    .fifo_A_PE_1_12_fifo_cap(3'd0),
    .fifo_A_PE_1_12_empty_n(fifo_A_PE_0_0_empty_n),
    .fifo_A_PE_1_12_read(grp_PE_fu_30_fifo_A_PE_1_12_read),
    .fifo_B_PE_1_1_dout(fifo_B_PE_0_0_dout),
    .fifo_B_PE_1_1_num_data_valid(3'd0),
    .fifo_B_PE_1_1_fifo_cap(3'd0),
    .fifo_B_PE_1_1_empty_n(fifo_B_PE_0_0_empty_n),
    .fifo_B_PE_1_1_read(grp_PE_fu_30_fifo_B_PE_1_1_read),
    .fifo_B_PE_2_1_din(grp_PE_fu_30_fifo_B_PE_2_1_din),
    .fifo_B_PE_2_1_num_data_valid(3'd0),
    .fifo_B_PE_2_1_fifo_cap(3'd0),
    .fifo_B_PE_2_1_full_n(fifo_B_PE_1_0_full_n),
    .fifo_B_PE_2_1_write(grp_PE_fu_30_fifo_B_PE_2_1_write),
    .fifo_A_PE_1_2_din(grp_PE_fu_30_fifo_A_PE_1_2_din),
    .fifo_A_PE_1_2_num_data_valid(3'd0),
    .fifo_A_PE_1_2_fifo_cap(3'd0),
    .fifo_A_PE_1_2_full_n(fifo_A_PE_0_1_full_n),
    .fifo_A_PE_1_2_write(grp_PE_fu_30_fifo_A_PE_1_2_write),
    .fifo_C_drain_PE_1_1_din(grp_PE_fu_30_fifo_C_drain_PE_1_1_din),
    .fifo_C_drain_PE_1_1_num_data_valid(3'd0),
    .fifo_C_drain_PE_1_1_fifo_cap(3'd0),
    .fifo_C_drain_PE_1_1_full_n(fifo_C_drain_PE_0_0_full_n),
    .fifo_C_drain_PE_1_1_write(grp_PE_fu_30_fifo_C_drain_PE_1_1_write)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_state1;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((grp_PE_fu_30_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state2))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        grp_PE_fu_30_ap_start_reg <= 1'b0;
    end else begin
        if (((1'b1 == ap_CS_fsm_state1) & (1'b0 == ap_block_state1_ignore_call10))) begin
            grp_PE_fu_30_ap_start_reg <= 1'b1;
        end else if ((grp_PE_fu_30_ap_ready == 1'b1)) begin
            grp_PE_fu_30_ap_start_reg <= 1'b0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        start_once_reg <= 1'b0;
    end else begin
        if (((real_start == 1'b1) & (internal_ap_ready == 1'b0))) begin
            start_once_reg <= 1'b1;
        end else if ((internal_ap_ready == 1'b1)) begin
            start_once_reg <= 1'b0;
        end
    end
end

always @ (*) begin
    if ((1'b1 == ap_block_state1)) begin
        ap_ST_fsm_state1_blk = 1'b1;
    end else begin
        ap_ST_fsm_state1_blk = 1'b0;
    end
end

always @ (*) begin
    if ((grp_PE_fu_30_ap_done == 1'b0)) begin
        ap_ST_fsm_state2_blk = 1'b1;
    end else begin
        ap_ST_fsm_state2_blk = 1'b0;
    end
end

always @ (*) begin
    if (((grp_PE_fu_30_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state2))) begin
        ap_done = 1'b1;
    end else begin
        ap_done = ap_done_reg;
    end
end

always @ (*) begin
    if (((real_start == 1'b0) & (1'b1 == ap_CS_fsm_state1))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        fifo_A_PE_0_0_read = grp_PE_fu_30_fifo_A_PE_1_12_read;
    end else begin
        fifo_A_PE_0_0_read = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        fifo_A_PE_0_1_write = grp_PE_fu_30_fifo_A_PE_1_2_write;
    end else begin
        fifo_A_PE_0_1_write = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        fifo_B_PE_0_0_read = grp_PE_fu_30_fifo_B_PE_1_1_read;
    end else begin
        fifo_B_PE_0_0_read = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        fifo_B_PE_1_0_write = grp_PE_fu_30_fifo_B_PE_2_1_write;
    end else begin
        fifo_B_PE_1_0_write = 1'b0;
    end
end

always @ (*) begin
    if ((1'b1 == ap_CS_fsm_state2)) begin
        fifo_C_drain_PE_0_0_write = grp_PE_fu_30_fifo_C_drain_PE_1_1_write;
    end else begin
        fifo_C_drain_PE_0_0_write = 1'b0;
    end
end

always @ (*) begin
    if (((grp_PE_fu_30_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state2))) begin
        internal_ap_ready = 1'b1;
    end else begin
        internal_ap_ready = 1'b0;
    end
end

always @ (*) begin
    if (((start_full_n == 1'b0) & (start_once_reg == 1'b0))) begin
        real_start = 1'b0;
    end else begin
        real_start = ap_start;
    end
end

always @ (*) begin
    if (((real_start == 1'b1) & (start_once_reg == 1'b0))) begin
        start_write = 1'b1;
    end else begin
        start_write = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_state1 : begin
            if (((1'b1 == ap_CS_fsm_state1) & (1'b0 == ap_block_state1))) begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end
        end
        ap_ST_fsm_state2 : begin
            if (((grp_PE_fu_30_ap_done == 1'b1) & (1'b1 == ap_CS_fsm_state2))) begin
                ap_NS_fsm = ap_ST_fsm_state1;
            end else begin
                ap_NS_fsm = ap_ST_fsm_state2;
            end
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_state1 = ap_CS_fsm[32'd0];

assign ap_CS_fsm_state2 = ap_CS_fsm[32'd1];

always @ (*) begin
    ap_block_state1 = ((real_start == 1'b0) | (ap_done_reg == 1'b1));
end

always @ (*) begin
    ap_block_state1_ignore_call10 = ((real_start == 1'b0) | (ap_done_reg == 1'b1));
end

assign ap_ready = internal_ap_ready;

assign fifo_A_PE_0_1_din = grp_PE_fu_30_fifo_A_PE_1_2_din;

assign fifo_B_PE_1_0_din = grp_PE_fu_30_fifo_B_PE_2_1_din;

assign fifo_C_drain_PE_0_0_din = grp_PE_fu_30_fifo_C_drain_PE_1_1_din;

assign grp_PE_fu_30_ap_start = grp_PE_fu_30_ap_start_reg;

assign start_out = real_start;

endmodule //kernel0_PE_wrapper
