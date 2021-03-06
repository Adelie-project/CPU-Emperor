// (c) Copyright 1995-2017 Xilinx, Inc. All rights reserved.
// 
// This file contains confidential and proprietary information
// of Xilinx, Inc. and is protected under U.S. and
// international copyright and other intellectual property
// laws.
// 
// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES.
// 
// DO NOT MODIFY THIS FILE.


// IP VLNV: user.org:module_ref:core_top:1.0
// IP Revision: 1

`timescale 1ns/1ps

(* DowngradeIPIdentifiedWarnings = "yes" *)
module design_1_core_top_0_0 (
  RST_N,
  CLK,
  I_MEM_IN,
  I_MEM_ADDR,
  MEM_IN,
  MEM_DATA,
  MEM_ADDR,
  MEM_WE,
  CSR_IN,
  CSR_DATA,
  CSR_ADDR,
  CSR_WE,
  ARADDR,
  ARREADY,
  ARVALID,
  AWADDR,
  AWREADY,
  AWVALID,
  BREADY,
  BRESP,
  BVALID,
  RDATA,
  RREADY,
  RRESP,
  RVALID,
  WDATA,
  WREADY,
  WVALID,
  WSTRB,
  i_fadds,
  i_fsubs,
  i_fmuls,
  i_fdivs,
  i_feqs,
  i_flts,
  i_fles,
  i_fcvtsw,
  i_fcvtws,
  i_fsqrts,
  rs1,
  frs1,
  frs2,
  fpu_result,
  tvalid_once,
  exec,
  stole
);

(* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 RST_N RST" *)
input wire RST_N;
(* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 CLK CLK" *)
input wire CLK;
input wire [31 : 0] I_MEM_IN;
output wire [31 : 0] I_MEM_ADDR;
input wire [31 : 0] MEM_IN;
output wire [31 : 0] MEM_DATA;
output wire [31 : 0] MEM_ADDR;
output wire MEM_WE;
input wire [31 : 0] CSR_IN;
output wire [31 : 0] CSR_DATA;
output wire [11 : 0] CSR_ADDR;
output wire CSR_WE;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm ARADDR" *)
output wire [3 : 0] ARADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm ARREADY" *)
input wire ARREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm ARVALID" *)
output wire ARVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm AWADDR" *)
output wire [3 : 0] AWADDR;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm AWREADY" *)
input wire AWREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm AWVALID" *)
output wire AWVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm BREADY" *)
output wire BREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm BRESP" *)
input wire [1 : 0] BRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm BVALID" *)
input wire BVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm RDATA" *)
input wire [31 : 0] RDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm RREADY" *)
output wire RREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm RRESP" *)
input wire [1 : 0] RRESP;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm RVALID" *)
input wire RVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm WDATA" *)
output wire [31 : 0] WDATA;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm WREADY" *)
input wire WREADY;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm WVALID" *)
output wire WVALID;
(* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 interface_aximm WSTRB" *)
output wire [3 : 0] WSTRB;
output wire i_fadds;
output wire i_fsubs;
output wire i_fmuls;
output wire i_fdivs;
output wire i_feqs;
output wire i_flts;
output wire i_fles;
output wire i_fcvtsw;
output wire i_fcvtws;
output wire i_fsqrts;
output wire [31 : 0] rs1;
output wire [31 : 0] frs1;
output wire [31 : 0] frs2;
input wire [31 : 0] fpu_result;
input wire tvalid_once;
output wire exec;
output wire stole;

  core_top inst (
    .RST_N(RST_N),
    .CLK(CLK),
    .I_MEM_IN(I_MEM_IN),
    .I_MEM_ADDR(I_MEM_ADDR),
    .MEM_IN(MEM_IN),
    .MEM_DATA(MEM_DATA),
    .MEM_ADDR(MEM_ADDR),
    .MEM_WE(MEM_WE),
    .CSR_IN(CSR_IN),
    .CSR_DATA(CSR_DATA),
    .CSR_ADDR(CSR_ADDR),
    .CSR_WE(CSR_WE),
    .ARADDR(ARADDR),
    .ARREADY(ARREADY),
    .ARVALID(ARVALID),
    .AWADDR(AWADDR),
    .AWREADY(AWREADY),
    .AWVALID(AWVALID),
    .BREADY(BREADY),
    .BRESP(BRESP),
    .BVALID(BVALID),
    .RDATA(RDATA),
    .RREADY(RREADY),
    .RRESP(RRESP),
    .RVALID(RVALID),
    .WDATA(WDATA),
    .WREADY(WREADY),
    .WVALID(WVALID),
    .WSTRB(WSTRB),
    .i_fadds(i_fadds),
    .i_fsubs(i_fsubs),
    .i_fmuls(i_fmuls),
    .i_fdivs(i_fdivs),
    .i_feqs(i_feqs),
    .i_flts(i_flts),
    .i_fles(i_fles),
    .i_fcvtsw(i_fcvtsw),
    .i_fcvtws(i_fcvtws),
    .i_fsqrts(i_fsqrts),
    .rs1(rs1),
    .frs1(frs1),
    .frs2(frs2),
    .fpu_result(fpu_result),
    .tvalid_once(tvalid_once),
    .exec(exec),
    .stole(stole)
  );
endmodule
