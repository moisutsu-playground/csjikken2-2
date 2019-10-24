/*********/
/* alu.v */
/*********/

//                  +----+
//     alu_a[31:0]->|    |
//     alu_b[31:0]->|    |->alu_y[31:0]
//   alu_ctrl[3:0]->|    |->alu_comp[1:0]
//                  +----+

// 命令セット
// lw(load word)
// sw(store word)
// add
// addu
// addi
// addiu
// sub
// and
// andi
// or
// ori
// slt(set on less than)
// beq(branch on equal)
// bne(branch not on equal)
// bgez(branch on greater than or equal to zero)
// blez(branch on less than or equal to zero)
// bgtz(branch on greater than zero)
// bltz(branch on less than zero)
// bgezal(branch on greater than or equal to zero and link)
// bltzal(branch on less than or equal to zero and link)
// j(jump)
// jal(jump and link)
// jalr(jump and link register)
// jr(jump register)
// sll(shift left logic)
// srl(shift right logic)
// sllv(shift left logic variable)
// srlv(shift right logic variable)
// sra(shift right arithmetic)
// srav(shift right arithmetic variable)
// lui(load upper immediate)

// 実験 9 のヒント（２）：コメントの追加(1)



// alu_ctrl[3:0], 実行する演算
// 0010,           add
// 0110,           sub
// 0000,           and
// 0001,           or
// 0111,           slt
// 0011,           nor
// 0100,           xor
// 1010,           sll
// 1110,           srl
// 1000,           sra
// 1001,           sltu
// 1111,           lui

// 実験 9 のヒント（３）：コメントの追加(2)



// ALU 制御コード
`define     ALU_ADD  4'b0010
`define     ALU_SUB  4'b0110
`define     ALU_AND  4'b0000
`define      ALU_OR  4'b0001
`define     ALU_SLT  4'b0111
`define     ALU_NOR  4'b0011
`define     ALU_XOR  4'b0100
`define     ALU_SLL  4'b1010
`define     ALU_SRL  4'b1110
`define     ALU_SRA  4'b1000
`define     ALU_SLTU 4'b1001
`define     ALU_LUI  4'b1111

// 実験 9 のヒント（４）：mult, mflo 用の ALU 制御コードの define


// 実験 9 のヒント（５）：ALU モジュールの入力ポートの拡張
// 　　   　　　　　　　　clock, reset 信号の追加、乗算結果を保持するレジスタ hi と lo 用
module alu (alu_a, alu_b, alu_ctrl, alu_y, alu_comp);  // 入出力ポート
  input  [31:0] alu_a;           // 入力 32-bit      a
  input  [31:0] alu_b;           // 入力 32-bit      b
  input   [3:0] alu_ctrl;        // 入力  4-bit   ALU 制御コード

  output [31:0]  alu_y;          // 出力 32-bit      y
  output  [1:0]  alu_comp;       // 出力  2-bit  比較結果

  reg    [31:0] result;
  reg     [1:0]   comp;

// 実験 9 のヒント（６）：mult 命令実行時に alu_a * alu_b の結果を {hi, lo}　に格納する記述の追加






  always @(alu_a or alu_b or alu_ctrl or comp) begin
    case (alu_ctrl)
      `ALU_ADD: begin
        result <= alu_a + alu_b;
      end
      `ALU_SUB: begin
        result <= alu_a - alu_b;
      end
      `ALU_AND: begin
        result <= alu_a & alu_b;
      end
      `ALU_OR: begin
        result <= alu_a | alu_b;
      end
      `ALU_SLT: begin
        result <= (comp == 2'b10) ? 32'h00000001 : 32'h00000000;
      end
      `ALU_NOR: begin
        result <= ~(alu_a | alu_b);
      end
      `ALU_XOR: begin
        result <= alu_a ^ alu_b;
      end
      `ALU_SLL: begin
        result <= alu_b << alu_a;
      end
      `ALU_SRL: begin
        result <= alu_b >> alu_a;
      end
      `ALU_SRA: begin
        case (alu_a[4:0])
          // default:
          // 5'b00000: begin
          //  result <= alu_b;
          // end
          5'b00001: begin
            result[31]   <= alu_b[31];
            result[30:0] <= alu_b[31:1];
          end
          5'b00010: begin
            result[31:30]   <= {alu_b[31], alu_b[31]};
            result[29:0] <= alu_b[31:2];
          end
          5'b00011: begin
            result[31:29]   <= {alu_b[31], alu_b[31], alu_b[31]};
            result[28:0] <= alu_b[31:3];
          end
          5'b00100: begin
            result[31:28]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31]};
            result[27:0] <= alu_b[31:4];
          end
          5'b00101: begin
            result[31:27]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31]};
            result[26:0] <= alu_b[31:5];
          end
          5'b00110: begin
            result[31:26]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31]};
            result[25:0] <= alu_b[31:6];
          end
          5'b00111: begin
            result[31:25]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31]};
            result[24:0] <= alu_b[31:7];
          end
          5'b01000: begin
            result[31:24]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31]};
            result[23:0] <= alu_b[31:8];
          end
          5'b01001: begin
            result[31:23]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31]};
            result[22:0] <= alu_b[31:9];
          end
          5'b01010: begin
            result[31:22]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31]};
            result[21:0] <= alu_b[31:10];
          end
          5'b01011: begin
            result[31:21]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31]};
            result[20:0] <= alu_b[31:11];
          end
          5'b01100: begin
            result[31:20]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31]};
            result[19:0] <= alu_b[31:12];
          end
          5'b01101: begin
            result[31:19]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31]};
            result[18:0] <= alu_b[31:13];
          end
          5'b01110: begin
            result[31:18]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31]};
            result[17:0] <= alu_b[31:14];
          end
          5'b01111: begin
            result[31:17]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31]};
            result[16:0] <= alu_b[31:15];
          end
          5'b10000: begin
            result[31:16]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31]};
            result[15:0] <= alu_b[31:16];
          end
          5'b10001: begin
            result[31:15]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31]};
            result[14:0] <= alu_b[31:17];
          end
          5'b10010: begin
            result[31:14]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31]};
            result[13:0] <= alu_b[31:18];
          end
          5'b10011: begin
            result[31:13]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31]};
            result[12:0] <= alu_b[31:19];
          end
          5'b10100: begin
            result[31:12]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31]};
            result[11:0] <= alu_b[31:20];
          end
          5'b10101: begin
            result[31:11]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31]};
            result[10:0] <= alu_b[31:21];
          end
          5'b10110: begin
            result[31:10]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31]};
            result[9:0] <= alu_b[31:22];
          end
          5'b10111: begin
            result[31:9]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31]};
            result[8:0] <= alu_b[31:23];
          end
          5'b11000: begin
            result[31:8]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31]};
            result[7:0] <= alu_b[31:24];
          end
          5'b11001: begin
            result[31:7]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31]};
            result[6:0] <= alu_b[31:25];
          end
          5'b11010: begin
            result[31:6]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31]};
            result[5:0] <= alu_b[31:26];
          end
          5'b11011: begin
            result[31:5]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31]};
            result[4:0] <= alu_b[31:27];
          end
          5'b11100: begin
            result[31:4]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31]};
            result[3:0] <= alu_b[31:28];
          end
          5'b11101: begin
            result[31:3]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31]};
            result[2:0] <= alu_b[31:29];
          end
          5'b11110: begin
            result[31:2]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31]};
            result[1:0] <= alu_b[31:30];
          end
          5'b11111: begin
            result[31:1]   <= {alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31], alu_b[31],
                                alu_b[31], alu_b[31], alu_b[31]};
            result[0] <= alu_b[31];
          end
          default: begin
            result <= alu_b;
          end
        endcase
      end
      `ALU_SLTU: begin
        result <= (alu_a < alu_b) ? 32'h00000001 : 32'h00000000;
      end
      `ALU_LUI: begin
        result <= alu_b << 16;
      end

// 実験 9 のヒント（７）：mflo 命令実行時に {hi, lo} の lo を result に出力する記述の追加


      default: begin
        result <= 0;
      end
    endcase
  end

  always @(alu_a or alu_b) begin
    if (alu_a == alu_b) begin
       comp <= 2'b00;
    end else begin
      if (alu_a[31] == 0) begin
        if (alu_b[31] == 0) begin  // alu_a,alu_b ともに正
          if (alu_a > alu_b) begin
            comp <= 2'b01;
          end else begin
            comp <= 2'b10;  // alu_a < alu_b
          end
        end else begin     // alu_a > 0 かつ alu_b < 0のとき 
          comp <= 2'b01;
        end     
      end else begin
        if (alu_b[31] == 0) begin  // alu_a < 0 かつ alu_b > 0のとき
          comp <= 2'b10;
        end else begin             // alu_a,alu_b　ともに負 
          if (alu_a > alu_b) begin
            comp <= 2'b10;
          end else begin   
            comp <= 2'b01;
          end
        end 
      end
    end
  end

  assign alu_y = result;
  assign alu_comp = comp;
endmodule
