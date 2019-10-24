/***********/
/* plus4.v */
/***********/

//              +----+
// inc_a[31:0]->|    |->inc_y[31:0]
//              +----+

module plus4 (inc_a, inc_y);  // 入出力ポート
  input  [31:0]  inc_a;          // 入力 32-bit
  output [31:0]  inc_y;          // 出力 32-bit

  assign inc_y = inc_a + 4;
endmodule
