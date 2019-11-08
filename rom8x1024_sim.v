/*******************/
/* rom8x1024_sim.v */
/*******************/

//                  +----+
//  rom_addr[11:0]->|    |->rom_data[31:0]
//                  +----+

//
// ROM�ε��ҡ��������ߥ�졼������ѡ�
//

module rom8x1024_sim (rom_addr, rom_data);

  input   [11:0]  rom_addr;  // 12-bit ���ɥ쥹���ϥݡ���
  output  [31:0]  rom_data;  // 32-bit �ǡ������ϥݡ���

  reg     [31:0]  data;

  // Wire
  wire     [9:0]  word_addr; // 10-bit address, word

  assign word_addr = rom_addr[9:2];
   
  always @(word_addr) begin
    case (word_addr)
      10'h000: data = 32'h00000000; // 00400000: SLL, REG[0]<=REG[0]<<0;
      10'h001: data = 32'h00000000; // 00400004: SLL, REG[0]<=REG[0]<<0;
      10'h002: data = 32'h00000000; // 00400008: SLL, REG[0]<=REG[0]<<0;
      10'h003: data = 32'h00000000; // 0040000c: SLL, REG[0]<=REG[0]<<0;
      10'h004: data = 32'h00000000; // 00400010: SLL, REG[0]<=REG[0]<<0;
      10'h005: data = 32'h00408010; // 00400014: R type, unknown. func=16(10)
    endcase
  end

  assign rom_data = data;
endmodule
