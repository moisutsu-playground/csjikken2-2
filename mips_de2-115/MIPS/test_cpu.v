/*                    *
 * test_cpu.v         *
 * cpu.v のテストベンチ *
 *                    */

`timescale 1ns / 1ns    // シミュレーションの単位時間 / 精度
                        // 1 ns = 1/1000000000 sec
`include "cpu.v"        // cpu.v の取り込み

module test_cpu ;           // テストベンチモジュール, 入出力ポート無し
   // cpu の入力用 flip-flop(1-bit レジスタ) の宣言
   reg clk;    // flip-flop
   reg reset;  // flip-flop
   reg clk_ctrl0;
   reg clk_ctrl1;
   reg clk_ctrl_clk;
   reg [12:0] i_ram_addr;   // RAM address
   reg [31:0] i_ram_wdata;  // RAM write data
   reg        i_ram_wen;    // RAM write enable

   // cpu の出力用 wire(信号線) の宣言
   wire o_clock;         // 1-bit 信号線
   wire [7:0] o_pc;      // 8-bit 信号線
   wire [31:0] o_alu_y;  // 32-bit 信号線
   wire [31:0]     o_alu_a;    // ALU in a
   wire [31:0]     o_alu_b;    // ALU in b
   wire [3:0]   o_alu_ctrl;    // ALU ctrl
   wire [1:0]   o_alu_comp;    // ALU comp
   wire [31:0] o_reg_data1;    // レジスタ out data1
   wire [4:0]   o_reg_idx1;    // レジスタ read idx1
   wire [31:0] o_reg_data2;    // レジスタ out data2
   wire [4:0]   o_reg_idx2;    // レジスタ read idx2
   wire [31:0] o_reg_wdata;    // レジスタ write data
   wire [4:0]   o_reg_widx;    // レジスタ write idx
   wire          o_reg_wen;    // レジスタ write enable
   wire [12:0]  o_ram_addr;    // RAM address
   wire [31:0] o_ram_rdata;    // RAM read data
   wire [31:0] o_ram_wdata;    // RAM write data
   wire          o_ram_wen;    // RAM write enable

   // module cpu の実体化
   cpu cpua (clk, reset,
            clk_ctrl0, clk_ctrl1, clk_ctrl_clk,
            o_clock, o_pc, o_alu_y, o_alu_a, o_alu_b, o_alu_ctrl, o_alu_comp,
            o_reg_data1, o_reg_idx1, o_reg_data2, o_reg_idx2, o_reg_wdata,
            o_reg_widx, o_reg_wen,
            o_ram_addr, o_ram_rdata, o_ram_wdata, o_ram_wen,
            i_ram_addr, i_ram_wdata, i_ram_wen
            );

   
   // シミュレーションパタン
   initial begin
       // clk, reset の初期値
       clk = 0; reset = 1;

       clk_ctrl0 = 1; clk_ctrl1 = 1;
       clk_ctrl_clk = 0;

       // 20 単位時間(20 ns)後
       #20  reset = 0;

       // 更に 20 単位時間(20 ns)後
       #20  reset = 1;

       #100000 $finish;
   end

   always begin
     #10 clk = ! clk;
   end

   always begin
     #10 clk_ctrl_clk = ! clk_ctrl_clk;
   end

endmodule
