-- Copyright 1986-2016 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2016.4 (lin64) Build 1756540 Mon Jan 23 19:11:19 MST 2017
-- Date        : Wed Dec  6 17:43:44 2017
-- Host        : ispc2016 running 64-bit Ubuntu 14.04.5 LTS
-- Command     : write_vhdl -force -mode synth_stub -rename_top decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix -prefix
--               decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix_ design_1_core_top_0_0_stub.vhdl
-- Design      : design_1_core_top_0_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xcku040-ffva1156-2-e
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
  Port ( 
    RST_N : in STD_LOGIC;
    CLK : in STD_LOGIC;
    I_MEM_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
    I_MEM_ADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    MEM_IN : in STD_LOGIC_VECTOR ( 31 downto 0 );
    MEM_DATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    MEM_ADDR : out STD_LOGIC_VECTOR ( 31 downto 0 );
    MEM_WE : out STD_LOGIC;
    ADDSUB_A_TDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ADDSUB_A_TREADY : in STD_LOGIC;
    ADDSUB_A_TVALID : out STD_LOGIC;
    ADDSUB_B_TDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    ADDSUB_B_TREADY : in STD_LOGIC;
    ADDSUB_B_TVALID : out STD_LOGIC;
    ADDSUB_OP_TDATA : out STD_LOGIC_VECTOR ( 7 downto 0 );
    ADDSUB_OP_TREADY : in STD_LOGIC;
    ADDSUB_OP_TVALID : out STD_LOGIC;
    ADDSUB_R_TDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    ADDSUB_R_TREADY : out STD_LOGIC;
    ADDSUB_R_TVALID : in STD_LOGIC;
    MUL_A_TDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    MUL_A_TREADY : in STD_LOGIC;
    MUL_A_TVALID : out STD_LOGIC;
    MUL_B_TDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    MUL_B_TREADY : in STD_LOGIC;
    MUL_B_TVALID : out STD_LOGIC;
    MUL_R_TDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    MUL_R_TREADY : out STD_LOGIC;
    MUL_R_TVALID : in STD_LOGIC;
    DIV_A_TDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    DIV_A_TREADY : in STD_LOGIC;
    DIV_A_TVALID : out STD_LOGIC;
    DIV_B_TDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    DIV_B_TREADY : in STD_LOGIC;
    DIV_B_TVALID : out STD_LOGIC;
    DIV_R_TDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    DIV_R_TREADY : out STD_LOGIC;
    DIV_R_TVALID : in STD_LOGIC;
    COMP_A_TDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    COMP_A_TREADY : in STD_LOGIC;
    COMP_A_TVALID : out STD_LOGIC;
    COMP_B_TDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    COMP_B_TREADY : in STD_LOGIC;
    COMP_B_TVALID : out STD_LOGIC;
    COMP_OP_TDATA : out STD_LOGIC_VECTOR ( 7 downto 0 );
    COMP_OP_TREADY : in STD_LOGIC;
    COMP_OP_TVALID : out STD_LOGIC;
    COMP_R_TDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    COMP_R_TREADY : out STD_LOGIC;
    COMP_R_TVALID : in STD_LOGIC;
    FCVTSW_A_TDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    FCVTSW_A_TREADY : in STD_LOGIC;
    FCVTSW_A_TVALID : out STD_LOGIC;
    FCVTSW_R_TDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    FCVTSW_R_TREADY : out STD_LOGIC;
    FCVTSW_R_TVALID : in STD_LOGIC;
    FCVTWS_A_TDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    FCVTWS_A_TREADY : in STD_LOGIC;
    FCVTWS_A_TVALID : out STD_LOGIC;
    FCVTWS_R_TDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    FCVTWS_R_TREADY : out STD_LOGIC;
    FCVTWS_R_TVALID : in STD_LOGIC;
    FSQRTS_A_TDATA : out STD_LOGIC_VECTOR ( 31 downto 0 );
    FSQRTS_A_TREADY : in STD_LOGIC;
    FSQRTS_A_TVALID : out STD_LOGIC;
    FSQRTS_R_TDATA : in STD_LOGIC_VECTOR ( 31 downto 0 );
    FSQRTS_R_TREADY : out STD_LOGIC;
    FSQRTS_R_TVALID : in STD_LOGIC;
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
    WSTRB : out STD_LOGIC_VECTOR ( 3 downto 0 )
  );

end decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix;

architecture stub of decalper_eb_ot_sdeen_pot_pi_dehcac_xnilix is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "RST_N,CLK,I_MEM_IN[31:0],I_MEM_ADDR[31:0],MEM_IN[31:0],MEM_DATA[31:0],MEM_ADDR[31:0],MEM_WE,ADDSUB_A_TDATA[31:0],ADDSUB_A_TREADY,ADDSUB_A_TVALID,ADDSUB_B_TDATA[31:0],ADDSUB_B_TREADY,ADDSUB_B_TVALID,ADDSUB_OP_TDATA[7:0],ADDSUB_OP_TREADY,ADDSUB_OP_TVALID,ADDSUB_R_TDATA[31:0],ADDSUB_R_TREADY,ADDSUB_R_TVALID,MUL_A_TDATA[31:0],MUL_A_TREADY,MUL_A_TVALID,MUL_B_TDATA[31:0],MUL_B_TREADY,MUL_B_TVALID,MUL_R_TDATA[31:0],MUL_R_TREADY,MUL_R_TVALID,DIV_A_TDATA[31:0],DIV_A_TREADY,DIV_A_TVALID,DIV_B_TDATA[31:0],DIV_B_TREADY,DIV_B_TVALID,DIV_R_TDATA[31:0],DIV_R_TREADY,DIV_R_TVALID,COMP_A_TDATA[31:0],COMP_A_TREADY,COMP_A_TVALID,COMP_B_TDATA[31:0],COMP_B_TREADY,COMP_B_TVALID,COMP_OP_TDATA[7:0],COMP_OP_TREADY,COMP_OP_TVALID,COMP_R_TDATA[31:0],COMP_R_TREADY,COMP_R_TVALID,FCVTSW_A_TDATA[31:0],FCVTSW_A_TREADY,FCVTSW_A_TVALID,FCVTSW_R_TDATA[31:0],FCVTSW_R_TREADY,FCVTSW_R_TVALID,FCVTWS_A_TDATA[31:0],FCVTWS_A_TREADY,FCVTWS_A_TVALID,FCVTWS_R_TDATA[31:0],FCVTWS_R_TREADY,FCVTWS_R_TVALID,FSQRTS_A_TDATA[31:0],FSQRTS_A_TREADY,FSQRTS_A_TVALID,FSQRTS_R_TDATA[31:0],FSQRTS_R_TREADY,FSQRTS_R_TVALID,ARADDR[3:0],ARREADY,ARVALID,AWADDR[3:0],AWREADY,AWVALID,BREADY,BRESP[1:0],BVALID,RDATA[31:0],RREADY,RRESP[1:0],RVALID,WDATA[31:0],WREADY,WVALID,WSTRB[3:0]";
attribute X_CORE_INFO : string;
attribute X_CORE_INFO of stub : architecture is "core_top,Vivado 2016.4";
begin
end;
