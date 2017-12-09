module core_div (

  input RST_N,
  input CLK,

  input wire [31:0] int_div_a_tdata,
  output reg int_div_a_tready,
  input wire int_div_a_tvalid,
  input wire [31:0] int_div_b_tdata,
  output reg int_div_b_tready,
  input wire int_div_b_tvalid,
  input wire [1:0] int_div_op_tdata,
  output reg int_div_op_tready,
  input wire int_div_op_tvalid,
  output reg [31:0] int_div_r_tdata,
  input wire int_div_r_tready,
  output reg int_div_r_tvalid

  );

  // int_div_op に対応
  localparam I_DIV = 2'b00;
  localparam I_DIVU = 2'b01;
  localparam I_REM = 2'b10;
  localparam I_REMU = 2'b11;

  reg [16:0] div_trace_valid;
  reg [16:0] div_trace_a_sign;
  reg [16:0] div_trace_b_sign;
  reg [1:0] div_trace_op[16:0];
  reg div_r_sign;

  reg [63:0] div_stage0[1:0];
  reg [63:0] div_stage1[5:0];
  reg [61:0] div_stage2[5:0];
  reg [59:0] div_stage3[5:0];
  reg [57:0] div_stage4[5:0];
  reg [55:0] div_stage5[5:0];
  reg [53:0] div_stage6[5:0];
  reg [51:0] div_stage7[5:0];
  reg [49:0] div_stage8[5:0];
  reg [47:0] div_stage9[5:0];
  reg [45:0] div_stage10[5:0];
  reg [43:0] div_stage11[5:0];
  reg [41:0] div_stage12[5:0];
  reg [39:0] div_stage13[5:0];
  reg [37:0] div_stage14[5:0];
  reg [35:0] div_stage15[5:0];
  reg [33:0] div_stage16[5:0];

  wire int_div_agreement;
  wire int_div_stole;

  assign int_div_agreement = int_div_a_tready && int_div_a_tvalid && int_div_b_tready && int_div_b_tvalid && int_div_op_tready && int_div_op_tvalid;
  assign int_div_stole = !int_div_r_tready && int_div_r_tvalid;

  // 開始時制御信号
  always @(posedge CLK) begin
    if(!RST_N) begin
      int_div_a_tready <= 0;
      int_div_b_tready <= 0;
      int_div_op_tready <= 0;
    end else begin
      int_div_a_tready <= int_div_agreement ? 0 :
                          int_div_r_tvalid ? 0 : 1;
      int_div_b_tready <= int_div_agreement ? 0 :
                          int_div_r_tvalid ? 0 : 1;
      int_div_op_tready <= int_div_agreement ? 0 :
                           int_div_r_tvalid ? 0 : 1;
    end
  end

  // 入力値
  always @(posedge CLK) begin
    if(!RST_N) begin
      div_stage0[0] <= 0;
      div_stage0[1] <= 0;
      div_trace_a_sign[0] <= 0;
      div_trace_b_sign[0] <= 0;
      div_trace_op[0] <= 0;
      div_trace_valid[0] <= 0;
    end else begin
      div_stage0[0] <= int_div_agreement ? ((int_div_op_tdata == I_DIVU || int_div_op_tdata == I_REMU) ? int_div_a_tdata
                                    : int_div_a_tdata[31] ? { 0 - {2'b11, int_div_a_tdata[31:0]}, 30'b0 }  : int_div_a_tdata)
                       : div_stage0[0];
      div_stage0[1] <= int_div_agreement ? ((int_div_op_tdata == I_DIVU || int_div_op_tdata == I_REMU)? { int_div_b_tdata, 30'b0 }
                                    : int_div_b_tdata[31] ? { 0 - {2'b11, int_div_b_tdata[31:0]}, 30'b0 } : { int_div_b_tdata, 30'b0 })
                       : div_stage0[1];
      div_trace_a_sign[0] <= int_div_agreement ? ((int_div_op_tdata == I_DIVU || int_div_op_tdata == I_REMU)? 0 : int_div_a_tdata[31]) : div_trace_a_sign[0];
      div_trace_b_sign[0] <= int_div_agreement ? ((int_div_op_tdata == I_DIVU || int_div_op_tdata == I_REMU)? 0 : int_div_b_tdata[31]) : div_trace_b_sign[0];
      div_trace_op[0] <= int_div_agreement ? int_div_op_tdata : div_trace_op[0];
      div_trace_valid[0] <= int_div_agreement ? 1 : 0;
    end
  end

  always @(posedge CLK) begin
    if(!RST_N) begin
      div_trace_valid[1] <= 0;
    end else if(!int_div_stole) begin
      div_stage1[0] <= div_stage0[0];
      div_stage1[1] <= div_stage0[0] - div_stage0[1];
      div_stage1[2] <= div_stage0[0] - { div_stage0[1], 1'b0 };
      div_stage1[3] <= div_stage0[0] - ( { div_stage0[1], 1'b0 } + div_stage0[1] );
      div_stage1[4] <= 0;
      div_stage1[5] <= div_stage0[1][61:2];
      div_trace_a_sign[1] <= div_trace_a_sign[0];
      div_trace_b_sign[1] <= div_trace_b_sign[0];
      div_trace_op[1] <= div_trace_op[0];
      div_trace_valid[1] <= div_trace_valid[0];
    end
  end

  //div_stage2 ~ div_stage15 の代入は実質for文, ここから
  always @(posedge CLK) begin
    if(!RST_N) begin
      div_trace_valid[2] <= 0;
    end else if(!int_div_stole) begin
      if(!div_stage1[3][63]) begin
        div_stage2[0] <= div_stage1[3];
        div_stage2[1] <= div_stage1[3] - div_stage1[5];
        div_stage2[2] <= div_stage1[3] - { div_stage1[5], 1'b0 };
        div_stage2[3] <= div_stage1[3] - ( { div_stage1[5], 1'b0 } + div_stage1[5] );
        div_stage2[4] <= { 2'b11, div_stage1[4][29:0] };
      end else if(!div_stage1[2][63]) begin
        div_stage2[0] <= div_stage1[2];
        div_stage2[1] <= div_stage1[2] - div_stage1[5];
        div_stage2[2] <= div_stage1[2] - { div_stage1[5], 1'b0 };
        div_stage2[3] <= div_stage1[2] - ( { div_stage1[5], 1'b0 } + div_stage1[5] );
        div_stage2[4] <= { 2'b10, div_stage1[4][29:0] };
      end else if(!div_stage1[1][63]) begin
        div_stage2[0] <= div_stage1[1];
        div_stage2[1] <= div_stage1[1] - div_stage1[5];
        div_stage2[2] <= div_stage1[1] - { div_stage1[5], 1'b0 };
        div_stage2[3] <= div_stage1[1] - ( { div_stage1[5], 1'b0 } + div_stage1[5] );
        div_stage2[4] <= { 2'b01, div_stage1[4][29:0] };
      end else begin
        div_stage2[0] <= div_stage1[0];
        div_stage2[1] <= div_stage1[0] - div_stage1[5];
        div_stage2[2] <= div_stage1[0] - { div_stage1[5], 1'b0 };
        div_stage2[3] <= div_stage1[0] - ( { div_stage1[5], 1'b0 } + div_stage1[5] );
        div_stage2[4] <= div_stage1[4];
      end
      div_stage2[5] <= div_stage1[5][59:2];
      div_trace_a_sign[2] <= div_trace_a_sign[1];
      div_trace_b_sign[2] <= div_trace_b_sign[1];
      div_trace_op[2] <= div_trace_op[1];
      div_trace_valid[2] <= div_trace_valid[1];
    end
  end

  always @(posedge CLK) begin
    if(!RST_N) begin
      div_trace_valid[3] <= 0;
    end else if(!int_div_stole) begin
      if(!div_stage2[3][61]) begin
        div_stage3[0] <= div_stage2[3];
        div_stage3[1] <= div_stage2[3] - div_stage2[5];
        div_stage3[2] <= div_stage2[3] - { div_stage2[5], 1'b0 };
        div_stage3[3] <= div_stage2[3] - ({ div_stage2[5], 1'b0 } + div_stage2[5]);
        div_stage3[4] <= { div_stage2[4][31:30], 2'b11, div_stage2[4][27:0] };
      end else if(!div_stage2[2][61]) begin
        div_stage3[0] <= div_stage2[2];
        div_stage3[1] <= div_stage2[2] - div_stage2[5];
        div_stage3[2] <= div_stage2[2] - { div_stage2[5], 1'b0 };
        div_stage3[3] <= div_stage2[2] - ({ div_stage2[5], 1'b0 } + div_stage2[5]);
        div_stage3[4] <= { div_stage2[4][31:30], 2'b10, div_stage2[4][27:0] };
      end else if(!div_stage2[1][61]) begin
        div_stage3[0] <= div_stage2[1];
        div_stage3[1] <= div_stage2[1] - div_stage2[5];
        div_stage3[2] <= div_stage2[1] - { div_stage2[5], 1'b0 };
        div_stage3[3] <= div_stage2[1] - ({ div_stage2[5], 1'b0 } + div_stage2[5]);
        div_stage3[4] <= { div_stage2[4][31:30], 2'b01, div_stage2[4][27:0] };
      end else begin
        div_stage3[0] <= div_stage2[0];
        div_stage3[1] <= div_stage2[0] - div_stage2[5];
        div_stage3[2] <= div_stage2[0] - { div_stage2[5], 1'b0 };
        div_stage3[3] <= div_stage2[0] - ({ div_stage2[5], 1'b0 } + div_stage2[5]);
        div_stage3[4] <= div_stage2[4];
      end
      div_stage3[5] <= div_stage2[5][57:2];
      div_trace_a_sign[3] <= div_trace_a_sign[2];
      div_trace_b_sign[3] <= div_trace_b_sign[2];
      div_trace_op[3] <= div_trace_op[2];
      div_trace_valid[3] <= div_trace_valid[2];
    end
  end

  always @(posedge CLK) begin
    if(!RST_N) begin
      div_trace_valid[4] <= 0;
    end else if(!int_div_stole) begin
      if(!div_stage3[3][59]) begin
        div_stage4[0] <= div_stage3[3];
        div_stage4[1] <= div_stage3[3] - div_stage3[5];
        div_stage4[2] <= div_stage3[3] - { div_stage3[5], 1'b0 };
        div_stage4[3] <= div_stage3[3] - ({ div_stage3[5], 1'b0 } + div_stage3[5]);
        div_stage4[4] <= { div_stage3[4][31:28], 2'b11, div_stage3[4][25:0] };
      end else if(!div_stage3[2][59]) begin
        div_stage4[0] <= div_stage3[2];
        div_stage4[1] <= div_stage3[2] - div_stage3[5];
        div_stage4[2] <= div_stage3[2] - { div_stage3[5], 1'b0 };
        div_stage4[3] <= div_stage3[2] - ({ div_stage3[5], 1'b0 } + div_stage3[5]);
        div_stage4[4] <= { div_stage3[4][31:28], 2'b10, div_stage3[4][25:0] };
      end else if(!div_stage3[1][59]) begin
        div_stage4[0] <= div_stage3[1];
        div_stage4[1] <= div_stage3[1] - div_stage3[5];
        div_stage4[2] <= div_stage3[1] - { div_stage3[5], 1'b0 };
        div_stage4[3] <= div_stage3[1] - ({ div_stage3[5], 1'b0 } + div_stage3[5]);
        div_stage4[4] <= { div_stage3[4][31:28], 2'b01, div_stage3[4][25:0] };
      end else begin
        div_stage4[0] <= div_stage3[0];
        div_stage4[1] <= div_stage3[0] - div_stage3[5];
        div_stage4[2] <= div_stage3[0] - { div_stage3[5], 1'b0 };
        div_stage4[3] <= div_stage3[0] - ({ div_stage3[5], 1'b0 } + div_stage3[5]);
        div_stage4[4] <= div_stage3[4];
      end
      div_stage4[5] <= div_stage3[5][55:2];
      div_trace_a_sign[4] <= div_trace_a_sign[3];
      div_trace_b_sign[4] <= div_trace_b_sign[3];
      div_trace_op[4] <= div_trace_op[3];
      div_trace_valid[4] <= div_trace_valid[3];
    end
  end

  always @(posedge CLK) begin
    if(!RST_N) begin
      div_trace_valid[5] <= 0;
    end else if(!int_div_stole) begin
      if(!div_stage4[3][57]) begin
        div_stage5[0] <= div_stage4[3];
        div_stage5[1] <= div_stage4[3] - div_stage4[5];
        div_stage5[2] <= div_stage4[3] - { div_stage4[5], 1'b0 };
        div_stage5[3] <= div_stage4[3] - ({ div_stage4[5], 1'b0 } + div_stage4[5]);
        div_stage5[4] <= { div_stage4[4][31:26], 2'b11, div_stage4[4][23:0] };
      end else if(!div_stage4[2][57]) begin
        div_stage5[0] <= div_stage4[2];
        div_stage5[1] <= div_stage4[2] - div_stage4[5];
        div_stage5[2] <= div_stage4[2] - { div_stage4[5], 1'b0 };
        div_stage5[3] <= div_stage4[2] - ({ div_stage4[5], 1'b0 } + div_stage4[5]);
        div_stage5[4] <= { div_stage4[4][31:26], 2'b10, div_stage4[4][23:0] };
      end else if(!div_stage4[1][57]) begin
        div_stage5[0] <= div_stage4[1];
        div_stage5[1] <= div_stage4[1] - div_stage4[5];
        div_stage5[2] <= div_stage4[1] - { div_stage4[5], 1'b0 };
        div_stage5[3] <= div_stage4[1] - ({ div_stage4[5], 1'b0 } + div_stage4[5]);
        div_stage5[4] <= { div_stage4[4][31:26], 2'b01, div_stage4[4][23:0] };
      end else begin
        div_stage5[0] <= div_stage4[0];
        div_stage5[1] <= div_stage4[0] - div_stage4[5];
        div_stage5[2] <= div_stage4[0] - { div_stage4[5], 1'b0 };
        div_stage5[3] <= div_stage4[0] - ({ div_stage4[5], 1'b0 } + div_stage4[5]);
        div_stage5[4] <= div_stage4[4];
      end
      div_stage5[5] <= div_stage4[5][53:2];
      div_trace_a_sign[5] <= div_trace_a_sign[4];
      div_trace_b_sign[5] <= div_trace_b_sign[4];
      div_trace_op[5] <= div_trace_op[4];
      div_trace_valid[5] <= div_trace_valid[4];
    end
  end

  always @(posedge CLK) begin
    if(!RST_N) begin
      div_trace_valid[6] <= 0;
    end else if(!int_div_stole) begin
      if(!div_stage5[3][55]) begin
        div_stage6[0] <= div_stage5[3];
        div_stage6[1] <= div_stage5[3] - div_stage5[5];
        div_stage6[2] <= div_stage5[3] - { div_stage5[5], 1'b0 };
        div_stage6[3] <= div_stage5[3] - ({ div_stage5[5], 1'b0 } + div_stage5[5]);
        div_stage6[4] <= { div_stage5[4][31:24], 2'b11, div_stage5[4][21:0] };
      end else if(!div_stage5[2][55]) begin
        div_stage6[0] <= div_stage5[2];
        div_stage6[1] <= div_stage5[2] - div_stage5[5];
        div_stage6[2] <= div_stage5[2] - { div_stage5[5], 1'b0 };
        div_stage6[3] <= div_stage5[2] - ({ div_stage5[5], 1'b0 } + div_stage5[5]);
        div_stage6[4] <= { div_stage5[4][31:24], 2'b10, div_stage5[4][21:0] };
      end else if(!div_stage5[1][55]) begin
        div_stage6[0] <= div_stage5[1];
        div_stage6[1] <= div_stage5[1] - div_stage5[5];
        div_stage6[2] <= div_stage5[1] - { div_stage5[5], 1'b0 };
        div_stage6[3] <= div_stage5[1] - ({ div_stage5[5], 1'b0 } + div_stage5[5]);
        div_stage6[4] <= { div_stage5[4][31:24], 2'b01, div_stage5[4][21:0] };
      end else begin
        div_stage6[0] <= div_stage5[0];
        div_stage6[1] <= div_stage5[0] - div_stage5[5];
        div_stage6[2] <= div_stage5[0] - { div_stage5[5], 1'b0 };
        div_stage6[3] <= div_stage5[0] - ({ div_stage5[5], 1'b0 } + div_stage5[5]);
        div_stage6[4] <= div_stage5[4];
      end
      div_stage6[5] <= div_stage5[5][51:2];
      div_trace_a_sign[6] <= div_trace_a_sign[5];
      div_trace_b_sign[6] <= div_trace_b_sign[5];
      div_trace_op[6] <= div_trace_op[5];
      div_trace_valid[6] <= div_trace_valid[5];
    end
  end

  always @(posedge CLK) begin
    if(!RST_N) begin
      div_trace_valid[7] <= 0;
    end else if(!int_div_stole) begin
      if(!div_stage6[3][53]) begin
        div_stage7[0] <= div_stage6[3];
        div_stage7[1] <= div_stage6[3] - div_stage6[5];
        div_stage7[2] <= div_stage6[3] - { div_stage6[5], 1'b0 };
        div_stage7[3] <= div_stage6[3] - ({ div_stage6[5], 1'b0 } + div_stage6[5]);
        div_stage7[4] <= { div_stage6[4][31:22], 2'b11, div_stage6[4][19:0] };
      end else if(!div_stage6[2][53]) begin
        div_stage7[0] <= div_stage6[2];
        div_stage7[1] <= div_stage6[2] - div_stage6[5];
        div_stage7[2] <= div_stage6[2] - { div_stage6[5], 1'b0 };
        div_stage7[3] <= div_stage6[2] - ({ div_stage6[5], 1'b0 } + div_stage6[5]);
        div_stage7[4] <= { div_stage6[4][31:22], 2'b10, div_stage6[4][19:0] };
      end else if(!div_stage6[1][53]) begin
        div_stage7[0] <= div_stage6[1];
        div_stage7[1] <= div_stage6[1] - div_stage6[5];
        div_stage7[2] <= div_stage6[1] - { div_stage6[5], 1'b0 };
        div_stage7[3] <= div_stage6[1] - ({ div_stage6[5], 1'b0 } + div_stage6[5]);
        div_stage7[4] <= { div_stage6[4][31:22], 2'b01, div_stage6[4][19:0] };
      end else begin
        div_stage7[0] <= div_stage6[0];
        div_stage7[1] <= div_stage6[0] - div_stage6[5];
        div_stage7[2] <= div_stage6[0] - { div_stage6[5], 1'b0 };
        div_stage7[3] <= div_stage6[0] - ({ div_stage6[5], 1'b0 } + div_stage6[5]);
        div_stage7[4] <= div_stage6[4];
      end
      div_stage7[5] <= div_stage6[5][49:2];
      div_trace_a_sign[7] <= div_trace_a_sign[6];
      div_trace_b_sign[7] <= div_trace_b_sign[6];
      div_trace_op[7] <= div_trace_op[6];
      div_trace_valid[7] <= div_trace_valid[6];
    end
  end

  always @(posedge CLK) begin
    if(!RST_N) begin
      div_trace_valid[8] <= 0;
    end else if(!int_div_stole) begin
      if(!div_stage7[3][51]) begin
        div_stage8[0] <= div_stage7[3];
        div_stage8[1] <= div_stage7[3] - div_stage7[5];
        div_stage8[2] <= div_stage7[3] - { div_stage7[5], 1'b0 };
        div_stage8[3] <= div_stage7[3] - ({ div_stage7[5], 1'b0 } + div_stage7[5]);
        div_stage8[4] <= { div_stage7[4][31:20], 2'b11, div_stage7[4][17:0] };
      end else if(!div_stage7[2][51]) begin
        div_stage8[0] <= div_stage7[2];
        div_stage8[1] <= div_stage7[2] - div_stage7[5];
        div_stage8[2] <= div_stage7[2] - { div_stage7[5], 1'b0 };
        div_stage8[3] <= div_stage7[2] - ({ div_stage7[5], 1'b0 } + div_stage7[5]);
        div_stage8[4] <= { div_stage7[4][31:20], 2'b10, div_stage7[4][17:0] };
      end else if(!div_stage7[1][51]) begin
        div_stage8[0] <= div_stage7[1];
        div_stage8[1] <= div_stage7[1] - div_stage7[5];
        div_stage8[2] <= div_stage7[1] - { div_stage7[5], 1'b0 };
        div_stage8[3] <= div_stage7[1] - ({ div_stage7[5], 1'b0 } + div_stage7[5]);
        div_stage8[4] <= { div_stage7[4][31:20], 2'b01, div_stage7[4][17:0] };
      end else begin
        div_stage8[0] <= div_stage7[0];
        div_stage8[1] <= div_stage7[0] - div_stage7[5];
        div_stage8[2] <= div_stage7[0] - { div_stage7[5], 1'b0 };
        div_stage8[3] <= div_stage7[0] - ({ div_stage7[5], 1'b0 } + div_stage7[5]);
        div_stage8[4] <= div_stage7[4];
      end
      div_stage8[5] <= div_stage7[5][47:2];
      div_trace_a_sign[8] <= div_trace_a_sign[7];
      div_trace_b_sign[8] <= div_trace_b_sign[7];
      div_trace_op[8] <= div_trace_op[7];
      div_trace_valid[8] <= div_trace_valid[7];
    end
  end

  always @(posedge CLK) begin
    if(!RST_N) begin
      div_trace_valid[9] <= 0;
    end else if(!int_div_stole) begin
      if(!div_stage8[3][49]) begin
        div_stage9[0] <= div_stage8[3];
        div_stage9[1] <= div_stage8[3] - div_stage8[5];
        div_stage9[2] <= div_stage8[3] - { div_stage8[5], 1'b0 };
        div_stage9[3] <= div_stage8[3] - ({ div_stage8[5], 1'b0 } + div_stage8[5]);
        div_stage9[4] <= { div_stage8[4][31:18], 2'b11, div_stage8[4][15:0] };
      end else if(!div_stage8[2][49]) begin
        div_stage9[0] <= div_stage8[2];
        div_stage9[1] <= div_stage8[2] - div_stage8[5];
        div_stage9[2] <= div_stage8[2] - { div_stage8[5], 1'b0 };
        div_stage9[3] <= div_stage8[2] - ({ div_stage8[5], 1'b0 } + div_stage8[5]);
        div_stage9[4] <= { div_stage8[4][31:18], 2'b10, div_stage8[4][15:0] };
      end else if(!div_stage8[1][49]) begin
        div_stage9[0] <= div_stage8[1];
        div_stage9[1] <= div_stage8[1] - div_stage8[5];
        div_stage9[2] <= div_stage8[1] - { div_stage8[5], 1'b0 };
        div_stage9[3] <= div_stage8[1] - ({ div_stage8[5], 1'b0 } + div_stage8[5]);
        div_stage9[4] <= { div_stage8[4][31:18], 2'b01, div_stage8[4][15:0] };
      end else begin
        div_stage9[0] <= div_stage8[0];
        div_stage9[1] <= div_stage8[0] - div_stage8[5];
        div_stage9[2] <= div_stage8[0] - { div_stage8[5], 1'b0 };
        div_stage9[3] <= div_stage8[0] - ({ div_stage8[5], 1'b0 } + div_stage8[5]);
        div_stage9[4] <= div_stage8[4];
      end
      div_stage9[5] <= div_stage8[5][45:2];
      div_trace_a_sign[9] <= div_trace_a_sign[8];
      div_trace_b_sign[9] <= div_trace_b_sign[8];
      div_trace_op[9] <= div_trace_op[8];
      div_trace_valid[9] <= div_trace_valid[8];
    end
  end

  always @(posedge CLK) begin
    if(!RST_N) begin
      div_trace_valid[10] <= 0;
    end else if(!int_div_stole) begin
      if(!div_stage9[3][47]) begin
        div_stage10[0] <= div_stage9[3];
        div_stage10[1] <= div_stage9[3] - div_stage9[5];
        div_stage10[2] <= div_stage9[3] - { div_stage9[5], 1'b0 };
        div_stage10[3] <= div_stage9[3] - ({ div_stage9[5], 1'b0 } + div_stage9[5]);
        div_stage10[4] <= { div_stage9[4][31:16], 2'b11, div_stage9[4][13:0] };
      end else if(!div_stage9[2][47]) begin
        div_stage10[0] <= div_stage9[2];
        div_stage10[1] <= div_stage9[2] - div_stage9[5];
        div_stage10[2] <= div_stage9[2] - { div_stage9[5], 1'b0 };
        div_stage10[3] <= div_stage9[2] - ({ div_stage9[5], 1'b0 } + div_stage9[5]);
        div_stage10[4] <= { div_stage9[4][31:16], 2'b10, div_stage9[4][13:0] };
      end else if(!div_stage9[1][47]) begin
        div_stage10[0] <= div_stage9[1];
        div_stage10[1] <= div_stage9[1] - div_stage9[5];
        div_stage10[2] <= div_stage9[1] - { div_stage9[5], 1'b0 };
        div_stage10[3] <= div_stage9[1] - ({ div_stage9[5], 1'b0 } + div_stage9[5]);
        div_stage10[4] <= { div_stage9[4][31:16], 2'b01, div_stage9[4][13:0] };
      end else begin
        div_stage10[0] <= div_stage9[0];
        div_stage10[1] <= div_stage9[0] - div_stage9[5];
        div_stage10[2] <= div_stage9[0] - { div_stage9[5], 1'b0 };
        div_stage10[3] <= div_stage9[0] - ({ div_stage9[5], 1'b0 } + div_stage9[5]);
        div_stage10[4] <= div_stage9[4];
      end
      div_stage10[5] <= div_stage9[5][43:2];
      div_trace_a_sign[10] <= div_trace_a_sign[9];
      div_trace_b_sign[10] <= div_trace_b_sign[9];
      div_trace_op[10] <= div_trace_op[9];
      div_trace_valid[10] <= div_trace_valid[9];
    end
  end

  always @(posedge CLK) begin
    if(!RST_N) begin
      div_trace_valid[11] <= 0;
    end else if(!int_div_stole) begin
      if(!div_stage10[3][45]) begin
        div_stage11[0] <= div_stage10[3];
        div_stage11[1] <= div_stage10[3] - div_stage10[5];
        div_stage11[2] <= div_stage10[3] - { div_stage10[5], 1'b0 };
        div_stage11[3] <= div_stage10[3] - ({ div_stage10[5], 1'b0 } + div_stage10[5]);
        div_stage11[4] <= { div_stage10[4][31:14], 2'b11, div_stage10[4][11:0] };
      end else if(!div_stage10[2][45]) begin
        div_stage11[0] <= div_stage10[2];
        div_stage11[1] <= div_stage10[2] - div_stage10[5];
        div_stage11[2] <= div_stage10[2] - { div_stage10[5], 1'b0 };
        div_stage11[3] <= div_stage10[2] - ({ div_stage10[5], 1'b0 } + div_stage10[5]);
        div_stage11[4] <= { div_stage10[4][31:14], 2'b10, div_stage10[4][11:0] };
      end else if(!div_stage10[1][45]) begin
        div_stage11[0] <= div_stage10[1];
        div_stage11[1] <= div_stage10[1] - div_stage10[5];
        div_stage11[2] <= div_stage10[1] - { div_stage10[5], 1'b0 };
        div_stage11[3] <= div_stage10[1] - ({ div_stage10[5], 1'b0 } + div_stage10[5]);
        div_stage11[4] <= { div_stage10[4][31:14], 2'b01, div_stage10[4][11:0] };
      end else begin
        div_stage11[0] <= div_stage10[0];
        div_stage11[1] <= div_stage10[0] - div_stage10[5];
        div_stage11[2] <= div_stage10[0] - { div_stage10[5], 1'b0 };
        div_stage11[3] <= div_stage10[0] - ({ div_stage10[5], 1'b0 } + div_stage10[5]);
        div_stage11[4] <= div_stage10[4];
      end
      div_stage11[5] <= div_stage10[5][41:2];
      div_trace_a_sign[11] <= div_trace_a_sign[10];
      div_trace_b_sign[11] <= div_trace_b_sign[10];
      div_trace_op[11] <= div_trace_op[10];
      div_trace_valid[11] <= div_trace_valid[10];
    end
  end

  always @(posedge CLK) begin
    if(!RST_N) begin
      div_trace_valid[12] <= 0;
    end else if(!int_div_stole) begin
      if(!div_stage11[3][43]) begin
        div_stage12[0] <= div_stage11[3];
        div_stage12[1] <= div_stage11[3] - div_stage11[5];
        div_stage12[2] <= div_stage11[3] - { div_stage11[5], 1'b0 };
        div_stage12[3] <= div_stage11[3] - ({ div_stage11[5], 1'b0 } + div_stage11[5]);
        div_stage12[4] <= { div_stage11[4][31:12], 2'b11, div_stage11[4][9:0] };
      end else if(!div_stage11[2][43]) begin
        div_stage12[0] <= div_stage11[2];
        div_stage12[1] <= div_stage11[2] - div_stage11[5];
        div_stage12[2] <= div_stage11[2] - { div_stage11[5], 1'b0 };
        div_stage12[3] <= div_stage11[2] - ({ div_stage11[5], 1'b0 } + div_stage11[5]);
        div_stage12[4] <= { div_stage11[4][31:12], 2'b10, div_stage11[4][9:0] };
      end else if(!div_stage11[1][43]) begin
        div_stage12[0] <= div_stage11[1];
        div_stage12[1] <= div_stage11[1] - div_stage11[5];
        div_stage12[2] <= div_stage11[1] - { div_stage11[5], 1'b0 };
        div_stage12[3] <= div_stage11[1] - ({ div_stage11[5], 1'b0 } + div_stage11[5]);
        div_stage12[4] <= { div_stage11[4][31:12], 2'b01, div_stage11[4][9:0] };
      end else begin
        div_stage12[0] <= div_stage11[0];
        div_stage12[1] <= div_stage11[0] - div_stage11[5];
        div_stage12[2] <= div_stage11[0] - { div_stage11[5], 1'b0 };
        div_stage12[3] <= div_stage11[0] - ({ div_stage11[5], 1'b0 } + div_stage11[5]);
        div_stage12[4] <= div_stage11[4];
      end
      div_stage12[5] <= div_stage11[5][39:2];
      div_trace_a_sign[12] <= div_trace_a_sign[11];
      div_trace_b_sign[12] <= div_trace_b_sign[11];
      div_trace_op[12] <= div_trace_op[11];
      div_trace_valid[12] <= div_trace_valid[11];
    end
  end

  always @(posedge CLK) begin
    if(!RST_N) begin
      div_trace_valid[13] <= 0;
    end else if(!int_div_stole) begin
      if(!div_stage12[3][41]) begin
        div_stage13[0] <= div_stage12[3];
        div_stage13[1] <= div_stage12[3] - div_stage12[5];
        div_stage13[2] <= div_stage12[3] - { div_stage12[5], 1'b0 };
        div_stage13[3] <= div_stage12[3] - ({ div_stage12[5], 1'b0 } + div_stage12[5]);
        div_stage13[4] <= { div_stage12[4][31:10], 2'b11, div_stage12[4][7:0] };
      end else if(!div_stage12[2][41]) begin
        div_stage13[0] <= div_stage12[2];
        div_stage13[1] <= div_stage12[2] - div_stage12[5];
        div_stage13[2] <= div_stage12[2] - { div_stage12[5], 1'b0 };
        div_stage13[3] <= div_stage12[2] - ({ div_stage12[5], 1'b0 } + div_stage12[5]);
        div_stage13[4] <= { div_stage12[4][31:10], 2'b10, div_stage12[4][7:0] };
      end else if(!div_stage12[1][41]) begin
        div_stage13[0] <= div_stage12[1];
        div_stage13[1] <= div_stage12[1] - div_stage12[5];
        div_stage13[2] <= div_stage12[1] - { div_stage12[5], 1'b0 };
        div_stage13[3] <= div_stage12[1] - ({ div_stage12[5], 1'b0 } + div_stage12[5]);
        div_stage13[4] <= { div_stage12[4][31:10], 2'b01, div_stage12[4][7:0] };
      end else begin
        div_stage13[0] <= div_stage12[0];
        div_stage13[1] <= div_stage12[0] - div_stage12[5];
        div_stage13[2] <= div_stage12[0] - { div_stage12[5], 1'b0 };
        div_stage13[3] <= div_stage12[0] - ({ div_stage12[5], 1'b0 } + div_stage12[5]);
        div_stage13[4] <= div_stage12[4];
      end
      div_stage13[5] <= div_stage12[5][37:2];
      div_trace_a_sign[13] <= div_trace_a_sign[12];
      div_trace_b_sign[13] <= div_trace_b_sign[12];
      div_trace_op[13] <= div_trace_op[12];
      div_trace_valid[13] <= div_trace_valid[12];
    end
  end

  always @(posedge CLK) begin
    if(!RST_N) begin
      div_trace_valid[14] <= 0;
    end else if(!int_div_stole) begin
      if(!div_stage13[3][39]) begin
        div_stage14[0] <= div_stage13[3];
        div_stage14[1] <= div_stage13[3] - div_stage13[5];
        div_stage14[2] <= div_stage13[3] - { div_stage13[5], 1'b0 };
        div_stage14[3] <= div_stage13[3] - ({ div_stage13[5], 1'b0 } + div_stage13[5]);
        div_stage14[4] <= { div_stage13[4][31:8], 2'b11, div_stage13[4][5:0] };
      end else if(!div_stage13[2][39]) begin
        div_stage14[0] <= div_stage13[2];
        div_stage14[1] <= div_stage13[2] - div_stage13[5];
        div_stage14[2] <= div_stage13[2] - { div_stage13[5], 1'b0 };
        div_stage14[3] <= div_stage13[2] - ({ div_stage13[5], 1'b0 } + div_stage13[5]);
        div_stage14[4] <= { div_stage13[4][31:8], 2'b10, div_stage13[4][5:0] };
      end else if(!div_stage13[1][39]) begin
        div_stage14[0] <= div_stage13[1];
        div_stage14[1] <= div_stage13[1] - div_stage13[5];
        div_stage14[2] <= div_stage13[1] - { div_stage13[5], 1'b0 };
        div_stage14[3] <= div_stage13[1] - ({ div_stage13[5], 1'b0 } + div_stage13[5]);
        div_stage14[4] <= { div_stage13[4][31:8], 2'b01, div_stage13[4][5:0] };
      end else begin
        div_stage14[0] <= div_stage13[0];
        div_stage14[1] <= div_stage13[0] - div_stage13[5];
        div_stage14[2] <= div_stage13[0] - { div_stage13[5], 1'b0 };
        div_stage14[3] <= div_stage13[0] - ({ div_stage13[5], 1'b0 } + div_stage13[5]);
        div_stage14[4] <= div_stage13[4];
      end
      div_stage14[5] <= div_stage13[5][35:2];
      div_trace_a_sign[14] <= div_trace_a_sign[13];
      div_trace_b_sign[14] <= div_trace_b_sign[13];
      div_trace_op[14] <= div_trace_op[13];
      div_trace_valid[14] <= div_trace_valid[13];
    end
  end

  always @(posedge CLK) begin
    if(!RST_N) begin
      div_trace_valid[15] <= 0;
    end else if(!int_div_stole) begin
      if(!div_stage14[3][37]) begin
        div_stage15[0] <= div_stage14[3];
        div_stage15[1] <= div_stage14[3] - div_stage14[5];
        div_stage15[2] <= div_stage14[3] - { div_stage14[5], 1'b0 };
        div_stage15[3] <= div_stage14[3] - ({ div_stage14[5], 1'b0 } + div_stage14[5]);
        div_stage15[4] <= { div_stage14[4][31:6], 2'b11, div_stage14[4][3:0] };
      end else if(!div_stage14[2][37]) begin
        div_stage15[0] <= div_stage14[2];
        div_stage15[1] <= div_stage14[2] - div_stage14[5];
        div_stage15[2] <= div_stage14[2] - { div_stage14[5], 1'b0 };
        div_stage15[3] <= div_stage14[2] - ({ div_stage14[5], 1'b0 } + div_stage14[5]);
        div_stage15[4] <= { div_stage14[4][31:6], 2'b10, div_stage14[4][3:0] };
      end else if(!div_stage14[1][37]) begin
        div_stage15[0] <= div_stage14[1];
        div_stage15[1] <= div_stage14[1] - div_stage14[5];
        div_stage15[2] <= div_stage14[1] - { div_stage14[5], 1'b0 };
        div_stage15[3] <= div_stage14[1] - ({ div_stage14[5], 1'b0 } + div_stage14[5]);
        div_stage15[4] <= { div_stage14[4][31:6], 2'b01, div_stage14[4][3:0] };
      end else begin
        div_stage15[0] <= div_stage14[0];
        div_stage15[1] <= div_stage14[0] - div_stage14[5];
        div_stage15[2] <= div_stage14[0] - { div_stage14[5], 1'b0 };
        div_stage15[3] <= div_stage14[0] - ({ div_stage14[5], 1'b0 } + div_stage14[5]);
        div_stage15[4] <= div_stage14[4];
      end
      div_stage15[5] <= div_stage14[5][33:2];
      div_trace_a_sign[15] <= div_trace_a_sign[14];
      div_trace_b_sign[15] <= div_trace_b_sign[14];
      div_trace_op[15] <= div_trace_op[14];
      div_trace_valid[15] <= div_trace_valid[14];
    end
  end
  //div_stage2 ~ div_stage15 の代入は実質for文, ここまで

  always @(posedge CLK) begin
    if(!RST_N) begin
      div_trace_valid[16] <= 0;
    end else if(!int_div_stole) begin
      if(!div_stage15[3][35]) begin
        div_stage16[0] <= div_stage15[3];
        div_stage16[1] <= div_stage15[3] - div_stage15[5];
        div_stage16[2] <= div_stage15[3] - { div_stage15[5], 1'b0 };
        div_stage16[3] <= div_stage15[3] - ({ div_stage15[5], 1'b0 } + div_stage15[5]);
        div_stage16[4] <= { div_stage15[4][31:4], 2'b11, div_stage15[4][1:0] };
      end else if(!div_stage15[2][35]) begin
        div_stage16[0] <= div_stage15[2];
        div_stage16[1] <= div_stage15[2] - div_stage15[5];
        div_stage16[2] <= div_stage15[2] - { div_stage15[5], 1'b0 };
        div_stage16[3] <= div_stage15[2] - ({ div_stage15[5], 1'b0 } + div_stage15[5]);
        div_stage16[4] <= { div_stage15[4][31:4], 2'b10, div_stage15[4][1:0] };
      end else if(!div_stage15[1][35]) begin
        div_stage16[0] <= div_stage15[1];
        div_stage16[1] <= div_stage15[1] - div_stage15[5];
        div_stage16[2] <= div_stage15[1] - { div_stage15[5], 1'b0 };
        div_stage16[3] <= div_stage15[1] - ({ div_stage15[5], 1'b0 } + div_stage15[5]);
        div_stage16[4] <= { div_stage15[4][31:4], 2'b01, div_stage15[4][1:0] };
      end else begin
        div_stage16[0] <= div_stage15[0];
        div_stage16[1] <= div_stage15[0] - div_stage15[5];
        div_stage16[2] <= div_stage15[0] - { div_stage15[5], 1'b0 };
        div_stage16[3] <= div_stage15[0] - ({ div_stage15[5], 1'b0 } + div_stage15[5]);
        div_stage16[4] <= div_stage15[4];
      end
      div_stage16[5] <= div_stage15[5][31:0];
      div_trace_a_sign[16] <= div_trace_a_sign[15];
      div_trace_b_sign[16] <= div_trace_b_sign[15];
      div_r_sign <= div_trace_a_sign[15] ^ div_trace_b_sign[15];
      div_trace_op[16] <= div_trace_op[15];
      div_trace_valid[16] <= div_trace_valid[15];
    end
  end



  always @(posedge CLK) begin
    if(!RST_N) begin
      int_div_r_tvalid <= 0;
    end else begin
      if(!int_div_stole) begin
        //例外処理
        if (div_stage16[5] == 0) begin
          int_div_r_tdata <= (div_trace_op[16] == I_DIV || div_trace_op[16] == I_DIVU) ? 32'hffffffff : div_stage16[0];
        end else if ((div_trace_op[16] == I_DIV || div_trace_op[16] == I_REM)
                      && div_trace_a_sign[16] && (div_stage16[0] == 32'h80000000)
                      && div_trace_a_sign[16] && (div_stage16[0] == 32'h80000000)
                      && div_trace_b_sign[16] && (div_stage16[4] == 0'b1)) begin
          int_div_r_tdata <= (div_trace_op[16] == I_DIV) ? 32'hffffffff : 0;
        end else if(!div_stage16[3][33]) begin
          int_div_r_tdata <=  (div_r_sign) ? ( (div_trace_op[16] == I_DIV) ? 0 - { div_stage16[4][31:2], 2'b11 }
                                                                                   : 0 - div_stage16[3])
                              : (div_trace_op[16] == I_DIV || div_trace_op[16] == I_DIVU) ? { div_stage16[4][31:2], 2'b11 }
                              : div_stage16[3];

        end else if(!div_stage16[2][33]) begin
          int_div_r_tdata <=  (div_r_sign) ? ( (div_trace_op[16] == I_DIV) ? 0 - { div_stage16[4][31:2], 2'b10 }
                                                                                   : 0 - div_stage16[2])
                              : (div_trace_op[16] == I_DIV || div_trace_op[16] == I_DIVU) ? { div_stage16[4][31:2], 2'b10 }
                              : div_stage16[2];
        end else if(!div_stage16[1][33]) begin
          int_div_r_tdata <=  (div_r_sign) ? ( (div_trace_op[16] == I_DIV) ? 0 - { div_stage16[4][31:2], 2'b01 }
                                                                                   : 0 - div_stage16[1])
                              : (div_trace_op[16] == I_DIV || div_trace_op[16] == I_DIVU) ? { div_stage16[4][31:2], 2'b01 }
                              : div_stage16[1];

        end else begin
          int_div_r_tdata <=  (div_r_sign) ? ( (div_trace_op[16] == I_DIV) ? 0 - { div_stage16[4][31:2], 2'b00 }
                                                                                   : 0 - div_stage16[0])
                              : (div_trace_op[16] == I_DIV || div_trace_op[16] == I_DIVU) ? { div_stage16[4][31:2], 2'b00 }
                              : div_stage16[0];
        end
      end
      int_div_r_tvalid <= (int_div_r_tready && int_div_r_tvalid) ? 0
                          : (int_div_r_tvalid | div_trace_valid[16]);
    end
  end

endmodule
