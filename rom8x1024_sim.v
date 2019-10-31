/*******************/
/* rom8x1024_sim.v */
/*******************/

//                  +----+
//  rom_addr[11:0]->|    |->rom_data[31:0]
//                  +----+

//
// ROMの記述（論理シミュレーション用）
//

module rom8x1024_sim (rom_addr, rom_data);

  input   [11:0]  rom_addr;  // 12-bit アドレス入力ポート
  output  [31:0]  rom_data;  // 32-bit データ出力ポート

  reg     [31:0]  data;

  // Wire
  wire     [9:0]  word_addr; // 10-bit address, word

  assign word_addr = rom_addr[9:2];
   
  always @(word_addr) begin
    case (word_addr)
      10'h000: data = 32'h6000000c; // 00400000: LLO, REG[0].[15:0]<=12; #NOT YET IMPREMENTED
      10'h001: data = 32'h00000000; // 00400004: SLL, REG[0]<=REG[0]<<0;
      10'h002: data = 32'h00000000; // 00400008: SLL, REG[0]<=REG[0]<<0;
      10'h003: data = 32'h00000000; // 0040000c: SLL, REG[0]<=REG[0]<<0;
      10'h004: data = 32'h00000000; // 00400010: SLL, REG[0]<=REG[0]<<0;
      10'h005: data = 32'h00408050; // 00400014: R type, unknown. func=16(10)
      10'h006: data = 32'h00000000; // 00400018: SLL, REG[0]<=REG[0]<<0;
      10'h007: data = 32'h00000000; // 0040001c: SLL, REG[0]<=REG[0]<<0;
      10'h008: data = 32'h27bdfff8; // 00400020: ADDIU, REG[29]<=REG[29]+65528(=0x0000fff8);
      10'h009: data = 32'hafbe0000; // 00400024: SW, RAM[REG[29]+0]<=REG[30];
      10'h00a: data = 32'h03a0f021; // 00400028: ADDU, REG[30]<=REG[29]+REG[0];
      10'h00b: data = 32'h24020300; // 0040002c: ADDIU, REG[2]<=REG[0]+768(=0x00000300);
      10'h00c: data = 32'hac400000; // 00400030: SW, RAM[REG[2]+0]<=REG[0];
      10'h00d: data = 32'h24030304; // 00400034: ADDIU, REG[3]<=REG[0]+772(=0x00000304);
      10'h00e: data = 32'h24020002; // 00400038: ADDIU, REG[2]<=REG[0]+2(=0x00000002);
      10'h00f: data = 32'hac620000; // 0040003c: SW, RAM[REG[3]+0]<=REG[2];
      10'h010: data = 32'h24030300; // 00400040: ADDIU, REG[3]<=REG[0]+768(=0x00000300);
      10'h011: data = 32'h24020001; // 00400044: ADDIU, REG[2]<=REG[0]+1(=0x00000001);
      10'h012: data = 32'hac620000; // 00400048: SW, RAM[REG[3]+0]<=REG[2];
      10'h013: data = 32'h0810000b; // 0040004c: J, PC<=0x0010000b*4(=0x0040002c);
      10'h014: data = 32'h00000000; // 00400050: SLL, REG[0]<=REG[0]<<0;
      10'h015: data = 32'h00000000; // 00400054: SLL, REG[0]<=REG[0]<<0;
      10'h016: data = 32'h00000000; // 00400058: SLL, REG[0]<=REG[0]<<0;
      10'h017: data = 32'h00000000; // 0040005c: SLL, REG[0]<=REG[0]<<0;
    endcase
  end

  assign rom_data = data;
endmodule
