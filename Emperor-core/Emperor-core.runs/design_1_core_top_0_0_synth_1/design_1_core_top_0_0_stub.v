// Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
// Date        : Wed Dec  6 17:43:44 2017
// Host        : ispc2016 running 64-bit Ubuntu 14.04.5 LTS
// Command     : write_verilog -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
//               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_core_top_0_0_stub.v
// Design      : design_1_core_top_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xcku040-ffva1156-2-e
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "core_top,Vivado 2016.4" *)
module decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix(RST_N, CLK, I_MEM_IN, I_MEM_ADDR, MEM_IN, MEM_DATA, 
  MEM_ADDR, MEM_WE, ADDSUB_A_TDATA, ADDSUB_A_TREADY, ADDSUB_A_TVALID, ADDSUB_B_TDATA, 
  ADDSUB_B_TREADY, ADDSUB_B_TVALID, ADDSUB_OP_TDATA, ADDSUB_OP_TREADY, ADDSUB_OP_TVALID, 
  ADDSUB_R_TDATA, ADDSUB_R_TREADY, ADDSUB_R_TVALID, MUL_A_TDATA, MUL_A_TREADY, MUL_A_TVALID, 
  MUL_B_TDATA, MUL_B_TREADY, MUL_B_TVALID, MUL_R_TDATA, MUL_R_TREADY, MUL_R_TVALID, 
  DIV_A_TDATA, DIV_A_TREADY, DIV_A_TVALID, DIV_B_TDATA, DIV_B_TREADY, DIV_B_TVALID, 
  DIV_R_TDATA, DIV_R_TREADY, DIV_R_TVALID, COMP_A_TDATA, COMP_A_TREADY, COMP_A_TVALID, 
  COMP_B_TDATA, COMP_B_TREADY, COMP_B_TVALID, COMP_OP_TDATA, COMP_OP_TREADY, COMP_OP_TVALID, 
  COMP_R_TDATA, COMP_R_TREADY, COMP_R_TVALID, FCVTSW_A_TDATA, FCVTSW_A_TREADY, 
  FCVTSW_A_TVALID, FCVTSW_R_TDATA, FCVTSW_R_TREADY, FCVTSW_R_TVALID, FCVTWS_A_TDATA, 
  FCVTWS_A_TREADY, FCVTWS_A_TVALID, FCVTWS_R_TDATA, FCVTWS_R_TREADY, FCVTWS_R_TVALID, 
  FSQRTS_A_TDATA, FSQRTS_A_TREADY, FSQRTS_A_TVALID, FSQRTS_R_TDATA, FSQRTS_R_TREADY, 
  FSQRTS_R_TVALID, ARADDR, ARREADY, ARVALID, AWADDR, AWREADY, AWVALID, BREADY, BRESP, BVALID, RDATA, 
  RREADY, RRESP, RVALID, WDATA, WREADY, WVALID, WSTRB)
/* synthesis syn_black_box black_box_pad_pin="RST_N,CLK,I_MEM_IN[31:0],I_MEM_ADDR[31:0],MEM_IN[31:0],MEM_DATA[31:0],MEM_ADDR[31:0],MEM_WE,ADDSUB_A_TDATA[31:0],ADDSUB_A_TREADY,ADDSUB_A_TVALID,ADDSUB_B_TDATA[31:0],ADDSUB_B_TREADY,ADDSUB_B_TVALID,ADDSUB_OP_TDATA[7:0],ADDSUB_OP_TREADY,ADDSUB_OP_TVALID,ADDSUB_R_TDATA[31:0],ADDSUB_R_TREADY,ADDSUB_R_TVALID,MUL_A_TDATA[31:0],MUL_A_TREADY,MUL_A_TVALID,MUL_B_TDATA[31:0],MUL_B_TREADY,MUL_B_TVALID,MUL_R_TDATA[31:0],MUL_R_TREADY,MUL_R_TVALID,DIV_A_TDATA[31:0],DIV_A_TREADY,DIV_A_TVALID,DIV_B_TDATA[31:0],DIV_B_TREADY,DIV_B_TVALID,DIV_R_TDATA[31:0],DIV_R_TREADY,DIV_R_TVALID,COMP_A_TDATA[31:0],COMP_A_TREADY,COMP_A_TVALID,COMP_B_TDATA[31:0],COMP_B_TREADY,COMP_B_TVALID,COMP_OP_TDATA[7:0],COMP_OP_TREADY,COMP_OP_TVALID,COMP_R_TDATA[31:0],COMP_R_TREADY,COMP_R_TVALID,FCVTSW_A_TDATA[31:0],FCVTSW_A_TREADY,FCVTSW_A_TVALID,FCVTSW_R_TDATA[31:0],FCVTSW_R_TREADY,FCVTSW_R_TVALID,FCVTWS_A_TDATA[31:0],FCVTWS_A_TREADY,FCVTWS_A_TVALID,FCVTWS_R_TDATA[31:0],FCVTWS_R_TREADY,FCVTWS_R_TVALID,FSQRTS_A_TDATA[31:0],FSQRTS_A_TREADY,FSQRTS_A_TVALID,FSQRTS_R_TDATA[31:0],FSQRTS_R_TREADY,FSQRTS_R_TVALID,ARADDR[3:0],ARREADY,ARVALID,AWADDR[3:0],AWREADY,AWVALID,BREADY,BRESP[1:0],BVALID,RDATA[31:0],RREADY,RRESP[1:0],RVALID,WDATA[31:0],WREADY,WVALID,WSTRB[3:0]" */;
  input RST_N;
  input CLK;
  input [31:0]I_MEM_IN;
  output [31:0]I_MEM_ADDR;
  input [31:0]MEM_IN;
  output [31:0]MEM_DATA;
  output [31:0]MEM_ADDR;
  output MEM_WE;
  output [31:0]ADDSUB_A_TDATA;
  input ADDSUB_A_TREADY;
  output ADDSUB_A_TVALID;
  output [31:0]ADDSUB_B_TDATA;
  input ADDSUB_B_TREADY;
  output ADDSUB_B_TVALID;
  output [7:0]ADDSUB_OP_TDATA;
  input ADDSUB_OP_TREADY;
  output ADDSUB_OP_TVALID;
  input [31:0]ADDSUB_R_TDATA;
  output ADDSUB_R_TREADY;
  input ADDSUB_R_TVALID;
  output [31:0]MUL_A_TDATA;
  input MUL_A_TREADY;
  output MUL_A_TVALID;
  output [31:0]MUL_B_TDATA;
  input MUL_B_TREADY;
  output MUL_B_TVALID;
  input [31:0]MUL_R_TDATA;
  output MUL_R_TREADY;
  input MUL_R_TVALID;
  output [31:0]DIV_A_TDATA;
  input DIV_A_TREADY;
  output DIV_A_TVALID;
  output [31:0]DIV_B_TDATA;
  input DIV_B_TREADY;
  output DIV_B_TVALID;
  input [31:0]DIV_R_TDATA;
  output DIV_R_TREADY;
  input DIV_R_TVALID;
  output [31:0]COMP_A_TDATA;
  input COMP_A_TREADY;
  output COMP_A_TVALID;
  output [31:0]COMP_B_TDATA;
  input COMP_B_TREADY;
  output COMP_B_TVALID;
  output [7:0]COMP_OP_TDATA;
  input COMP_OP_TREADY;
  output COMP_OP_TVALID;
  input [31:0]COMP_R_TDATA;
  output COMP_R_TREADY;
  input COMP_R_TVALID;
  output [31:0]FCVTSW_A_TDATA;
  input FCVTSW_A_TREADY;
  output FCVTSW_A_TVALID;
  input [31:0]FCVTSW_R_TDATA;
  output FCVTSW_R_TREADY;
  input FCVTSW_R_TVALID;
  output [31:0]FCVTWS_A_TDATA;
  input FCVTWS_A_TREADY;
  output FCVTWS_A_TVALID;
  input [31:0]FCVTWS_R_TDATA;
  output FCVTWS_R_TREADY;
  input FCVTWS_R_TVALID;
  output [31:0]FSQRTS_A_TDATA;
  input FSQRTS_A_TREADY;
  output FSQRTS_A_TVALID;
  input [31:0]FSQRTS_R_TDATA;
  output FSQRTS_R_TREADY;
  input FSQRTS_R_TVALID;
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
endmodule
