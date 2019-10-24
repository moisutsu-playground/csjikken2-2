/*******************/
/* rom8x1024_DE2.v */
/*******************/

//                  +----+
//  rom_addr[11:0]->|    |->rom_data[31:0]
//                  +----+

//
// ROMの記述（DE2ボード, quartus, 動作実験用）
//

module rom8x1024_DE2 (clock, rom_addr, rom_data);
   // Inputs
   input          clock;
   input   [11:0] rom_addr;      // 12-bit address

   // Outputs
   output [31:0]  rom_data;      // 32-bit data

   // Wire
   wire    [9:0]  word_addr;     // 10-bit address, word

  assign word_addr = rom_addr[11:2];

   lpm_rom lpm_rom_component (
			      .address(word_addr),
			      .inclock(clock),
			      .outclock(clock),
			      .q(rom_data));
   defparam lpm_rom_component.LPM_WIDTH   = 32,   // 32-bit data
	    lpm_rom_component.LPM_WIDTHAD = 10,   // 10-bit address
	    lpm_rom_component.LPM_ADDRESS_CONTROL = "REGISTERED",
	    lpm_rom_component.LPM_OUTDATA = "REGISTERED",
	    lpm_rom_component.LPM_FILE    = "rom8x1024_DE2.mif";
       
endmodule
