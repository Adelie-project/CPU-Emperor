vlib work
vlib riviera

vlib riviera/xil_defaultlib
vlib riviera/xpm
vlib riviera/xbip_utils_v3_0_7
vlib riviera/axi_utils_v2_0_3
vlib riviera/xbip_pipe_v3_0_3
vlib riviera/xbip_dsp48_wrapper_v3_0_4
vlib riviera/xbip_dsp48_addsub_v3_0_3
vlib riviera/xbip_dsp48_multadd_v3_0_3
vlib riviera/xbip_bram18k_v3_0_3
vlib riviera/mult_gen_v12_0_12
vlib riviera/floating_point_v7_1_3
vlib riviera/blk_mem_gen_v8_3_5
vlib riviera/axi_lite_ipif_v3_0_4
vlib riviera/lib_pkg_v1_0_2
vlib riviera/lib_srl_fifo_v1_0_2
vlib riviera/lib_cdc_v1_0_2
vlib riviera/axi_uartlite_v2_0_15

vmap xil_defaultlib riviera/xil_defaultlib
vmap xpm riviera/xpm
vmap xbip_utils_v3_0_7 riviera/xbip_utils_v3_0_7
vmap axi_utils_v2_0_3 riviera/axi_utils_v2_0_3
vmap xbip_pipe_v3_0_3 riviera/xbip_pipe_v3_0_3
vmap xbip_dsp48_wrapper_v3_0_4 riviera/xbip_dsp48_wrapper_v3_0_4
vmap xbip_dsp48_addsub_v3_0_3 riviera/xbip_dsp48_addsub_v3_0_3
vmap xbip_dsp48_multadd_v3_0_3 riviera/xbip_dsp48_multadd_v3_0_3
vmap xbip_bram18k_v3_0_3 riviera/xbip_bram18k_v3_0_3
vmap mult_gen_v12_0_12 riviera/mult_gen_v12_0_12
vmap floating_point_v7_1_3 riviera/floating_point_v7_1_3
vmap blk_mem_gen_v8_3_5 riviera/blk_mem_gen_v8_3_5
vmap axi_lite_ipif_v3_0_4 riviera/axi_lite_ipif_v3_0_4
vmap lib_pkg_v1_0_2 riviera/lib_pkg_v1_0_2
vmap lib_srl_fifo_v1_0_2 riviera/lib_srl_fifo_v1_0_2
vmap lib_cdc_v1_0_2 riviera/lib_cdc_v1_0_2
vmap axi_uartlite_v2_0_15 riviera/axi_uartlite_v2_0_15

vlog -work xil_defaultlib  -sv2k12 "+incdir+../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/100a" "+incdir+../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/100a" \
"/opt/Xilinx/Vivado/2016.4/data/ip/xpm/xpm_cdc/hdl/xpm_cdc.sv" \
"/opt/Xilinx/Vivado/2016.4/data/ip/xpm/xpm_memory/hdl/xpm_memory.sv" \

vcom -work xpm -93 \
"/opt/Xilinx/Vivado/2016.4/data/ip/xpm/xpm_VCOMP.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/100a" "+incdir+../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/100a" \
"../../../bd/design_1/ip/design_1_core_fpu_0_0_1/sim/design_1_core_fpu_0_0.v" \
"../../../bd/design_1/ip/design_1_core_top_0_0_1/sim/design_1_core_top_0_0.v" \

vcom -work xbip_utils_v3_0_7 -93 \
"../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/6fc3/hdl/xbip_utils_v3_0_vh_rfs.vhd" \

vcom -work axi_utils_v2_0_3 -93 \
"../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/43f5/hdl/axi_utils_v2_0_vh_rfs.vhd" \

vcom -work xbip_pipe_v3_0_3 -93 \
"../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/7db8/hdl/xbip_pipe_v3_0_vh_rfs.vhd" \

vcom -work xbip_dsp48_wrapper_v3_0_4 -93 \
"../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/1e87/hdl/xbip_dsp48_wrapper_v3_0_vh_rfs.vhd" \

vcom -work xbip_dsp48_addsub_v3_0_3 -93 \
"../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/c9c4/hdl/xbip_dsp48_addsub_v3_0_vh_rfs.vhd" \

vcom -work xbip_dsp48_multadd_v3_0_3 -93 \
"../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/779d/hdl/xbip_dsp48_multadd_v3_0_vh_rfs.vhd" \

vcom -work xbip_bram18k_v3_0_3 -93 \
"../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/403d/hdl/xbip_bram18k_v3_0_vh_rfs.vhd" \

vcom -work mult_gen_v12_0_12 -93 \
"../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/f0ab/hdl/mult_gen_v12_0_vh_rfs.vhd" \

vcom -work floating_point_v7_1_3 -93 \
"../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/ad02/hdl/floating_point_v7_1_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_floating_point_0_0_1/sim/design_1_floating_point_0_0.vhd" \
"../../../bd/design_1/ip/design_1_floating_point_0_1_1/sim/design_1_floating_point_0_1.vhd" \
"../../../bd/design_1/ip/design_1_floating_point_1_0/sim/design_1_floating_point_1_0.vhd" \
"../../../bd/design_1/ip/design_1_floating_point_2_0_1/sim/design_1_floating_point_2_0.vhd" \
"../../../bd/design_1/ip/design_1_floating_point_3_0/sim/design_1_floating_point_3_0.vhd" \
"../../../bd/design_1/ip/design_1_floating_point_4_0/sim/design_1_floating_point_4_0.vhd" \
"../../../bd/design_1/ip/design_1_floating_point_5_0_1/sim/design_1_floating_point_5_0.vhd" \

vlog -work blk_mem_gen_v8_3_5  -v2k5 "+incdir+../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/100a" "+incdir+../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/100a" \
"../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/6273/simulation/blk_mem_gen_v8_3.v" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/100a" "+incdir+../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/100a" \
"../../../bd/design_1/ip/design_1_blk_mem_gen_0_0_1/sim/design_1_blk_mem_gen_0_0.v" \
"../../../bd/design_1/ipshared/e147/xlconstant.v" \
"../../../bd/design_1/ip/design_1_xlconstant_0_0_1/sim/design_1_xlconstant_0_0.v" \
"../../../bd/design_1/ip/design_1_blk_mem_gen_1_0_1/sim/design_1_blk_mem_gen_1_0.v" \
"../../../bd/design_1/ip/design_1_xlconstant_1_0/sim/design_1_xlconstant_1_0.v" \

vcom -work axi_lite_ipif_v3_0_4 -93 \
"../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/0ba0/hdl/axi_lite_ipif_v3_0_vh_rfs.vhd" \

vcom -work lib_pkg_v1_0_2 -93 \
"../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/832a/hdl/lib_pkg_v1_0_rfs.vhd" \

vcom -work lib_srl_fifo_v1_0_2 -93 \
"../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/6039/hdl/lib_srl_fifo_v1_0_rfs.vhd" \

vcom -work lib_cdc_v1_0_2 -93 \
"../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/52cb/hdl/lib_cdc_v1_0_rfs.vhd" \

vcom -work axi_uartlite_v2_0_15 -93 \
"../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/2479/hdl/axi_uartlite_v2_0_vh_rfs.vhd" \

vcom -work xil_defaultlib -93 \
"../../../bd/design_1/ip/design_1_axi_uartlite_0_0/sim/design_1_axi_uartlite_0_0.vhd" \

vlog -work xil_defaultlib  -v2k5 "+incdir+../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/100a" "+incdir+../../../../Emperor-core.srcs/sources_1/bd/design_1/ipshared/100a" \
"../../../bd/design_1/hdl/design_1.v" \
"../../../bd/design_1/ip/design_1_clk_wiz_0_0_1/design_1_clk_wiz_0_0_clk_wiz.v" \
"../../../bd/design_1/ip/design_1_clk_wiz_0_0_1/design_1_clk_wiz_0_0.v" \
"../../../bd/design_1/ip/design_1_blk_mem_gen_2_0/sim/design_1_blk_mem_gen_2_0.v" \

vlog -work xil_defaultlib "glbl.v"

