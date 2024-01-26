// sa_ram_rwsthp_80x72: synthesizable model wrapper
// Generated by /home/nvtools/branch/release/t194_rg/2017/06/01_10_25_11/nvtools/rams/scripts/ramgen - DO NOT EDIT
// Estimated area: 1770.44 um^2 (nvstd_tsmc16fflr)
// Option explanations:
// p:
// Causes read ports to have their outputs flopped.
// The 'ore' input is used as a load enable on the output flop
// stage. This flop stage tends to be nearly free, since some
// flops are generally required for testability purposes.
// s:
// Indicates that the ram is synchronous (i.e. all
// ports use the same clock). The one or more clk(_[rw])[0-9]*
// ports will be replaced with a single 'clk' port.
// h:
// Functional bypass option creates a bypass_di port and a control port.
// When the control is asserted, bypass_di is floped into the data register instead
// of RAM core output.
// t:
// Indicates that write-through capability is necessary.
// This allows a read of an entry that is currently being
// written to result in correct (new) data. This option is
// only allowed for synchronous rams, and usually results in a
// bypass path being built around the main storage.
// leda ELB072 off
`timescale 1ns / 10ps
module sa_ram_rwsthp_80x72 (
        clk,
        ra,
        re,
        ore,
        dout,
        wa,
        we,
        di,
        byp_sel,
        dbyp,
        pwrbus_ram_pd
        );
parameter FORCE_CONTENTION_ASSERTION_RESET_ACTIVE=1'b0;
// port list
input clk;
input [6:0] ra;
input re;
input ore;
output [71:0] dout;
input [6:0] wa;
input we;
input [71:0] di;
input byp_sel;
input [71:0] dbyp;
input [31:0] pwrbus_ram_pd;
// This wrapper consists of : 1 Ram cells: AUTOSARAMPDP_80X72_GL_M1_D2 ;
//Wires for Misc Ports
wire DFT_clamp;
//Wires for Mbist Ports
wire [6:0] mbist_Wa_w0;
wire [1:0] mbist_Di_w0;
wire mbist_we_w0;
wire [6:0] mbist_Ra_r0;
// verilint 528 off - Variable set but not used
wire [71:0] mbist_Do_r0_int_net;
// verilint 528 on - Variable set but not used
wire mbist_ce_r0;
wire mbist_en_sync;
//Wires for RamAccess Ports
wire SI;
// verilint 528 off - Variable set but not used
wire SO_int_net;
// verilint 528 on - Variable set but not used
wire shiftDR;
wire updateDR;
wire debug_mode;
//Wires for Misc Ports
wire mbist_ramaccess_rst_;
wire ary_atpg_ctl;
wire write_inh;
wire scan_ramtms;
wire iddq_mode;
wire jtag_readonly_mode;
wire ary_read_inh;
wire test_mode;
wire scan_en;
wire [7:0] svop;
// Use Bbox and clamps to clamp and tie off the DFT signals in the wrapper
SA_BLKBOX_SRC0 UI_enableDFTmode_async_ld_buf (.Y(DFT_clamp));
wire pre_mbist_Wa_w0_0;
SA_BLKBOX_SRC0_X testInst_mbist_Wa_w0_0 (.Y(pre_mbist_Wa_w0_0));
SA_AN2D4PO4 UJ_DFTQUALIFIER_mbist_Wa_w0_0 (.Z(mbist_Wa_w0[0]), .A1(pre_mbist_Wa_w0_0), .A2(DFT_clamp) );
wire pre_mbist_Wa_w0_1;
SA_BLKBOX_SRC0_X testInst_mbist_Wa_w0_1 (.Y(pre_mbist_Wa_w0_1));
SA_AN2D4PO4 UJ_DFTQUALIFIER_mbist_Wa_w0_1 (.Z(mbist_Wa_w0[1]), .A1(pre_mbist_Wa_w0_1), .A2(DFT_clamp) );
wire pre_mbist_Wa_w0_2;
SA_BLKBOX_SRC0_X testInst_mbist_Wa_w0_2 (.Y(pre_mbist_Wa_w0_2));
SA_AN2D4PO4 UJ_DFTQUALIFIER_mbist_Wa_w0_2 (.Z(mbist_Wa_w0[2]), .A1(pre_mbist_Wa_w0_2), .A2(DFT_clamp) );
wire pre_mbist_Wa_w0_3;
SA_BLKBOX_SRC0_X testInst_mbist_Wa_w0_3 (.Y(pre_mbist_Wa_w0_3));
SA_AN2D4PO4 UJ_DFTQUALIFIER_mbist_Wa_w0_3 (.Z(mbist_Wa_w0[3]), .A1(pre_mbist_Wa_w0_3), .A2(DFT_clamp) );
wire pre_mbist_Wa_w0_4;
SA_BLKBOX_SRC0_X testInst_mbist_Wa_w0_4 (.Y(pre_mbist_Wa_w0_4));
SA_AN2D4PO4 UJ_DFTQUALIFIER_mbist_Wa_w0_4 (.Z(mbist_Wa_w0[4]), .A1(pre_mbist_Wa_w0_4), .A2(DFT_clamp) );
wire pre_mbist_Wa_w0_5;
SA_BLKBOX_SRC0_X testInst_mbist_Wa_w0_5 (.Y(pre_mbist_Wa_w0_5));
SA_AN2D4PO4 UJ_DFTQUALIFIER_mbist_Wa_w0_5 (.Z(mbist_Wa_w0[5]), .A1(pre_mbist_Wa_w0_5), .A2(DFT_clamp) );
wire pre_mbist_Wa_w0_6;
SA_BLKBOX_SRC0_X testInst_mbist_Wa_w0_6 (.Y(pre_mbist_Wa_w0_6));
SA_AN2D4PO4 UJ_DFTQUALIFIER_mbist_Wa_w0_6 (.Z(mbist_Wa_w0[6]), .A1(pre_mbist_Wa_w0_6), .A2(DFT_clamp) );
wire pre_mbist_Di_w0_0;
SA_BLKBOX_SRC0_X testInst_mbist_Di_w0_0 (.Y(pre_mbist_Di_w0_0));
SA_AN2D4PO4 UJ_DFTQUALIFIER_mbist_Di_w0_0 (.Z(mbist_Di_w0[0]), .A1(pre_mbist_Di_w0_0), .A2(DFT_clamp) );
wire pre_mbist_Di_w0_1;
SA_BLKBOX_SRC0_X testInst_mbist_Di_w0_1 (.Y(pre_mbist_Di_w0_1));
SA_AN2D4PO4 UJ_DFTQUALIFIER_mbist_Di_w0_1 (.Z(mbist_Di_w0[1]), .A1(pre_mbist_Di_w0_1), .A2(DFT_clamp) );
wire pre_mbist_we_w0;
SA_BLKBOX_SRC0_X testInst_mbist_we_w0 (.Y(pre_mbist_we_w0));
SA_AN2D4PO4 UJ_DFTQUALIFIER_mbist_we_w0 (.Z(mbist_we_w0), .A1(pre_mbist_we_w0), .A2(DFT_clamp) );
wire pre_mbist_Ra_r0_0;
SA_BLKBOX_SRC0_X testInst_mbist_Ra_r0_0 (.Y(pre_mbist_Ra_r0_0));
SA_AN2D4PO4 UJ_DFTQUALIFIER_mbist_Ra_r0_0 (.Z(mbist_Ra_r0[0]), .A1(pre_mbist_Ra_r0_0), .A2(DFT_clamp) );
wire pre_mbist_Ra_r0_1;
SA_BLKBOX_SRC0_X testInst_mbist_Ra_r0_1 (.Y(pre_mbist_Ra_r0_1));
SA_AN2D4PO4 UJ_DFTQUALIFIER_mbist_Ra_r0_1 (.Z(mbist_Ra_r0[1]), .A1(pre_mbist_Ra_r0_1), .A2(DFT_clamp) );
wire pre_mbist_Ra_r0_2;
SA_BLKBOX_SRC0_X testInst_mbist_Ra_r0_2 (.Y(pre_mbist_Ra_r0_2));
SA_AN2D4PO4 UJ_DFTQUALIFIER_mbist_Ra_r0_2 (.Z(mbist_Ra_r0[2]), .A1(pre_mbist_Ra_r0_2), .A2(DFT_clamp) );
wire pre_mbist_Ra_r0_3;
SA_BLKBOX_SRC0_X testInst_mbist_Ra_r0_3 (.Y(pre_mbist_Ra_r0_3));
SA_AN2D4PO4 UJ_DFTQUALIFIER_mbist_Ra_r0_3 (.Z(mbist_Ra_r0[3]), .A1(pre_mbist_Ra_r0_3), .A2(DFT_clamp) );
wire pre_mbist_Ra_r0_4;
SA_BLKBOX_SRC0_X testInst_mbist_Ra_r0_4 (.Y(pre_mbist_Ra_r0_4));
SA_AN2D4PO4 UJ_DFTQUALIFIER_mbist_Ra_r0_4 (.Z(mbist_Ra_r0[4]), .A1(pre_mbist_Ra_r0_4), .A2(DFT_clamp) );
wire pre_mbist_Ra_r0_5;
SA_BLKBOX_SRC0_X testInst_mbist_Ra_r0_5 (.Y(pre_mbist_Ra_r0_5));
SA_AN2D4PO4 UJ_DFTQUALIFIER_mbist_Ra_r0_5 (.Z(mbist_Ra_r0[5]), .A1(pre_mbist_Ra_r0_5), .A2(DFT_clamp) );
wire pre_mbist_Ra_r0_6;
SA_BLKBOX_SRC0_X testInst_mbist_Ra_r0_6 (.Y(pre_mbist_Ra_r0_6));
SA_AN2D4PO4 UJ_DFTQUALIFIER_mbist_Ra_r0_6 (.Z(mbist_Ra_r0[6]), .A1(pre_mbist_Ra_r0_6), .A2(DFT_clamp) );
SA_BLKBOX_SINK testInst_mbist_Do_r0_0 (.A(mbist_Do_r0_int_net[0]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_1 (.A(mbist_Do_r0_int_net[1]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_2 (.A(mbist_Do_r0_int_net[2]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_3 (.A(mbist_Do_r0_int_net[3]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_4 (.A(mbist_Do_r0_int_net[4]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_5 (.A(mbist_Do_r0_int_net[5]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_6 (.A(mbist_Do_r0_int_net[6]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_7 (.A(mbist_Do_r0_int_net[7]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_8 (.A(mbist_Do_r0_int_net[8]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_9 (.A(mbist_Do_r0_int_net[9]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_10 (.A(mbist_Do_r0_int_net[10]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_11 (.A(mbist_Do_r0_int_net[11]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_12 (.A(mbist_Do_r0_int_net[12]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_13 (.A(mbist_Do_r0_int_net[13]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_14 (.A(mbist_Do_r0_int_net[14]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_15 (.A(mbist_Do_r0_int_net[15]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_16 (.A(mbist_Do_r0_int_net[16]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_17 (.A(mbist_Do_r0_int_net[17]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_18 (.A(mbist_Do_r0_int_net[18]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_19 (.A(mbist_Do_r0_int_net[19]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_20 (.A(mbist_Do_r0_int_net[20]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_21 (.A(mbist_Do_r0_int_net[21]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_22 (.A(mbist_Do_r0_int_net[22]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_23 (.A(mbist_Do_r0_int_net[23]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_24 (.A(mbist_Do_r0_int_net[24]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_25 (.A(mbist_Do_r0_int_net[25]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_26 (.A(mbist_Do_r0_int_net[26]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_27 (.A(mbist_Do_r0_int_net[27]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_28 (.A(mbist_Do_r0_int_net[28]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_29 (.A(mbist_Do_r0_int_net[29]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_30 (.A(mbist_Do_r0_int_net[30]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_31 (.A(mbist_Do_r0_int_net[31]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_32 (.A(mbist_Do_r0_int_net[32]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_33 (.A(mbist_Do_r0_int_net[33]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_34 (.A(mbist_Do_r0_int_net[34]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_35 (.A(mbist_Do_r0_int_net[35]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_36 (.A(mbist_Do_r0_int_net[36]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_37 (.A(mbist_Do_r0_int_net[37]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_38 (.A(mbist_Do_r0_int_net[38]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_39 (.A(mbist_Do_r0_int_net[39]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_40 (.A(mbist_Do_r0_int_net[40]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_41 (.A(mbist_Do_r0_int_net[41]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_42 (.A(mbist_Do_r0_int_net[42]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_43 (.A(mbist_Do_r0_int_net[43]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_44 (.A(mbist_Do_r0_int_net[44]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_45 (.A(mbist_Do_r0_int_net[45]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_46 (.A(mbist_Do_r0_int_net[46]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_47 (.A(mbist_Do_r0_int_net[47]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_48 (.A(mbist_Do_r0_int_net[48]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_49 (.A(mbist_Do_r0_int_net[49]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_50 (.A(mbist_Do_r0_int_net[50]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_51 (.A(mbist_Do_r0_int_net[51]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_52 (.A(mbist_Do_r0_int_net[52]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_53 (.A(mbist_Do_r0_int_net[53]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_54 (.A(mbist_Do_r0_int_net[54]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_55 (.A(mbist_Do_r0_int_net[55]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_56 (.A(mbist_Do_r0_int_net[56]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_57 (.A(mbist_Do_r0_int_net[57]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_58 (.A(mbist_Do_r0_int_net[58]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_59 (.A(mbist_Do_r0_int_net[59]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_60 (.A(mbist_Do_r0_int_net[60]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_61 (.A(mbist_Do_r0_int_net[61]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_62 (.A(mbist_Do_r0_int_net[62]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_63 (.A(mbist_Do_r0_int_net[63]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_64 (.A(mbist_Do_r0_int_net[64]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_65 (.A(mbist_Do_r0_int_net[65]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_66 (.A(mbist_Do_r0_int_net[66]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_67 (.A(mbist_Do_r0_int_net[67]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_68 (.A(mbist_Do_r0_int_net[68]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_69 (.A(mbist_Do_r0_int_net[69]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_70 (.A(mbist_Do_r0_int_net[70]));
SA_BLKBOX_SINK testInst_mbist_Do_r0_71 (.A(mbist_Do_r0_int_net[71]));
wire pre_mbist_ce_r0;
SA_BLKBOX_SRC0_X testInst_mbist_ce_r0 (.Y(pre_mbist_ce_r0));
SA_AN2D4PO4 UJ_DFTQUALIFIER_mbist_ce_r0 (.Z(mbist_ce_r0), .A1(pre_mbist_ce_r0), .A2(DFT_clamp) );
wire pre_mbist_en_sync;
SA_BLKBOX_SRC0_X testInst_mbist_en_sync (.Y(pre_mbist_en_sync));
SA_AN2D4PO4 UJ_DFTQUALIFIER_mbist_en_sync (.Z(mbist_en_sync), .A1(pre_mbist_en_sync), .A2(DFT_clamp) );
wire pre_SI;
SA_BLKBOX_SRC0_X testInst_SI (.Y(pre_SI));
SA_AN2D4PO4 UJ_DFTQUALIFIER_SI (.Z(SI), .A1(pre_SI), .A2(DFT_clamp) );
SA_BLKBOX_SINK testInst_SO (.A(SO_int_net));
wire pre_shiftDR;
SA_BLKBOX_SRC0_X testInst_shiftDR (.Y(pre_shiftDR));
SA_AN2D4PO4 UJ_DFTQUALIFIER_shiftDR (.Z(shiftDR), .A1(pre_shiftDR), .A2(DFT_clamp) );
wire pre_updateDR;
SA_BLKBOX_SRC0_X testInst_updateDR (.Y(pre_updateDR));
SA_AN2D4PO4 UJ_DFTQUALIFIER_updateDR (.Z(updateDR), .A1(pre_updateDR), .A2(DFT_clamp) );
wire pre_debug_mode;
SA_BLKBOX_SRC0_X testInst_debug_mode (.Y(pre_debug_mode));
SA_AN2D4PO4 UJ_DFTQUALIFIER_debug_mode (.Z(debug_mode), .A1(pre_debug_mode), .A2(DFT_clamp) );
wire pre_mbist_ramaccess_rst_;
SA_BLKBOX_SRC0_X testInst_mbist_ramaccess_rst_ (.Y(pre_mbist_ramaccess_rst_));
SA_AN2D4PO4 UJ_DFTQUALIFIER_mbist_ramaccess_rst_ (.Z(mbist_ramaccess_rst_), .A1(pre_mbist_ramaccess_rst_), .A2(DFT_clamp) );
wire pre_ary_atpg_ctl;
SA_BLKBOX_SRC0_X testInst_ary_atpg_ctl (.Y(pre_ary_atpg_ctl));
SA_AN2D4PO4 UJ_DFTQUALIFIER_ary_atpg_ctl (.Z(ary_atpg_ctl), .A1(pre_ary_atpg_ctl), .A2(DFT_clamp) );
wire pre_write_inh;
SA_BLKBOX_SRC0_X testInst_write_inh (.Y(pre_write_inh));
SA_AN2D4PO4 UJ_DFTQUALIFIER_write_inh (.Z(write_inh), .A1(pre_write_inh), .A2(DFT_clamp) );
wire pre_scan_ramtms;
SA_BLKBOX_SRC0_X testInst_scan_ramtms (.Y(pre_scan_ramtms));
SA_AN2D4PO4 UJ_DFTQUALIFIER_scan_ramtms (.Z(scan_ramtms), .A1(pre_scan_ramtms), .A2(DFT_clamp) );
wire pre_iddq_mode;
SA_BLKBOX_SRC0_X testInst_iddq_mode (.Y(pre_iddq_mode));
SA_AN2D4PO4 UJ_DFTQUALIFIER_iddq_mode (.Z(iddq_mode), .A1(pre_iddq_mode), .A2(DFT_clamp) );
wire pre_jtag_readonly_mode;
SA_BLKBOX_SRC0_X testInst_jtag_readonly_mode (.Y(pre_jtag_readonly_mode));
SA_AN2D4PO4 UJ_DFTQUALIFIER_jtag_readonly_mode (.Z(jtag_readonly_mode), .A1(pre_jtag_readonly_mode), .A2(DFT_clamp) );
wire pre_ary_read_inh;
SA_BLKBOX_SRC0_X testInst_ary_read_inh (.Y(pre_ary_read_inh));
SA_AN2D4PO4 UJ_DFTQUALIFIER_ary_read_inh (.Z(ary_read_inh), .A1(pre_ary_read_inh), .A2(DFT_clamp) );
wire pre_test_mode;
SA_BLKBOX_SRC0_X testInst_test_mode (.Y(pre_test_mode));
SA_AN2D4PO4 UJ_DFTQUALIFIER_test_mode (.Z(test_mode), .A1(pre_test_mode), .A2(DFT_clamp) );
wire pre_scan_en;
SA_BLKBOX_SRC0_X testInst_scan_en (.Y(pre_scan_en));
SA_AN2D4PO4 UJ_DFTQUALIFIER_scan_en (.Z(scan_en), .A1(pre_scan_en), .A2(DFT_clamp) );
SA_BLKBOX_SRC0 testInst_svop_0 (.Y(svop[0]));
SA_BLKBOX_SRC0 testInst_svop_1 (.Y(svop[1]));
SA_BLKBOX_SRC0 testInst_svop_2 (.Y(svop[2]));
SA_BLKBOX_SRC0 testInst_svop_3 (.Y(svop[3]));
SA_BLKBOX_SRC0 testInst_svop_4 (.Y(svop[4]));
SA_BLKBOX_SRC0 testInst_svop_5 (.Y(svop[5]));
SA_BLKBOX_SRC0 testInst_svop_6 (.Y(svop[6]));
SA_BLKBOX_SRC0 testInst_svop_7 (.Y(svop[7]));
// Declare the wires for test signals
// Instantiating the internal logic module now
// verilint 402 off - inferred Reset must be a module port
sa_ram_rwsthp_80x72_logic #(FORCE_CONTENTION_ASSERTION_RESET_ACTIVE) r_sa_ram_rwsthp_80x72 (
                           .SI(SI), .SO_int_net(SO_int_net),
                           .ary_atpg_ctl(ary_atpg_ctl),
                           .ary_read_inh(ary_read_inh), .byp_sel(byp_sel),
                           .clk(clk), .dbyp(dbyp), .debug_mode(debug_mode),
                           .di(di), .dout(dout), .iddq_mode(iddq_mode),
                           .jtag_readonly_mode(jtag_readonly_mode),
                           .mbist_Di_w0(mbist_Di_w0),
                           .mbist_Do_r0_int_net(mbist_Do_r0_int_net),
                           .mbist_Ra_r0(mbist_Ra_r0), .mbist_Wa_w0(mbist_Wa_w0),
                           .mbist_ce_r0(mbist_ce_r0),
                           .mbist_en_sync(mbist_en_sync),
                           .mbist_ramaccess_rst_(mbist_ramaccess_rst_),
                           .mbist_we_w0(mbist_we_w0), .ore(ore),
                           .pwrbus_ram_pd(pwrbus_ram_pd), .ra(ra), .re(re),
                           .scan_en(scan_en), .scan_ramtms(scan_ramtms),
                           .shiftDR(shiftDR), .svop(svop), .test_mode(test_mode),
                           .updateDR(updateDR), .wa(wa), .we(we),
                           .write_inh(write_inh) );
// verilint 402 on - inferred Reset must be a module port
// synopsys dc_tcl_script_begin
// set_dont_touch [get_cells "testInst_SI"]
// set_dont_touch [get_cells "testInst_SO"]
// set_dont_touch [get_cells "testInst_ary_atpg_ctl"]
// set_dont_touch [get_cells "testInst_ary_read_inh"]
// set_dont_touch [get_cells "testInst_debug_mode"]
// set_dont_touch [get_cells "testInst_iddq_mode"]
// set_dont_touch [get_cells "testInst_jtag_readonly_mode"]
// set_dont_touch [get_cells "testInst_mbist_Di_w0_0"]
// set_dont_touch [get_cells "testInst_mbist_Di_w0_1"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_0"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_1"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_10"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_11"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_12"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_13"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_14"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_15"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_16"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_17"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_18"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_19"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_2"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_20"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_21"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_22"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_23"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_24"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_25"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_26"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_27"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_28"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_29"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_3"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_30"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_31"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_32"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_33"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_34"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_35"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_36"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_37"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_38"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_39"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_4"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_40"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_41"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_42"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_43"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_44"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_45"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_46"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_47"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_48"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_49"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_5"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_50"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_51"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_52"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_53"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_54"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_55"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_56"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_57"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_58"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_59"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_6"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_60"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_61"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_62"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_63"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_64"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_65"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_66"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_67"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_68"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_69"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_7"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_70"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_71"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_8"]
// set_dont_touch [get_cells "testInst_mbist_Do_r0_9"]
// set_dont_touch [get_cells "testInst_mbist_Ra_r0_0"]
// set_dont_touch [get_cells "testInst_mbist_Ra_r0_1"]
// set_dont_touch [get_cells "testInst_mbist_Ra_r0_2"]
// set_dont_touch [get_cells "testInst_mbist_Ra_r0_3"]
// set_dont_touch [get_cells "testInst_mbist_Ra_r0_4"]
// set_dont_touch [get_cells "testInst_mbist_Ra_r0_5"]
// set_dont_touch [get_cells "testInst_mbist_Ra_r0_6"]
// set_dont_touch [get_cells "testInst_mbist_Wa_w0_0"]
// set_dont_touch [get_cells "testInst_mbist_Wa_w0_1"]
// set_dont_touch [get_cells "testInst_mbist_Wa_w0_2"]
// set_dont_touch [get_cells "testInst_mbist_Wa_w0_3"]
// set_dont_touch [get_cells "testInst_mbist_Wa_w0_4"]
// set_dont_touch [get_cells "testInst_mbist_Wa_w0_5"]
// set_dont_touch [get_cells "testInst_mbist_Wa_w0_6"]
// set_dont_touch [get_cells "testInst_mbist_ce_r0"]
// set_dont_touch [get_cells "testInst_mbist_en_sync"]
// set_dont_touch [get_cells "testInst_mbist_ramaccess_rst_"]
// set_dont_touch [get_cells "testInst_mbist_we_w0"]
// set_dont_touch [get_cells "testInst_scan_en"]
// set_dont_touch [get_cells "testInst_scan_ramtms"]
// set_dont_touch [get_cells "testInst_shiftDR"]
// set_dont_touch [get_cells "testInst_svop_0"]
// set_dont_touch [get_cells "testInst_svop_1"]
// set_dont_touch [get_cells "testInst_svop_2"]
// set_dont_touch [get_cells "testInst_svop_3"]
// set_dont_touch [get_cells "testInst_svop_4"]
// set_dont_touch [get_cells "testInst_svop_5"]
// set_dont_touch [get_cells "testInst_svop_6"]
// set_dont_touch [get_cells "testInst_svop_7"]
// set_dont_touch [get_cells "testInst_test_mode"]
// set_dont_touch [get_cells "testInst_updateDR"]
// set_dont_touch [get_cells "testInst_write_inh"]
// synopsys dc_tcl_script_end
// synopsys dc_tcl_script_begin
// set_dont_touch [get_nets "SI"]
// set_dont_touch [get_nets "SO_int_net"]
// set_dont_touch [get_nets "ary_atpg_ctl"]
// set_dont_touch [get_nets "ary_read_inh"]
// set_dont_touch [get_nets "debug_mode"]
// set_dont_touch [get_nets "iddq_mode"]
// set_dont_touch [get_nets "jtag_readonly_mode"]
// set_dont_touch [get_nets "mbist_Di_w0"]
// set_dont_touch [get_nets "mbist_Do_r0_int_net"]
// set_dont_touch [get_nets "mbist_Ra_r0"]
// set_dont_touch [get_nets "mbist_Wa_w0"]
// set_dont_touch [get_nets "mbist_ce_r0"]
// set_dont_touch [get_nets "mbist_en_sync"]
// set_dont_touch [get_nets "mbist_ramaccess_rst_"]
// set_dont_touch [get_nets "mbist_we_w0"]
// set_dont_touch [get_nets "scan_en"]
// set_dont_touch [get_nets "scan_ramtms"]
// set_dont_touch [get_nets "shiftDR"]
// set_dont_touch [get_nets "svop"]
// set_dont_touch [get_nets "test_mode"]
// set_dont_touch [get_nets "updateDR"]
// set_dont_touch [get_nets "write_inh"]
// synopsys dc_tcl_script_end
`ifndef SYNTHESIS
task arrangement (output integer arrangment_string[71:0]);
  begin
    arrangment_string[0] = 0 ;
    arrangment_string[1] = 1 ;
    arrangment_string[2] = 2 ;
    arrangment_string[3] = 3 ;
    arrangment_string[4] = 4 ;
    arrangment_string[5] = 5 ;
    arrangment_string[6] = 6 ;
    arrangment_string[7] = 7 ;
    arrangment_string[8] = 8 ;
    arrangment_string[9] = 9 ;
    arrangment_string[10] = 10 ;
    arrangment_string[11] = 11 ;
    arrangment_string[12] = 12 ;
    arrangment_string[13] = 13 ;
    arrangment_string[14] = 14 ;
    arrangment_string[15] = 15 ;
    arrangment_string[16] = 16 ;
    arrangment_string[17] = 17 ;
    arrangment_string[18] = 18 ;
    arrangment_string[19] = 19 ;
    arrangment_string[20] = 20 ;
    arrangment_string[21] = 21 ;
    arrangment_string[22] = 22 ;
    arrangment_string[23] = 23 ;
    arrangment_string[24] = 24 ;
    arrangment_string[25] = 25 ;
    arrangment_string[26] = 26 ;
    arrangment_string[27] = 27 ;
    arrangment_string[28] = 28 ;
    arrangment_string[29] = 29 ;
    arrangment_string[30] = 30 ;
    arrangment_string[31] = 31 ;
    arrangment_string[32] = 32 ;
    arrangment_string[33] = 33 ;
    arrangment_string[34] = 34 ;
    arrangment_string[35] = 35 ;
    arrangment_string[36] = 36 ;
    arrangment_string[37] = 37 ;
    arrangment_string[38] = 38 ;
    arrangment_string[39] = 39 ;
    arrangment_string[40] = 40 ;
    arrangment_string[41] = 41 ;
    arrangment_string[42] = 42 ;
    arrangment_string[43] = 43 ;
    arrangment_string[44] = 44 ;
    arrangment_string[45] = 45 ;
    arrangment_string[46] = 46 ;
    arrangment_string[47] = 47 ;
    arrangment_string[48] = 48 ;
    arrangment_string[49] = 49 ;
    arrangment_string[50] = 50 ;
    arrangment_string[51] = 51 ;
    arrangment_string[52] = 52 ;
    arrangment_string[53] = 53 ;
    arrangment_string[54] = 54 ;
    arrangment_string[55] = 55 ;
    arrangment_string[56] = 56 ;
    arrangment_string[57] = 57 ;
    arrangment_string[58] = 58 ;
    arrangment_string[59] = 59 ;
    arrangment_string[60] = 60 ;
    arrangment_string[61] = 61 ;
    arrangment_string[62] = 62 ;
    arrangment_string[63] = 63 ;
    arrangment_string[64] = 64 ;
    arrangment_string[65] = 65 ;
    arrangment_string[66] = 66 ;
    arrangment_string[67] = 67 ;
    arrangment_string[68] = 68 ;
    arrangment_string[69] = 69 ;
    arrangment_string[70] = 70 ;
    arrangment_string[71] = 71 ;
  end
endtask
`endif
`ifndef SYNTHESIS
`ifndef NO_INIT_MEM_VAL_TASKS
`ifndef MEM_REG_NAME
 `define MEM_REG_NAME MX.mem
`endif
// Bit vector indicating which shadow addresses have been written
reg [79:0] shadow_written = 'b0;
// Shadow ram array used to store initialization values
reg [71:0] shadow_mem [79:0];
`ifdef SA_RAM_EXPAND_ARRAY
wire [71:0] shadow_mem_row0 = shadow_mem[0];
wire [71:0] shadow_mem_row1 = shadow_mem[1];
wire [71:0] shadow_mem_row2 = shadow_mem[2];
wire [71:0] shadow_mem_row3 = shadow_mem[3];
wire [71:0] shadow_mem_row4 = shadow_mem[4];
wire [71:0] shadow_mem_row5 = shadow_mem[5];
wire [71:0] shadow_mem_row6 = shadow_mem[6];
wire [71:0] shadow_mem_row7 = shadow_mem[7];
wire [71:0] shadow_mem_row8 = shadow_mem[8];
wire [71:0] shadow_mem_row9 = shadow_mem[9];
wire [71:0] shadow_mem_row10 = shadow_mem[10];
wire [71:0] shadow_mem_row11 = shadow_mem[11];
wire [71:0] shadow_mem_row12 = shadow_mem[12];
wire [71:0] shadow_mem_row13 = shadow_mem[13];
wire [71:0] shadow_mem_row14 = shadow_mem[14];
wire [71:0] shadow_mem_row15 = shadow_mem[15];
wire [71:0] shadow_mem_row16 = shadow_mem[16];
wire [71:0] shadow_mem_row17 = shadow_mem[17];
wire [71:0] shadow_mem_row18 = shadow_mem[18];
wire [71:0] shadow_mem_row19 = shadow_mem[19];
wire [71:0] shadow_mem_row20 = shadow_mem[20];
wire [71:0] shadow_mem_row21 = shadow_mem[21];
wire [71:0] shadow_mem_row22 = shadow_mem[22];
wire [71:0] shadow_mem_row23 = shadow_mem[23];
wire [71:0] shadow_mem_row24 = shadow_mem[24];
wire [71:0] shadow_mem_row25 = shadow_mem[25];
wire [71:0] shadow_mem_row26 = shadow_mem[26];
wire [71:0] shadow_mem_row27 = shadow_mem[27];
wire [71:0] shadow_mem_row28 = shadow_mem[28];
wire [71:0] shadow_mem_row29 = shadow_mem[29];
wire [71:0] shadow_mem_row30 = shadow_mem[30];
wire [71:0] shadow_mem_row31 = shadow_mem[31];
wire [71:0] shadow_mem_row32 = shadow_mem[32];
wire [71:0] shadow_mem_row33 = shadow_mem[33];
wire [71:0] shadow_mem_row34 = shadow_mem[34];
wire [71:0] shadow_mem_row35 = shadow_mem[35];
wire [71:0] shadow_mem_row36 = shadow_mem[36];
wire [71:0] shadow_mem_row37 = shadow_mem[37];
wire [71:0] shadow_mem_row38 = shadow_mem[38];
wire [71:0] shadow_mem_row39 = shadow_mem[39];
wire [71:0] shadow_mem_row40 = shadow_mem[40];
wire [71:0] shadow_mem_row41 = shadow_mem[41];
wire [71:0] shadow_mem_row42 = shadow_mem[42];
wire [71:0] shadow_mem_row43 = shadow_mem[43];
wire [71:0] shadow_mem_row44 = shadow_mem[44];
wire [71:0] shadow_mem_row45 = shadow_mem[45];
wire [71:0] shadow_mem_row46 = shadow_mem[46];
wire [71:0] shadow_mem_row47 = shadow_mem[47];
wire [71:0] shadow_mem_row48 = shadow_mem[48];
wire [71:0] shadow_mem_row49 = shadow_mem[49];
wire [71:0] shadow_mem_row50 = shadow_mem[50];
wire [71:0] shadow_mem_row51 = shadow_mem[51];
wire [71:0] shadow_mem_row52 = shadow_mem[52];
wire [71:0] shadow_mem_row53 = shadow_mem[53];
wire [71:0] shadow_mem_row54 = shadow_mem[54];
wire [71:0] shadow_mem_row55 = shadow_mem[55];
wire [71:0] shadow_mem_row56 = shadow_mem[56];
wire [71:0] shadow_mem_row57 = shadow_mem[57];
wire [71:0] shadow_mem_row58 = shadow_mem[58];
wire [71:0] shadow_mem_row59 = shadow_mem[59];
wire [71:0] shadow_mem_row60 = shadow_mem[60];
wire [71:0] shadow_mem_row61 = shadow_mem[61];
wire [71:0] shadow_mem_row62 = shadow_mem[62];
wire [71:0] shadow_mem_row63 = shadow_mem[63];
wire [71:0] shadow_mem_row64 = shadow_mem[64];
wire [71:0] shadow_mem_row65 = shadow_mem[65];
wire [71:0] shadow_mem_row66 = shadow_mem[66];
wire [71:0] shadow_mem_row67 = shadow_mem[67];
wire [71:0] shadow_mem_row68 = shadow_mem[68];
wire [71:0] shadow_mem_row69 = shadow_mem[69];
wire [71:0] shadow_mem_row70 = shadow_mem[70];
wire [71:0] shadow_mem_row71 = shadow_mem[71];
wire [71:0] shadow_mem_row72 = shadow_mem[72];
wire [71:0] shadow_mem_row73 = shadow_mem[73];
wire [71:0] shadow_mem_row74 = shadow_mem[74];
wire [71:0] shadow_mem_row75 = shadow_mem[75];
wire [71:0] shadow_mem_row76 = shadow_mem[76];
wire [71:0] shadow_mem_row77 = shadow_mem[77];
wire [71:0] shadow_mem_row78 = shadow_mem[78];
wire [71:0] shadow_mem_row79 = shadow_mem[79];
`endif
task init_mem_val;
  input [6:0] row;
  input [71:0] data;
  begin
    shadow_mem[row] = data;
    shadow_written[row] = 1'b1;
  end
endtask
task init_mem_commit;
integer row;
begin
// initializing AUTOSARAMPDP_80X72_GL_M1_D2
for (row = 0; row < 80; row = row + 1)
 if (shadow_written[row]) r_sa_ram_rwsthp_80x72.ram_Inst_80X72.mem_write(row - 0, shadow_mem[row][71:0]);
shadow_written = 'b0;
end
endtask
`endif
`endif
`ifndef SYNTHESIS
`ifndef NO_INIT_MEM_VAL_TASKS
task do_write; //(wa, we, di);
   input [6:0] wa;
   input we;
   input [71:0] di;
   reg [71:0] d;
   begin
      d = probe_mem_val(wa);
      d = (we ? di : d);
      init_mem_val(wa,d);
   end
endtask
`endif
`endif
`ifndef SYNTHESIS
`ifndef NO_INIT_MEM_VAL_TASKS
`ifndef MEM_REG_NAME
 `define MEM_REG_NAME MX.mem
`endif
function [71:0] probe_mem_val;
input [6:0] row;
reg [71:0] data;
begin
// probing AUTOSARAMPDP_80X72_GL_M1_D2
 if (row >= 0 && row < 80) data[71:0] = r_sa_ram_rwsthp_80x72.ram_Inst_80X72.mem_read(row - 0);
    probe_mem_val = data;
end
endfunction
`endif
`endif
`ifndef SYNTHESIS
`ifndef NO_CLEAR_MEM_TASK
`ifndef NO_INIT_MEM_VAL_TASKS
reg disable_clear_mem = 0;
task clear_mem;
integer i;
begin
  if (!disable_clear_mem)
  begin
    for (i = 0; i < 80; i = i + 1)
      begin
        init_mem_val(i, 'bx);
      end
    init_mem_commit();
  end
end
endtask
`endif
`endif
`endif
`ifndef SYNTHESIS
`ifndef NO_INIT_MEM_ZERO_TASK
`ifndef NO_INIT_MEM_VAL_TASKS
task init_mem_zero;
integer i;
begin
 for (i = 0; i < 80; i = i + 1)
   begin
     init_mem_val(i, 'b0);
   end
 init_mem_commit();
end
endtask
`endif
`endif
`endif
`ifndef SYNTHESIS
`ifndef NO_INIT_MEM_VAL_TASKS
`ifndef NO_INIT_MEM_FROM_FILE_TASK
task init_mem_from_file;
input string init_file;
integer i;
begin
 $readmemh(init_file,shadow_mem);
 for (i = 0; i < 80; i = i + 1)
   begin
     shadow_written[i] = 1'b1;
   end
 init_mem_commit();
end
endtask
`endif
`endif
`endif
`ifndef SYNTHESIS
`ifndef NO_INIT_MEM_RANDOM_TASK
`ifndef NO_INIT_MEM_VAL_TASKS
SA_RANDFUNC rf0 ();
SA_RANDFUNC rf1 ();
SA_RANDFUNC rf2 ();
task init_mem_random;
reg [71:0] random_num;
integer i;
begin
 for (i = 0; i < 80; i = i + 1)
   begin
     random_num = {rf0.rollpli(0,32'hffffffff),rf1.rollpli(0,32'hffffffff),rf2.rollpli(0,32'hffffffff)};
     init_mem_val(i, random_num);
   end
 init_mem_commit();
end
endtask
`endif
`endif
`endif
`ifndef SYNTHESIS
`ifndef NO_FLIP_TASKS
`ifndef NO_INIT_MEM_VAL_TASKS
SA_RANDFUNC rflip ();
task random_flip;
integer random_num;
integer row;
integer bitnum;
begin
  random_num = rflip.rollpli(0, 5760);
  row = random_num / 72;
  bitnum = random_num % 72;
  target_flip(row, bitnum);
end
endtask
task target_flip;
input [6:0] row;
input [71:0] bitnum;
reg [71:0] data;
begin
  if(!$test$plusargs("no_display_target_flips"))
    $display("%m: flipping row %d bit %d at time %t", row, bitnum, $time);
  data = probe_mem_val(row);
  data[bitnum] = ~data[bitnum];
  init_mem_val(row, data);
  init_mem_commit();
end
endtask
`endif
`endif
`endif
// The main module is done
endmodule
//********************************************************************************
