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
      10'h000: data = 32'he000001c; // 00400000: other type! opcode=56(10)
      10'h001: data = 32'h00000000; // 00400004: SLL, REG[0]<=REG[0]<<0;
      10'h002: data = 32'h00000000; // 00400008: SLL, REG[0]<=REG[0]<<0;
      10'h003: data = 32'h00000000; // 0040000c: SLL, REG[0]<=REG[0]<<0;
      10'h004: data = 32'h00000000; // 00400010: SLL, REG[0]<=REG[0]<<0;
      10'h005: data = 32'h004080c0; // 00400014: SLL, REG[16]<=REG[0]<<3;
      10'h006: data = 32'h00000000; // 00400018: SLL, REG[0]<=REG[0]<<0;
      10'h007: data = 32'h00000000; // 0040001c: SLL, REG[0]<=REG[0]<<0;
      10'h008: data = 32'h27bdffe8; // 00400020: ADDIU, REG[29]<=REG[29]+65512(=0x0000ffe8);
      10'h009: data = 32'hafbf0014; // 00400024: SW, RAM[REG[29]+20]<=REG[31];
      10'h00a: data = 32'hafbe0010; // 00400028: SW, RAM[REG[29]+16]<=REG[30];
      10'h00b: data = 32'h03a0f021; // 0040002c: ADDU, REG[30]<=REG[29]+REG[0];
      10'h00c: data = 32'h0c100010; // 00400030: JAL, PC<=0x00100010*4(=0x00400040); REG[31]<=PC+4
      10'h00d: data = 32'h00000000; // 00400034: SLL, REG[0]<=REG[0]<<0;
      10'h00e: data = 32'h0810000c; // 00400038: J, PC<=0x0010000c*4(=0x00400030);
      10'h00f: data = 32'h00000000; // 0040003c: SLL, REG[0]<=REG[0]<<0;
      10'h010: data = 32'h27bdffe8; // 00400040: ADDIU, REG[29]<=REG[29]+65512(=0x0000ffe8);
      10'h011: data = 32'hafbf0014; // 00400044: SW, RAM[REG[29]+20]<=REG[31];
      10'h012: data = 32'hafbe0010; // 00400048: SW, RAM[REG[29]+16]<=REG[30];
      10'h013: data = 32'h03a0f021; // 0040004c: ADDU, REG[30]<=REG[29]+REG[0];
      10'h014: data = 32'h24040008; // 00400050: ADDIU, REG[4]<=REG[0]+8(=0x00000008);
      10'h015: data = 32'h0c100026; // 00400054: JAL, PC<=0x00100026*4(=0x00400098); REG[31]<=PC+4
      10'h016: data = 32'h00000000; // 00400058: SLL, REG[0]<=REG[0]<<0;
      10'h017: data = 32'h24040004; // 0040005c: ADDIU, REG[4]<=REG[0]+4(=0x00000004);
      10'h018: data = 32'h0c100026; // 00400060: JAL, PC<=0x00100026*4(=0x00400098); REG[31]<=PC+4
      10'h019: data = 32'h00000000; // 00400064: SLL, REG[0]<=REG[0]<<0;
      10'h01a: data = 32'h24040002; // 00400068: ADDIU, REG[4]<=REG[0]+2(=0x00000002);
      10'h01b: data = 32'h0c100026; // 0040006c: JAL, PC<=0x00100026*4(=0x00400098); REG[31]<=PC+4
      10'h01c: data = 32'h00000000; // 00400070: SLL, REG[0]<=REG[0]<<0;
      10'h01d: data = 32'h24040001; // 00400074: ADDIU, REG[4]<=REG[0]+1(=0x00000001);
      10'h01e: data = 32'h0c100026; // 00400078: JAL, PC<=0x00100026*4(=0x00400098); REG[31]<=PC+4
      10'h01f: data = 32'h00000000; // 0040007c: SLL, REG[0]<=REG[0]<<0;
      10'h020: data = 32'h03c0e821; // 00400080: ADDU, REG[29]<=REG[30]+REG[0];
      10'h021: data = 32'h8fbf0014; // 00400084: LW, REG[31]<=RAM[REG[29]+20];
      10'h022: data = 32'h8fbe0010; // 00400088: LW, REG[30]<=RAM[REG[29]+16];
      10'h023: data = 32'h27bd0018; // 0040008c: ADDIU, REG[29]<=REG[29]+24(=0x00000018);
      10'h024: data = 32'h03e00008; // 00400090: JR, PC<=REG[31];
      10'h025: data = 32'h00000000; // 00400094: SLL, REG[0]<=REG[0]<<0;
      10'h026: data = 32'h27bdfff0; // 00400098: ADDIU, REG[29]<=REG[29]+65520(=0x0000fff0);
      10'h027: data = 32'hafbe0008; // 0040009c: SW, RAM[REG[29]+8]<=REG[30];
      10'h028: data = 32'h03a0f021; // 004000a0: ADDU, REG[30]<=REG[29]+REG[0];
      10'h029: data = 32'hafc40010; // 004000a4: SW, RAM[REG[30]+16]<=REG[4];
      10'h02a: data = 32'h24030320; // 004000a8: ADDIU, REG[3]<=REG[0]+800(=0x00000320);
      10'h02b: data = 32'h8fc20010; // 004000ac: LW, REG[2]<=RAM[REG[30]+16];
      10'h02c: data = 32'h00000000; // 004000b0: SLL, REG[0]<=REG[0]<<0;
      10'h02d: data = 32'hac620000; // 004000b4: SW, RAM[REG[3]+0]<=REG[2];
      10'h02e: data = 32'h03c0e821; // 004000b8: ADDU, REG[29]<=REG[30]+REG[0];
      10'h02f: data = 32'h8fbe0008; // 004000bc: LW, REG[30]<=RAM[REG[29]+8];
      10'h030: data = 32'h27bd0010; // 004000c0: ADDIU, REG[29]<=REG[29]+16(=0x00000010);
      10'h031: data = 32'h03e00008; // 004000c4: JR, PC<=REG[31];
      10'h032: data = 32'h00000000; // 004000c8: SLL, REG[0]<=REG[0]<<0;
      10'h033: data = 32'h00000000; // 004000cc: SLL, REG[0]<=REG[0]<<0;
    endcase
  end

  assign rom_data = data;
endmodule
