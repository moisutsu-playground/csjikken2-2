/***************/
/* registers.v */
/***************/

//                       +----+
//                clock->|    |
//                reset->|    |
//   reg_read_idx1[4:0]->|    |
//   reg_read_idx2[4:0]->|    |->reg_read_data1[31:0]
//   reg_write_idx[4:0]->|    |->reg_read_data2[31:0]
//     reg_write_enable->|    |
// reg_write_data[31:0]->|    |
//                       +----+

module registers (clock, reset,
		  reg_read_idx1, reg_read_idx2,
		  reg_write_idx, reg_write_enable, reg_write_data,
		  reg_read_data1, reg_read_data2);

  input               clock, reset;       // 入力 クロック, リセット
  input   [4:0]       reg_read_idx1;      // 読みアドレス1
  input   [4:0]       reg_read_idx2;      // 読みアドレス2
  input   [4:0]       reg_write_idx;      // 書き込みアドレス
  input               reg_write_enable;   // 書き込み(1)/読み(0)
  input  [31:0]       reg_write_data;     // 書き込みデータ
  output [31:0]       reg_read_data1;     // 読みデータ1
  output [31:0]       reg_read_data2;     // 読みデータ2

  // Registers (regs_0 = 0)
  //                 // 0
  reg [31:0] regs_1;
  reg [31:0] regs_2;
  reg [31:0] regs_3;
  reg [31:0] regs_4;
  reg [31:0] regs_5;
  reg [31:0] regs_6;
  reg [31:0] regs_7;
  reg [31:0] regs_8;
  reg [31:0] regs_9;
  reg [31:0] regs_10;
  reg [31:0] regs_11;
  reg [31:0] regs_12;
  reg [31:0] regs_13;
  reg [31:0] regs_14;
  reg [31:0] regs_15;
  reg [31:0] regs_16;
  reg [31:0] regs_17;
  reg [31:0] regs_18;
  reg [31:0] regs_19;
  reg [31:0] regs_20;
  reg [31:0] regs_21;
  reg [31:0] regs_22;
  reg [31:0] regs_23;
  reg [31:0] regs_24;
  reg [31:0] regs_25;
  reg [31:0] regs_26;
  reg [31:0] regs_27;
  reg [31:0] regs_28; //gp (global pointer)
  reg [31:0] regs_29; //sp (stack pointer)
  reg [31:0] regs_30; //fp (frame pointer)
  reg [31:0] regs_31; //ra (return address, for ...*AL)

  //
  // 読み1（regs[0]は常に0）
  // assign reg_read_data1 = regs[1〜15];
  //
  assign reg_read_data1 = (reg_read_idx1 == 5'b00000) ? 0 : (
    (reg_read_idx1 == 5'b00001) ? regs_1 : (
    (reg_read_idx1 == 5'b00010) ? regs_2 : (
    (reg_read_idx1 == 5'b00011) ? regs_3 : (
    (reg_read_idx1 == 5'b00100) ? regs_4 : (
    (reg_read_idx1 == 5'b00101) ? regs_5 : (
    (reg_read_idx1 == 5'b00110) ? regs_6 : (
    (reg_read_idx1 == 5'b00111) ? regs_7 : (
    (reg_read_idx1 == 5'b01000) ? regs_8 : (
    (reg_read_idx1 == 5'b01001) ? regs_9 : (
    (reg_read_idx1 == 5'b01010) ? regs_10 : (
    (reg_read_idx1 == 5'b01011) ? regs_11 : (
    (reg_read_idx1 == 5'b01100) ? regs_12 : (
    (reg_read_idx1 == 5'b01101) ? regs_13 : (
    (reg_read_idx1 == 5'b01110) ? regs_14 : (
    (reg_read_idx1 == 5'b01111) ? regs_15 : (
    (reg_read_idx1 == 5'b10000) ? regs_16 : (
    (reg_read_idx1 == 5'b10001) ? regs_17 : (
    (reg_read_idx1 == 5'b10010) ? regs_18 : (
    (reg_read_idx1 == 5'b10011) ? regs_19 : (
    (reg_read_idx1 == 5'b10100) ? regs_20 : (
    (reg_read_idx1 == 5'b10101) ? regs_21 : (
    (reg_read_idx1 == 5'b10110) ? regs_22 : (
    (reg_read_idx1 == 5'b10111) ? regs_23 : (
    (reg_read_idx1 == 5'b11000) ? regs_24 : (
    (reg_read_idx1 == 5'b11001) ? regs_25 : (
    (reg_read_idx1 == 5'b11010) ? regs_26 : (
    (reg_read_idx1 == 5'b11011) ? regs_27 : (
    (reg_read_idx1 == 5'b11100) ? regs_28 : (
    (reg_read_idx1 == 5'b11101) ? regs_29 : (
    (reg_read_idx1 == 5'b11110) ? regs_30 : (regs_31)))))))))))))))
))))))))))))))));

  //
  // 読み2（regs[0]は常に0）
  // assign reg_read_data2 = regs[1〜15];
  //
  assign reg_read_data2 = (reg_read_idx2 == 5'b00000) ? 0 : (
    (reg_read_idx2 == 5'b00001) ? regs_1 : (
    (reg_read_idx2 == 5'b00010) ? regs_2 : (
    (reg_read_idx2 == 5'b00011) ? regs_3 : (
    (reg_read_idx2 == 5'b00100) ? regs_4 : (
    (reg_read_idx2 == 5'b00101) ? regs_5 : (
    (reg_read_idx2 == 5'b00110) ? regs_6 : (
    (reg_read_idx2 == 5'b00111) ? regs_7 : (
    (reg_read_idx2 == 5'b01000) ? regs_8 : (
    (reg_read_idx2 == 5'b01001) ? regs_9 : (
    (reg_read_idx2 == 5'b01010) ? regs_10 : (
    (reg_read_idx2 == 5'b01011) ? regs_11 : (
    (reg_read_idx2 == 5'b01100) ? regs_12 : (
    (reg_read_idx2 == 5'b01101) ? regs_13 : (
    (reg_read_idx2 == 5'b01110) ? regs_14 : (
    (reg_read_idx2 == 5'b01111) ? regs_15 : (
    (reg_read_idx2 == 5'b10000) ? regs_16 : (
    (reg_read_idx2 == 5'b10001) ? regs_17 : (
    (reg_read_idx2 == 5'b10010) ? regs_18 : (
    (reg_read_idx2 == 5'b10011) ? regs_19 : (
    (reg_read_idx2 == 5'b10100) ? regs_20 : (
    (reg_read_idx2 == 5'b10101) ? regs_21 : (
    (reg_read_idx2 == 5'b10110) ? regs_22 : (
    (reg_read_idx2 == 5'b10111) ? regs_23 : (
    (reg_read_idx2 == 5'b11000) ? regs_24 : (
    (reg_read_idx2 == 5'b11001) ? regs_25 : (
    (reg_read_idx2 == 5'b11010) ? regs_26 : (
    (reg_read_idx2 == 5'b11011) ? regs_27 : (
    (reg_read_idx2 == 5'b11100) ? regs_28 : (
    (reg_read_idx2 == 5'b11101) ? regs_29 : (
    (reg_read_idx2 == 5'b11110) ? regs_30 : (regs_31)))))))))))))))
))))))))))))))));

  // Always ブロック: 書き込み
  // 入力: clock, reset, reg_write_idx, reg_write_enable, reg_write_data
  // 出力: regs_1〜regs_15
  // レジスタ: regs_1〜regs_15
  always @(posedge clock or negedge reset) begin
    if (reset == 1'b0) begin
       regs_1 <= 0;
       regs_2 <= 0;
       regs_3 <= 0;
       regs_4 <= 0;
       regs_5 <= 0;
       regs_6 <= 0;
       regs_7 <= 0;
       regs_8 <= 0;
       regs_9 <= 0;
      regs_10 <= 0;
      regs_11 <= 0;
      regs_12 <= 0;
      regs_13 <= 0;
      regs_14 <= 0;
      regs_15 <= 0;
      regs_16 <= 0;
      regs_17 <= 0;
      regs_18 <= 0;
      regs_19 <= 0;
      regs_20 <= 0;
      regs_21 <= 0;
      regs_22 <= 0;
      regs_23 <= 0;
      regs_24 <= 0;
      regs_25 <= 0;
      regs_26 <= 0;
      regs_27 <= 0;
      regs_28 <= 0;
      regs_29 <= 0;
      regs_30 <= 0;
      regs_31 <= 0;
    end else begin
    if (reg_write_enable == 1'b1) begin
      // 
      // 書き込み（regs[0]は常に0）
      // regs[1〜15] = reg_write_data;
      // 
      if (reg_write_idx == 5'b00001) begin
        regs_1 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b00010) begin
        regs_2 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b00011) begin
        regs_3 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b00100) begin
        regs_4 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b00101) begin
        regs_5 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b00110) begin
        regs_6 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b00111) begin
        regs_7 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b01000) begin
        regs_8 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b01001) begin
        regs_9 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b01010) begin
        regs_10 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b01011) begin
        regs_11 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b01100) begin
        regs_12 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b01101) begin
        regs_13 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b01110) begin
        regs_14 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b01111) begin
        regs_15 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b10000) begin
        regs_16 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b10001) begin
        regs_17 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b10010) begin
        regs_18 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b10011) begin
        regs_19 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b10100) begin
        regs_20 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b10101) begin
        regs_21 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b10110) begin
        regs_22 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b10111) begin
        regs_23 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b11000) begin
        regs_24 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b11001) begin
        regs_25 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b11010) begin
        regs_26 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b11011) begin
        regs_27 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b11100) begin
        regs_28 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b11101) begin
        regs_29 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b11110) begin
        regs_30 <= reg_write_data;
      end    
      if (reg_write_idx == 5'b11111) begin
        regs_31 <= reg_write_data;
      end    
      end    
    end  // End: if (reg_write_enable == 1'b1) begin
  end  // End: always @(posedge clock or negedge reset) begin

endmodule
