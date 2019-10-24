/*******************/
/* ram8x2048_DE2.v */
/*******************/

`define   SCAN_ASCII_ADDR  13'h0310
`define   SCAN_ASCII_WEN   1'b1

//                        +----+
//                 clock->|    |
//        ram_addr[12:0]->|    |
//      ram_write_enable->|    |->ram_read_data[31:0]
//  ram_write_data[31:0]->|    |
//    key_ram_addr[12:0]->|    |
//   key_ram_wdata[31:0]->|    |
//           key_ram_wen->|    |
//                        +----+

//
// RAMの記述（DE2ボード, quartus, 動作実験用）
//

module ram8x2048_DE2 (clock, ram_addr, ram_write_enable,
		      ram_write_data, ram_read_data, key_ram_addr, key_ram_wdata, key_ram_wen);
   // Inputs
   input                    clock;    // クロック
   input  [12:0]         ram_addr;    // 13-bit address, byte
   input         ram_write_enable;
   input  [31:0]   ram_write_data;    // 32-bit data
   input  [12:0]     key_ram_addr;    // 13-bit address, byte
   input  [31:0]    key_ram_wdata;    // 32-bit data
   input              key_ram_wen;
   
   // Outputs
   output [31:0]    ram_read_data;    // 32-bit data

   // Wire
   wire                    inclock;
   wire                   outclock;
   wire    [10:0]         word_addr;   // 12-bit address, word
   wire  [31:0]  ram_read_data_tmp;    // 32-bit data

   assign   inclock =  clock;
   assign  outclock = ~clock;
   assign word_addr = ram_addr[12:2];

   assign ram_read_data = ((key_ram_addr == `SCAN_ASCII_ADDR)
                            && (key_ram_wen == `SCAN_ASCII_WEN)
                            && (ram_addr == `SCAN_ASCII_ADDR)
                            && (ram_write_enable == 1'b0)) ? key_ram_wdata : ram_read_data_tmp;

   altsyncram altsyncram_component (
				.wren_a (ram_write_enable),  //ram_write_enable
				.clock0 (inclock),
				.clock1 (outclock),
				.address_a (word_addr),      //word_addr
				.data_a (ram_write_data),    //ram_write_data
				.q_a (ram_read_data_tmp),    //ram_read_data_tmp
				.aclr0 (1'b0),
				.aclr1 (1'b0),
				.address_b (1'b1),
				.addressstall_a (1'b0),
				.addressstall_b (1'b0),
				.byteena_a (1'b1),
				.byteena_b (1'b1),
				.clocken0 (1'b1),
				.clocken1 (1'b1),
				.data_b (1'b1),
				.q_b (),
				.rden_b (1'b1),
				.wren_b (1'b0));
	defparam
		altsyncram_component.clock_enable_input_a = "BYPASS",
		altsyncram_component.clock_enable_output_a = "BYPASS",
		altsyncram_component.intended_device_family = "Cyclone II",
		altsyncram_component.lpm_type = "altsyncram",
		altsyncram_component.numwords_a = 2048,
		altsyncram_component.operation_mode = "SINGLE_PORT",
		altsyncram_component.outdata_aclr_a = "NONE",
		altsyncram_component.outdata_reg_a = "CLOCK1",
		altsyncram_component.power_up_uninitialized = "FALSE",
		altsyncram_component.widthad_a = 11,
		altsyncram_component.width_a = 32,
		altsyncram_component.width_byteena_a = 1,
		altsyncram_component.init_file = "ram8x2048_DE2.mif";
       
endmodule
