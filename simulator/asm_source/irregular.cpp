#include "irregular.hpp"

void divide(param_t *param) {
  param->buf = {};
  unsigned k = 0, i = 0;
  int syntax_mode = 0;
  for(; i < (param->readline).length(); i++) {
    char c = param->readline[i];
    // comment mode
    if (param->comment_mode == 0 && c == '/') { param->comment_mode = 1; c = ' '; }
    else if (param->comment_mode == 1) {
      if (c == '*') { param->comment_mode = 2; c = ' '; }
      else { printf("\x1b[31merror\x1b[39m: syntax error in character %d, line %d\n", i+1, param->lineno); exit(EXIT_FAILURE); }
    }
    else if (param->comment_mode == 2) {
      if (c == '*') { param->comment_mode = 3; c = ' '; }
      else c = ' ';
    }
    else if (param->comment_mode == 3) {
      if (c == '/') { param->comment_mode = 0; c = ' '; }
      else { param->comment_mode = 2; c = ' '; }
    }
    //
    if (c == ';') break;
    else if (c <= ' ' || c == '\t') {
      if (k != i) {
        (param->buf).push_back(param->readline.substr(k, i - k));
        if (syntax_mode == 0) syntax_mode = 1;
        else if (syntax_mode == 1) syntax_mode = 2;
      }
      k = i + 1;
    }
    else {
      if (syntax_mode == 2) { printf("\x1b[31merror\x1b[39m: syntax error in character %d, line %d\n", i+1, param->lineno); exit(EXIT_FAILURE); }
      if (c == ':') {
        (param->buf).push_back(param->readline.substr(k, i - k + 1));
        syntax_mode = 2;
        k = i + 1;
      }
      else if (c == ',') {
        if (syntax_mode == 0) { printf("\x1b[31merror\x1b[39m: syntax error in character %d, line %d\n", i+1, param->lineno); exit(EXIT_FAILURE); }
        (param->buf).push_back(param->readline.substr(k, i - k));
        k = i + 1;
      }
    }
  }
  if (k != i) (param->buf).push_back(param->readline.substr(k, i - k));
  return;
}

void pre_parse_irregular(param_t* param) {
  /*
  if(param->buf[0] == "set") {
    unsigned rd = set_regn(param, 1, STD);
    auto itr = (param->labels).find(param->buf[2]);
    if (itr->second == UINT_MAX) { printf("\x1b[31merror\x1b[39m: register name is used in 3rd argumentould not find the label: %s used in line %d\n", (param->buf.back()).c_str(), param->lineno); exit(EXIT_FAILURE); }
    if(param->buf[2][0] == '$') {
      int imm = strtol((param->buf[2]).substr(1, (param->buf[2]).size()-1).c_str(), NULL, 0);
      unsigned imm_upper = (unsigned)imm & 0xfffff000, imm_lower = (unsigned)imm & 0xfff;
      stringstream ss_u, ss_l;
      if(imm_lower > 0x7ff) imm_upper += 0x1000;
      ss_u << "0x" << hex << imm_upper;
      ss_l << "0x" << hex << imm_lower;
      if (imm_lower == 0) {
        param->irregular[param->pc] = { "lui " + x_reg[rd] + ", " + ss_u.str(), false };
      }
      else if (imm_upper == 0) {
        param->irregular[param->pc] = { "addi " + x_reg[rd] + ", zero, " + ss_l.str(), false};
      }
      else {
        param->irregular[param->pc] = { "lui " + x_reg[rd] + ", " + ss_u.str(), true };
        param->pc += param->pc_interval;
        param->irregular[param->pc] = { "addi " + x_reg[rd] + ", " + x_reg[rd] + ", " + ss_l.str(), false};
      }
    }
    else {
        param->irregular[param->pc] = { "lui " + x_reg[rd] + ", " + param->buf[2], true };
        param->pc += param->pc_interval;
        param->irregular[param->pc] = { "addi " + x_reg[rd] + ", " + x_reg[rd] + ", " + param->buf[2], false };
    }
  }
  */
}

void parse_irregular(param_t* param) {
  //絶対アドレスの検索
  auto itr = (param->labels).find(param->buf.back());
  if (itr == (param->labels).end()) { printf("\x1b[31merror\x1b[39m: could not find the label: %s used in line %d\n", (param->buf.back()).c_str(), param->lineno); exit(EXIT_FAILURE); }
  else if (itr->second == UINT_MAX) return;
  else {
    if (param->buf[0] == "lui") {
      unsigned a = itr->second & 0xfffff000;
      if ((itr->second & 0xfff) > 0x7ff) a += 0x1000;
      param->buf.back() = to_string(a);
    }
    else {
      unsigned a = itr->second & 0xfff;
      if (a & 0x800) a |= 0xfffff000;
      param->buf.back() = to_string(a);
    }
    return;
  }
}
