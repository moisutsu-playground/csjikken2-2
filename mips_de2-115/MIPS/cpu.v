/*********/
/* cpu.v */
/*********/

/*
Top module || Sub modules
============================
     cpu.v + rom8x1024_sim.v, 論理シミュレーション用 ROM
           |
           + rom8x1024_DE2.v, 動作実験用 ROM
           |
           + ram8x2048_sim.v, 論理シミュレーション用 RAM
           |
           + ram8x2048_DE2.v, 動作実験用 RAM
           |
           + alu.v, 算術論理演算ユニット(ALU)
           |
           + pc.v, プログラムカウンタ(PC)
           |
           + registers.v, レジスタファイル
           |
           + plus4.v, PC 4 インクリメント
           |
           + adder32.v, 32-bit 加算回路
           |
           + mux32_32_32.v, 32-bit 2 入力 1 出力選択回路
           |
           + mux5_5_5.v, 5-bit 2 入力 1 出力選択回路
           |
           + main_ctrl.v, メイン制御回路
           |
           + alu_ctrler.v, ALU 制御回路
           |
           + shifter32_32_l2.v, 32-bit 入力 32-bit 出力 2-bit 左シフト回路
           |
           + signext16_32.v, 16-bit 入力 32-bit 出力 符号拡張回路
           |
           - is_branch.v, 分岐制御回路
============================
*/

//                   +----+
//              clk->|    |->o_clock
//            reset->|    |->o_pc[11:0]
//                   |    |->o_alu_y[31:0]
//                   |    |->o_alu_a[31:0]
//                   |    |->o_alu_b[31:0]
//                   |    |->o_alu_ctrl[3:0]
//                   |    |->o_alu_comp[1:0]
//        clk_ctrl0->|    |->o_reg_data1[31:0]
//        clk_ctrl1->|    |->o_reg_idx1[4:0]
//    clk_ctrl1_clk->|    |->o_reg_data2[31:0]
//                   |    |->o_reg_idx2[4:0]
//                   |    |->o_reg_wdata[31:0]
//                   |    |->o_reg_widx[4:0]
//                   |    |->o_reg_wen
//                   |    |->o_ram_addr
//       i_ram_addr->|    |->o_ram_rdata
//      i_ram_wdata->|    |->o_ram_wdata
//        i_ram_wen->|    |->o_ram_wen
//                   +----+

//
//論理シミュレーション用
//DE2, quartus, 動作実験時コメントアウト
//`include "rom8x1024_sim.v"  // ROMの記述（論理シミュレーション用）
//`include "ram8x2048_sim.v"  // RAMの記述（論理シミュレーション用）

//
//動作実験用
//論理シミュレーション時コメントアウト
`include "rom8x1024_DE2.v"  // ROMの記述（DE2ボード, quartus, 動作実験用）
`include "ram8x2048_DE2.v"  // RAMの記述（DE2ボード, quartus, 動作実験用）

`include "alu.v"           // ALUの記述
`include "pc.v"            // PCの記述
`include "registers.v"     // レジスタファイルの記述
`include "plus4.v"         // PCインクリメント回路の記述
`include "adder32.v"       // PC加算回路の記述
`include "mux32_32_32.v"   // 32-bit, 32-bit入力,
                           // 32-bit出力(alu_b,reg_sel)選択回路の記述
`include "mux5_5_5.v"      // 5-bit, 5-bit入力,
                           // 5-bit出力(reg_widx_sel1, reg_widx_sel2)選択回路の記述
`include "main_ctrl.v"     // メイン制御回路の記述
`include "alu_ctrler.v"    // ALU 制御回路の記述
`include "shifter32_32_l2.v"   // 32-bit入力, 32-bit出力の2ビット左シフト回路の記述
`include "signext16_32.v"      // 16-bit入力, 32-bit出力の符号拡張回路の記述
`include "is_branch.v"         // 分岐制御回路の記述

`define max_bunsyuu_reg_val_2Hz 12587500    //  2Hz
`define max_bunsyuu_reg_val_10Hz   2517500  //  10Hz, 2517500 = 12587500/5
`define max_bunsyuu_reg_val_20Hz   1258750  //  20Hz, 1258750 = 12587500/10
`define max_bunsyuu_reg_val_100Hz   251750  //  100Hz,  251750 = 12587500/50
`define max_bunsyuu_reg_val_200Hz   125875  //  200Hz,  125875 = 12587500/100
`define max_bunsyuu_reg_val_1kHz    25175   //   1kHz,   25175 = 12587500/500
`define max_bunsyuu_reg_val_10kHz    2517   //  10kHz,    2517 = 12587500/5000

module cpu (clk, reset,
            clk_ctrl0, clk_ctrl1, clk_ctrl_clk,
            o_clock, o_pc, o_alu_y, o_alu_a, o_alu_b, o_alu_ctrl, o_alu_comp,
            o_reg_data1, o_reg_idx1, o_reg_data2, o_reg_idx2, o_reg_wdata, o_reg_widx, o_reg_wen,
            o_ram_addr, o_ram_rdata, o_ram_wdata, o_ram_wen,
            i_ram_addr, i_ram_wdata, i_ram_wen
);

  // Input ports
  input clk;           // クロック(25.175 MHz)
  input reset;         // リセット信号

  input clk_ctrl0;     //
  input clk_ctrl1;     // (clk_ctrl1, clk_ctrl0)=(0,0)2Hz, (0,1)20Hz, (1,0)200Hz, (1,1)手押しクロック
  input clk_ctrl_clk;  //手押しクロック

  input [12:0]  i_ram_addr;    // RAM address
  input [31:0] i_ram_wdata;    // RAM write data
  input          i_ram_wen;    // RAM write enable

  // Output ports
  output            o_clock;
  output [11:0]        o_pc;    // PC
  output [31:0]     o_alu_y;    // ALU result
  output [31:0]     o_alu_a;    // ALU in a
  output [31:0]     o_alu_b;    // ALU in b
  output [3:0]   o_alu_ctrl;    // ALU ctrl
  output [1:0]   o_alu_comp;    // ALU comp
  output [31:0] o_reg_data1;    // レジスタ out data1
  output [4:0]   o_reg_idx1;    // レジスタ read idx1
  output [31:0] o_reg_data2;    // レジスタ out data2
  output [4:0]   o_reg_idx2;    // レジスタ read idx2
  output [31:0] o_reg_wdata;    // レジスタ write data
  output [4:0]   o_reg_widx;    // レジスタ write idx
  output          o_reg_wen;    // レジスタ write enable
  output [12:0]  o_ram_addr;    // RAM address
  output [31:0] o_ram_rdata;    // RAM read data
  output [31:0] o_ram_wdata;    // RAM write data
  output          o_ram_wen;    // RAM write enable

  //
  //
  // 分周
  // Registers(分周)
  wire [23:0] max_bunsyuu_reg_val;

  reg            clock_reg;  //  1-bit レジスタ
  reg  [23:0]  bunsyuu_reg;  // 24-bit レジスタ

  // Wire(分周)
  wire               clock;      //  1-bit wire
  wire           clock_rom;      //  1-bit wire
  wire           clock_ram;      //  1-bit wire

  // Assignment(分周)
  // (clk_ctrl1, clk_ctrl0)=(0,0)2Hz, (0,1)200Hz, (1,0)1kHz, (1,1)手押しクロック
  assign clock         = ((clk_ctrl1 == 1'b1) && (clk_ctrl0 == 1'b1)) ? clk_ctrl_clk : clock_reg;  // wire
  assign clock_rom     =   bunsyuu_reg[3];  // wire
  assign clock_ram     =   bunsyuu_reg[4];  // wire

  // Alwaysブロック: クロックの分周
  // 入力: clk, reset
  // 出力: clock_reg
  // 機能: オリジナルclk(約50MHz) から
  //       分周clock(2Hz, 200Hz, 1kHz, 分周なし手押しクロック)を生成,
  //                (clk_ctrl1, clk_ctrl0)=(0,0)2Hz, (0,1)200Hz, (1,0)1kHz, (1,1)手押しクロック
  //       clock の周波数はソース先頭の define 文で決定.
  // レジスタ: bunsyuu_reg, clk_reg
  assign max_bunsyuu_reg_val = ((clk_ctrl1 == 1'b0) && (clk_ctrl0 == 1'b0)) ? `max_bunsyuu_reg_val_2Hz
                               : (((clk_ctrl1 == 1'b0) && (clk_ctrl0 == 1'b1)) ? `max_bunsyuu_reg_val_200Hz
                                 : (((clk_ctrl1 == 1'b1) && (clk_ctrl0 == 1'b0)) ? `max_bunsyuu_reg_val_1kHz
                                   : `max_bunsyuu_reg_val_2Hz));


  always @(posedge clk or negedge reset) begin
     if (reset == 1'b0) begin
	 bunsyuu_reg <= 24'b000000000000000000000000;  // bunsyuu_reg = 0
	 clock_reg   <=                         1'b0;  //     clk_reg = 0
     end else begin
	 if (bunsyuu_reg >= max_bunsyuu_reg_val) begin
	     bunsyuu_reg <= 24'b000000000000000000000000;  // bunsyuu_reg = 0

             clock_reg   <= ~clock_reg;              // clk_reg = not clk_reg
	 end else begin
             bunsyuu_reg <= bunsyuu_reg + 1;
	 end
     end
  end  // always @(posedge clk or negedge reset) begin
  // 分周
  //
  //

  // Wires
  wire  [11:0]       rom_addr;  // ROM
  wire  [31:0]       rom_data;  // ROM

  wire  [12:0]       ram_addr;  // RAM
  wire       ram_write_enable;  // RAM
  wire  [31:0] ram_write_data;  // RAM
  wire  [31:0]  ram_read_data;  // RAM
  wire  [12:0]  key_ram_addr;   // RAM
  wire  [31:0] key_ram_wdata;   // RAM
  wire          key_ram_wen;    // RAM

  wire  [31:0]   alu_a, alu_b;  // ALU
  wire   [3:0] 	     alu_ctrl;  // ALU
  wire  [31:0]          alu_y;  // ALU
  wire   [1:0]       alu_comp;  // ALU

  wire   [31:0]       pc_next;  // PC
  wire   [31:0]            pc;  // PC

  wire   [4:0]  reg_read_idx1;  // レジスタファイル
  wire   [4:0]  reg_read_idx2;  // レジスタファイル
  wire   [4:0]  reg_write_idx;  // レジスタファイル
  wire  [31:0] reg_write_data;  // レジスタファイル
  wire  [31:0] reg_read_data1;  // レジスタファイル
  wire  [31:0] reg_read_data2;  // レジスタファイル

  wire   [31:0]         inc_a;  // PC インクリメントモジュール
  wire   [31:0]         inc_y;  // PC インクリメントモジュール

  wire   [31:0]         add_a;  // PC 加算モジュール
  wire   [31:0]         add_b;  // PC 加算モジュール
  wire   [31:0]         add_y;  // PC 加算モジュール

  wire  [31:0]   alu_b_sel1_d0;  // alu_b 選択回路1モジュール
  wire  [31:0]   alu_b_sel1_d1;  // alu_b 選択回路1モジュール
  wire            alu_b_sel1_s;  // alu_b 選択回路1モジュール
  wire  [31:0]    alu_b_sel1_y;  // alu_b 選択回路1モジュール

  wire  [31:0]   alu_b_sel2_d0;  // alu_b 選択回路2モジュール
  wire  [31:0]   alu_b_sel2_d1;  // alu_b 選択回路2モジュール
  wire            alu_b_sel2_s;  // alu_b 選択回路2モジュール
  wire  [31:0]    alu_b_sel2_y;  // alu_b 選択回路2モジュール

  wire  [31:0]   alu_ram_sel_d0; // alu_ram 選択回路モジュール
  wire  [31:0]   alu_ram_sel_d1; // alu_ram 選択回路モジュール
  wire            alu_ram_sel_s; // alu_ram 選択回路2モジュール
  wire  [31:0]    alu_ram_sel_y; // alu_ram 選択回路モジュール

  wire  [31:0]      link_sel_d0;    // link 選択回路モジュール
  wire  [31:0]      link_sel_d1;    // link 選択回路モジュール
  wire               link_sel_s;    // link 選択回路モジュール
  wire  [31:0]       link_sel_y;    // link 選択回路モジュール

  wire  [4:0]   reg_widx_sel1_d0;  // reg_write_idx 選択回路1モジュール
  wire  [4:0]   reg_widx_sel1_d1;  // reg_write_idx 選択回路1モジュール
  wire           reg_widx_sel1_s;  // reg_write_idx 選択回路1モジュール
  wire  [4:0]    reg_widx_sel1_y;  // reg_write_idx 選択回路1モジュール

  wire  [4:0]     reg_widx_sel2_d0;  // reg_write_idx 選択回路2モジュール
  wire  [4:0]     reg_widx_sel2_d1;  // reg_write_idx 選択回路2モジュール
  wire             reg_widx_sel2_s;  // reg_write_idx 選択回路2モジュール
  wire  [4:0]      reg_widx_sel2_y;  // reg_write_idx 選択回路2モジュール

  wire  [31:0]       pc_sel_d0;  // pc 選択回路モジュール
  wire  [31:0]       pc_sel_d1;  // pc 選択回路モジュール
  wire                pc_sel_s;  // pc 選択回路モジュール
  wire  [31:0]        pc_sel_y;  // pc 選択回路モジュール

//
//追加設計 2 のヒント(1)：jp_sel の入出力用ワイヤの宣言
//
 wire  [31:0]     jp_sel_d0;  // jp 選択回路モジュール データ 1
 wire  [31:0]     jp_sel_d1;  // jp 選択回路モジュール データ 2
 wire              jp_sel_s;  // jp 選択回路モジュール セレクト信号
 wire  [31:0]      jp_sel_y;  // jp 選択回路モジュール 出力

//
//追加設計 5 ヒント(1)：jpr_sel の入出力用ワイヤの宣言
//
  wire   [31:0]     jpr_sel_d0;
  wire   [31:0]     jpr_sel_d1;
  wire               jpr_sel_s;
  wire   [31:0]      jpr_sel_y;

  wire   [31:0]    instruction;  // メイン制御回路
  wire              alu_b_sel1;  // メイン制御回路
  wire              alu_b_sel2;  // メイン制御回路
  wire   [2:0]          alu_op;  // メイン制御回路
  wire   [2:0]  is_branch_ctrl;  // メイン制御回路
  wire        reg_write_enable;  // メイン制御回路
  wire                      jp;  // メイン制御回路
  wire                    link;  // メイン制御回路
  wire                     jpr;  // メイン制御回路
  wire                  shiftv;  // メイン制御回路
  wire             do_sign_ext;  // メイン制御回路

  wire   [5:0]            func;  // ALU 制御回路モジュール

  wire   [31:0]           sh_a;  // shifter(2-bit left)
  wire   [31:0]           sh_y;  // shifter(2-bit left)

  wire   [31:0]         sh_j_a;  // shifter(2-bit left) (jump用)
  wire   [31:0]         sh_j_y;  // shifter(2-bit left) (jump用)

  wire   [15:0]            a16;  // 符号拡張回路
  wire   [31:0]            y32;  // 符号拡張回路

  wire    [2:0]   is_branch_d0;  // is_branch回路
  wire    [1:0]   is_branch_d1;  // is_branch回路
  wire             is_branch_y;  // is_branch回路

  wire  [31:0]   alu_a_sel1_d0;  // alu_a 選択回路1モジュール
  wire  [31:0]   alu_a_sel1_d1;  // alu_a 選択回路1モジュール
  wire            alu_a_sel1_s;  // alu_a 選択回路1モジュール
  wire  [31:0]    alu_a_sel1_y;  // alu_a 選択回路1モジュール

  //
  //
  // Body   
  //

  //                  +----+
  //             clk->|    |
  //  rom_addr[11:0]->|    |->rom_data[31:0]
  //                  +----+
  //
  //論理シミュレーション用
  //DE2, quartus, 動作実験時コメントアウト
  //rom8x1024_sim  rom8x1024a(rom_addr, rom_data);
  //
  //動作実験用
  //論理シミュレーション時コメントアウト
  rom8x1024_DE2  rom8x1024a(clock_rom, rom_addr, rom_data);

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
  //論理シミュレーション用
  //DE2, quartus, 動作実験時コメントアウト
  //ram8x2048_sim  ram8x2048a(clk, ram_addr, ram_write_enable,
  //                          ram_write_data, ram_read_data,
  //                          key_ram_addr, key_ram_wdata, key_ram_wen);
  //
  //動作実験用
  //論理シミュレーション時コメントアウト
  ram8x2048_DE2  ram8x2048a(clock_ram, ram_addr, ram_write_enable,
                            ram_write_data, ram_read_data,
                            key_ram_addr, key_ram_wdata, key_ram_wen);


  //実験9のヒント（１）：ALUモジュールの実体化に関する記述の変更
  //clock, reset信号の追加，乗算結果を保持するレジスタhiとlo用
  // alu
  //                  +----+
  //           clock->|    |
  //           reset->|    |
  //     alu_a[31:0]->|    |
  //     alu_b[31:0]->|    |->alu_y[31:0]
  //   alu_ctrl[3:0]->|    |->alu_comp[1:0]
  //                  +----+
  alu  alua(clock, reset, alu_a, alu_b, alu_ctrl, alu_y, alu_comp);

  // pc
  //                +----+
  //         clock->|    |
  //         reset->|    |
  // pc_next[31:0]->|    |->pc[31:0]
  //                +----+
  pc  pca (clock, reset, pc_next, pc); 

  // registers
  //                       +----+
  //                clock->|    |
  //                reset->|    |
  //   reg_read_idx1[4:0]->|    |
  //   reg_read_idx2[4:0]->|    |->reg_read_data1[31:0]
  //   reg_write_idx[4:0]->|    |->reg_read_data2[31:0]
  //     reg_write_enable->|    |
  // reg_write_data[31:0]->|    |
  //                       +----+
  registers register_file(clock, reset,
		  reg_read_idx1, reg_read_idx2,
		  reg_write_idx, reg_write_enable, reg_write_data,
		  reg_read_data1, reg_read_data2);

  // plus4
  //              +----+
  // inc_a[31:0]->|    |->inc_y[31:0]
  //              +----+
  plus4 pc_plus4 (inc_a, inc_y);   


  // adder32
  //              +----+
  // add_a[31:0]->|    |
  // add_b[31:0]->|    |->add_y[31:0]
  //              +----+
  adder32 pc_add(add_a, add_b, add_y);

  // mux32_32_32
  //           +----+
  // d0[31:0]->|    |
  // d1[31:0]->|    |->y[31:0]
  //        s->|    |
  //           +----+
  mux32_32_32  alu_b_sel_1(alu_b_sel1_d0, alu_b_sel1_d1, alu_b_sel1_s, alu_b_sel1_y);
  mux32_32_32  alu_b_sel_2(alu_b_sel2_d0, alu_b_sel2_d1, alu_b_sel2_s, alu_b_sel2_y);
  mux32_32_32  alu_ram_sel(alu_ram_sel_d0, alu_ram_sel_d1, alu_ram_sel_s, alu_ram_sel_y);
  mux32_32_32  link_sel(link_sel_d0, link_sel_d1, link_sel_s, link_sel_y);
  mux32_32_32  alu_a_sel_1(alu_a_sel1_d0, alu_a_sel1_d1, alu_a_sel1_s, alu_a_sel1_y);

//
//追加設計 5 ヒント(2)：32-bit, 32-bit 入力, 32-bit 出力のセレクタを実体化
//

  mux32_32_32 jpr_sel(jpr_sel_d0, jpr_sel_d1, jpr_sel_s, jpr_sel_y);


//
//追加設計 2 のヒント(2)：32-bit, 32-bit 入力, 32-bit 出力のセレクタを実体化
//
  mux32_32_32  jp_sel(jp_sel_d0, jp_sel_d1, jp_sel_s, jp_sel_y);

  mux32_32_32  pc_sel(pc_sel_d0, pc_sel_d1, pc_sel_s, pc_sel_y);

  // mux5_5_5
  //           +----+
  //  d0[4:0]->|    |
  //  d1[4:0]->|    |->y[4:0]
  //        s->|    |
  //           +----+
  mux5_5_5  reg_widx_sel1(reg_widx_sel1_d0, reg_widx_sel1_d1,
                            reg_widx_sel1_s, reg_widx_sel1_y);
  mux5_5_5  reg_widx_sel2(reg_widx_sel2_d0, reg_widx_sel2_d1,
                        reg_widx_sel2_s, reg_widx_sel2_y);

  // main_ctrl
  //                     +----+
  //  instruction[31:0]->|    |->ram_write_enable
  //                     |    |->alu_b_sel1_s
  //                     |    |->alu_b_sel2_s
  //                     |    |->alu_op[2:0]
  //                     |    |->is_branch_ctrl[2:0]
  //                     |    |->reg_write_enable
  //                     |    |->alu_ram_sel_s
  //                     |    |->reg_widx_sel1_s
  //                     |    |->jp
  //                     |    |->link
  //                     |    |->jpr
  //                     |    |->shiftv
  //                     |    |->do_sign_ext
  //                     +----+
  main_ctrl main_ctrla(instruction, ram_write_enable, alu_b_sel1, alu_b_sel2, alu_op,
                       is_branch_ctrl, reg_write_enable, 
                       alu_ram_sel_s, reg_widx_sel1_s, jp, link, jpr,
                       shiftv, do_sign_ext);

  // alu_ctrler
  //              +----+
  // alu_op[2:0]->|    |
  //   func[5:0]->|    |->alu_ctrl[3:0]
  //              +----+
  alu_ctrler alu_ctrlera(alu_op, func, alu_ctrl);

  // shifter32_32_l2
  //             +----+
  // sh_a[31:0]->|    |->sh_y[31:0]
  //             +----+
  shifter32_32_l2 shifter32_32_l2a(sh_a, sh_y);
  shifter32_32_l2 shifter32_32_l2b(sh_j_a, sh_j_y);

  // signext16_32
  //              +----+
  // do_sign_ext->|    |
  //   a16[15:0]->|    |->y32[31:0]
  //              +----+
  signext16_32 signext16_32a(do_sign_ext, a16, y32);

  // is_branch
  //           +----+
  //  d0[2:0]->|    |
  //  d1[1:0]->|    |->y
  //           +----+
  is_branch is_brancha(is_branch_d0, is_branch_d1, is_branch_y);

  assign rom_addr = (pc[31:0] > 32'h00400fff) ? 12'hfff : pc[11:0];
  // assign rom_addr = pc[11:0];
  assign ram_addr = alu_y[12:0];
  assign ram_write_data = reg_read_data2;
  assign key_ram_addr   = i_ram_addr;
  assign key_ram_wdata  = i_ram_wdata;
  assign key_ram_wen    = i_ram_wen;
  assign alu_a = alu_a_sel1_y;
  assign alu_b = alu_b_sel2_y;

//
//追加設計 5 ヒント(3)：jpr_sel の出力 jpr_sel_y の pc_next への接続
//
  assign pc_next = jpr_sel_y;
//
//追加設計 2 のヒント(3)：jp_sel の出力 jp_sel_y の pc_next への接続
//
  //assign pc_next = jp_sel_y;

  assign reg_read_idx1 = instruction[25:21];
  assign reg_read_idx2 = instruction[20:16];
  assign reg_write_idx = reg_widx_sel2_y;
  assign reg_write_data = link_sel_y;
  assign inc_a = pc;
  assign add_a = inc_y;
  assign add_b = sh_y;
  assign alu_b_sel1_d0 = reg_read_data2;
  assign alu_b_sel1_d1 = y32;
  assign alu_b_sel1_s = alu_b_sel1;
  assign alu_b_sel2_d0 = alu_b_sel1_y;
  assign alu_b_sel2_d1 = 0;
  assign alu_b_sel2_s = alu_b_sel2;
  assign alu_ram_sel_d0 = alu_y;
  assign alu_ram_sel_d1 = ram_read_data;
  assign reg_widx_sel1_d0 = instruction[20:16];
  assign reg_widx_sel1_d1 = instruction[15:11];
  assign reg_widx_sel2_d0 = reg_widx_sel1_y;
  assign reg_widx_sel2_d1 = 5'b11111;  // RA の idx, 31
  assign reg_widx_sel2_s = link;
  assign link_sel_d0 = alu_ram_sel_y;
  assign link_sel_d1 = inc_y;
  assign link_sel_s = link;
  assign pc_sel_d0 = inc_y;
  assign pc_sel_d1 = add_y;
  assign pc_sel_s = is_branch_y;

//
//追加設計 2 ヒント(4)：jp_sel の入力 jp_sel_d0, jp_sel_d1, jp_sel_s の接続
//
  assign jp_sel_d0 = pc_sel_y;
  assign jp_sel_d1 = sh_j_y;
  assign jp_sel_s = jp;

//
//追加設計 5 ヒント(4)：jpr_sel の入力 jpr_sel_d0, jpr_sel_d1, jpr_sel_s と接続
//
  assign jpr_sel_d0 = jp_sel_y;
  assign jpr_sel_d1 = alu_ram_sel_y;
  assign jpr_sel_s = jpr;

  assign instruction = rom_data;
  assign func = y32[5:0];
  assign sh_a = y32;
  assign sh_j_a = {6'b000000, instruction[25:0]};
  assign a16 = instruction[15:0];
  assign is_branch_d0 = is_branch_ctrl;
  assign is_branch_d1 = alu_comp;

  assign alu_a_sel1_d0 = reg_read_data1;
  assign alu_a_sel1_d1 = {27'b000000000000000000000000000, y32[10:6]};
  assign alu_a_sel1_s = shiftv;

  assign o_pc        = pc[11:0];
  assign o_clock     = clock;
  assign o_alu_y     = alu_y;
  assign o_alu_a     = alu_a;
  assign o_alu_b     = alu_b;
  assign o_alu_ctrl  = alu_ctrl;
  assign o_alu_comp  = alu_comp;
  assign o_reg_data1 = reg_read_data1;
  assign o_reg_idx1  = reg_read_idx1;
  assign o_reg_data2 = reg_read_data2;
  assign o_reg_idx2  = reg_read_idx2;
  assign o_reg_wdata = reg_write_data;
  assign o_reg_widx  = reg_write_idx;
  assign o_reg_wen   = reg_write_enable;
  assign o_ram_addr  = ram_addr;
  assign o_ram_rdata = ram_read_data;
  assign o_ram_wdata = ram_write_data;
  assign o_ram_wen   = ram_write_enable;
   
endmodule