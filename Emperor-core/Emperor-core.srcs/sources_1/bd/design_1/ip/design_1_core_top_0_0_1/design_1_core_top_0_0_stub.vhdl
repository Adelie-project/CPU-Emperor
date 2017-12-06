-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
-- Date        : Wed Dec  6 21:15:10 2017
-- Host        : ispc2016 running 64-bit Ubuntu 14.04.5 LTS
-- Command     : write_vhdl -force -mode synth_stub
--               /home/yamaguchi/CPU-Emperor/Emperor-core/Emperor-core.srcs/sources_1/bd/design_1/ip/design_1_core_top_0_0_1/design_1_core_top_0_0_stub.vhdl
-- Design      : design_1_core_top_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku040-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity design_1_core_top_0_0 is
  Port ( 
    RST_N : in STD_LOGIC;
    CLK : in STD_LOGIC;
    I_MEM_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
    I_MEM_ADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    MEM_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
    MEM_DATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    MEM_ADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    MEM_WE : out STD_LOGIC;
    ARADDR : out STD_LOGIC_VECTOR ( 3 downto 0 );
    ARREADY : in STD_LOGIC;
    ARVALID : out STD_LOGIC;
    AWADDR : out STD_LOGIC_VECTOR ( 3 downto 0 );
    AWREADY : in STD_LOGIC;
    AWVALID : out STD_LOGIC;
    BREADY : out STD_LOGIC;
    BRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    BVALID : in STD_LOGIC;
    RDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    RREADY : out STD_LOGIC;
    RRESP : in STD_LOGIC_VECTOR ( 1 downto 0 );
    RVALID : in STD_LOGIC;
    WDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    WREADY : in STD_LOGIC;
    WVALID : out STD_LOGIC;
    WSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 );
    i_fadds : out STD_LOGIC;
    i_fsubs : out STD_LOGIC;
    i_fmuls : out STD_LOGIC;
    i_fdivs : out STD_LOGIC;
    i_feqs : out STD_LOGIC;
    i_flts : out STD_LOGIC;
    i_fles : out STD_LOGIC;
    i_fcvtsw : out STD_LOGIC;
    i_fcvtws : out STD_LOGIC;
    i_fsqrts : out STD_LOGIC;
    rs1 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    frs1 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    frs2 : out STD_LOGIC_VECTOR ( 31 downto 0 );
    fpu_result : in STD_LOGIC_VECTOR ( 31 downto 0 );
    fpu_stole : in STD_LOGIC
  );

end design_1_core_top_0_0;

architecture stub of design_1_core_top_0_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "RST_N,CLK,I_MEM_IN[31:0],I_MEM_ADDR[31:0],MEM_IN[31:0],MEM_DATA[31:0],MEM_ADDR[31:0],MEM_WE,ARADDR[3:0],ARREADY,ARVALID,AWADDR[3:0],AWREADY,AWVALID,BREADY,BRESP[1:0],BVALID,RDATA[31:0],RREADY,RRESP[1:0],RVALID,WDATA[31:0],WREADY,WVALID,WSTRB[3:0],i_fadds,i_fsubs,i_fmuls,i_fdivs,i_feqs,i_flts,i_fles,i_fcvtsw,i_fcvtws,i_fsqrts,rs1[31:0],frs1[31:0],frs2[31:0],fpu_result[31:0],fpu_stole";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "core_top,Vivado 2016.4";
begin
end;
