#include "encoder.hpp"

unordered_map<string, struct r_factors> r_type = {
  {     "add", {0b0000000, 0b000, 0b0110011, STD} },
  {     "sub", {0b0100000, 0b000, 0b0110011, STD} },
  {     "sll", {0b0000000, 0b001, 0b0110011, STD} },
  {     "slt", {0b0000000, 0b010, 0b0110011, STD} },
  {    "sltu", {0b0000000, 0b011, 0b0110011, STD} },
  {     "xor", {0b0000000, 0b100, 0b0110011, STD} },
  {     "srl", {0b0000000, 0b101, 0b0110011, STD} },
  {     "sra", {0b0100000, 0b101, 0b0110011, STD} },
  {      "or", {0b0000000, 0b110, 0b0110011, STD} },
  {     "and", {0b0000000, 0b111, 0b0110011, STD} },
  {    "slli", {0b0000000, 0b001, 0b0010011, SHIFT} },
  {    "srli", {0b0000000, 0b101, 0b0010011, SHIFT} },
  {    "srai", {0b0100000, 0b101, 0b0010011, SHIFT} },
  {     "mul", {0b0000001, 0b000, 0b0110011, STD} },
  {    "mulh", {0b0000001, 0b001, 0b0110011, STD} },
  {  "mulhsu", {0b0000001, 0b010, 0b0110011, STD} },
  {   "mulhu", {0b0000001, 0b011, 0b0110011, STD} },
  {     "div", {0b0000001, 0b100, 0b0110011, STD} },
  {    "divu", {0b0000001, 0b101, 0b0110011, STD} },
  {     "rem", {0b0000001, 0b110, 0b0110011, STD} },
  {    "remu", {0b0000001, 0b111, 0b0110011, STD} },
  {   "fadds", {0b0000000,    RM, 0b1010011, FSTD} },
  {   "fmuls", {0b0001000,    RM, 0b1010011, FSTD} },
  {   "fsubs", {0b0000100,    RM, 0b1010011, FSTD} },
  {   "fdivs", {0b0001100,    RM, 0b1010011, FSTD} },
  {    "feqs", {0b1010000, 0b010, 0b1010011, FCMP} },
  {    "flts", {0b1010000, 0b001, 0b1010011, FCMP} },
  {    "fles", {0b1010000, 0b000, 0b1010011, FCMP} },
  {   "fmvsx", {0b1111000, 0b000, 0b1010011, FSX} },
  {   "fmvxs", {0b1110000, 0b000, 0b1010011, FXS} },
  {  "fcvtsw", {0b1101000,    RM, 0b1010011, FSX} },
  {  "fcvtws", {0b1100000,    RM, 0b1010011, FXS} },
  {  "fsqrts", {0b0101100,    RM, 0b1010011, FUNARY} },
  { "fsgnjxs", {0b0010000, 0b010, 0b1010011, FSTD} },
  {     "rot", {0b0000000, 0b001, 0b0001011, UNARY} }
};

unordered_map<string, struct i_factors> i_type = {
  {  "addi", {0b000, 0b0010011, STD} },
  {  "slti", {0b010, 0b0010011, STD} },
  { "sltiu", {0b011, 0b0010011, STD} },
  {  "xori", {0b100, 0b0010011, STD} },
  {   "ori", {0b110, 0b0010011, STD} },
  {  "andi", {0b111, 0b0010011, STD} },
  {  "jalr", {0b000, 0b1100111, STD} },
  {    "lb", {0b000, 0b0000011, STD} },
  {    "lh", {0b001, 0b0000011, STD} },
  {    "lw", {0b010, 0b0000011, STD} },
  {   "lbu", {0b100, 0b0000011, STD} },
  {   "lhu", {0b101, 0b0000011, STD} },
  {   "flw", {0b010, 0b0000111, FL} },
  {    "in", {0b000, 0b0000001, IN} }
};

unordered_map<string, struct i_factors> s_type = {
  {    "sb", {0b000, 0b0100011, STD} },
  {    "sh", {0b001, 0b0100011, STD} },
  {    "sw", {0b010, 0b0100011, STD} },
  {   "fsw", {0b010, 0b0100111, FS} },
  {   "out", {0b001, 0b0000001, OUT} }
};

unordered_map<string, struct i_factors> sb_type = {
  {   "beq", {0b000, 0b1100011, STD} },
  {   "bne", {0b001, 0b1100011, STD} },
  {   "blt", {0b100, 0b1100011, STD} },
  {   "bge", {0b101, 0b1100011, STD} },
  {  "bltu", {0b110, 0b1100011, STD} },
  {  "bgeu", {0b111, 0b1100011, STD} }
};
unordered_map<string, struct u_factors> u_type = {
  {   "lui", {0b0110111, STD} },
  { "auipc", {0b0010111, STD} }
};
unordered_map<string, struct u_factors> uj_type = {
  {   "jal", {0b1101111, STD} }
};

const char reg_pattern[16][4] = {
  { 'x', 'x', 'x', 'x' }, //STD
  { 'x', 'x', 'x', 'x' }, //SHIFT
  { 'f', 'f', 'f', 'f' }, //FSTD
  { 'x', 'f', 'f', 'x' }, //FCMP
  { 'f', 'x', 'x', 'x' }, //FL
  { 'x', 'f', 'x', 'x' }, //FS
  { 'f', 'x', 'x', 'x' }, //FSX
  { 'x', 'f', 'x', 'x' }, //FXS
  { 'f', 'f', 'f', 'f' }, //FUNARY
  { 'x', 'x', 'x', 'x' }, //UNARY
  { 'x', 'x', 'x', 'x' }, //IN
  { 'x', 'x', 'x', 'x' }  //OUT
};

unsigned set_regn(param_t *param, unsigned k, proc_t proc) {
  if (reg_pattern[proc][k - 1] == 'x') {
    unordered_map<string, unsigned>::iterator itr_xrn;
    if ((itr_xrn = x_regn.find(param->buf[k])) != x_regn.end()) return itr_xrn->second;
    else { printf("\x1b[31merror\x1b[39m: inappropriate integer register name of \"%s\" in line %d\n", param->buf[k].c_str(), param->lineno); exit(EXIT_FAILURE); }
	}
  else if (reg_pattern[proc][k - 1] == 'f') {
    unordered_map<string, unsigned>::iterator itr_frn;
    if ((itr_frn = f_regn.find(param->buf[k])) != f_regn.end()) return itr_frn->second;
    else { printf("\x1b[31merror\x1b[39m: inappropriate integer register name of \"%s\" in line %d\n", param->buf[k].c_str(), param->lineno); exit(EXIT_FAILURE); }
  }
  else { printf("program error\n"); exit(EXIT_FAILURE); }
}

inline int set_imm(param_t *param, unsigned k, int digit) {
  int imm;
  char *strtol_endptr;
  if(param->buf[k].size() > 2 && param->buf[k][0] == '0' && param->buf[k][1] == 'x') {
    //16進数
    imm = strtol((param->buf[k]).substr(0, (param->buf[k]).size()).c_str(), &strtol_endptr, 16);
    if (*strtol_endptr != '\0') {
      printf("\x1b[31merror\x1b[39m: invalid immediate \"%s\" in line %d\n", param->buf[k].c_str(), param->lineno); exit(EXIT_FAILURE);
    }
    if (digit < 32 && (unsigned)imm >> digit) {
      printf("\x1b[35mwarning\x1b[39m: immediate is out of range (%d bit) in line %d\n", digit, param->lineno);
    }
  }
  else {
    //それ以外は10進数とみなす
    imm = strtol((param->buf[k]).substr(0, (param->buf[k]).size()).c_str(), &strtol_endptr, 10);
    if (*strtol_endptr != '\0') {
      printf("\x1b[31merror\x1b[39m: invalid immediate \"%s\" in line %d\n", param->buf[k].c_str(), param->lineno); exit(EXIT_FAILURE);
    }
    if (digit != 32 && (imm >= (1 << (digit - 1)) || imm < -1 * (1 << (digit - 1)))) {
      printf("\x1b[35mwarning\x1b[39m: immediate %d is out of range (%d bit) in line %d\n", imm, digit, param->lineno);
    }
  }
  return imm;
}

inline int set_shamt(param_t *param, unsigned k) {
  char *strtoul_endptr;
  unsigned shamt = strtoul((param->buf[k]).substr(0,param->buf[k].size()).c_str(), &strtoul_endptr, 0);
  if (errno == EINVAL) printf("\x1b[35mwarning\x1b[39m: improper representation of shamt in line %d\n", param->lineno);
  if (*strtoul_endptr != '\0') {
    printf("\x1b[31merror\x1b[39m: invalid immediate \"%s\" in line %d\n", param->buf[k].c_str(), param->lineno); exit(EXIT_FAILURE);
  }
  if (shamt >> 5) printf("\x1b[35mwarning\x1b[39m: shamt is out of range (5 bit) in line %d\n", param->lineno);
  return shamt;
}

unsigned result;
unsigned rd, rs1, rs2;
int imm;
unordered_map<string , struct r_factors>::iterator itr_r;
unordered_map<string , struct i_factors>::iterator itr_i;
unordered_map<string , struct u_factors>::iterator itr_u;

unsigned encoding(param_t *param) {
  //R-type
  if ((itr_r = r_type.find(param->buf[0])) != r_type.end()) {
    proc_t proc = (itr_r->second).proc;
    if (param->buf.size() != 4) { printf("\x1b[31merror\x1b[39m: the number of arguments is imappropriate in line %d\n", param->lineno); exit(EXIT_FAILURE); }
    rd = set_regn(param, 1, proc);
    rs1 = set_regn(param, 2, proc);
    if (proc == SHIFT) rs2 = set_shamt(param, 3);
    else if (proc == FSX || proc == FXS || proc == FUNARY || proc == UNARY) rs2 = 0;
    else rs2 = set_regn(param, 3, proc);
    result = (itr_r->second).funct7 << 25 | rs2 << 20 | rs1 << 15
           | (itr_r->second).funct3 << 12 | rd << 7 | (itr_r->second).opcode;
  }
  //I-type
  else if ((itr_i = i_type.find(param->buf[0])) != i_type.end()) {
    proc_t proc = (itr_i->second).proc;
    if (proc == IN) {
      if (param->buf.size() != 2) { printf("\x1b[31merror\x1b[39m: the number of arguments is imappropriate in line %d\n", param->lineno); exit(EXIT_FAILURE); }
    }
    else if (param->buf.size() != 4) { printf("\x1b[31merror\x1b[39m: the number of arguments is imappropriate in line %d\n", param->lineno); exit(EXIT_FAILURE); }
    rd = set_regn(param, 1, proc);
    if (proc == IN) { rs1 = 0; imm = 0; }
    else {
      rs1 = set_regn(param, 2, proc);
      imm = set_imm(param, 3, 12);
    }
    result = imm << 20 | rs1 << 15
           | (itr_i->second).funct3 << 12 | rd << 7 | (itr_i->second).opcode;
  }
  //S-type
  else if ((itr_i = s_type.find(param->buf[0])) != s_type.end()) {
    proc_t proc = (itr_i->second).proc;
    if (proc == OUT) {
      if (param->buf.size() != 2) { printf("\x1b[31merror\x1b[39m: the number of arguments is imappropriate in line %d\n", param->lineno); exit(EXIT_FAILURE); }
    }
    else if (param->buf.size() != 4) { printf("\x1b[31merror\x1b[39m: the number of arguments is imappropriate in line %d\n", param->lineno); exit(EXIT_FAILURE); }
    rs1 = set_regn(param, 1, proc);
    if (proc == OUT) { rs2 = 0; imm = 0; }
    else {
      rs2 = set_regn(param, 2, proc);
      imm = set_imm(param, 3, 12);
    }
    result = (imm & 0xfe0) << 20 | rs2 << 20 | rs1 << 15
           | (itr_i->second).funct3 << 12 | (imm & 0x1f) << 7 | (itr_i->second).opcode;
  }
  //SB-type
  else if ((itr_i = sb_type.find(param->buf[0])) != sb_type.end()) {
    proc_t proc = (itr_i->second).proc;
    if (param->buf.size() != 4) { printf("\x1b[31merror\x1b[39m: the number of arguments is imappropriate in line %d\n", param->lineno); exit(EXIT_FAILURE); }
    rs1 = set_regn(param, 1, proc);
    rs2 = set_regn(param, 2, proc);
    auto itr = (param->labels).find(param->buf[3]);
    if (itr->second == UINT_MAX) { printf("\x1b[31merror\x1b[39m: register name is used in 3rd argument (here should be a label name or immediate) in line %d\n", param->lineno); exit(EXIT_FAILURE); }
    else if (itr == (param->labels).end()) imm = set_imm(param, 3, 13);
    else imm = itr->second - param->pc;
    result = (imm & 0x1000) << 19 | (imm & 0x7e0) << 20 | rs2 << 20 | rs1 << 15
           | (itr_i->second).funct3 << 12 | (imm & 0x1e) << 7 | (imm & 0x800) >> 4 | (itr_i->second).opcode;
  }
  //U-type
  else if ((itr_u = u_type.find(param->buf[0])) != u_type.end()) {
    proc_t proc = (itr_u->second).proc;
    if (param->buf.size() != 3) { printf("\x1b[31merror\x1b[39m: the number of arguments is imappropriate in line %d\n", param->lineno); exit(EXIT_FAILURE); }
    rd = set_regn(param, 1, proc);
    imm = set_imm(param, 2, 32);
    if (imm & 0xfff) printf("\x1b[35mwarning\x1b[39m: lower 12 bits of immediate will be ignored in line %d\n", param->lineno);
    result = (imm & 0xfffff000) | rd << 7 | (itr_u->second).opcode;
  }
  //UJ-type
  else if ((itr_u = uj_type.find(param->buf[0])) != uj_type.end()) {
    proc_t proc = (itr_u->second).proc;
    if (param->buf.size() != 3) { printf("\x1b[31merror\x1b[39m: the number of arguments is imappropriate in line %d\n", param->lineno); exit(EXIT_FAILURE); }
    rd = set_regn(param, 1, proc);
    auto itr = (param->labels).find(param->buf[2]);
    if (itr->second == UINT_MAX) { printf("\x1b[31merror\x1b[39m: register name is used in 3rd argument (here should be a label name or immediate) in line %d\n", param->lineno); exit(EXIT_FAILURE); }
    else if (itr == (param->labels).end()) imm = set_imm(param, 2, 21);
    else imm = itr->second - param->pc;
    result = (imm & 0x100000) << 11 | (imm & 0x7fe) << 20 | (imm & 0x800) << 9
           | (imm & 0xff000) | rd << 7 | (itr_u->second).opcode;
  }
  else {
    printf("\x1b[31merror\x1b[39m: unknown mnemonic in line %d\n", param->lineno); exit(EXIT_FAILURE);
  }
  return result;
}
