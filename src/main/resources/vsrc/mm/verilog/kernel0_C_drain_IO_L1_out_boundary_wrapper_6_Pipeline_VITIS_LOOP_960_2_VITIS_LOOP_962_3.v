// ==============================================================
// Generated by Vitis HLS v2023.2
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps 

module kernel0_C_drain_IO_L1_out_boundary_wrapper_6_Pipeline_VITIS_LOOP_960_2_VITIS_LOOP_962_3 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        fifo_C_drain_C_drain_IO_L1_out_1_1_din,
        fifo_C_drain_C_drain_IO_L1_out_1_1_num_data_valid,
        fifo_C_drain_C_drain_IO_L1_out_1_1_fifo_cap,
        fifo_C_drain_C_drain_IO_L1_out_1_1_full_n,
        fifo_C_drain_C_drain_IO_L1_out_1_1_write,
        local_C_address0,
        local_C_ce0,
        local_C_q0
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
output  [127:0] fifo_C_drain_C_drain_IO_L1_out_1_1_din;
input  [2:0] fifo_C_drain_C_drain_IO_L1_out_1_1_num_data_valid;
input  [2:0] fifo_C_drain_C_drain_IO_L1_out_1_1_fifo_cap;
input   fifo_C_drain_C_drain_IO_L1_out_1_1_full_n;
output   fifo_C_drain_C_drain_IO_L1_out_1_1_write;
output  [3:0] local_C_address0;
output   local_C_ce0;
input  [127:0] local_C_q0;

reg ap_idle;
reg fifo_C_drain_C_drain_IO_L1_out_1_1_write;
reg local_C_ce0;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_idle_pp0;
reg    ap_block_state2_pp0_stage0_iter1;
reg    ap_block_pp0_stage0_subdone;
wire   [0:0] icmp_ln960_fu_107_p2;
reg    ap_condition_exit_pp0_iter0_stage0;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
reg    fifo_C_drain_C_drain_IO_L1_out_1_1_blk_n;
wire    ap_block_pp0_stage0;
reg    ap_block_pp0_stage0_11001;
wire   [63:0] zext_ln967_2_fu_169_p1;
reg   [1:0] c6_fu_56;
wire   [1:0] add_ln962_fu_174_p2;
wire    ap_loop_init;
reg   [1:0] ap_sig_allocacmp_c6_load;
reg   [3:0] c5_fu_60;
wire   [3:0] select_ln960_1_fu_145_p3;
reg   [3:0] ap_sig_allocacmp_c5_load;
reg   [4:0] indvar_flatten6_fu_64;
wire   [4:0] add_ln960_1_fu_113_p2;
reg   [4:0] ap_sig_allocacmp_indvar_flatten6_load;
reg    ap_block_pp0_stage0_01001;
wire   [0:0] icmp_ln962_fu_131_p2;
wire   [3:0] add_ln960_fu_125_p2;
wire   [1:0] select_ln960_fu_137_p3;
wire   [3:0] shl_ln967_fu_153_p2;
wire   [3:0] zext_ln967_fu_159_p1;
wire   [3:0] add_ln967_fu_163_p2;
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
#0 c6_fu_56 = 2'd0;
#0 c5_fu_60 = 4'd0;
#0 indvar_flatten6_fu_64 = 5'd0;
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
        if (((icmp_ln960_fu_107_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            c5_fu_60 <= select_ln960_1_fu_145_p3;
        end else if ((ap_loop_init == 1'b1)) begin
            c5_fu_60 <= 4'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((icmp_ln960_fu_107_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            c6_fu_56 <= add_ln962_fu_174_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            c6_fu_56 <= 2'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((icmp_ln960_fu_107_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            indvar_flatten6_fu_64 <= add_ln960_1_fu_113_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            indvar_flatten6_fu_64 <= 5'd0;
        end
    end
end

always @ (*) begin
    if (((icmp_ln960_fu_107_p2 == 1'd1) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
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
        ap_sig_allocacmp_c5_load = 4'd0;
    end else begin
        ap_sig_allocacmp_c5_load = c5_fu_60;
    end
end

always @ (*) begin
    if (((ap_loop_init == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_sig_allocacmp_c6_load = 2'd0;
    end else begin
        ap_sig_allocacmp_c6_load = c6_fu_56;
    end
end

always @ (*) begin
    if (((ap_loop_init == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_sig_allocacmp_indvar_flatten6_load = 5'd0;
    end else begin
        ap_sig_allocacmp_indvar_flatten6_load = indvar_flatten6_fu_64;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        fifo_C_drain_C_drain_IO_L1_out_1_1_blk_n = fifo_C_drain_C_drain_IO_L1_out_1_1_full_n;
    end else begin
        fifo_C_drain_C_drain_IO_L1_out_1_1_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        fifo_C_drain_C_drain_IO_L1_out_1_1_write = 1'b1;
    end else begin
        fifo_C_drain_C_drain_IO_L1_out_1_1_write = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        local_C_ce0 = 1'b1;
    end else begin
        local_C_ce0 = 1'b0;
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

assign add_ln960_1_fu_113_p2 = (ap_sig_allocacmp_indvar_flatten6_load + 5'd1);

assign add_ln960_fu_125_p2 = (ap_sig_allocacmp_c5_load + 4'd1);

assign add_ln962_fu_174_p2 = (select_ln960_fu_137_p3 + 2'd1);

assign add_ln967_fu_163_p2 = (shl_ln967_fu_153_p2 + zext_ln967_fu_159_p1);

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
    ap_block_state2_pp0_stage0_iter1 = (fifo_C_drain_C_drain_IO_L1_out_1_1_full_n == 1'b0);
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start_int;

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage0;

assign fifo_C_drain_C_drain_IO_L1_out_1_1_din = local_C_q0;

assign icmp_ln960_fu_107_p2 = ((ap_sig_allocacmp_indvar_flatten6_load == 5'd16) ? 1'b1 : 1'b0);

assign icmp_ln962_fu_131_p2 = ((ap_sig_allocacmp_c6_load == 2'd2) ? 1'b1 : 1'b0);

assign local_C_address0 = zext_ln967_2_fu_169_p1;

assign select_ln960_1_fu_145_p3 = ((icmp_ln962_fu_131_p2[0:0] == 1'b1) ? add_ln960_fu_125_p2 : ap_sig_allocacmp_c5_load);

assign select_ln960_fu_137_p3 = ((icmp_ln962_fu_131_p2[0:0] == 1'b1) ? 2'd0 : ap_sig_allocacmp_c6_load);

assign shl_ln967_fu_153_p2 = select_ln960_1_fu_145_p3 << 4'd1;

assign zext_ln967_2_fu_169_p1 = add_ln967_fu_163_p2;

assign zext_ln967_fu_159_p1 = select_ln960_fu_137_p3;

endmodule //kernel0_C_drain_IO_L1_out_boundary_wrapper_6_Pipeline_VITIS_LOOP_960_2_VITIS_LOOP_962_3
