// ================================================================
// AUTOSA Open Source Project
//
// Copyright(c) 2016 - 2017 NVIDIA Corporation. Licensed under the
// AUTOSA Open Hardware License; Check "LICENSE" which comes with
// this distribution for more information.
// ================================================================
// File Name: SA_HWACC_AUTOSA_tick_defines.vh
//`include "SA_HWACC_common_tick_defines.vh"
`ifndef SA_HWACC_AUTOSA_tick_defines_vh
`define SA_HWACC_AUTOSA_tick_defines_vh
//this section contains IP specific defines
`ifdef SA_FPGA_SYSTEM
`ifndef SA_HWACC_AUTOSA_SFPGA_UFPGA_EMU
`define SA_HWACC_AUTOSA_SFPGA_UFPGA_EMU
`endif
`ifndef SA_HWACC_AUTOSA_SFPGA_UFPGA
`define SA_HWACC_AUTOSA_SFPGA_UFPGA
`endif
`ifndef SA_HWACC_AUTOSA_SFPGA_EMU
`define SA_HWACC_AUTOSA_SFPGA_EMU
`endif
`endif
`ifdef SA_FPGA_UNIT
`ifndef SA_HWACC_AUTOSA_SFPGA_UFPGA_EMU
`define SA_HWACC_AUTOSA_SFPGA_UFPGA_EMU
`endif
`ifndef SA_HWACC_AUTOSA_SFPGA_UFPGA
`define SA_HWACC_AUTOSA_SFPGA_UFPGA
`endif
`ifndef SA_HWACC_AUTOSA_UFPGA_EMU
`define SA_HWACC_AUTOSA_UFPGA_EMU
`endif
`endif
`ifdef SA_EMULATION
`ifndef SA_HWACC_AUTOSA_SFPGA_UFPGA_EMU
`define SA_HWACC_AUTOSA_SFPGA_UFPGA_EMU
`endif
`ifndef SA_HWACC_AUTOSA_SFPGA_EMU
`define SA_HWACC_AUTOSA_SFPGA_EMU
`endif
`ifndef SA_HWACC_AUTOSA_UFPGA_EMU
`define SA_HWACC_AUTOSA_UFPGA_EMU
`endif
`endif
//DEFINES
//defines shared between system fpga and unit fpga and emulation
`ifdef SA_HWACC_AUTOSA_SFPGA_UFPGA_EMU
//add defines here
`endif
//defines shared between system fpga and unit fpga
`ifdef SA_HWACC_AUTOSA_SFPGA_UFPGA
//add defines here
`endif
//defines shared between system fpga and emulation
`ifdef SA_HWACC_AUTOSA_SFPGA_EMU
//add defines here
`endif
//defines shared between unit fpga and emulation
`ifdef SA_HWACC_AUTOSA_UFPGA_EMU
//add defines here
`endif
//defines used only in system fpga
`ifdef SA_FPGA_SYSTEM
//add defines here
`endif
//defines used only in unit fpga
`ifdef SA_FPGA_UNIT
//add defines here
`endif
//defines used only in emulation
`ifdef SA_EMULATION
//add defines here
`endif
`endif //SA_HWACC_AUTOSA_tick_defines_vh
