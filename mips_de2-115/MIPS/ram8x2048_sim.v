/*******************/
/* ram8x2048_sim.v */
/*******************/

`define   SCAN_ASCII_ADDR  13'h0310
`define   SCAN_ASCII_WEN   1'b1

//                        +----+
//                   clk->|    |
//        ram_addr[12:0]->|    |
//      ram_write_enable->|    |->ram_read_data[31:0]
//  ram_write_data[31:0]->|    |
//    key_ram_addr[12:0]->|    |
//   key_ram_wdata[31:0]->|    |
//           key_ram_wen->|    |
//                        +----+

//
// RAMの記述（論理シミュレーション用）
//

module ram8x2048_sim (clk, ram_addr, ram_write_enable,
		      ram_write_data, ram_read_data, key_ram_addr, key_ram_wdata , key_ram_wen);

  // Inputs
  input                       clk;    // クロック
  input  [12:0]          ram_addr;    // 13-bit address, byte
  input          ram_write_enable;    // 書き込み(1)/読み(0)
  input  [31:0]    ram_write_data;    // 32-bit data
  input  [12:0]     key_ram_addr;    // 13-bit address, byte
  input  [31:0]    key_ram_wdata;    // 32-bit data
  input              key_ram_wen;
   
  // Outputs
  output [31:0]     ram_read_data;    // 32-bit data

  reg    [31:0]         mem[0:2048];  // 32x2048 regs
  reg    [31:0]	        read_data;

  // Wire
  wire    [5:0]         word_addr;    // 6-bit address, word

  assign word_addr = ram_addr[12:2];

  // 書き込み
  always @(posedge clk) begin
    if (ram_write_enable == 1'b1) begin
      mem[word_addr] <= ram_write_data;
    end
  end

  // 読み
  always @(word_addr or ram_write_enable or ram_write_data) begin
    if (ram_write_enable == 1'b0) begin
      read_data = mem[word_addr];
    end else begin
      read_data = ram_write_data;
    end
  end

  assign ram_read_data = ((key_ram_addr == `SCAN_ASCII_ADDR)
                            && (key_ram_wen == `SCAN_ASCII_WEN)
                            && (ram_addr == `SCAN_ASCII_ADDR)
                            && (ram_write_enable == 1'b0)) ? key_ram_wdata : read_data;

endmodule
