/**************/
/* mux32_32_32.v */
/**************/

//           +----+
// d0[31:0]->|    |
// d1[31:0]->|    |->y[31:0]
//        s->|    |
//           +----+

module mux32_32_32 (d0, d1, s, y);  // 入出力ポート
  input  [31:0] d0;          // 入力 32-bit d0
  input  [31:0] d1;          // 入力 32-bit d1
  input          s;          // 入力 1-bit  s
  output [31:0]  y;          // 出力 32-bit  y

  // Multiplexer body
  // if (s == 0) y = d0; else y = d1;
  // 出力ポートに対する代入は assign 文で行う
  assign y = (s == 1'b0) ? d0 : d1;
endmodule
