/****************/
/* alu_ctrler.v */
/****************/

//              +----+
// alu_op[2:0]->|    |
//   func[5:0]->|    |->alu_ctrl[3:0]
//              +----+

// ALU 制御コード
`define     ALU_CTRL_ADD  4'b0010
`define     ALU_CTRL_SUB  4'b0110
`define     ALU_CTRL_AND  4'b0000
`define      ALU_CTRL_OR  4'b0001
`define     ALU_CTRL_SLT  4'b0111
`define     ALU_CTRL_NOR  4'b0011
`define     ALU_CTRL_XOR  4'b0100
`define     ALU_CTRL_SLL  4'b1010
`define     ALU_CTRL_SRL  4'b1110
`define     ALU_CTRL_SRA  4'b1000
`define     ALU_CTRL_SLTU 4'b1001
`define     ALU_CTRL_LUI  4'b1111

// 実験 9 のヒント（１０）：mult, mflo 命令用の ALU 制御コードの define




//           命令,         ALUOp(alu_op),  命令機能コード(func), ALU 制御コード
//     lw(load word),           000,         xxxxxx,             0010(add)
//    sw(store word),           000,         xxxxxx,             0010(add)
////beq(branch on equal),         001,         xxxxxx,             0110(sub)
////bne(branch on not equal),     001,         xxxxxx,             0110(sub)
////       j(jump),               001,         xxxxxx,             0110(sub)
////    jal(jump and link),       001,         xxxxxx,             0110(sub)
//    addi(add immedaiate),     000,         xxxxxx,             0010(add)
//   addiu(add immedaiate),     000,         xxxxxx,             0010(add)

// 実験 9 のヒント（１１）：mult, mflo 命令用の ALU 制御コードについてのコメント



//        R 形式 add,           010,          100000,             0010(add)
//        R 形式 addu,          010,          100001,             0010(add)
//        R 形式 sub,           010,          100010,             0110(sub)
//        R 形式 subu,          010,          100011,             0110(sub)
//        R 形式 and,           010,          100100,             0000(and)
//        R 形式 or,            010,          100101,             0001(or)
//        R 形式 slt,           010,          101010,             0111(slt)
//        R 形式 jalr,          010,          001001,             0010(add)
//        R 形式 jr,            010,          001000,             0010(add)
//        R 形式 nor,           010,          100111,             0011(nor)
//        R 形式 xor,           010,          100110,             0100(xor)
//        R 形式 sll,           010,          000000,             1010(sll)
//        R 形式 srl,           010,          000010,             1110(srl)
//        R 形式 sllv,          010,          000100,             1010(sll)
//        R 形式 srlv,          010,          000110,             1110(srl)
//        R 形式 sra,           010,          000011,             1000(sra)
//        R 形式 srav,          010,          000111,             1000(sra)
//        R 形式 sltu,          010,          101011,             1001(sltu)
//   andi(and immediate),      011,           xxxxxx,             000(and)
//    ori(or immediate),       100,           xxxxxx,             001(or)
//   xori(xor immediate),      101,           xxxxxx,             100(xor)
//   slti(set on less than immediate signed),
//                             110,           xxxxxx,             0111(slt)
//   sltiu(set on less than immediate unsigned),
//                             111,           xxxxxx,             1001(sltu)
//   lui(load upper immediate),
//                             001,           xxxxxx,             1111(lui)

module alu_ctrler (alu_op, func, alu_ctrl);  // 入出力ポート
  input  [2:0]  alu_op;          // 入力 3-bit      メイン制御回路からの制御入力
  input  [5:0]    func;          // 入力 6-bit      R 形式、function フィールド

  output [3:0]  alu_ctrl;          // 出力 4-bit      y

  reg    [3:0]       y;
   
  always @(alu_op or func) begin
    case (alu_op)
      3'b000: begin
        y = `ALU_CTRL_ADD;  // I 形式 LW, SW 用
        end
      3'b001: begin
        y = `ALU_CTRL_LUI;  // I 形式 LUI 用
      end
      3'b010: begin  // R 形式
        if (func == 6'b100000) begin // func=ADD
          y = `ALU_CTRL_ADD;
        end else if (func == 6'b100001) begin // func=ADDU
          y = `ALU_CTRL_ADD;
        end else if (func == 6'b100010) begin // func=SUB
          y = `ALU_CTRL_SUB;
        end else if (func == 6'b100011) begin // func=SUBU
          y = `ALU_CTRL_SUB;
        end else if (func == 6'b100100) begin // func=AND
          y = `ALU_CTRL_AND;
        end else if (func == 6'b100101) begin // func=OR
          y = `ALU_CTRL_OR;
        end else if (func == 6'b101010) begin // func=SLT
          y = `ALU_CTRL_SLT;
        end else if (func == 6'b001001) begin // func=JALR
          y = `ALU_CTRL_ADD;
        end else if (func == 6'b001000) begin // func=JR
          y = `ALU_CTRL_ADD;
        end else if (func == 6'b001000) begin // func=NOR
          y = `ALU_CTRL_NOR;
        end else if (func == 6'b001000) begin // func=XOR
          y = `ALU_CTRL_XOR;
        end else if (func == 6'b000000) begin // func=SLL
          y = `ALU_CTRL_SLL;
        end else if (func == 6'b000010) begin // func=SRL
          y = `ALU_CTRL_SRL;
        end else if (func == 6'b000100) begin // func=SLLV
          y = `ALU_CTRL_SLL;
        end else if (func == 6'b000110) begin // func=SRLV
          y = `ALU_CTRL_SRL;
        end else if (func == 6'b000011) begin // func=SRA
          y = `ALU_CTRL_SRA;
        end else if (func == 6'b000111) begin // func=SRAV
          y = `ALU_CTRL_SRA;
        end else if (func == 6'b101011) begin // func=SLTU
          y = `ALU_CTRL_SLTU;

// 実験 9 のヒント（１２）：実行する命令が mult, mflo 命令のとき、mult, mflo 命令用の ALU 制御コードを生成する処理の記述




        end else begin
          y = 3'b000;
        end
      end
      3'b011: begin
        y = `ALU_CTRL_AND;   // I 形式 ANDI 用
      end
      3'b100: begin
        y = `ALU_CTRL_OR;    // I 形式 ORI 用
      end
      3'b101: begin
        y = `ALU_CTRL_XOR;   // I 形式 XORI 用
      end
      3'b110: begin
        y = `ALU_CTRL_SLT;   // I 形式 SLTI 用
      end
      default: begin  //  3'b111: begin
        y = `ALU_CTRL_SLTU;  // I 形式 SLTIU 用
      end
    endcase
  end

  assign alu_ctrl = y;
endmodule
