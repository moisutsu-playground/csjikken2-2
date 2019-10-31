/***************/
/* main_ctrl.v */
/***************/

//                     +----+
//  instruction[31:0]->|    |->ram_write_enable
//                     |    |->alu_b_sel1_s
//                     |    |->alu_b_sel2_s
//                     |    |->alu_op[2:0]
//                     |    |->is_branch_ctrl[2:0]
//                     |    |->reg_write_enable
//                     |    |->alu_ram_sel_s
//                     |    |->reg_widx_sel1_s
//                     |    |->jp
//                     |    |->link
//                     |    |->jpr
//                     |    |->shiftv
//                     |    |->do_sign_ext
//                     +----+

`define      R  6'b000000  //  R 形式 (add, addu, sub, subu, and, or, slt, jalr, jr)
//
// 追加設計 3 のヒント(14)：I 形式の命令 LW の追加、命令コードの定義
//
`define     LW  6'b001100
//
//
//
`define   ADDI  6'b001000  //  add immediate (I 形式)
//
// 追加設計 1 のヒント(1)：I 形式の命令 addiu の追加、命令コードの定義
//
`define  ADDIU  6'b001001
//
//

`define   ANDI  6'b001100  //  and immediate (I 形式)
`define    ORI  6'b001101  //  or immediate (I 形式)
//
// 追加設計 1 のヒント(10)：I 形式の命令 sw の追加、命令コードの定義
//
`define     SW  6'b101011  //  store word (I 形式)
//
//
//
`define    BEQ  6'b000100  //  branch on equal (I 形式)
//
// 追加設計 3 のヒント(9)：I 形式の命令 BNE の追加、命令コードの定義
//
 `define    BNE  6'b001100
//
//
//
`define   BGEZ  6'b000001  //  branch on greater than or equal to zero (I 形式)
`define   BLEZ  6'b000110  //  branch on less than or equal to zero (I 形式)
`define   BGTZ  6'b000111  //  branch on greater than zero (I 形式)
`define   BLTZ  6'b000001  //  branch on less than zero (I 形式)
`define BGEZAL  6'b000001  //  branch on greater than or equal to zero and link (I 形式)
`define BLTZAL  6'b000001  //  branch on less than zero and link (I 形式)
//
// 追加設計 2 のヒント(1)：J 形式の命令 J の追加、命令コードの定義
//
`define  J  6'b000010
//
//
//
//
// 追加設計 4 のヒント(1)：J 形式の命令 JAL の追加、命令コードの定義
// JAL の命令コード。既に修正済。変更の必要なし。
`define    JAL  6'b000011  //  jump and link (J 形式)
//
//
//
`define   XORI  6'b001110  //  xor immediate (I 形式)
`define   SLTI  6'b001010  //  set on less than immediate, signed (I 形式)
//
// 追加設計 3 のヒント(1)：I 形式の命令 SLTIU の追加、命令コードの定義
//
`define   SLTIU 6'b001100
//
//
//
`define   LUI   6'b001111  //  load upp immediate (I 形式)

/* 命令セット
R 形式
31      26 25    21 20   16 15   11 10    6 5      0
----------------------------------------------------
| op      | rs     | rt    | rd    | shamt | func  |
| (6-bit) |(5-bit) |(5-bit)|(5-bit)|(5-bit)|(6-bit)|
----------------------------------------------------
ADD(op = 000000, func = 100000)
REG[rd] <= REG[rs] + REG[rt];                            ADD rd,rs,rt

ADDU(op = 000000, func = 100001)
REG[rd] <= REG[rs] + REG[rt];                            ADDU rd,rs,rt

SUB(op = 000000, func = 100010)
SUB        REG[rd] <= REG[rs] - REG[rt];                 SUB rd,rs,rt

SUBU(op = 000000, func = 100011)
SUBU       REG[rd] <= REG[rs] - REG[rt];                 SUBU rd,rs,rt

AND(op = 000000, func = 100100)
AND        REG[rd] <= REG[rs] & REG[rt];                 AND rd,rs,rt

OR(op = 000000, func = 100101)
OR         REG[rd] <= REG[rs] | REG[rt];                 OR  rd,rs,rt

SLT(op = 000000, func = 101010)
SLT        REG[rd] <= (REG[rs] < REG[rt]) ? 1 : 0;       SLT rd,rs,rt

JALR(op = 000000, func = 001001, target=00000)
Jump and link register
JALR     REG[rd] <= PC+4; PC <= REG[rs];                JALR  rd,rs

JR(op = 000000, func = 001000, target=00000, destination=00000)
Jump Register
JR       PC <= REG[rs];                                 JR  rs

NOR(op = 000000, func = 100111)
NOR        REG[rd] <= REG[rs] nor REG[rt];              NOR rd,rs,rt

XOR(op = 000000, func = 100110)
XOR        REG[rd] <= REG[rs] xor REG[rt];              XOR rd,rs,rt

SLL(op = 000000, func = 000000)
SLL        REG[rd] <= REG[rt] << shamt;                 SLL rd,rt,shamt

SRL(op = 000000, func = 000010)
SRL        REG[rd] <= REG[rt] >> shamt;                 SRL rd,rt,shamt

SLLV(op = 000000, func = 000100)
SLLV       REG[rd] <= REG[rt] << REG[rs];               SLLV rd,rt,rs

SRLV(op = 000000, func = 000110)
SRLV       REG[rd] <= REG[rt] >> REG[rs];               SRLV rd,rt,rs

SRA(op = 000000, func = 000011)
SRA        REG[rd] <= REG[rt] >> shamt;                 SRA rd,rt,shamt

SRAV(op = 000000, func = 000111)
SRAV       REG[rd] <= REG[rt] >> REG[rs];               SRAV rd,rt,rs

SLTU(op = 000000, func = 101011)
SLTU       REG[rd] <= (REG[rs] < REG[rt]) ? 1 : 0;      SLTU rd,rs,rt

// 実験 9 のヒント（９）：mult, mflo 命令に関するコメントの追加





I 形式
31      26 25    21 20   16 15                     0 
----------------------------------------------------
| op      | rs     | rt    | address/immediate     |
| (6-bit) |(5-bit) |(5-bit)|(16-bit)               |
----------------------------------------------------
LW       REG[rt] <= RAM[REG[rs]+address];           LW  rt, rs, address
SW       Ram[rs+address] <= REG[rt];                SW  rt, rs, address
ADDI     REG[rt] <= REG[rs] + immediate;          ADDI  rt, rs, immediate
ADDIU    REG[rt] <= REG[rs] + immediate;         ADDIU  rt, rs, immediate
ANDI     REG[rt] <= REG[rs] & immediate;          ANDI  rt, rs, immediate
ORI      REG[rt] <= REG[rs] | immediate;           ORI  rt, rs, immediate
BEQ      PC <= (rs == rt) ? PC+4+address*4 : PC+4; BEQ  rs, rt, address
BNE      PC <= (rs != rt) ? PC+4+address*4 : PC+4; BNE  rs, rt, address

I 形式
BGEZ(op = 000001, rt = 00001)
BGEZ     PC <= (rs >= 0)  ? PC+4+address*4 : PC+4; BGEZ    rs, address

BLEZ(op = 000110, rt = 00000)
BLEZ      PC <= (rs <= 0)  ? PC+4+address*4 : PC+4; BLEZ    rs, address

BGTZ(op = 000111, rt = 00000)
BGTZ      PC <= (rs > 0)   ? PC+4+address*4 : PC+4; BGTZ    rs, address

BLTZ(op = 000001, rt = 00000)
BLTZ      PC <= (rs < 0)   ? PC+4+address*4 : PC+4; BLTZ    rs, address

BGEZAL(op = 000001, rt = 10001)
BGEZAL   PC <= (rs >= 0) ? PC+4+address*4 :  PC+4; RA_REG <= PC+4; 
                                                   BGEZAL  rs, address
BLTZAL(op = 000001, rt = 10000)
BLTZAL   PC <= (rs < 0)   ? PC+4+address*4 : PC+4; RA_REG <= PC+4; 
                                                   BLTZAL  rs, address
＃RA_REG は REG[31]

XORI(op = 001110)
XORI      REG[rt] <= REG[rs] xor immediate;           XORI  rt, rs, immediate

SLTI(op = 001010)
SLTI      REG[rt] <= (REG[rs] < immediate) ? 1 : 0;   SLTI  rt, rs, immediate

SLTIU(op = 001011)
SLTIU      REG[rt] <= (REG[rs] < immediate) ? 1 : 0;  SLTIU rt, rs, immediate

LUI(op = 001111)
LUI        REG[rt] <= (immediate << 16) ;  LUI rt, immediate

J 形式
31      26 25                                     0
---------------------------------------------------
|op       |target address                         |
| (6-bit) | (26-bit)                              |
---------------------------------------------------
J      PC <= target address*4;                    J    target address
JAL    PC <= target address*4; RA_REG <=PC+4;     JAL  target address

*/

module main_ctrl (instruction,
		  ram_write_enable,
		  alu_b_sel1_s,
		  alu_b_sel2_s,
		  alu_op,
                  is_branch_ctrl,
                  reg_write_enable,
                  alu_ram_sel_s,
		  reg_widx_sel1_s,
		  jp,
		  link,
		  jpr,
		  shiftv,
		  do_sign_ext
);  // 入出力ポート
  input [31:0] instruction;          // 入力 31-bit 命令

  output      ram_write_enable;       // 出力 RAM 書き込み(1)/読み(0)
  output          alu_b_sel1_s;       // 出力 alu_b 選択回路1 セレクト信号
  output          alu_b_sel2_s;       // 出力 alu_b 選択回路2 セレクト信号
  output  [2:0]         alu_op;       // 出力 ALU 制御コード
  output  [2:0] is_branch_ctrl;       // 出力 分岐判定（is_branch.v参照）
  output      reg_write_enable;       // 出力 レジスタ書き込み(1)/読み(0)
  output         alu_ram_sel_s;       // 出力 alu_ram 選択回路 セレクト信号
  output       reg_widx_sel1_s;       // 出力 reg_write_idx 選択回路1 セレクト信号
  output                    jp;       // 出力 ジャンプ命令(1)/others(0)
  output                  link;       // 出力 link 命令(1)/others(0)
  output                   jpr;       // 出力 jalr, jr 命令(1)/others(0)
  output                shiftv;       // 出力 sllv, srlv, srav 命令(1)/others(0)
  output           do_sign_ext;       // 出力 addi, slti, beg, bne,
                                      //     bgez, blez, bgtz, bltz,
                                      //     bgezal, bltzal 命令(1)/others(0)

  wire  [5:0]        op_code;    // 命令コード

  wire  [4:0]         Rrs;       // R 形式 rs
  wire  [4:0]         Rrt;       // R 形式 rt
  wire  [4:0]         Rrd;       // R 形式 rt
  wire  [4:0]         Rshamt;    // R 形式 shamt
  wire  [5:0]         Rfunc;     // R 形式 func

  assign op_code = instruction[31:26];

  assign Rrs    = instruction[25:21];
  assign Rrt    = instruction[20:16];
  assign Rrd    = instruction[15:11];
  assign Rshamt = instruction[10:6];
  assign Rfunc  = instruction[5:0];

  wire  [4:0]         Irs;       // I 形式 rs
  wire  [4:0]         Irt;       // I 形式 rt
  wire [15:0]         Iaddr;     // I 形式 address

  assign Irs    = instruction[25:21];
  assign Irt    = instruction[20:16];
  assign Iaddr  = instruction[15:0];

  wire [25:0]         Jaddr;     // J 形式 address

  assign Jaddr  = instruction[25:0];

  reg    [2:0] is_branch_ctrl_tmp;
  reg            alu_b_sel1_s_tmp;
  reg    [2:0]         alu_op_tmp;
  reg        reg_write_enable_tmp;
  reg           alu_ram_sel_s_tmp;
  reg         reg_widx_sel1_s_tmp;
  reg 	                  link_tmp;
   
   
  // ram_write_enable
  //
  // RAM の書き込み制御信号
  // ram_write_enable == 1'b0：書き込みを行わない
  // ram_write_enable == 1'b1：書き込みを行う
  //
//
// 追加設計 1 のヒント(11)：I 形式の命令 sw の追加、RAM への制御信号の記述
//
  assign  ram_write_enable = (op_code == `SW) ? 1'b1 : 1'b0;
//
//
//

  // is_branch_d0
  //
  // 分岐判定モジュール is_branch の制御信号
  // 3'b000,  ==, EQ
  // 3'b001, !=, NEQ
  // 3'b010, >=, GE
  // 3'b011, <=, LE
  // 3'b100, >, GT
  // 3'b101, <, LT
  // 3'b110, do nothing
  //
  always @(op_code) begin
    case (op_code)
      `R:      is_branch_ctrl_tmp = 3'b110;  // do nothing
//
// 追加設計 3 のヒント(15)：I 形式の命令 LW の追加、is_branch モジュールへの制御信号の記述
//
      `LW:     is_branch_ctrl_tmp = 3'bXXX;
//
//
//

//
// 追加設計 1 のヒント(12)：I 形式の命令 sw の追加、is_branch モジュールへの制御信号の記述
//
      `SW:     is_branch_ctrl_tmp = 3'b110;
//
//
//
      `ADDI:   is_branch_ctrl_tmp = 3'b110;  // do nothing
//
// 追加設計 1 のヒント(2)：I 形式の命令 addiu の追加、is_branch モジュールへの制御信号の記述
//
      `ADDIU:  is_branch_ctrl_tmp = 3'b110;
//
//
//
      `ANDI:   is_branch_ctrl_tmp = 3'b110;  // do nothing
      `ORI:    is_branch_ctrl_tmp = 3'b110;  // do nothing
      `BEQ:    is_branch_ctrl_tmp = 3'b000;  // ==, EQ
//
// 追加設計 3 のヒント(10)：I 形式の命令 BNE の追加、is_branch モジュールへの制御信号の記述
//
      `BNE:    is_branch_ctrl_tmp = 3'bXXX;
//
//
//
      `BGEZ:   is_branch_ctrl_tmp = 3'b010;  // >=, GE
      `BLEZ:   is_branch_ctrl_tmp = 3'b011;  // <=, LE
      `BGTZ:   is_branch_ctrl_tmp = 3'b100;  // >, GT
      `BLTZ:   is_branch_ctrl_tmp = 3'b101;  // <, LT
      `BGEZAL: is_branch_ctrl_tmp = 3'b010;  // >=, GE
      `BLTZAL: is_branch_ctrl_tmp = 3'b101;  // <, LT
      `XORI:   is_branch_ctrl_tmp = 3'b110;  // do nothing
      `SLTI:   is_branch_ctrl_tmp = 3'b110;  // do nothing
//
// 追加設計 3 のヒント(2)：I 形式の命令 SLTIU の追加、is_branch モジュールへの制御信号の記述
//
      `SLTIU:  is_branch_ctrl_tmp = 3'bXXX;
//
//
//
      `LUI:    is_branch_ctrl_tmp = 3'b110;  // do nothing
      default: is_branch_ctrl_tmp = 3'b110;  // do nothing
    endcase
  end

  assign  is_branch_ctrl = is_branch_ctrl_tmp;

  // jump, J, JAL 用
  //
  // MUX, jp_sel モジュールのセレクト信号
  // jp == 1'b0： jump しない場合の、次の PC の値を選択
  // jp == 1'b1： jump する場合の、次の PC の値を選択
  //
//
// 追加設計 2 のヒント(2)：J 形式の命令 J の追加、jp_sel モジュールへの制御信号の記述
//
//
// 更に、追加設計 4 のヒント(2)：J 形式の命令 JAL (jump and link) の追加、jp_sel モジュールへの制御信号の記述
//
  assign  jp = ((op_code == `J) || ((op_code == `JAL) && 0)) ? 1'b1 : 1'b0;
//
//
//
//
//
//

  // jpr, JALR, JR 用
  //
  // MUX, jpr_sel モジュールのセレクト信号
  // jump_sel_s == 1'b0： jump しない場合の、次の PC の値を選択
  // jump_sel_s == 1'b1： jump する場合の、次の PC の値を選択
  //
  assign  jpr = (op_code == `R &&
                (Rfunc == 6'b001001
//
// 追加設計 5 のヒント(1)：R 形式の命令 JR の追加、JR の機能コードの記述
//
                  || Rfunc == 6'b001001)) ? 1'b1 : 1'b0;
//
//
//

  // shiftv, SLL, SRL, SRA 用
  assign  shiftv = (op_code == `R &&
                (Rfunc == 6'b000000 || Rfunc == 6'b000010
                                    || Rfunc == 6'b000011)) ? 1'b1 : 1'b0;

  // alu_b_sel1_s
  //
  // MUX, alu_b_sel1 モジュールのセレクト信号
  // alu_b_sel1_s == 1'b0： レジスタファイル registers の出力ポート 2 からのデータを選択
  // alu_b_sel1_s == 1'b1： I 形式, 即値命令の即値, immediate フィールドのデータを選択
  //
  always @(op_code) begin
    case (op_code)
      `R:      alu_b_sel1_s_tmp = 1'b0;
//
// 追加設計 3 のヒント(16)：I 形式の命令 LW の追加、ALU の入力ポート B へ流すデータを選択するセレクト信号の記述
//
      `LW:     alu_b_sel1_s_tmp = 1'bX;
//
//
//

//
// 追加設計 1 のヒント(13)：I 形式の命令 sw の追加、ALU の入力ポート B へ流すデータを選択するセレクト信号の記述
//
      `SW:     alu_b_sel1_s_tmp = 1'b1;
//
//
//
      `ADDI:   alu_b_sel1_s_tmp = 1'b1;
//
// 追加設計 1 のヒント(3)：I 形式の命令 addiu の追加、ALU の入力ポート B へ流すデータを選択するセレクト信号の記述
//
      `ADDIU:  alu_b_sel1_s_tmp = 1'b1;
//
//
//
      `ANDI:   alu_b_sel1_s_tmp = 1'b1;
      `ORI:    alu_b_sel1_s_tmp = 1'b1;
      `BEQ:    alu_b_sel1_s_tmp = 1'b0;
//
// 追加設計 3 のヒント(11)：I 形式の命令 BNE の追加、ALU の入力ポート B へ流すデータを選択するセレクト信号の記述
//
      `BNE:    alu_b_sel1_s_tmp = 1'bX;
//
//
//

      `XORI:   alu_b_sel1_s_tmp = 1'b1;
      `SLTI:   alu_b_sel1_s_tmp = 1'b1;
//
// 追加設計 3 のヒント(3)：I 形式の命令 SLTIU の追加、ALU の入力ポート B へ流すデータを選択するセレクト信号の記述
//
      `SLTIU:  alu_b_sel1_s_tmp = 1'bX;
//
//
//
      `LUI:    alu_b_sel1_s_tmp = 1'b1;
      default: alu_b_sel1_s_tmp = 1'b0;
    endcase
  end
  assign  alu_b_sel1_s = alu_b_sel1_s_tmp;
   
  // alu_b_sel2_s
  // op_code=000001, BGEZ, BGEZAL, BLTZAL
  assign alu_b_sel2_s = (op_code == 6'b000001) ? 1'b1 : 1'b0;

  // do_sign_ext
  //
  // 符号拡張モジュール sign_ext の制御信号
  // do_sign_ext == 1'b0：16-bit データを 32-bit 化するとき符号拡張を行わない
  // do_sign_ext == 1'b1：16-bit データを 32-bit 化するとき符号拡張を行う
  //
  // addi, slti, beg, bne, bgez, blez, bgtz, bltz,
  // bgezal, bltzal 命令用
  assign do_sign_ext = ((op_code == `ADDI)
//
// 追加設計 1 のヒント(4)：I 形式の命令 addiu の追加、符号拡張を行う制御信号の記述
//
                        || (op_code == `ADDIU)
//
// 追加設計 1 のヒント(14)：I 形式の命令 sw の追加、符号拡張を行う制御信号の記述
//
                        || (op_code == `SW)
//
//
//
                        || (op_code == `SLTI)
                        || (op_code == `BEQ)
//
// 追加設計 3 のヒント(12)：I 形式の命令 BNE の追加、符号拡張を行う制御信号の記述
//
                        || ((op_code == `BNE) && 0)
//
//
//
                        || (op_code == `BGEZ) || (op_code == `BLEZ)
                        || (op_code == `BGTZ) || (op_code == `BLTZ)
                        || (op_code == `BGEZAL) || (op_code == `BLTZAL)) ? 1'b1 : 1'b0;

  // alu_op
  //
  // ALU 制御モジュール alu_ctrler の制御信号
  // 3'b000, ALU に加算を行わせる
  // 3'b001, ALU に LUI の処理を行わせる
  // 3'b010, ALU に R 形式の命令に対して、R 形式の機能コードに応じた演算を行わせる
  // 3'b011, ALU に AND 演算を行わせる
  // 3'b100, ALU に OR 演算を行わせる
  // 3'b101, ALU に XOR 演算を行わせる
  // 3'b110, ALU に SLT の処理を行わせる
  // 3'b111, ALU に SLTU の処理を行わせる
  //
  always @(op_code) begin
    case (op_code)
      `R:      alu_op_tmp = 3'b010;
//
// 追加設計 3 のヒント(17)：I 形式の命令 LW の追加、加算を行う制御信号の記述
//
      `LW:     alu_op_tmp = 3'bXXX;
//
//
//

//
// 追加設計 1 のヒント(15)：I 形式の命令 sw の追加、加算を行う制御信号の記述
//
      `SW:     alu_op_tmp = 3'b000;
//
//
//
      `ADDI:   alu_op_tmp = 3'b000;
//
// 追加設計 1 のヒント(5)：I 形式の命令 addiu の追加、加算を行う制御信号の記述
//
      `ADDIU:  alu_op_tmp = 3'b000;
//
//
//
      `ANDI:   alu_op_tmp = 3'b011;
      `ORI:    alu_op_tmp = 3'b100;
      `XORI:   alu_op_tmp = 3'b101;
      `SLTI:   alu_op_tmp = 3'b110;
//
// 追加設計 3 のヒント(4)：I 形式の命令 SLTIU の追加
//
      `SLTIU:  alu_op_tmp = 3'bXXX;
//
//
//
      `LUI:    alu_op_tmp = 3'b001;
      default: alu_op_tmp = 3'b000;
    endcase
  end
  assign  alu_op = alu_op_tmp;

  // reg_write_enable
  // 
  // レジスタファイル registers の書き込み制御信号
  // reg_write_enable == 1'b0：書き込みを行わない
  // reg_write_enable == 1'b1：書き込みを行う
  //
  always @(op_code) begin
    case (op_code)
      `R: begin
            if (Rfunc == 6'b001000) begin  // R 形式の命令, JR 用
//
// 追加設計 5 のヒント(2)：R 形式の命令 JR の追加、レジスタファイルへの制御信号の記述
//
              reg_write_enable_tmp = 1'b1;
//
//
//
            end else begin                 // R 形式の命令, その他用
              reg_write_enable_tmp = 1'b1;
            end
          end

//
// 追加設計 3 のヒント(18)：I 形式の命令 LW の追加、レジスタファイルへの制御信号の記述
//
      `LW:     reg_write_enable_tmp = 1'bX;
//
//
//

//
// 追加設計 1 のヒント(16)：I 形式の命令 sw の追加、レジスタファイルへの制御信号の記述
//
      `SW:     reg_write_enable_tmp = 1'b0;
//
//
//
      `ADDI:   reg_write_enable_tmp = 1'b1;
//
// 追加設計 1 のヒント(6)：I 形式の命令 addiu の追加、レジスタファイルへの制御信号の記述
//
      `ADDIU:  reg_write_enable_tmp = 1'b1;
//
//
//
      `ANDI:   reg_write_enable_tmp = 1'b1;
      `ORI:    reg_write_enable_tmp = 1'b1;
      `BEQ:    reg_write_enable_tmp = 1'b0;
//
// 追加設計 3 のヒント(13)：I 形式の命令 BNE の追加、レジスタファイルへの制御信号の記述
//
      `BNE:    reg_write_enable_tmp = 1'bX;
//
//
//

//
// 追加設計 2 のヒント(3)：J 形式の命令 J の追加、レジスタファイルへの制御信号の記述
//
      `J:      reg_write_enable_tmp = 1'b0;
//
//
//

//
// 追加設計 4 のヒント(3)：J 形式の命令 JAL の追加、レジスタファイルへの制御信号の記述
//
      `JAL:    reg_write_enable_tmp = 1'b0;
//
//
//
      `XORI:   reg_write_enable_tmp = 1'b1;
      `SLTI:   reg_write_enable_tmp = 1'b1;
//
// 追加設計 3 のヒント(5)：I 形式の命令 SLTIU の追加、レジスタファイルへの制御信号の記述
//
      `SLTIU:  reg_write_enable_tmp = 1'b0;
//
//
//
      `LUI:    reg_write_enable_tmp = 1'b1;
      default: reg_write_enable_tmp = 1'b0;
    endcase
  end
  assign  reg_write_enable = reg_write_enable_tmp;

  // alu_ram_sel_s
  //
  // MUX, alu_ram_sel モジュールのセレクト信号
  // alu_ram_sel_s == 1'b0： ALU からのデータを選択
  // alu_ram_sel_s == 1'b1： RAM からのデータを選択
  //
  always @(op_code) begin
    case (op_code)
      `R:      alu_ram_sel_s_tmp = 1'b0;
//
// 追加設計 3 のヒント(19)：I 形式の命令 LW の追加、レジスタファイルの方へ流すデータを選択するセレクト信号の記述
//
      `LW:     alu_ram_sel_s_tmp = 1'bX;
//
//
//

      `ADDI:   alu_ram_sel_s_tmp = 1'b0;
//
// 追加設計 1 のヒント(7)：I 形式の命令 addiu の追加、レジスタファイルの方へ流すデータを選択するセレクト信号の記述
//
      `ADDIU:  alu_ram_sel_s_tmp = 1'b0;
//
//
//
      `ANDI:   alu_ram_sel_s_tmp = 1'b0;
      `ORI:    alu_ram_sel_s_tmp = 1'b0;
      `BEQ:    alu_ram_sel_s_tmp = 1'b0;
      `XORI:   alu_ram_sel_s_tmp = 1'b0;
      `SLTI:   alu_ram_sel_s_tmp = 1'b0;
//
// 追加設計 3 のヒント(6)：I 形式の命令 SLTIU の追加、レジスタファイルの方へ流すデータを選択するセレクト信号の記述
//
      `SLTIU:  alu_ram_sel_s_tmp = 1'bX;
//
//
//
      `LUI:    alu_ram_sel_s_tmp = 1'b0;
      default: alu_ram_sel_s_tmp = 1'b0;
    endcase
  end
  assign  alu_ram_sel_s = alu_ram_sel_s_tmp;

  // reg_widx_sel1_s
  //
  // MUX, reg_widx_sel1 モジュールのセレクト信号
  // reg_widx_sel1_s == 1'b0： 命令の Rt フィールドを選択
  // reg_widx_sel1_s == 1'b1： 命令の Rd フィールドを選択
  //
  always @(op_code) begin
    case (op_code)
      `R:      reg_widx_sel1_s_tmp = 1'b1;
//
// 追加設計 3 のヒント(20)：I 形式の命令 LW の追加、レジスタファイルの write_idx の方へ流すデータを選択するセレクト信号の記述
//
      `LW:     reg_widx_sel1_s_tmp = 1'bX;
//
//
//

      `ADDI:   reg_widx_sel1_s_tmp = 1'b0;
//
// 追加設計 1 のヒント(8)：I 形式の命令 addiu の追加、レジスタファイルの write_idx へ流すデータを選択するセレクト信号の記述
//
      `ADDIU:  reg_widx_sel1_s_tmp = 1'b0;
//
//
//
      `ANDI:   reg_widx_sel1_s_tmp = 1'b0;
      `ORI:    reg_widx_sel1_s_tmp = 1'b0;
      `BEQ:    reg_widx_sel1_s_tmp = 1'b0;
      `XORI:   reg_widx_sel1_s_tmp = 1'b0;
      `SLTI:   reg_widx_sel1_s_tmp = 1'b0;
//
// 追加設計 3 のヒント(7)：I 形式の命令 SLTIU の追加、レジスタファイルの write_idx の方へ流すデータを選択するセレクト信号の記述
//
      `SLTIU:  reg_widx_sel1_s_tmp = 1'bX;
//
//
//
      `LUI:    reg_widx_sel1_s_tmp = 1'b0;
      default: reg_widx_sel1_s_tmp = 1'b0;
    endcase
  end
  assign  reg_widx_sel1_s = reg_widx_sel1_s_tmp;

  // link
  //
  // MUX, reg_widx_sel2 モジュールのセレクト信号
  // link == 1'b0： reg_widx_sel1_y を選択
  // link == 1'b1： レジスタファイル中の PC の値を記憶するレジスタ RA の idx, 31 を選択
  //
  always @(op_code) begin
    case (op_code)
      `R: begin
            if (Rfunc == 6'b001001) begin  // R 形式の命令, JALR 用
              link_tmp = 1'b1;
            end else begin                 // R 形式の命令, その他用
              link_tmp = 1'b0;
            end
          end
//
// 追加設計 3 のヒント(21)：I 形式の命令 LW の追加、レジスタファイルの write_idx へ流すデータを選択するセレクト信号の記述
//
      `LW:     link_tmp = 1'bX;
//
//
//

      `ADDI:   link_tmp = 1'b0;
//
// 追加設計 1 のヒント(9)：I 形式の命令 addiu の追加、レジスタファイルの write_idx へ流すデータを選択するセレクト信号の記述
//
      `ADDIU:  link_tmp = 1'b0;
//
//
//
      `ANDI:   link_tmp = 1'b0;
      `ORI:    link_tmp = 1'b0;
      `BEQ:    link_tmp = 1'b0;
      `BGEZ:   link_tmp = 1'b0;
      `BLEZ:   link_tmp = 1'b0;
      `BGTZ:   link_tmp = 1'b0;
      `BLTZ:   link_tmp = 1'b0;
      `BGEZAL: link_tmp = 1'b1;
      `BLTZAL: link_tmp = 1'b1;

//
// 追加設計 4 のヒント(4)：J 形式の命令 JAL の追加、レジスタファイルの write_idx へ流すデータを選択するセレクト信号の記述
//
      `JAL:    link_tmp = 1'b0;
//
//
//
      `XORI:   link_tmp = 1'b0;
      `SLTI:   link_tmp = 1'b0;
//
// 追加設計 3 のヒント(8)：I 形式の命令 SLTIU の追加、レジスタファイルの write_idx へ流すデータを選択するセレクト信号の記述
//
      `SLTIU:  link_tmp = 1'bX;
//
//
//
      `LUI:    link_tmp = 1'b0;
      default: link_tmp = 1'b0;
    endcase
  end
  assign  link = link_tmp;

endmodule
