
�
Command: %s
53*	vivadotcl2S
?write_bitstream -force -no_partial_bitfile design_1_wrapper.bit2default:defaultZ4-113h px� 
�
@Attempting to get a license for feature '%s' and/or device '%s'
308*common2"
Implementation2default:default2
xcku0402default:defaultZ17-347h px� 
�
0Got license for feature '%s' and/or device '%s'
310*common2"
Implementation2default:default2
xcku0402default:defaultZ17-349h px� 
�
�The version limit for your license is '%s' and will expire in %s days. A version limit expiration means that, although you may be able to continue to use the current version of tools or IP with this license, you will not be eligible for any updates or new releases.
519*common2
2017.032default:default2
-2512default:defaultZ17-1223h px� 
x
,Running DRC as a precondition to command %s
1349*	planAhead2#
write_bitstream2default:defaultZ12-1349h px� 
P
Running DRC with %s threads
24*drc2
42default:defaultZ23-27h px� 
�
Rule violation (%s) %s - %s
20*drc2
CFGBVS-12default:default2G
3Missing CFGBVS and CONFIG_VOLTAGE Design Properties2default:default2�
�Neither the CFGBVS nor CONFIG_VOLTAGE voltage property is set in the current_design.  Configuration bank voltage select (CFGBVS) must be set to VCCO or GND, and CONFIG_VOLTAGE must be set to the correct configuration voltage, in order to determine the I/O voltage support for the pins in bank 0.  It is suggested to specify these either using the 'Edit Device Properties' function in the GUI or directly in the XDC file using the following syntax:

 set_property CFGBVS value1 [current_design]
 #where value1 is either VCCO or GND

 set_property CONFIG_VOLTAGE value2 [current_design]
 #where value2 is the voltage provided to configuration bank 0

Refer to the device configuration user guide for more information.2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
	RTSTAT-102default:default2%
No routable loads2default:default2�
�31 net(s) have no routable loads. The problem bus(es) and/or net(s) are dbg_hub/inst/RUNTEST, dbg_hub/inst/TCK, dbg_hub/inst/TMS, dbg_hub/inst/UPDATE_temp_i, dbg_hub/inst/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_RD/U_RD_FIFO/SUBCORE_FIFO.xsdbm_v2_0_2_rdfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gr1.gr1_int.rfwft/aempty_fwft_i, dbg_hub/inst/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD7_CTL/ctl_reg[2:0], dbg_hub/inst/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD1/ctl_reg_en_2[1], dbg_hub/inst/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD7_CTL/ctl_reg_en_2[1], dbg_hub/inst/SWITCH_N_EXT_BSCAN.bscan_switch/m_bscan_capture[0], dbg_hub/inst/SWITCH_N_EXT_BSCAN.bscan_switch/m_bscan_drck[0], dbg_hub/inst/SWITCH_N_EXT_BSCAN.bscan_switch/m_bscan_flags[7:0], dbg_hub/inst/SWITCH_N_EXT_BSCAN.bscan_switch/m_bscan_runtest[0], dbg_hub/inst/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_RD/U_RD_FIFO/SUBCORE_FIFO.xsdbm_v2_0_2_rdfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.rd/gras.rsts/ram_empty_i, dbg_hub/inst/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_WR/U_WR_FIFO/SUBCORE_FIFO.xsdbm_v2_0_2_wrfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/gntv_or_sync_fifo.gl0.wr/gwas.wsts/ram_full_i, dbg_hub/inst/CORE_XSDB.UUT_MASTER/U_ICON_INTERFACE/U_CMD6_WR/U_WR_FIFO/SUBCORE_FIFO.xsdbm_v2_0_2_wrfifo_inst/inst_fifo_gen/gconvfifo.rf/grf.rf/rstblk/rd_rst_reg[0] (the first 15 of 22 listed).2default:defaultZ23-20h px� 
�
Rule violation (%s) %s - %s
20*drc2
AVAL-1552default:default2W
Cenum_AMULTSEL_BMULTSEL_enum_DREG_ADREG_0_connects_CED_CEAD_RSTD_GND2default:default2�
�design_1_i/floating_point_0/U0/i_synth/ADDSUB_OP.ADDSUB/SPEED_OP.DSP.OP/DSP48E1_BODY.NORM_RND/FULL_USAGE_DSP.SHIFT_RND/DSP: DSP48E2 is not using the D port (AMULTSEL = A and BMULTSEL = B). For improved power characteristics, set DREG and ADREG to '1', tie CED, CEAD, and RSTD to logic '0'.2default:defaultZ23-20h px� 
t
DRC finished with %s
1905*	planAhead26
"0 Errors, 2 Warnings, 1 Advisories2default:defaultZ12-3199h px� 
i
BPlease refer to the DRC report (report_drc) for more information.
1906*	planAheadZ12-3200h px� 
?
Loading data files...
1271*designutilsZ12-1165h px� 
>
Loading site data...
1273*designutilsZ12-1167h px� 
?
Loading route data...
1272*designutilsZ12-1166h px� 
?
Processing options...
1362*designutilsZ12-1514h px� 
<
Creating bitmap...
1249*designutilsZ12-1141h px� 
7
Creating bitstream...
7*	bitstreamZ40-7h px� 
g
Writing bitstream %s...
11*	bitstream2*
./design_1_wrapper.bit2default:defaultZ40-11h px� 
F
Bitgen Completed Successfully.
1606*	planAheadZ12-1842h px� 
s
QWebTalk data collection is enabled (User setting is ON. Install Setting is ON.).
118*projectZ1-118h px� 
�
�'%s' has been successfully sent to Xilinx on %s. For additional details about this file, please refer to the Webtalk help file at %s.
186*common2r
^/home/yamaguchi/CPU-Emperor/Emperor-core/Emperor-core.runs/impl_1/usage_statistics_webtalk.xml2default:default2,
Thu Dec  7 12:54:09 20172default:default2K
7/opt/Xilinx/Vivado/2016.4/doc/webtalk_introduction.html2default:defaultZ17-186h px� 
Z
Releasing license: %s
83*common2"
Implementation2default:defaultZ17-83h px� 
�
G%s Infos, %s Warnings, %s Critical Warnings and %s Errors encountered.
28*	vivadotcl2
962default:default2
42default:default2
02default:default2
02default:defaultZ4-41h px� 
a
%s completed successfully
29*	vivadotcl2#
write_bitstream2default:defaultZ4-42h px� 
�
r%sTime (s): cpu = %s ; elapsed = %s . Memory (MB): peak = %s ; gain = %s ; free physical = %s ; free virtual = %s
480*common2%
write_bitstream: 2default:default2
00:00:592default:default2
00:00:522default:default2
3871.9262default:default2
395.5702default:default2
76862default:default2
268392default:defaultZ17-722h px� 


End Record