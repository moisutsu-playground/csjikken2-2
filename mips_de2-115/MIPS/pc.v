/********/
/* pc.v */
/********/

//
// プログラムカウンタの初期値は 0x00400000
//

//                +----+
//         clock->|    |
//         reset->|    |
// pc_next[31:0]->|    |->pc[31:0]
//                +----+

module pc (clock, reset, pc_next, pc);  // 入出力ポート

  input       clock, reset;   // 入力 クロック, リセット
  input  [31:0]    pc_next;   // 入力 32-bit 次にPCにセットする値
  output [31:0]         pc;   // 出力 32-bit PC

  reg    [31:0]     pc_reg;   // PC用レジスタ

  // Always ブロック: プログラムカウンタ
  // 入力: clock, reset, pc_next
  // 出力: pc_reg
  // レジスタ: pc_reg
  always @(posedge clock or negedge reset) begin
    if (reset == 1'b0) begin
	pc_reg <= 32'h00400000;
    end else begin
	pc_reg <= pc_next;
    end
  end

  assign pc = pc_reg;   
endmodule
