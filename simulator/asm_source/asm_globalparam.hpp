#ifndef ASM_GLOBALPARAM_HPP
#define ASM_GLOBALPARAM_HPP

#include <iostream>
#include <climits>
#include <algorithm>
#include <vector>
#include <map>
#include <unordered_map>
using namespace std;
#define Loop(i, n) for(int i = 0; i < (int)n; i++)
#define Loop1(i, n) for(int i = 1; i <= (int)n; i++)
#define Loopr(i, n) for(int i = (int)n - 1; i >= 0; i--)
#define Loopr1(i, n) for(int i = (int)n; i >= 1; i--)
#define bitmanip(m,val) static_cast<bitset<(int)m>>(val)

#define BUFSIZE 256

struct param_t {
  string readline;
  vector<string> buf;
  FILE *fp, *mfp;
  unsigned pc_interval;
  unsigned lineno;
  unsigned pc;
  map<string, unsigned> labels;
  map<unsigned, pair<string,bool>> irregular;
  int comment_mode;
};

void init_param(param_t* param);

extern unordered_map<string, unsigned> x_regn;

extern vector<string> x_reg;

extern unordered_map<string, unsigned> f_regn;

extern vector<string> f_reg;

#endif
