/***************/
/* is_branch.v */
/***************/

//           +----+
//  d0[2:0]->|    |
//  d1[1:0]->|    |->y
//           +----+

`define    EQ   3'b000  // ==
`define    NEQ  3'b001  // !=
`define    GE   3'b010  // >=
`define    LE   3'b011  // <=
`define    GT   3'b100  // >
`define    LT   3'b101  // <
`define    X    3'b110  //

module is_branch (d0, d1, y);  // 入出力ポート
  input  [2:0] d0;          // 入力 d0, main_ctrl から
  input  [1:0] d1;          // 入力 d1, alu から
  output  y;                // 出力  y

  reg   y_temp;
 
  always @(d0 or d1) begin
    case (d0)
          `EQ:      y_temp = (d1 == 2'b00) ? 1'b1 : 1'b0;
         `NEQ:      y_temp = (d1 == 2'b00) ? 1'b0 : 1'b1;
          `GE:      y_temp = (d1[1] == 1'b0) ? 1'b1 : 1'b0;
          `LE:      y_temp = (d1[0] == 1'b0) ? 1'b1 : 1'b0;
          `GT:      y_temp = (d1 == 2'b01) ? 1'b1 : 1'b0;
          `LT:      y_temp = (d1 == 2'b10) ? 1'b1 : 1'b0;
           `X:      y_temp = 1'b0;
      default:      y_temp = 1'b0;
    endcase
  end

  assign y = y_temp;

endmodule
