// ==============================================================
// Generated by Vitis HLS v2023.2
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
// ==============================================================

`timescale 1 ns / 1 ps 

module kernel0_A_IO_L2_in_intra_trans_Pipeline_VITIS_LOOP_95_1_VITIS_LOOP_97_2_VITIS_LOOP_99_3 (
        ap_clk,
        ap_rst,
        ap_start,
        ap_done,
        ap_idle,
        ap_ready,
        fifo_A_PE_1_0_din,
        fifo_A_PE_1_0_num_data_valid,
        fifo_A_PE_1_0_fifo_cap,
        fifo_A_PE_1_0_full_n,
        fifo_A_PE_1_0_write,
        local_A_address0,
        local_A_ce0,
        local_A_q0
);

parameter    ap_ST_fsm_pp0_stage0 = 1'd1;

input   ap_clk;
input   ap_rst;
input   ap_start;
output   ap_done;
output   ap_idle;
output   ap_ready;
output  [63:0] fifo_A_PE_1_0_din;
input  [2:0] fifo_A_PE_1_0_num_data_valid;
input  [2:0] fifo_A_PE_1_0_fifo_cap;
input   fifo_A_PE_1_0_full_n;
output   fifo_A_PE_1_0_write;
output  [2:0] local_A_address0;
output   local_A_ce0;
input  [511:0] local_A_q0;

reg ap_idle;
reg fifo_A_PE_1_0_write;
reg local_A_ce0;

(* fsm_encoding = "none" *) reg   [0:0] ap_CS_fsm;
wire    ap_CS_fsm_pp0_stage0;
wire    ap_enable_reg_pp0_iter0;
reg    ap_enable_reg_pp0_iter1;
reg    ap_idle_pp0;
reg    ap_block_state2_pp0_stage0_iter1;
reg    ap_block_pp0_stage0_subdone;
wire   [0:0] icmp_ln95_fu_173_p2;
reg    ap_condition_exit_pp0_iter0_stage0;
wire    ap_loop_exit_ready;
reg    ap_ready_int;
reg    fifo_A_PE_1_0_blk_n;
wire    ap_block_pp0_stage0;
wire   [2:0] empty_fu_258_p1;
reg   [2:0] empty_reg_462;
reg    ap_block_pp0_stage0_11001;
wire   [63:0] zext_ln105_fu_272_p1;
reg   [3:0] c7_fu_114;
wire   [3:0] add_ln99_fu_277_p2;
wire    ap_loop_init;
reg   [3:0] ap_sig_allocacmp_c7_load;
reg   [7:0] indvar_flatten_fu_118;
wire   [7:0] select_ln97_1_fu_289_p3;
reg   [7:0] ap_sig_allocacmp_indvar_flatten_load;
reg   [3:0] c5_fu_122;
wire   [3:0] select_ln95_fu_224_p3;
reg   [3:0] ap_sig_allocacmp_c5_load;
reg   [9:0] indvar_flatten12_fu_126;
wire   [9:0] add_ln95_1_fu_179_p2;
reg   [9:0] ap_sig_allocacmp_indvar_flatten12_load;
wire   [63:0] p_0_fu_391_p19;
reg    ap_block_pp0_stage0_01001;
wire   [0:0] icmp_ln97_fu_200_p2;
wire   [0:0] icmp_ln99_fu_212_p2;
wire   [0:0] xor_ln95_fu_206_p2;
wire   [3:0] add_ln95_fu_194_p2;
wire   [0:0] and_ln95_fu_218_p2;
wire   [0:0] or_ln97_fu_232_p2;
wire   [0:0] tmp_fu_246_p3;
wire   [3:0] select_ln97_fu_238_p3;
wire   [2:0] trunc_ln105_fu_262_p1;
wire   [2:0] p_cast_fu_254_p1;
wire   [2:0] add_ln105_fu_266_p2;
wire   [7:0] add_ln97_fu_283_p2;
wire   [63:0] p_0_fu_391_p2;
wire   [63:0] p_0_fu_391_p4;
wire   [63:0] p_0_fu_391_p6;
wire   [63:0] p_0_fu_391_p8;
wire   [63:0] p_0_fu_391_p10;
wire   [63:0] p_0_fu_391_p12;
wire   [63:0] p_0_fu_391_p14;
wire   [63:0] p_0_fu_391_p16;
wire   [63:0] p_0_fu_391_p17;
reg    ap_done_reg;
wire    ap_continue_int;
reg    ap_done_int;
reg   [0:0] ap_NS_fsm;
wire    ap_enable_pp0;
wire    ap_start_int;
wire   [2:0] p_0_fu_391_p1;
wire   [2:0] p_0_fu_391_p3;
wire   [2:0] p_0_fu_391_p5;
wire   [2:0] p_0_fu_391_p7;
wire  signed [2:0] p_0_fu_391_p9;
wire  signed [2:0] p_0_fu_391_p11;
wire  signed [2:0] p_0_fu_391_p13;
wire  signed [2:0] p_0_fu_391_p15;
wire    ap_ce_reg;

// power-on initialization
initial begin
#0 ap_CS_fsm = 1'd1;
#0 ap_enable_reg_pp0_iter1 = 1'b0;
#0 c7_fu_114 = 4'd0;
#0 indvar_flatten_fu_118 = 8'd0;
#0 c5_fu_122 = 4'd0;
#0 indvar_flatten12_fu_126 = 10'd0;
#0 ap_done_reg = 1'b0;
end

kernel0_sparsemux_17_3_64_1_1 #(
    .ID( 1 ),
    .NUM_STAGE( 1 ),
    .CASE0( 3'h0 ),
    .din0_WIDTH( 64 ),
    .CASE1( 3'h1 ),
    .din1_WIDTH( 64 ),
    .CASE2( 3'h2 ),
    .din2_WIDTH( 64 ),
    .CASE3( 3'h3 ),
    .din3_WIDTH( 64 ),
    .CASE4( 3'h4 ),
    .din4_WIDTH( 64 ),
    .CASE5( 3'h5 ),
    .din5_WIDTH( 64 ),
    .CASE6( 3'h6 ),
    .din6_WIDTH( 64 ),
    .CASE7( 3'h7 ),
    .din7_WIDTH( 64 ),
    .def_WIDTH( 64 ),
    .sel_WIDTH( 3 ),
    .dout_WIDTH( 64 ))
sparsemux_17_3_64_1_1_U15(
    .din0(p_0_fu_391_p2),
    .din1(p_0_fu_391_p4),
    .din2(p_0_fu_391_p6),
    .din3(p_0_fu_391_p8),
    .din4(p_0_fu_391_p10),
    .din5(p_0_fu_391_p12),
    .din6(p_0_fu_391_p14),
    .din7(p_0_fu_391_p16),
    .def(p_0_fu_391_p17),
    .sel(empty_reg_462),
    .dout(p_0_fu_391_p19)
);

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
        if (((icmp_ln95_fu_173_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            c5_fu_122 <= select_ln95_fu_224_p3;
        end else if ((ap_loop_init == 1'b1)) begin
            c5_fu_122 <= 4'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((icmp_ln95_fu_173_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            c7_fu_114 <= add_ln99_fu_277_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            c7_fu_114 <= 4'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((icmp_ln95_fu_173_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            indvar_flatten12_fu_126 <= add_ln95_1_fu_179_p2;
        end else if ((ap_loop_init == 1'b1)) begin
            indvar_flatten12_fu_126 <= 10'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        if (((icmp_ln95_fu_173_p2 == 1'd0) & (ap_enable_reg_pp0_iter0 == 1'b1))) begin
            indvar_flatten_fu_118 <= select_ln97_1_fu_289_p3;
        end else if ((ap_loop_init == 1'b1)) begin
            indvar_flatten_fu_118 <= 8'd0;
        end
    end
end

always @ (posedge ap_clk) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        empty_reg_462 <= empty_fu_258_p1;
    end
end

always @ (*) begin
    if (((icmp_ln95_fu_173_p2 == 1'd1) & (1'b0 == ap_block_pp0_stage0_subdone) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
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
    if (((ap_start_int == 1'b0) & (ap_idle_pp0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
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
        ap_sig_allocacmp_c5_load = c5_fu_122;
    end
end

always @ (*) begin
    if (((ap_loop_init == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_sig_allocacmp_c7_load = 4'd0;
    end else begin
        ap_sig_allocacmp_c7_load = c7_fu_114;
    end
end

always @ (*) begin
    if (((ap_loop_init == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_sig_allocacmp_indvar_flatten12_load = 10'd0;
    end else begin
        ap_sig_allocacmp_indvar_flatten12_load = indvar_flatten12_fu_126;
    end
end

always @ (*) begin
    if (((ap_loop_init == 1'b1) & (1'b0 == ap_block_pp0_stage0) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        ap_sig_allocacmp_indvar_flatten_load = 8'd0;
    end else begin
        ap_sig_allocacmp_indvar_flatten_load = indvar_flatten_fu_118;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        fifo_A_PE_1_0_blk_n = fifo_A_PE_1_0_full_n;
    end else begin
        fifo_A_PE_1_0_blk_n = 1'b1;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter1 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        fifo_A_PE_1_0_write = 1'b1;
    end else begin
        fifo_A_PE_1_0_write = 1'b0;
    end
end

always @ (*) begin
    if (((1'b0 == ap_block_pp0_stage0_11001) & (ap_enable_reg_pp0_iter0 == 1'b1) & (1'b1 == ap_CS_fsm_pp0_stage0))) begin
        local_A_ce0 = 1'b1;
    end else begin
        local_A_ce0 = 1'b0;
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

assign add_ln105_fu_266_p2 = (trunc_ln105_fu_262_p1 + p_cast_fu_254_p1);

assign add_ln95_1_fu_179_p2 = (ap_sig_allocacmp_indvar_flatten12_load + 10'd1);

assign add_ln95_fu_194_p2 = (ap_sig_allocacmp_c5_load + 4'd1);

assign add_ln97_fu_283_p2 = (ap_sig_allocacmp_indvar_flatten_load + 8'd1);

assign add_ln99_fu_277_p2 = (select_ln97_fu_238_p3 + 4'd1);

assign and_ln95_fu_218_p2 = (xor_ln95_fu_206_p2 & icmp_ln99_fu_212_p2);

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
    ap_block_state2_pp0_stage0_iter1 = (fifo_A_PE_1_0_full_n == 1'b0);
end

assign ap_enable_pp0 = (ap_idle_pp0 ^ 1'b1);

assign ap_enable_reg_pp0_iter0 = ap_start_int;

assign ap_loop_exit_ready = ap_condition_exit_pp0_iter0_stage0;

assign empty_fu_258_p1 = select_ln95_fu_224_p3[2:0];

assign fifo_A_PE_1_0_din = p_0_fu_391_p19;

assign icmp_ln95_fu_173_p2 = ((ap_sig_allocacmp_indvar_flatten12_load == 10'd512) ? 1'b1 : 1'b0);

assign icmp_ln97_fu_200_p2 = ((ap_sig_allocacmp_indvar_flatten_load == 8'd64) ? 1'b1 : 1'b0);

assign icmp_ln99_fu_212_p2 = ((ap_sig_allocacmp_c7_load == 4'd8) ? 1'b1 : 1'b0);

assign local_A_address0 = zext_ln105_fu_272_p1;

assign or_ln97_fu_232_p2 = (icmp_ln97_fu_200_p2 | and_ln95_fu_218_p2);

assign p_0_fu_391_p10 = {{local_A_q0[319:256]}};

assign p_0_fu_391_p12 = {{local_A_q0[383:320]}};

assign p_0_fu_391_p14 = {{local_A_q0[447:384]}};

assign p_0_fu_391_p16 = {{local_A_q0[511:448]}};

assign p_0_fu_391_p17 = 'bx;

assign p_0_fu_391_p2 = local_A_q0[63:0];

assign p_0_fu_391_p4 = {{local_A_q0[127:64]}};

assign p_0_fu_391_p6 = {{local_A_q0[191:128]}};

assign p_0_fu_391_p8 = {{local_A_q0[255:192]}};

assign p_cast_fu_254_p1 = tmp_fu_246_p3;

assign select_ln95_fu_224_p3 = ((icmp_ln97_fu_200_p2[0:0] == 1'b1) ? add_ln95_fu_194_p2 : ap_sig_allocacmp_c5_load);

assign select_ln97_1_fu_289_p3 = ((icmp_ln97_fu_200_p2[0:0] == 1'b1) ? 8'd1 : add_ln97_fu_283_p2);

assign select_ln97_fu_238_p3 = ((or_ln97_fu_232_p2[0:0] == 1'b1) ? 4'd0 : ap_sig_allocacmp_c7_load);

assign tmp_fu_246_p3 = select_ln95_fu_224_p3[32'd3];

assign trunc_ln105_fu_262_p1 = select_ln97_fu_238_p3[2:0];

assign xor_ln95_fu_206_p2 = (icmp_ln97_fu_200_p2 ^ 1'd1);

assign zext_ln105_fu_272_p1 = add_ln105_fu_266_p2;

endmodule //kernel0_A_IO_L2_in_intra_trans_Pipeline_VITIS_LOOP_95_1_VITIS_LOOP_97_2_VITIS_LOOP_99_3
