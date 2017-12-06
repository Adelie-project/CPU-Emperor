// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
// Date        : Wed Dec  6 21:15:10 2017
// Host        : ispc2016 running 64-bit Ubuntu 14.04.5 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/yamaguchi/CPU-Emperor/Emperor-core/Emperor-core.srcs/sources_1/bd/design_1/ip/design_1_core_top_0_0_1/design_1_core_top_0_0_stub.v
// Design      : design_1_core_top_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku040-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "core_top,Vivado 2016.4" *)
module design_1_core_top_0_0(RST_N, CLK, I_MEM_IN, I_MEM_ADDR, MEM_IN, MEM_DATA, 
  MEM_ADDR, MEM_WE, ARADDR, ARREADY, ARVALID, AWADDR, AWREADY, AWVALID, BREADY, BRESP, BVALID, RDATA, 
  RREADY, RRESP, RVALID, WDATA, WREADY, WVALID, WSTRB, i_fadds, i_fsubs, i_fmuls, i_fdivs, i_feqs, i_flts, 
  i_fles, i_fcvtsw, i_fcvtws, i_fsqrts, rs1, frs1, frs2, fpu_result, fpu_stole)
/* synthesis syn_black_box black_box_pad_pin="RST_N,CLK,I_MEM_IN[31:0],I_MEM_ADDR[31:0],MEM_IN[31:0],MEM_DATA[31:0],MEM_ADDR[31:0],MEM_WE,ARADDR[3:0],ARREADY,ARVALID,AWADDR[3:0],AWREADY,AWVALID,BREADY,BRESP[1:0],BVALID,RDATA[31:0],RREADY,RRESP[1:0],RVALID,WDATA[31:0],WREADY,WVALID,WSTRB[3:0],i_fadds,i_fsubs,i_fmuls,i_fdivs,i_feqs,i_flts,i_fles,i_fcvtsw,i_fcvtws,i_fsqrts,rs1[31:0],frs1[31:0],frs2[31:0],fpu_result[31:0],fpu_stole" */;
  input RST_N;
  input CLK;
  input [31:0]I_MEM_IN;
  output [31:0]I_MEM_ADDR;
  input [31:0]MEM_IN;
  output [31:0]MEM_DATA;
  output [31:0]MEM_ADDR;
  output MEM_WE;
  output [3:0]ARADDR;
  input ARREADY;
  output ARVALID;
  output [3:0]AWADDR;
  input AWREADY;
  output AWVALID;
  output BREADY;
  input [1:0]BRESP;
  input BVALID;
  input [31:0]RDATA;
  output RREADY;
  input [1:0]RRESP;
  input RVALID;
  output [31:0]WDATA;
  input WREADY;
  output WVALID;
  output [3:0]WSTRB;
  output i_fadds;
  output i_fsubs;
  output i_fmuls;
  output i_fdivs;
  output i_feqs;
  output i_flts;
  output i_fles;
  output i_fcvtsw;
  output i_fcvtws;
  output i_fsqrts;
  output [31:0]rs1;
  output [31:0]frs1;
  output [31:0]frs2;
  input [31:0]fpu_result;
  input fpu_stole;
endmodule
