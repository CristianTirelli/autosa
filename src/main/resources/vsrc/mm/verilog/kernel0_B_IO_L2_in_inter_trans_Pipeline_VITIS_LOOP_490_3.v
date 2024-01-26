// ==============================================================
// Generated by Vitis HLS v2023.2
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps 

module kernel0_B_IO_L2_in_inter_trans_Pipeline_VITIS_LOOP_490_3 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        fifo_B_B_IO_L2_in_0_dout,
        fifo_B_B_IO_L2_in_0_num_data_valid,
        fifo_B_B_IO_L2_in_0_fifo_cap,
        fifo_B_B_IO_L2_in_0_empty_n,
        fifo_B_B_IO_L2_in_0_read,
        fifo_B_B_IO_L2_in_1_din,
        fifo_B_B_IO_L2_in_1_num_data_valid,
        fifo_B_B_IO_L2_in_1_fifo_cap,
        fifo_B_B_IO_L2_in_1_full_n,
        fifo_B_B_IO_L2_in_1_write
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
input  [511:0] fifo_B_B_IO_L2_in_0_dout;
input  [2:0] fifo_B_B_IO_L2_in_0_num_data_valid;
input  [2:0] fifo_B_B_IO_L2_in_0_fifo_cap;
input   fifo_B_B_IO_L2_in_0_empty_n;
output   fifo_B_B_IO_L2_in_0_read;
output  [511:0] fifo_B_B_IO_L2_in_1_din;
input  [2:0] fifo_B_B_IO_L2_in_1_num_data_valid;
input  [2:0] fifo_B_B_IO_L2_in_1_fifo_cap;
input   fifo_B_B_IO_L2_in_1_full_n;
output   fifo_B_B_IO_L2_in_1_write;

reg ap_idle;
reg fifo_B_B_IO_L2_in_0_read;
reg fifo_B_B_IO_L2_in_1_write;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_idle_pp0;
reg    ap_block_state2_pp0_stage0_iter1;
reg    ap_block_pp0_stage0_subdone;
wire   [0:0] icmp_ln490_fu_70_p2;
reg    ap_condition_exit_pp0_iter0_stage0;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
reg    fifo_B_B_IO_L2_in_0_blk_n;
wire    ap_block_pp0_stage0;
reg    fifo_B_B_IO_L2_in_1_blk_n;
reg   [3:0] c4_2_fu_44;
wire   [3:0] c4_3_fu_76_p2;
wire    ap_loop_init;
reg    ap_block_pp0_stage0_11001;
reg   [3:0] ap_sig_allocacmp_c4;
reg    ap_block_pp0_stage0_01001;
reg    ap_done_reg;
wire    ap_continue_int;
reg    ap_done_int;
reg   [0:0] ap_NS_fsm;
wire    ap_enable_pp0;
wire    ap_start_int;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 c4_2_fu_44 = 4'd0;
#0 ap_done_reg = 1'b0;
end

kernel0_flow_control_loop_pipe_sequential_init flow_control_loop_pipe_sequential_init_U(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_ready(ap_ready),
    .ap_done(ap_done),
    .ap_start_int(ap_start_int),
    .ap_loop_init(ap_loop_init),
    .ap_ready_int(ap_ready_int),
    .ap_loop_exit_ready(ap_condition_exit_pp0_iter0_stage0),
    .ap_loop_exit_done(ap_done_int),
    .ap_continue_int(ap_continue_int),
    .ap_done_int(ap_done_int)
);

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_CS_fsm <= ap_ST_fsm_pp0_stage0;
    end else begin
        ap_CS_fsm <= ap_NS_fsm;
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_done_reg <= 1'b0;
    end else begin
        if ((ap_continue_int == 1'b1)) begin
            ap_done_reg <= 1'b0;
        end else if (((ap_loop_exit_ready == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_done_reg <= 1'b1;
        end
    end
end

always @ (posedge ap_clk) begin
    if (ap_rst == 1'b1) begin
        ap_enable_reg_pp0_iter1 <= 1'b0;
    end else begin
        if ((1'b1 == ap_condition_exit_pp0_iter0_stage0)) begin
            ap_enable_reg_pp0_iter1 <= 1'b0;
        end else if (((1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
            ap_enable_reg_pp0_iter1 <= ap_start_int;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((icmp_ln490_fu_70_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            c4_2_fu_44 <= c4_3_fu_76_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            c4_2_fu_44 <= 4'd0;
        end
    end
end

always @ (*) begin
    if (((icmp_ln490_fu_70_p2 == 1'd1) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b1;
    end else begin
        ap_condition_exit_pp0_iter0_stage0 = 1'b0;
    end
end

always @ (*) begin
    if (((ap_loop_exit_ready == 1'b1) & (1'b0 == ap_block_pp0_stage0_subdone) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_done_int = 1'b1;
    end else begin
        ap_done_int = ap_done_reg;
    end
end

always @ (*) begin
    if (((ap_idle_pp0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0) & (ap_start_int == 1'b0))) begin
        ap_idle = 1'b1;
    end else begin
        ap_idle = 1'b0;
    end
end

always @ (*) begin
    if (((ap_enable_reg_pp0_iter1 == 1'b0) & (ap_enable_reg_pp0_iter0 == 1'b0))) begin
        ap_idle_pp0 = 1'b1;
    end else begin
        ap_idle_pp0 = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_ready_int = 1'b1;
    end else begin
        ap_ready_int = 1'b0;
    end
end

always @ (*) begin
    if (((ap_loop_init == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_sig_allocacmp_c4 = 4'd0;
    end else begin
        ap_sig_allocacmp_c4 = c4_2_fu_44;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        fifo_B_B_IO_L2_in_0_blk_n = fifo_B_B_IO_L2_in_0_empty_n;
    end else begin
        fifo_B_B_IO_L2_in_0_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        fifo_B_B_IO_L2_in_0_read = 1'b1;
    end else begin
        fifo_B_B_IO_L2_in_0_read = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        fifo_B_B_IO_L2_in_1_blk_n = fifo_B_B_IO_L2_in_1_full_n;
    end else begin
        fifo_B_B_IO_L2_in_1_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        fifo_B_B_IO_L2_in_1_write = 1'b1;
    end else begin
        fifo_B_B_IO_L2_in_1_write = 1'b0;
    end
end

always @ (*) begin
    case (ap_CS_fsm)
        ap_ST_fsm_pp0_stage0 : begin
            ap_NS_fsm = ap_ST_fsm_pp0_stage0;
        end
        default : begin
            ap_NS_fsm = 'bx;
        end
    endcase
end

assign ap_CS_fsm_pp0_stage0 = ap_CS_fsm[32'd0];

assign ap_block_pp0_stage0 = ~(1'b1 == 1'b1);

always @ (*) begin
    ap_block_pp0_stage0_01001 = ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state2_pp0_stage0_iter1));
end

always @ (*) begin
    ap_block_pp0_stage0_11001 = ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state2_pp0_stage0_iter1));
end

always @ (*) begin
    ap_block_pp0_stage0_subdone = ((ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_block_state2_pp0_stage0_iter1));
end

always @ (*) begin
    ap_block_state2_pp0_stage0_iter1 = ((fifo_B_B_IO_L2_in_1_full_n == 1'b0) | (fifo_B_B_IO_L2_in_0_empty_n == 1'b0));
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start_int;

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage0;

assign c4_3_fu_76_p2 = (ap_sig_allocacmp_c4 + 4'd1);

assign fifo_B_B_IO_L2_in_1_din = fifo_B_B_IO_L2_in_0_dout;

assign icmp_ln490_fu_70_p2 = ((ap_sig_allocacmp_c4 == 4'd8) ? 1'b1 : 1'b0);

endmodule //kernel0_B_IO_L2_in_inter_trans_Pipeline_VITIS_LOOP_490_3
