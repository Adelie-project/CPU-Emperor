#include "globalparam.hpp"

void init_param (param_t* param) {
  //parameters
  param->pc_interval = 4; // default
  param->breakpoint = UINT_MAX;
  param->wave = 0;
  param->step = false;
  param->trace = ULLONG_MAX;
  param->fp = NULL; // 命令列ファイル記述子
  param->ifp = NULL; // 入力ファイル記述子
  param->ofp = NULL; // 出力ファイル記述子
  param->rbuf_p = 0; // rbuf中の何命令目
  param->rsize = 0; // rbuf中の有効なサイズ
  param->rbuf_begin = UINT_MAX - RBUFSIZE; // rbufが何命令目から始まっているか
  param->pc = 0; // 大域プログラムカウンタ、0から pc_interval ずつスタート
  param->prepc = UINT_MAX; // 直前のプログラムカウンタ、pc = prepcとなったときシミュレータは終了
  param->f_display = false; // 浮動小数点表示
  param->warn = false; // 警告表示
  param->cnt = 0; // 命令数カウント
  param->contest = true;
  param->breakcnt = ULONG_MAX;
  param->max_mem_no = 0; // 最大使用メモリ番号
  Loop(i, 128) param->call_time[i] = 0;
  fill_n(param->mem, MEM_LIMIT, 0); // バイトアドレス
}

void exit_message(param_t* param) {
  printf("program terminated in failure, in prePC = %08X, PC = %08X, cnt = %lld\n", param->prepc, param->pc, param->cnt);
  print_standard_reg(param);
  printf("\n\n");
  exit(EXIT_FAILURE);
}

void print_standard_reg(param_t* param) {
  Loop(i, 32) {
    if (i % 8 == 0) printf("\n");
    printf("r%02d:%08X ", i, param->reg[i]);
  }
  printf("\n");
  Loop(i, 32) {
    if (i % 8 == 0) printf("\n");
    if(param->f_display) printf("f%02d:%8f ", i, param->freg[i]);
    else {
      int_float_mover ifm;
      ifm.f = param->freg[i];
      printf("f%02d:%08X ", i, ifm.i);
    }
  }
  return;
}

unordered_map<string, unsigned> x_regn = {
  { "zero", 0 },
  { "ra", 1 },
  { "sp", 2 },
  { "gp", 3 },
  { "tp", 4 },
  { "t0", 5 },
  { "t1", 6 },
  { "t2", 7 },
  { "s0", 8 },{ "fp", 8 },
  { "s1", 9 },
  { "a0", 10 },
  { "a1", 11 },
  { "a2", 12 },
  { "a3", 13 },
  { "a4", 14 },
  { "a5", 15 },
  { "a6", 16 },
  { "a7", 17 },
  { "s2", 18 },
  { "s3", 19 },
  { "s4", 20 },
  { "s5", 21 },
  { "s6", 22 },
  { "s7", 23 },
  { "s8", 24 },
  { "s9", 25 },
  { "s10", 26 },
  { "s11", 27 },
  { "t3", 28 },
  { "t4", 29 },
  { "t5", 30 },
  { "t6", 31 }
};

vector<string> x_reg = {
  "zero", "ra", "sp", "gp", "tp", "t0", "t1", "t2",
  "s0", "s1", "a0", "a1", "a2", "a3", "a4", "a5",
  "a6", "a7", "s2", "s3", "s4", "s5", "s6", "s7",
  "s8", "s9", "s10", "s11", "t3", "t4", "t5", "t6"
};

unordered_map<string, unsigned> f_regn = {
  { "ft0", 0 },
  { "ft1", 1 },
  { "ft2", 2 },
  { "ft3", 3 },
  { "ft4", 4 },
  { "ft5", 5 },
  { "ft6", 6 },
  { "ft7", 7 },
  { "fs0", 8 },{ "fp", 8 },
  { "fs1", 9 },
  { "fa0", 10 },
  { "fa1", 11 },
  { "fa2", 12 },
  { "fa3", 13 },
  { "fa4", 14 },
  { "fa5", 15 },
  { "fa6", 16 },
  { "fa7", 17 },
  { "fs2", 18 },
  { "fs3", 19 },
  { "fs4", 20 },
  { "fs5", 21 },
  { "fs6", 22 },
  { "fs7", 23 },
  { "fs8", 24 },
  { "fs9", 25 },
  { "fs10", 26 },
  { "fs11", 27 },
  { "ft8", 28 },
  { "ft9", 29 },
  { "ft10", 30 },
  { "ft11", 31 }
};

vector<string> f_reg = {
  "ft0", "ft1", "ft2", "ft3", "ft4", "ft5", "ft6", "ft7",
  "fs0", "fs1", "fa0", "fa1", "fa2", "fa3", "fa4", "fa5",
  "fa6", "fa7", "fs2", "fs3", "fs4", "fs5", "fs6", "fs7",
  "fs8", "fs9", "fs10", "fs11", "ft8", "ft9", "ft10", "ft11"
};