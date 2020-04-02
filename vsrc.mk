nvdla_blocks_dir := $(patsubst %/,%,$(dir $(abspath $(lastword $(MAKEFILE_LIST)))))

nvdla_large_vsrcs := \
	$(nvdla_blocks_dir)/vsrc/defines/defs.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/CKLNQD12.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/HLS_cdp_icvt.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/HLS_cdp_ocvt.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/MUX2D4.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/MUX2HDD2.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/NV_BLKBOX_SINK.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/NV_BLKBOX_SRC0.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/nv_assert_no_x.vlib.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/NV_CLK_gate_power.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cacc/NV_NVDLA_CACC_CALC_int8.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cacc/NV_NVDLA_CACC_assembly_buffer.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cacc/NV_NVDLA_CACC_assembly_ctrl.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cacc/NV_NVDLA_CACC_calculator.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cacc/NV_NVDLA_CACC_delivery_buffer.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cacc/NV_NVDLA_CACC_delivery_ctrl.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cacc/NV_NVDLA_CACC_dual_reg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/include/simulate_x_tick.vh \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cacc/NV_NVDLA_CACC_regfile.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cacc/NV_NVDLA_CACC_single_reg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cacc/NV_NVDLA_CACC_slcg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdma/NV_NVDLA_CDMA_CVT_cell.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdma/NV_NVDLA_CDMA_DC_fifo.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdma/NV_NVDLA_CDMA_IMG_ctrl.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdma/NV_NVDLA_CDMA_IMG_fifo.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdma/NV_NVDLA_CDMA_IMG_pack.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdma/NV_NVDLA_CDMA_IMG_sg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdma/NV_NVDLA_CDMA_IMG_sg2pack_fifo.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/fifos/NV_NVDLA_CDMA_WT_8ATMM_fifo.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdma/NV_NVDLA_CDMA_WT_fifo.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdma/NV_NVDLA_CDMA_cvt.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdma/NV_NVDLA_CDMA_dc.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdma/NV_NVDLA_CDMA_dma_mux.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdma/NV_NVDLA_CDMA_dual_reg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdma/NV_NVDLA_CDMA_img.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdma/NV_NVDLA_CDMA_regfile.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdma/NV_NVDLA_CDMA_shared_buffer.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdma/NV_NVDLA_CDMA_single_reg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdma/NV_NVDLA_CDMA_slcg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdma/NV_NVDLA_CDMA_status.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdma/NV_NVDLA_CDMA_wt.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_INTP_unit.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_LUT_CTRL_unit.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_LUT_ctrl.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_MUL_unit.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_bufferin.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_cvtin.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_cvtout.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/fifos/NV_NVDLA_CDP_DP_data_fifo.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_intp.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/fifos/NV_NVDLA_CDP_DP_intpinfo_fifo.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_lut.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_mul.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_nan.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_sum.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/fifos/NV_NVDLA_CDP_DP_sumpd_fifo.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_syncfifo.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_RDMA_REG_dual.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_RDMA_REG_single.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_RDMA_cq.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_RDMA_eg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_RDMA_ig.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/fifos/NV_NVDLA_CDP_RDMA_lat_fifo.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_RDMA_reg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/fifos/NV_NVDLA_CDP_RDMA_ro_fifo.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_REG_dual.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_REG_single.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/fifos/NV_NVDLA_CDP_WDMA_dat_fifo.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_dp.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_rdma.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_reg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_slcg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_CDP_wdma.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cfgrom/NV_NVDLA_CFGROM_rom.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cmac/NV_NVDLA_CMAC_CORE_active.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cmac/NV_NVDLA_CMAC_CORE_cfg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cmac/NV_NVDLA_CMAC_CORE_mac.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cmac/NV_NVDLA_CMAC_CORE_rt_in.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cmac/NV_NVDLA_CMAC_CORE_rt_out.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cmac/NV_NVDLA_CMAC_CORE_slcg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cmac/NV_NVDLA_CMAC_REG_dual.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cmac/NV_NVDLA_CMAC_REG_single.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cmac/NV_NVDLA_CMAC_core.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cmac/NV_NVDLA_CMAC_reg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/csb_master/NV_NVDLA_CSB_MASTER_csb2falcon_fifo.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/csb_master/NV_NVDLA_CSB_MASTER_falcon2csb_fifo.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/csc/NV_NVDLA_CSC_SG_dat_fifo.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/csc/NV_NVDLA_CSC_SG_wt_fifo.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/csc/NV_NVDLA_CSC_WL_dec.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/csc/NV_NVDLA_CSC_dl.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/csc/NV_NVDLA_CSC_dual_reg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/csc/NV_NVDLA_CSC_regfile.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/csc/NV_NVDLA_CSC_sg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/csc/NV_NVDLA_CSC_single_reg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/csc/NV_NVDLA_CSC_slcg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/csc/NV_NVDLA_CSC_wl.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/nocif/NV_NVDLA_DMAIF_rdreq.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/nocif/NV_NVDLA_DMAIF_rdrsp.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/nocif/NV_NVDLA_DMAIF_wr.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/glb/NV_NVDLA_GLB_CSB_reg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/glb/NV_NVDLA_GLB_csb.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/glb/NV_NVDLA_GLB_ic.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/NV_NVDLA_HLS_saturate.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/NV_NVDLA_HLS_shiftleftsu.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/NV_NVDLA_HLS_shiftrightsatsu.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/NV_NVDLA_HLS_shiftrightss.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/NV_NVDLA_HLS_shiftrightsu.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/NV_NVDLA_HLS_shiftrightusz.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/nocif/NV_NVDLA_MCIF_CSB_reg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/nocif/NV_NVDLA_MCIF_READ_IG_arb.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/nocif/NV_NVDLA_MCIF_READ_IG_bpt.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/nocif/NV_NVDLA_MCIF_READ_IG_cvt.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/include/NV_NVDLA_MCIF_define.vh \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/nocif/NV_NVDLA_MCIF_READ_eg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/nocif/NV_NVDLA_MCIF_READ_ig.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/nocif/NV_NVDLA_MCIF_WRITE_IG_arb.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/nocif/NV_NVDLA_MCIF_WRITE_IG_bpt.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/nocif/NV_NVDLA_MCIF_WRITE_IG_cvt.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/nocif/NV_NVDLA_MCIF_WRITE_cq.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/nocif/NV_NVDLA_MCIF_WRITE_eg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/nocif/NV_NVDLA_MCIF_WRITE_ig.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/nocif/NV_NVDLA_MCIF_csb.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/nocif/NV_NVDLA_MCIF_read.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/nocif/NV_NVDLA_MCIF_write.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/pdp/NV_NVDLA_PDP_CORE_cal1d.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/pdp/NV_NVDLA_PDP_CORE_cal2d.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/pdp/NV_NVDLA_PDP_CORE_preproc.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/pdp/NV_NVDLA_PDP_CORE_unit1d.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/pdp/NV_NVDLA_PDP_RDMA_REG_dual.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/pdp/NV_NVDLA_PDP_RDMA_REG_single.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/pdp/NV_NVDLA_PDP_RDMA_cq.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/pdp/NV_NVDLA_PDP_RDMA_eg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/pdp/NV_NVDLA_PDP_RDMA_ig.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/fifos/NV_NVDLA_PDP_RDMA_lat_fifo.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/pdp/NV_NVDLA_PDP_RDMA_reg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/fifos/NV_NVDLA_PDP_RDMA_ro_fifo.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/pdp/NV_NVDLA_PDP_REG_dual.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/pdp/NV_NVDLA_PDP_REG_single.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/fifos/NV_NVDLA_PDP_SDPIN_ro_fifo.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/fifos/NV_NVDLA_PDP_WDMA_DAT_fifo.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/pdp/NV_NVDLA_PDP_WDMA_cmd.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/pdp/NV_NVDLA_PDP_WDMA_dat.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/pdp/NV_NVDLA_PDP_core.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/pdp/NV_NVDLA_PDP_nan.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/pdp/NV_NVDLA_PDP_rdma.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/pdp/NV_NVDLA_PDP_reg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/pdp/NV_NVDLA_PDP_slcg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/pdp/NV_NVDLA_PDP_wdma.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_BRDMA_cq_lib.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_BRDMA_gate.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/fifos/NV_NVDLA_SDP_BRDMA_lat_fifo_lib.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_CORE_Y_lut.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_CORE_gate.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_CORE_pack.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_CORE_unpack.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_CORE_y.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_ERDMA_cq_lib.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_ERDMA_gate.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/fifos/NV_NVDLA_SDP_ERDMA_lat_fifo_lib.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_C_int.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_X_int_alu.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_X_int_mul.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_X_int_relu.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_X_int_trt.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_Y_cvt_top.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_Y_idx_top.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_Y_inp_top.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_Y_int_alu.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_Y_int_core.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_Y_int_cvt.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_Y_int_idx.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_Y_int_inp.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_Y_int_mul.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_c.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_lut_expn.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_lut_line.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_prelu.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_relu.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_sync2data.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_x1_int.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_x2_int.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_MRDMA_EG_cmd.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_MRDMA_EG_din.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_MRDMA_EG_dout.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/fifos/NV_NVDLA_SDP_MRDMA_EG_lat_fifo_lib.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_MRDMA_cq_lib.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_MRDMA_eg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_MRDMA_gate.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_MRDMA_ig.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_NRDMA_cq_lib.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_NRDMA_gate.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/fifos/NV_NVDLA_SDP_NRDMA_lat_fifo_lib.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_RDMA_EG_ro.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_RDMA_REG_dual.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_RDMA_REG_single.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_RDMA_dmaif.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_RDMA_eg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_RDMA_ig.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_RDMA_pack.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_RDMA_reg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_RDMA_unpack.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_REG_dual.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_REG_single.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_WDMA_DAT_in.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_WDMA_DAT_out.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_WDMA_cmd.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_WDMA_dat.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_WDMA_gate.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_WDMA_intr.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_brdma.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_cmux.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_core.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_erdma.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_mrdma.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_nrdma.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_rdma.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_reg.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_SDP_wdma.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/nocif/NV_NVDLA_XXIF_libs.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/apb2csb/NV_NVDLA_apb2csb.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cacc/NV_NVDLA_cacc.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cbuf/NV_NVDLA_cbuf.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdma/NV_NVDLA_cdma.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/NV_NVDLA_cdp.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cfgrom/NV_NVDLA_cfgrom.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cmac/NV_NVDLA_cmac.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/car/NV_NVDLA_core_reset.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/csb_master/NV_NVDLA_csb_master.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/csc/NV_NVDLA_csc.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/glb/NV_NVDLA_glb.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/nocif/NV_NVDLA_mcif.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/include/NV_HWACC_NVDLA_tick_defines.vh \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/top/NV_NVDLA_partition_a.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/top/NV_NVDLA_partition_c.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/top/NV_NVDLA_partition_m.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/top/NV_NVDLA_partition_o.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/top/NV_NVDLA_partition_p.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/pdp/NV_NVDLA_pdp.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/car/NV_NVDLA_reset.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/sdp/NV_NVDLA_sdp.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/car/NV_NVDLA_sync3d.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/car/NV_NVDLA_sync3d_c.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/car/NV_NVDLA_sync3d_s.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/top/NV_nvdla.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/OR2D1.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/nvdla/cdp/int_sum_block_tp1.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsp_16x14.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsp_8x14.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsp_64x14.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsp_16x65.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsp_64x129.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsp_16x16.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsp_64x16.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsp_128x257.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsp_32x129.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsthp_60x21.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsthp_60x42.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsthp_60x84.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsthp_20x4.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsthp_20x8.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsthp_20x16.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsthp_80x9.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsthp_80x36.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsthp_80x18.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsp_8x65.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsp_8x129.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rws_16x256.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rws_256x3.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rws_512x256.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rws_64x1024.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rws_64x1088.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rws_64x116.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsp_128x11.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsp_128x6.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsp_256x14.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsp_256x16.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsp_256x257.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsp_8x257.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwst_256x8.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsthp_20x32.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsthp_60x168.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsthp_80x17.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/rams/fpga/model/nv_ram_rwsthp_80x72.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/oneHotClk_async_read_clock.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/oneHotClk_async_write_clock.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/p_SSYNC2DO_C_PP.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/p_SSYNC3DO.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/p_SSYNC3DO_C_PPP.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/p_SSYNC3DO_S_PPP.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/p_STRICTSYNC3DOTM_C_PPP.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/sync3d.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/sync3d_c_ppp.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/sync3d_s_ppp.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/sync_reset.v \
	$(nvdla_blocks_dir)/vsrc/large/vmod/vlibs/NV_DW_lsd.sv \
	$(nvdla_blocks_dir)/vsrc/large/nvdla_large.v \
	$(nvdla_blocks_dir)/vsrc/defines/undefs.v

nvdla_small_vsrcs := \
	$(nvdla_blocks_dir)/vsrc/defines/defs.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/CKLNQD12.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/rams/fpga/small_rams/nv_ram_rwsp_80x65.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_RDMA_unpack.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/NV_CLK_gate_power.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/NV_BLKBOX_SINK.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/p_SSYNC3DO_C_PPP.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/nv_assert_no_x.vlib.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/rams/fpga/small_rams/nv_ram_rwsp_80x14.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/rams/fpga/small_rams/nv_ram_rwsp_160x65.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/rams/fpga/small_rams/nv_ram_rwsp_160x16.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/rams/fpga/small_rams/nv_ram_rwsp_128x11.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/include/simulate_x_tick.vh \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/nocif/NV_NVDLA_XXIF_libs.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_RDMA_EG_ro.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_MRDMA_EG_dout.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_MRDMA_EG_din.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_MRDMA_EG_cmd.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_sync2data.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_relu.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_prelu.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/NV_NVDLA_HLS_shiftrightsatsu.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/NV_NVDLA_HLS_shiftleftsu.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/NV_NVDLA_HLS_saturate.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/nocif/NV_NVDLA_DMAIF_rdrsp.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/nocif/NV_NVDLA_DMAIF_rdreq.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/NV_NVDLA_HLS_shiftrightsu.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/sync3d_c_ppp.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/rams/fpga/small_rams/nv_ram_rws_256x7.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/rams/fpga/small_rams/nv_ram_rws_256x3.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/rams/fpga/small_rams/nv_ram_rws_128x18.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/rams/fpga/small_rams/nv_ram_rwst_256x8.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/rams/fpga/small_rams/nv_ram_rwsthp_80x9.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/rams/fpga/small_rams/nv_ram_rwsthp_80x15.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/rams/fpga/small_rams/nv_ram_rwsthp_60x21.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/rams/fpga/small_rams/nv_ram_rwsthp_19x4.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/rams/fpga/small_rams/nv_ram_rwsp_61x65.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/rams/fpga/small_rams/nv_ram_rwsp_128x6.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_WDMA_DAT_out.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_WDMA_DAT_in.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_RDMA_REG_single.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_RDMA_REG_dual.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_RDMA_ig.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_RDMA_eg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_RDMA_dmaif.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_NRDMA_lat_fifo.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_NRDMA_gate.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_NRDMA_cq.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_MRDMA_ig.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_MRDMA_gate.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_MRDMA_eg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_MRDMA_cq.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_X_int_trt.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_X_int_relu.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_X_int_mul.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_X_int_alu.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_C_int.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_BRDMA_lat_fifo.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_BRDMA_gate.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_BRDMA_cq.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/pdp/NV_NVDLA_PDP_RDMA_REG_single.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/pdp/NV_NVDLA_PDP_RDMA_REG_dual.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/pdp/NV_NVDLA_PDP_CORE_unit1d.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/nocif/NV_NVDLA_NOCIF_DRAM_WRITE_IG_spt.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/nocif/NV_NVDLA_NOCIF_DRAM_WRITE_IG_cvt.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/nocif/NV_NVDLA_NOCIF_DRAM_WRITE_IG_bpt.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/nocif/NV_NVDLA_NOCIF_DRAM_WRITE_IG_arb.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/nocif/NV_NVDLA_NOCIF_DRAM_READ_IG_spt.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/nocif/NV_NVDLA_NOCIF_DRAM_READ_IG_cvt.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/nocif/NV_NVDLA_NOCIF_DRAM_READ_IG_bpt.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/nocif/NV_NVDLA_NOCIF_DRAM_READ_IG_arb.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_RDMA_REG_single.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_RDMA_REG_dual.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_MUL_unit.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_LUT_CTRL_unit.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_INTP_unit.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdma/NV_NVDLA_CDMA_IMG_sg2pack_fifo.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdma/NV_NVDLA_CDMA_IMG_fifo.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/NV_BLKBOX_SRC0.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/MUX2HDD2.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/int_sum_block_tp1.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/HLS_cdp_ocvt.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/HLS_cdp_icvt.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/p_STRICTSYNC3DOTM_C_PPP.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/p_SSYNC3DO_S_PPP.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/p_SSYNC3DO.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/p_SSYNC2DO_C_PP.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/OR2D1.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/oneHotClk_async_write_clock.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/oneHotClk_async_read_clock.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/rams/fpga/small_rams/nv_ram_rws_16x64.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/rams/fpga/small_rams/nv_ram_rws_16x272.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/rams/fpga/small_rams/nv_ram_rws_16x256.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/rams/fpga/small_rams/nv_ram_rwsp_8x65.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/car/NV_NVDLA_sync3d_c.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_WDMA_intr.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_WDMA_gate.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_WDMA_dat.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_WDMA_cmd.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_REG_single.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_REG_dual.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_RDMA_reg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_RDMA_pack.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_nrdma.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_mrdma.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_x2_int.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_x1_int.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_HLS_c.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_CORE_unpack.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_CORE_pack.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_CORE_gate.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_cmux.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_brdma.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/pdp/NV_NVDLA_PDP_WDMA_dat.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/pdp/NV_NVDLA_PDP_WDMA_cmd.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/pdp/NV_NVDLA_PDP_slcg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/pdp/NV_NVDLA_PDP_REG_single.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/pdp/NV_NVDLA_PDP_REG_dual.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/pdp/NV_NVDLA_PDP_RDMA_reg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/pdp/NV_NVDLA_PDP_RDMA_ig.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/pdp/NV_NVDLA_PDP_RDMA_eg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/pdp/NV_NVDLA_PDP_RDMA_cq.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/pdp/NV_NVDLA_PDP_CORE_preproc.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/pdp/NV_NVDLA_PDP_CORE_cal2d.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/pdp/NV_NVDLA_PDP_CORE_cal1d.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/nocif/NV_NVDLA_NOCIF_DRAM_WRITE_ig.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/nocif/NV_NVDLA_NOCIF_DRAM_WRITE_eg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/nocif/NV_NVDLA_NOCIF_DRAM_WRITE_cq.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/nocif/NV_NVDLA_NOCIF_DRAM_READ_ig.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/nocif/NV_NVDLA_NOCIF_DRAM_READ_eg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/nocif/NV_NVDLA_NOCIF_DRAM_READ_cq.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/nocif/NV_NVDLA_MCIF_CSB_reg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/glb/NV_NVDLA_GLB_CSB_reg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/nocif/NV_NVDLA_DMAIF_wr.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/csc/NV_NVDLA_CSC_WL_dec.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/csc/NV_NVDLA_CSC_single_reg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/csc/NV_NVDLA_CSC_SG_wt_fifo.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/csc/NV_NVDLA_CSC_SG_dat_fifo.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/csc/NV_NVDLA_CSC_dual_reg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cmac/NV_NVDLA_CMAC_REG_single.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cmac/NV_NVDLA_CMAC_REG_dual.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cmac/NV_NVDLA_CMAC_CORE_slcg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cmac/NV_NVDLA_CMAC_CORE_rt_out.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cmac/NV_NVDLA_CMAC_CORE_rt_in.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cmac/NV_NVDLA_CMAC_CORE_mac.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cmac/NV_NVDLA_CMAC_CORE_cfg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cmac/NV_NVDLA_CMAC_CORE_active.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_slcg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_REG_single.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_REG_dual.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_RDMA_reg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_RDMA_ig.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_RDMA_eg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_RDMA_cq.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_syncfifo.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_sum.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_mul.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_LUT_ctrl.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_lut.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_intp.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_cvtout.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_cvtin.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_bufferin_tp1.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdma/NV_NVDLA_CDMA_WT_fifo.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdma/NV_NVDLA_CDMA_single_reg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdma/NV_NVDLA_CDMA_IMG_sg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdma/NV_NVDLA_CDMA_IMG_pack.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdma/NV_NVDLA_CDMA_IMG_ctrl.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdma/NV_NVDLA_CDMA_dual_reg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdma/NV_NVDLA_CDMA_DC_fifo.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdma/NV_NVDLA_CDMA_CVT_cell.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cacc/NV_NVDLA_CACC_single_reg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cacc/NV_NVDLA_CACC_dual_reg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cacc/NV_NVDLA_CACC_CALC_int8.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/MUX2D4.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/sync_reset.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/sync3d_s_ppp.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/vlibs/sync3d.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/rams/fpga/small_rams/nv_ram_rws_256x64.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_wdma.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_reg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_rdma.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_SDP_core.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/pdp/NV_NVDLA_PDP_wdma.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/pdp/NV_NVDLA_PDP_reg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/pdp/NV_NVDLA_PDP_rdma.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/pdp/NV_NVDLA_PDP_nan.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/pdp/NV_NVDLA_PDP_core.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/nocif/NV_NVDLA_NOCIF_DRAM_write.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/nocif/NV_NVDLA_NOCIF_DRAM_read.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/nocif/NV_NVDLA_MCIF_csb.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/glb/NV_NVDLA_GLB_ic.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/glb/NV_NVDLA_GLB_csb.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/csc/NV_NVDLA_CSC_wl.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/csc/NV_NVDLA_CSC_slcg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/csc/NV_NVDLA_CSC_sg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/csc/NV_NVDLA_CSC_regfile.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/csc/NV_NVDLA_CSC_dl.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/csb_master/NV_NVDLA_CSB_MASTER_falcon2csb_fifo.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/csb_master/NV_NVDLA_CSB_MASTER_csb2falcon_fifo.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cmac/NV_NVDLA_CMAC_reg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cmac/NV_NVDLA_CMAC_core.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cfgrom/NV_NVDLA_CFGROM_rom.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_wdma.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_reg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_rdma.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_DP_nan.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_CDP_dp.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdma/NV_NVDLA_CDMA_wt.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdma/NV_NVDLA_CDMA_status.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdma/NV_NVDLA_CDMA_slcg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdma/NV_NVDLA_CDMA_shared_buffer.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdma/NV_NVDLA_CDMA_regfile.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdma/NV_NVDLA_CDMA_img.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdma/NV_NVDLA_CDMA_dma_mux.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdma/NV_NVDLA_CDMA_dc.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdma/NV_NVDLA_CDMA_cvt.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cacc/NV_NVDLA_CACC_slcg.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cacc/NV_NVDLA_CACC_regfile.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cacc/NV_NVDLA_CACC_delivery_ctrl.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cacc/NV_NVDLA_CACC_delivery_buffer.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cacc/NV_NVDLA_CACC_calculator.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cacc/NV_NVDLA_CACC_assembly_ctrl.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cacc/NV_NVDLA_CACC_assembly_buffer.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/car/NV_NVDLA_sync3d_s.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/car/NV_NVDLA_sync3d.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/sdp/NV_NVDLA_sdp.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/car/NV_NVDLA_reset.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/pdp/NV_NVDLA_pdp.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/nocif/NV_NVDLA_NOCIF_dram.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/glb/NV_NVDLA_glb.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/csc/NV_NVDLA_csc.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/csb_master/NV_NVDLA_csb_master.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/car/NV_NVDLA_core_reset.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cmac/NV_NVDLA_cmac.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cfgrom/NV_NVDLA_cfgrom.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdp/NV_NVDLA_cdp.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cdma/NV_NVDLA_cdma.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cbuf/NV_NVDLA_cbuf.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/cacc/NV_NVDLA_cacc.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/top/NV_NVDLA_partition_p.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/top/NV_NVDLA_partition_o.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/top/NV_NVDLA_partition_m.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/top/NV_NVDLA_partition_c.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/top/NV_NVDLA_partition_a.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/apb2csb/NV_NVDLA_apb2csb.v \
	$(nvdla_blocks_dir)/vsrc/small/vmod/nvdla/top/NV_nvdla.v \
	$(nvdla_blocks_dir)/vsrc/small/nvdla_small.v \
	$(nvdla_blocks_dir)/vsrc/defines/undefs.v
