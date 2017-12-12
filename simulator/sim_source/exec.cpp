#include "exec.hpp"

inline void pc_inclement(param_t* param){
  (param->rbuf_p)++;
  param->prepc = param->pc;
  (param->pc) += (param->pc_interval);
}

void exec_jmp_fread(param_t* param, unsigned newpc) {
  if (param->rbuf_begin * param->pc_interval <= newpc && newpc < (param->rbuf_begin + RBUFSIZE) * param->pc_interval) {
    param->rbuf_p = newpc  / param->pc_interval - param->rbuf_begin;
  }
  else {
    if (fseek(param->fp, newpc * 4 / param->pc_interval, SEEK_SET) != 0) { perror("fseek error"); exit_message(param); }
    param->rsize = fread(param->rbuf, sizeof(unsigned), RBUFSIZE, param->fp);
    if (param->rsize < 0) { perror("fread error"); exit_message(param); }
    param->rbuf_begin = newpc;
    param->rbuf_p = 0;
    decode_all(param);
  }
  param->prepc = param->pc;
  param->pc = newpc;
  if (param->rsize == 0) { printf("pc %d: no instruction\n", param->pc); exit_message(param); }
  return;
}

inline void exec_branch(param_t* param, bool b, int *imm, const char *mnemonic, unsigned *rs1, unsigned *rs2) {
  if(param->step) printf("%s %s, %s, %d\n", mnemonic, x_reg[*rs1].c_str(), x_reg[*rs2].c_str(), *imm);
  if(b) exec_jmp_fread(param, param->pc + *imm);
  else pc_inclement(param);
  return;
}

inline void set_sb_type(param_t* param, unsigned* rs1, unsigned* rs2, int* imm) {
  *rs1 = (param->decoded)[param->rbuf_p][1];
  *rs2 = (param->decoded)[param->rbuf_p][2];
  *imm = (param->decoded)[param->rbuf_p][3];
  //12th bit = sign
  if ((param->decoded)[param->rbuf_p][3] & 0x1000) (param->decoded)[param->rbuf_p][3] = (param->decoded)[param->rbuf_p][3] | 0xFFFFE000;
}

inline void set_i_type(param_t* param, unsigned* rd, unsigned* rs1, int* imm) {
  *rd = (param->decoded)[param->rbuf_p][1];
  *rs1 = (param->decoded)[param->rbuf_p][2];
  *imm = (param->decoded)[param->rbuf_p][3];
  //11th bit = sign
  if ((param->decoded)[param->rbuf_p][3] & 0x800) (param->decoded)[param->rbuf_p][3] = (param->decoded)[param->rbuf_p][3] | 0xFFFFF000;
}

inline void set_s_type(param_t* param, unsigned* rs1, unsigned* rs2, int* imm) {
  *rs1 = (param->decoded)[param->rbuf_p][1];
  *rs2 = (param->decoded)[param->rbuf_p][2];
  *imm = (param->decoded)[param->rbuf_p][3];
  //11th bit = sign
  if ((param->decoded)[param->rbuf_p][3] & 0x800) (param->decoded)[param->rbuf_p][3] = (param->decoded)[param->rbuf_p][3] | 0xFFFFF000;
}

inline void set_r_type(param_t* param, unsigned* rd, unsigned* rs1, unsigned*rs2) {
  *rd = (param->decoded)[param->rbuf_p][1];
  *rs1 = (param->decoded)[param->rbuf_p][2];
  *rs2 = (param->decoded)[param->rbuf_p][3];
}

inline void set_u_type(param_t* param, unsigned* rd, int* imm) {
  *rd = (param->decoded)[param->rbuf_p][1];
  *imm = (param->decoded)[param->rbuf_p][2];
}

inline void set_uj_type(param_t* param, unsigned* rd, int* imm) {
  *rd = (param->decoded)[param->rbuf_p][1];
  *imm = (param->decoded)[param->rbuf_p][2];
}

//param->rbuf_p
int imm;
unsigned evac;
unsigned rs1, rs2, rd;
int_float_mover ifm, ifm2;
unsigned char in_data, out_data;

inline void warn_nan(param_t* param) {
  if (isnanf(param->freg[rd])) {
    printf("\x1b[35mwarning\x1b[39m: nan is written in freg[%d], when PC = %d, cnt = %lld\n", rd, param->pc, param->cnt);
  }
}


inline int float_to_int(float x) {
  // ties to even
  int ret;
  int n = x;
  if (x >= 0) {
    if (x - n == 0.5) {
      if (n % 2 == 1) ret = n + 1;
      else ret = n;
    }
    else if (x - n < 0.5) ret = n;
    else ret = n + 1;
  }
  else {
    if (n - x == 0.5) {
      if (n % 2 == -1) ret = n - 1;
      else ret = n;
    }
    else if (n - x < 0.5) ret = n;
    else ret = n - 1;
  }
  return ret;
}

void exec_main(param_t* param) {
  param->cnt++;
  if(param->trace <= param->cnt) {
    if(param->trace + TRACE_SIZE <= param->cnt) exit(EXIT_SUCCESS);
    printf("%lld, %d\n", param->cnt, param->pc);
  }
  param->call_time[(param->decoded)[param->rbuf_p][0]]++;
  switch((param->decoded)[param->rbuf_p][0]) {
    case LUI:
      set_u_type(param, &rd, &imm);
      if(param->step) printf("lui %s, %d\n", x_reg[rd].c_str(), imm);
      if(rd != 0) param->reg[rd] = imm;
      pc_inclement(param);
      return;
    case AUIPC:
      set_u_type(param, &rd, &imm);
      if(param->step) printf("auipc %s, %d\n", x_reg[rd].c_str(), imm);
      if(rd != 0) param->reg[rd] = param->pc + imm;
      exec_jmp_fread(param, param->pc + imm);
      return;
    case JAL:
      set_uj_type(param, &rd, &imm);
      if(param->step) printf("jal %s, %d\n", x_reg[rd].c_str(), imm);
      if(rd != 0) param->reg[rd] = param->pc + param->pc_interval;
      exec_jmp_fread(param, param->pc + imm);
      return;
    case JALR:
      set_i_type(param, &rd, &rs1, &imm);
      if(param->step) printf("jalr %s, %s, %d\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), imm);
      evac = param->pc + param->pc_interval;
      exec_jmp_fread(param, param->reg[rs1] + imm);
      if(rd != 0) param->reg[rd] = evac;
      return;
    case BEQ:
      set_sb_type(param, &rs1, &rs2, &imm);
      exec_branch(param, param->reg[rs1] == param->reg[rs2], &imm, "beq", &rs1, &rs2);
      return;
    case BNE:
      set_sb_type(param, &rs1, &rs2, &imm);
      exec_branch(param, param->reg[rs1] != param->reg[rs2], &imm, "bne", &rs1, &rs2);
      return;
    case BLT:
      set_sb_type(param, &rs1, &rs2, &imm);
      exec_branch(param, param->reg[rs1] < param->reg[rs2], &imm, "blt", &rs1, &rs2);
      return;
    case BGE:
      set_sb_type(param, &rs1, &rs2, &imm);
      exec_branch(param, param->reg[rs1] >= param->reg[rs2], &imm, "bge", &rs1, &rs2);
      return;
    case BLTU:
      set_sb_type(param, &rs1, &rs2, &imm);
      exec_branch(param, (unsigned)(param->reg[rs1]) < (unsigned)(param->reg[rs2]), &imm, "bltu", &rs1, &rs2);
      return;
    case BGEU:
      set_sb_type(param, &rs1, &rs2, &imm);
      exec_branch(param, (unsigned)(param->reg[rs1]) >= (unsigned)(param->reg[rs2]), &imm, "bgeu", &rs1, &rs2);
      return;
    case LB:
      set_i_type(param, &rd, &rs1, &imm);
      if(param->step) printf("lb %s, %s, %d\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), imm);
      evac = param->reg[rs1] + imm;
      param->max_mem_no = max(param->max_mem_no, evac);
      if(rd != 0) param->reg[rd] = (char)(0x000000ff & param->mem[evac]);
      pc_inclement(param);
      return;
    case LH:
      set_i_type(param, &rd, &rs1, &imm);
      if(param->step) printf("lh %s, %s, %d\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), imm);
      evac = param->reg[rs1] + imm;
      param->max_mem_no = max(param->max_mem_no, evac);
      if(rd != 0) param->reg[rd] = (short)(0x0000ffff & param->mem[evac]);
      pc_inclement(param);
      return;
    case LW:
      set_i_type(param, &rd, &rs1, &imm);
      if(param->step) printf("lw %s, %s, %d\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), imm);
      evac = param->reg[rs1] + imm;
      param->max_mem_no = max(param->max_mem_no, evac);
      if(rd != 0) param->reg[rd] = (int)(param->mem[evac]);
      pc_inclement(param);
      return;
    case LBU:
      set_i_type(param, &rd, &rs1, &imm);
      if(param->step) printf("lbu %s, %s, %d\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), imm);
      evac = param->reg[rs1] + imm;
      param->max_mem_no = max(param->max_mem_no, evac);
      if(rd != 0) param->reg[rd] = (0x000000ff & param->mem[evac]);
      pc_inclement(param);
      return;
    case LHU:
      set_i_type(param, &rd, &rs1, &imm);
      if(param->step) printf("lhu %s, %s, %d\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), imm);
      evac = param->reg[rs1] + imm;
      param->max_mem_no = max(param->max_mem_no, evac);
      if(rd != 0) param->reg[rd] = (0x0000ffff & param->mem[evac]);
      pc_inclement(param);
      return;
    case SB:
      set_s_type(param, &rs1, &rs2, &imm);
      if(param->step) printf("sb %s, %s, %d\n", x_reg[rs1].c_str(), x_reg[rs2].c_str(), imm);
      evac = param->reg[rs1] + imm;
      param->max_mem_no = max(param->max_mem_no, evac);
      param->mem[evac] = 0x000000ff & param->reg[rs2];
      pc_inclement(param);
      return;
    case SH:
      set_s_type(param, &rs1, &rs2, &imm);
      if(param->step) printf("sh %s, %s, %d\n", x_reg[rs1].c_str(), x_reg[rs2].c_str(), imm);
      evac = param->reg[rs1] + imm;
      param->max_mem_no = max(param->max_mem_no, evac);
      param->mem[evac] = 0x0000ffff & param->reg[rs2];
      pc_inclement(param);
      return;
    case SW:
      set_s_type(param, &rs1, &rs2, &imm);
      if(param->step) printf("sw %s, %s, %d\n", x_reg[rs1].c_str(), x_reg[rs2].c_str(), imm);
      evac = param->reg[rs1] + imm;
      param->max_mem_no = max(param->max_mem_no, evac);
      param->mem[evac] = param->reg[rs2];
      pc_inclement(param);
      return;
    case ADDI:
      set_i_type(param, &rd, &rs1, &imm);
      if(param->step) printf("addi %s, %s, %d\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), imm);
      if(rd != 0) param->reg[rd] = param->reg[rs1] + imm;
      pc_inclement(param);
      return;
    case SLTI:
      set_i_type(param, &rd, &rs1, &imm);
      if(param->step) printf("slti %s, %s, %d\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), imm);
      if(rd != 0) param->reg[rd] = param->reg[rs1] < imm ? 1 : 0;
      pc_inclement(param);
      return;
    case SLTIU:
      set_i_type(param, &rd, &rs1, &imm);
      if(param->step) printf("sltiu %s, %s, %d\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), imm);
      if(rd != 0) param->reg[rd] = (unsigned)(param->reg[rs1]) < (unsigned)imm ? 1 : 0;
      pc_inclement(param);
      return;
    case XORI:
      set_i_type(param, &rd, &rs1, &imm);
      if(param->step) printf("xori %s, %s, %d\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), imm);
      if(rd != 0) param->reg[rd] = param->reg[rs1];
      pc_inclement(param);
      return;
    case ORI:
      set_i_type(param, &rd, &rs1, &imm);
      if(param->step) printf("ori %s, %s, %d\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), imm);
      if(rd != 0) param->reg[rd] = param->reg[rs1];
      pc_inclement(param);
      return;
    case ANDI:
      set_i_type(param, &rd, &rs1, &imm);
      if(param->step) printf("andi %s, %s, %d\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), imm);
      if(rd != 0) param->reg[rd] = param->reg[rs1];
      pc_inclement(param);
      return;
    case SLLI:
      set_i_type(param, &rd, &rs1, &imm);
      if(param->step) printf("slli %s, %s, %d\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), imm);
      if(rd != 0) param->reg[rd] = (unsigned)(param->reg[rs1]) << imm;
      pc_inclement(param);
      return;
    case SRLI:
      set_i_type(param, &rd, &rs1, &imm);
      if(param->step) printf("srli %s, %s, %d\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), imm);
      if(rd != 0) param->reg[rd] = (unsigned)(param->reg[rs1]) >> imm;
      pc_inclement(param);
      return;
    case SRAI:
      set_i_type(param, &rd, &rs1, &imm);
      if(param->step) printf("srai %s, %s, %d\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), imm);
      if(rd != 0) param->reg[rd] = param->reg[rs1] >> imm;
      pc_inclement(param);
      return;
    case ADD:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("add %s, %s, %s\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), x_reg[rs2].c_str());
      if(rd != 0) param->reg[rd] = param->reg[rs1] + param->reg[rs2];
      pc_inclement(param);
      return;
    case SUB:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("sub %s, %s, %s\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), x_reg[rs2].c_str());
      if(rd != 0) param->reg[rd] = param->reg[rs1] - param->reg[rs2];
      pc_inclement(param);
      return;
    case SLL:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("sll %s, %s, %s\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), x_reg[rs2].c_str());
      if(rd != 0) param->reg[rd] = (unsigned)(param->reg[rs1]) << (param->reg[rs2] & 0b11111);
      pc_inclement(param);
      return;
    case SLT:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("slt %s, %s, %s\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), x_reg[rs2].c_str());
      if(rd != 0) param->reg[rd] = param->reg[rs1] < param->reg[rs2] ? 1 : 0;
      pc_inclement(param);
      return;
    case SLTU:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("sltu %s, %s, %s\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), x_reg[rs2].c_str());
      if(rd != 0) param->reg[rd] = (unsigned)(param->reg[rs1]) < (unsigned)(param->reg[rs2]) ? 1 : 0;
      pc_inclement(param);
      return;
    case XOR:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("xor %s, %s, %s\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), x_reg[rs2].c_str());
      if(rd != 0) param->reg[rd] = param->reg[rs1] ^ param->reg[rs2];
      pc_inclement(param);
      return;
    case SRL:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("srl %s, %s, %s\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), x_reg[rs2].c_str());
      if(rd != 0) param->reg[rd] = (unsigned)(param->reg[rs1]) >> (param->reg[rs2] & 0b11111);
      pc_inclement(param);
      return;
    case SRA:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("sra %s, %s, %s\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), x_reg[rs2].c_str());
      if(rd != 0) param->reg[rd] = param->reg[rs1] >> (param->reg[rs2] & 0b11111);
      pc_inclement(param);
      return;
    case OR:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("or %s, %s, %s\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), x_reg[rs2].c_str());
      if(rd != 0) param->reg[rd] = param->reg[rs1] | param->reg[rs2];
      pc_inclement(param);
      return;
    case AND:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("and %s, %s, %s\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), x_reg[rs2].c_str());
      if(rd != 0) param->reg[rd] = param->reg[rs1] & param->reg[rs2];
      pc_inclement(param);
      return;
    case MUL:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("mul %s, %s, %s\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), x_reg[rs2].c_str());
      if(rd != 0) param->reg[rd] = param->reg[rs1] * param->reg[rs2];
      pc_inclement(param);
      return;
    case MULH:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("mulh %s, %s, %s\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), x_reg[rs2].c_str());
      if(rd != 0) param->reg[rd] = ((long long)param->reg[rs1] * (long long)param->reg[rs2]) >> 32;
      pc_inclement(param);
      return;
    case MULHSU:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("mulhsu %s, %s, %s\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), x_reg[rs2].c_str());
      if(rd != 0) param->reg[rd] = ((long long)param->reg[rs1] * (long long)((unsigned)param->reg[rs2])) >> 32;
      pc_inclement(param);
      return;
    case MULHU:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("mulhu %s, %s, %s\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), x_reg[rs2].c_str());
      if(rd != 0) param->reg[rd] = ((long long)((unsigned)param->reg[rs1]) * (long long)((unsigned)param->reg[rs2])) >> 32;
      pc_inclement(param);
      return;
    case DIV:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("div %s, %s, %s\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), x_reg[rs2].c_str());
      if(rd != 0) param->reg[rd] = param->reg[rs1] / param->reg[rs2];
      pc_inclement(param);
      return;
    case DIVU:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("divu %s, %s, %s\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), x_reg[rs2].c_str());
      if(rd != 0) param->reg[rd] = (unsigned)param->reg[rs1] / (unsigned)param->reg[rs2];
      pc_inclement(param);
      return;
    case REM:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("rem %s, %s, %s\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), x_reg[rs2].c_str());
      if(rd != 0) param->reg[rd] = param->reg[rs1] % param->reg[rs2];
      pc_inclement(param);
      return;
    case REMU:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("remu %s, %s, %s\n", x_reg[rd].c_str(), x_reg[rs1].c_str(), x_reg[rs2].c_str());
      if(rd != 0) param->reg[rd] = (unsigned)param->reg[rs1] % (unsigned)param->reg[rs2];
      pc_inclement(param);
      return;
    case FLW:
      set_i_type(param, &rd, &rs1, &imm);
      if(param->step) printf("flw %s, %s, %d\n", f_reg[rd].c_str(), x_reg[rs1].c_str(), imm);
      evac = param->reg[rs1] + imm;
      param->max_mem_no = max(param->max_mem_no, evac);
      ifm.u = param->mem[evac];
      if(rd != 0) { param->freg[rd] = ifm.f; warn_nan(param); }
      pc_inclement(param);
      return;
    case FSW:
      set_s_type(param, &rs1, &rs2, &imm);
      if(param->step) printf("fsw %s, %s, %d\n", x_reg[rs1].c_str(), f_reg[rs2].c_str(), imm);
      evac = param->reg[rs1] + imm;
      param->max_mem_no = max(param->max_mem_no, evac);
      ifm.f = param->freg[rs2];
      param->mem[evac] = ifm.u;
      pc_inclement(param);
      return;
    case FADDS:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("fadds %s, %s, %s\n", f_reg[rd].c_str(), f_reg[rs1].c_str(), f_reg[rs2].c_str());
      if(rd != 0) { param->freg[rd] = param->freg[rs1] + param->freg[rs2]; warn_nan(param); }
      pc_inclement(param);
      return;
    case FSUBS:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("fsubs %s, %s, %s\n", f_reg[rd].c_str(), f_reg[rs1].c_str(), f_reg[rs2].c_str());
      if(rd != 0) { param->freg[rd] = param->freg[rs1] - param->freg[rs2]; warn_nan(param); }
      pc_inclement(param);
      return;
    case FMULS:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("fmuls %s, %s, %s\n", f_reg[rd].c_str(), f_reg[rs1].c_str(), f_reg[rs2].c_str());
      if(rd != 0) { param->freg[rd] = param->freg[rs1] * param->freg[rs2]; warn_nan(param); }
      pc_inclement(param);
      return;
    case FDIVS:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("fdiv %s, %s, %s\n", f_reg[rd].c_str(), f_reg[rs1].c_str(), f_reg[rs2].c_str());
      if(rd != 0) { param->freg[rd] = param->freg[rs1] / param->freg[rs2]; warn_nan(param); }
      pc_inclement(param);
      return;
    case FLTS:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("flts %s, %s, %s\n", x_reg[rd].c_str(), f_reg[rs1].c_str(), f_reg[rs2].c_str());
      if(rd != 0) param->reg[rd] = param->freg[rs1] < param->freg[rs2] ? 1 : 0;
      pc_inclement(param);
      return;
    case FLES:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("fles %s, %s, %s\n", x_reg[rd].c_str(), f_reg[rs1].c_str(), f_reg[rs2].c_str());
      if(rd != 0) param->reg[rd] = param->freg[rs1] <= param->freg[rs2] ? 1 : 0;
      pc_inclement(param);
      return;
    case FEQS:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("feqs %s, %s, %s\n", x_reg[rd].c_str(), f_reg[rs1].c_str(), f_reg[rs2].c_str());
      if(rd != 0) param->reg[rd] = param->freg[rs1] == param->freg[rs2] ? 1 : 0;
      pc_inclement(param);
      return;
    case FMVSX:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("fmvsx %s, %s\n", f_reg[rd].c_str(), x_reg[rs1].c_str());
      ifm.i = param->reg[rs1];
      if(rd != 0) { param->freg[rd] = ifm.f; warn_nan(param); }
      pc_inclement(param);
      return;
    case FMVXS:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("fmvxs %s, %s\n", x_reg[rd].c_str(), f_reg[rs1].c_str());
      ifm.f = param->freg[rs1];
      if(rd != 0) param->reg[rd] = ifm.i;
      pc_inclement(param);
      return;
    case FCVTSW:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("fcvtsw %s, %s\n", f_reg[rd].c_str(), x_reg[rs1].c_str());
      if(rd != 0) { param->freg[rd] = param->reg[rs1]; warn_nan(param); }
      pc_inclement(param);
      return;
    case FCVTWS:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("fcvtws %s, %s\n", x_reg[rd].c_str(), f_reg[rs1].c_str());
      if(rd != 0) param->reg[rd] = float_to_int(param->freg[rs1]);
      pc_inclement(param);
      return;
    case FSQRTS:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("fsqrts %s, %s\n", f_reg[rd].c_str(), f_reg[rs1].c_str());
      if(rd != 0) { param->freg[rd] = sqrt(param->freg[rs1]); warn_nan(param); }
      pc_inclement(param);
      return;
    case FSGNJXS:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("fsgnjxs %s, %s, %s\n", f_reg[rd].c_str(), f_reg[rs1].c_str(), f_reg[rs2].c_str());
      ifm.f = param->freg[rs1];
      ifm2.f = param->freg[rs2];
      ifm.i = (ifm.i & 0x7fffffff) | ((ifm.i ^ ifm2.i) & 0x80000000);
      if(rd != 0) param->freg[rd] = ifm.f;
      pc_inclement(param);
      return;
    case ROT:
      set_r_type(param, &rd, &rs1, &rs2);
      if(param->step) printf("rot %s, %s\n", x_reg[rd].c_str(), x_reg[rs1].c_str());
      if(rd != 0) param->reg[rd] =
        ((unsigned)(param->reg[rs1] & 0xff000000) >> 24)
      | ((unsigned)(param->reg[rs1] & 0x00ff0000) >> 8)
      | ((unsigned)(param->reg[rs1] & 0x0000ff00) << 8)
      | ((unsigned)(param->reg[rs1] & 0x000000ff) << 24);
      pc_inclement(param);
      return;
    case IN:
      set_i_type(param, &rd, &rs1, &imm);
      if(param->step) printf("in %s\n", x_reg[rd].c_str());
      if(param->ifp == NULL) { printf("error: no input file though \"in\" is called.\n"); exit(EXIT_FAILURE); }
      if(param->contest) { printf("error: could not catch 0xaa though simulator is in contest-mode.\n"); exit(EXIT_FAILURE); }
      if((int)fread(&in_data, sizeof(unsigned char), 1, param->ifp) < 0) { perror("fread error"); exit_message(param); }
      if(rd != 0) param->reg[rd] = (param->reg[rd] & 0xffffff00) | (unsigned)in_data;
      pc_inclement(param);
      return;
    case OUT:
      set_s_type(param, &rs1, &rs2, &imm);
      if(param->step) printf("out %s\n", x_reg[rs1].c_str());
      if(param->ofp == NULL) { printf("error: no output file though \"out\" is called.\n"); exit(EXIT_FAILURE); }
      out_data = param->reg[rs1] & 0x000000ff;
      if(param->contest && out_data == 0xaa) param->contest = false;
      else if (fwrite(&out_data, sizeof(unsigned char), 1, param->ofp) != 1) {
        perror("fwrite error"); exit_message(param);
      }
      pc_inclement(param);
      return;
    default:
      printf("unknown fatal error, exit\n");
      exit_message(param);
  }
  return;
}
