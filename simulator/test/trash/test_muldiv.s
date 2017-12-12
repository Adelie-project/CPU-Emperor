set %r5, $0xfe9
set %r6, $0xa745
mul %r7, %r5, %r6 ; %r5 * %r6 = 0xa6548cd
set %r8, $0x8a3591f2 ; signed => -1976200718 unsigned => 2318766578
set %r9, $0x82d9fae7 ; signed => -2099643673 unsigned => 2195323623
mul %r10, %r8, %r9
mulh %r11, %r8, %r9 ; 4149317334126757214
mulhsu %r12, %r8, %r9 ; -4338400120014961314
mulhu %r13, %r8, %r9 ; 5090443044906272094
set %r15, $0x8594df1
set %r16, $0x3984
div %r17, %r15, %r16 ; %r15 * %r16 = 0x2529
set %r18, $0xf3819ab2
set %r19, $0x98fe14ab
div %r20, %r18, %r19
divu %r21, %r18, %r19
rem %r22, %r18, %r19
remu %r23, %r18, %r19
