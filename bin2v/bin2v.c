/***************/
/*** bin2v.c ***/
/***************/

/*
  Ver. 1.2
*/

#include <stdio.h>
#include <stdlib.h>

#define SIM_FNM        "rom8x1024_sim.v"
#define MIF_FNM        "rom8x1024_DE2.mif"
#define PRG_START_ADDR 0x00400000

/*
  実験 9 ヒント（１）：整数乗算命令 mult, ムーブ・フロム・Lo 命令 mflo についてのコメント追加
  `defineR  6'b000000    R形式(add, addu, sub, subu, and, or, slt,jalr, jr, mult, mflo)
  実験 10 ヒント（１）：符号なし除算命令 divu, ムーブ・フロム・Hi 命令 mfhi についてのコメント追加

  `define      R  6'b000000    R 形式 (add, addu, sub, subu, and, or, slt, jalr, jr)
  `define     LW  6'b100011    load word (I 形式)
  `define   ADDI  6'b001000    add immediate (I 形式)
  `define  ADDIU  6'b001001    add immediate, unsigned (I 形式)
  `define   ANDI  6'b001100    and immediate (I 形式)
  `define    ORI  6'b001101    or immediate (I 形式)
  `define     SW  6'b101011    store word (I 形式)
  `define    BEQ  6'b000100    branch on equal (I 形式)
  `define    BNE  6'b000101    branch on not equal (I 形式)
  `define   BGEZ  6'b000001    branch on greater than or equal to zero (I 形式)
  `define   BLEZ  6'b000110    branch on less than or equal to zero (I 形式)
  `define   BGTZ  6'b000111    branch on greater than zero (I 形式)
  `define   BLTZ  6'b000001    branch on less than zero (I 形式)
  `define BGEZAL  6'b000001    branch on greater than or equal to zero and link (I 形式)
  `define BLTZAL  6'b000001    branch on less than zero and link (I 形式)
  `define      J  6'b000010    jump (J 形式)
  `define    JAL  6'b000011    jump and link (J 形式)
  `define   XORI  6'b001110    xor immediate (I 形式)
  `define   SLTI  6'b001010    set on less than immediate, signed (I 形式)
  `define   SLTIU 6'b001011    set on less than immediate, unsigned (I 形式)
  `define   LUI   6'b001111    load upp immediate (I 形式)
*/

/* 命令セット
   R 形式
   31      26 25    21 20   16 15   11 10    6 5      0
   ----------------------------------------------------
   | op      | rs     | rt    | rd    | shamt | func  |
   | (6-bit) |(5-bit) |(5-bit)|(5-bit)|(5-bit)|(6-bit)|
   ----------------------------------------------------
   ADD(op = 000000, func = 100000)
   REG[rd] <= REG[rs] + REG[rt];                            ADD rd,rs,rt

   ADDU(op = 000000, func = 100001)
   REG[rd] <= REG[rs] + REG[rt];                            ADDU rd,rs,rt

   SUB(op = 000000, func = 100010)
   SUB        REG[rd] <= REG[rs] - REG[rt];                 SUB rd,rs,rt

   SUBU(op = 000000, func = 100011)
   SUBU       REG[rd] <= REG[rs] - REG[rt];                 SUBU rd,rs,rt

   AND(op = 000000, func = 100100)
   AND        REG[rd] <= REG[rs] & REG[rt];                 AND rd,rs,rt

   OR(op = 000000, func = 100101)
   OR         REG[rd] <= REG[rs] | REG[rt];                 OR  rd,rs,rt

   SLT(op = 000000, func = 101010)
   SLT        REG[rd] <= (REG[rs] < REG[rt]) ? 1 : 0;       SLT rd,rs,rt

   JALR(op = 000000, func = 001001, target=00000)
   Jump and link register
   JALR     REG[rd] <= PC+4; PC <= REG[rs];                JALR  rd,rs

   JR(op = 000000, func = 001000, target=00000, destination=00000)
   Jump Register
   JR       PC <= REG[rs];                                 JR  rs

   NOR(op = 000000, func = 100111)
   NOR        REG[rd] <= REG[rs] nor REG[rt];              NOR rd,rs,rt

   XOR(op = 000000, func = 100110)
   XOR        REG[rd] <= REG[rs] xor REG[rt];              XOR rd,rs,rt

   SLL(op = 000000, func = 000000)
   SLL        REG[rd] <= REG[rt] << shamt;                 SLL rd,rt,shamt

   SRL(op = 000000, func = 000010)
   SRL        REG[rd] <= REG[rt] >> shamt;                 SRL rd,rt,shamt

   SLLV(op = 000000, func = 000100)
   SLLV       REG[rd] <= REG[rt] << REG[rs];               SLLV rd,rt,rs

   SRLV(op = 000000, func = 000110)
   SRLV       REG[rd] <= REG[rt] >> REG[rs];               SRLV rd,rt,rs

   SRA(op = 000000, func = 000011)
   SRA        REG[rd] <= REG[rt] >> shamt;                 SRA rd,rt,shamt

   SRAV(op = 000000, func = 000111)
   SRAV       REG[rd] <= REG[rt] >> REG[rs];               SRAV rd,rt,rs

   SLTU(op = 000000, func = 101011)
   SLTU       REG[rd] <= (REG[rs] < REG[rt]) ? 1 : 0;      SLTU rd,rs,rt

   実験 9 ヒント（２）：整数乗算命令 mult についてのコメント追加
   MULT(op = 000000, func = 011000)
   MULT{Hi, Lo} <= REG[rs] * REG[rt];MULT rs,rt

   実験 9 ヒント（３）：ムーブ・フロム・Lo 命令 mflo についてのコメント追加
   MFLO(op = 000000, func = 010010)
   MFLO      REG[rd]  <= Lo;                    MFLO rd

   実験 10 ヒント（２）：符号なし除算命令 divu についてのコメント追加
   ...

   実験 10 ヒント（３）：ムーブ・フロム・Hi 命令 mfhi についてのコメント追加
   ...

   I 形式
   31      26 25    21 20   16 15                     0 
   ----------------------------------------------------
   | op      | rs     | rt    | address/immediate     |
   | (6-bit) |(5-bit) |(5-bit)|(16-bit)               |
   ----------------------------------------------------
   LW       REG[rt] <= RAM[rs+address];                LW  rt, rs, address
   SW       Ram[rs+address] <= REG[rt];                SW  rt, rs, address
   ADDI     REG[rt] <= REG[rs] + immediate;          ADDI  rt, rs, immediate
   ADDIU    REG[rt] <= REG[rs] + immediate;         ADDIU  rt, rs, immediate
   ANDI     REG[rt] <= REG[rs] & immediate;          ANDI  rt, rs, immediate
   ORI      REG[rt] <= REG[rs] | immediate;           ORI  rt, rs, immediate
   BEQ      PC <= (rs == rt) ? PC+4+address*4 : PC+4; BEQ  rs, rt, address
   BNE      PC <= (rs != rt) ? PC+4+address*4 : PC+4; BNE  rs, rt, address

   I 形式
   BGEZ(op = 000001, rt = 00001)
   BGEZ     PC <= (rs >= 0)  ? PC+4+address*4 : PC+4; BGEZ    rs, address

   BLEZ(op = 000110, rt = 00000)
   BLEZ      PC <= (rs <= 0)  ? PC+4+address*4 : PC+4; BLEZ    rs, address

   BGTZ(op = 000111, rt = 00000)
   BGTZ      PC <= (rs > 0)   ? PC+4+address*4 : PC+4; BGTZ    rs, address

   BLTZ(op = 000001, rt = 00000)
   BLTZ      PC <= (rs < 0)   ? PC+4+address*4 : PC+4; BLTZ    rs, address

   BGEZAL(op = 000001, rt = 10001)
   BGEZAL   PC <= (rs >= 0) ? PC+4+address*4 :  PC+4; RA_REG <= PC+4; 
   BGEZAL  rs, address
   BLTZAL(op = 000001, rt = 10000)
   BLTZAL   PC <= (rs < 0)   ? PC+4+address*4 : PC+4; RA_REG <= PC+4; 
   BLTZAL  rs, address
   ＃RA_REG は REG[31]

   XORI(op = 001110)
   XORI      REG[rt] <= REG[rs] xor immediate;           XORI  rt, rs, immediate

   SLTI(op = 001010)
   SLTI      REG[rt] <= (REG[rs] < immediate) ? 1 : 0;   SLTI  rt, rs, immediate

   SLTIU(op = 001011)
   SLTIU      REG[rt] <= (REG[rs] < immediate) ? 1 : 0;  SLTIU rt, rs, immediate

   LUI(op = 001111)
   LUI        REG[rt] <= (immediate << 16) ;  LUI rt, immediate

   J 形式
   31      26 25                                     0
   ---------------------------------------------------
   |op       |target address                         |
   | (6-bit) | (26-bit)                              |
   ---------------------------------------------------
   J       PC <= target address*4;                    J    target address
   JAL    PC <= target address*4; RA_REG <=PC+4;     JAL  target address

*/

#define      R   0
#define     LW  35
#define   ADDI   8
#define  ADDIU   9
#define   ANDI  12
#define    ORI  13
#define     SW  43
#define    BEQ   4
#define    BNE   5
#define   BGEZ_X 1
#define   BLEZ   6
#define   BGTZ   7
#define      J   2
#define    JAL   3
#define   XORI  14
#define   SLTI  10
#define  SLTIU  11
#define    LUI  15

#define    LLO  24

#define     ADD 32
#define    ADDU 33
#define     SUB 34
#define    SUBU 35
#define     AND 36
#define      OR 37
#define     SLT 42
#define    JALR  9
#define      JR  8
#define     NOR 39
#define     XOR 38
#define     SLL  0
#define     SRL  2
#define    SLLV  4
#define    SRLV  6
#define     SRA  3
#define    SRAV  7
#define    SLTU 43

// 実験 9 ヒント（４）：ムーブ・フロム・Lo 命令 mflo の func コードの define

//#define    MULT XX
#define    MFLO 18

#define      LB 32
#define      SB 40

// 実験 10 ヒント（４）：ムーブ・フロム・Hi 命令 mfhi の func コードの define

//#define    DIVU XX
//#define    MFHI XX

#define   BGEZ   1
#define   BLTZ   0
#define BGEZAL  17
#define BLTZAL  16

void sim_gen();
void mif_gen();
void fprint_sim();
void fprint_mif();

int main(int argc, char** argv) {
	FILE *infp;
	char cmd[128];

	printf("#\n");
	printf("# This program generates rom8x1024_sim.v and %s", argv[0]);
	printf("rom8x1024_DE2.mif from a MIPS binary file.\n");
  
	if (argc != 2) {
		printf("#\n");
		printf("# Usage: bin2v name.bin\n");
		printf("#   - Input: name.bin(MIPS binary file)\n");
		printf("#   - Outputs: rom8x1024_sim.v(Verilog HDL code for simulation) and\n");
		printf("#              rom8x1024_DE2.mif(memory image file for DE2 board).\n");
		printf("# Example:    %% bin2v ex1.bin\n");
		printf("#\n");
		exit(-1);
	} else {
		printf("#   - Input: %s(MIPS binary file)\n", argv[1]);
		printf("#   - Outputs: rom8x1024_sim.v(Verilog HDL code for simulation) and\n");
		printf("#              rom8x1024_DE2.mif(memory image file for DE2 board).\n");
		printf("#\n");
	}

	infp = fopen(argv[1], "rb");
	if (infp == NULL) {
		fprintf(stderr, "%s: Cannot open %s.\n", argv[0], argv[1]);
		exit(-1);
	}
	printf("--- \n");
	
	sim_gen(infp);
	fclose(infp);

	infp = fopen(argv[1], "rb");
	if (infp == NULL) {
		fprintf(stderr, "%s: Cannot open %s.\n", argv[0], argv[1]);
		exit(-1);
	}
	mif_gen(infp);
	fclose(infp);

	printf("Finished.\n");

	sprintf(cmd, "ls -l %s", SIM_FNM);
	system(cmd);
	sprintf(cmd, "ls -l %s", MIF_FNM);
	system(cmd);
}

void sim_gen(FILE *infp) {
	FILE *outfp;

	unsigned int byte_data;
	unsigned int word_data;
	unsigned int word_count;
	unsigned int operation_count;
  
	outfp = fopen(SIM_FNM, "w");
	if (outfp == NULL) {
		fprintf(stderr, "bin2v: Cannot open %s.\n", SIM_FNM);
		exit(-1);
	}
  
	fprintf(outfp, "/*******************/\n");
	fprintf(outfp, "/* rom8x1024_sim.v */\n");
	fprintf(outfp, "/*******************/\n");
	fprintf(outfp, "\n");
	fprintf(outfp, "//                  +----+\n");
	fprintf(outfp, "//  rom_addr[11:0]->|    |->rom_data[31:0]\n");
	fprintf(outfp, "//                  +----+\n");
	fprintf(outfp, "\n");
	fprintf(outfp, "//\n");
	fprintf(outfp, "// ROMの記述（論理シミュレーション用）\n");
	fprintf(outfp, "//\n");
	fprintf(outfp, "\n");
	fprintf(outfp, "module rom8x1024_sim (rom_addr, rom_data);\n");
	fprintf(outfp, "\n");
	fprintf(outfp, "  input   [11:0]  rom_addr;  // 12-bit アドレス入力ポート\n");
	fprintf(outfp, "  output  [31:0]  rom_data;  // 32-bit データ出力ポート\n");
	fprintf(outfp, "\n");
	fprintf(outfp, "  reg     [31:0]  data;\n");
	fprintf(outfp, "\n");
	fprintf(outfp, "  // Wire\n");
	fprintf(outfp, "  wire     [9:0]  word_addr; // 10-bit address, word\n");
	fprintf(outfp, "\n");
	fprintf(outfp, "  assign word_addr = rom_addr[9:2];\n");
	fprintf(outfp, "   \n");
	fprintf(outfp, "  always @(word_addr) begin\n");
	fprintf(outfp, "    case (word_addr)\n");

	word_data  = 0;
	word_count = 0;
	operation_count = 0;
	while(fread(&byte_data, 1, 1, infp) != 0) {
		word_data = (word_data << 8) | byte_data;
		word_count++;

		if (word_count == 4) {
			fprint_sim(outfp, word_data, operation_count);
			word_data  = 0;
			word_count = 0;
			operation_count++;
		}
	}

	fprintf(outfp, "    endcase\n");
	fprintf(outfp, "  end\n");
	fprintf(outfp, "\n");
	fprintf(outfp, "  assign rom_data = data;\n");
	fprintf(outfp, "endmodule\n");
  
	fclose(outfp);
}

void mif_gen(FILE *infp) {
	FILE *outfp;

	unsigned int byte_data;
	unsigned int word_data;
	unsigned int word_count;
	unsigned int operation_count;
  
	outfp = fopen(MIF_FNM, "w");
	if (outfp == NULL) {
		fprintf(stderr, "bin2v: Cannot open %s.\n", SIM_FNM);
		exit(-1);
	}
  
	fprintf(outfp, "Depth = 1024;;\n");
	fprintf(outfp, "Width =   32;;\n");
	fprintf(outfp, "Address_radix = hex;;\n");
	fprintf(outfp, "Data_radix = hex;;\n");
	fprintf(outfp, "%% 32-bit x 1024-word ROM Data %%;\n");
	fprintf(outfp, "Content;\n");
	fprintf(outfp, "  Begin;\n");
	fprintf(outfp, "[ 000 .. 3ff ] : 00000000; %% initialize all data %%;\n");

	word_data  = 0;
	word_count = 0;
	operation_count = 0;
	while(fread(&byte_data, 1, 1, infp) != 0) {
		word_data = (word_data << 8) | byte_data;
		word_count++;

		if (word_count == 4) {
			fprint_mif(outfp, word_data, operation_count);
			word_data  = 0;
			word_count = 0;
			operation_count++;
		}
	}

	fprintf(outfp, "End;\n");
	fclose(outfp);
}

void fprint_sim(FILE *outfp, volatile unsigned int wd, unsigned int op_cnt) {
	unsigned int rs;
	unsigned int rt;
	unsigned int rd;
	unsigned int shamt;
	unsigned int func;
	unsigned int address;
	unsigned int target_address;
	unsigned int immediate;
	unsigned int rom_addr;
	unsigned int cmt_addr;

	/*
	  R 形式
	  31      26 25    21 20   16 15   11 10    6 5      0
	  ----------------------------------------------------
	  | op      | rs     | rt    | rd    | shamt | func  |
	  | (6-bit) |(5-bit) |(5-bit)|(5-bit)|(5-bit)|(6-bit)|
	  ----------------------------------------------------

	  I 形式
	  31      26 25    21 20   16 15                     0 
	  ----------------------------------------------------
	  | op      | rs     | rt    | address/immediate     |
	  | (6-bit) |(5-bit) |(5-bit)|(16-bit)               |
	  ----------------------------------------------------

	  J 形式
	  31      26 25                                     0
	  ---------------------------------------------------
	  |op       |target address                         |
	  | (6-bit) | (26-bit)                              |
	  ---------------------------------------------------
	*/

	rs             = ((wd >> 21) & 0x0000001f);
	rt             = ((wd >> 16) & 0x0000001f);
	rd             = ((wd >> 11) & 0x0000001f);
	shamt          = ( (wd >> 6) & 0x0000001f);
	address        = (wd & (((unsigned int)1 << 16)-1));
	immediate      = address;
	target_address = (wd & (((unsigned int)1 << 26)-1));
	func      = (wd & (unsigned int)63);
  
	rom_addr = ((op_cnt * 4 + PRG_START_ADDR) >> 2) & (((unsigned int)1<<17) - 1);
	cmt_addr = op_cnt * 4 + PRG_START_ADDR;
  
	fprintf(outfp, "      ");
	//	printf("32'h%08x% \n", wd >> 26);
	switch (wd >> 26) {
	case R:
		switch (func) {
		case ADD:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: ADD, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]+REG[%d];\n", rd, rs, rt);
			break;
		case ADDU:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: ADDU, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]+REG[%d];\n", rd, rs, rt);
			break;
		case SUB:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: SUB, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]-REG[%d];\n", rd, rs, rt);
			break;
		case SUBU:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: SUBU, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]-REG[%d];\n", rd, rs, rt);
			break;
		case AND:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: AND, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]&REG[%d];\n", rd, rs, rt);
			break;
		case OR:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: OR, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]|REG[%d];\n", rd, rs, rt);
			break;
		case SLT:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: SLT, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=(REG[%d]<REG[%d])?1:0;\n", rd, rs, rt);
			break;
		case JALR:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: JALR, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=PC+4; PC<=REG[%d];\n", rd, rs);
			break;
		case JR:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: JR, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "PC<=REG[%d];\n", rs);
			break;
		case NOR:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: NOR, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=~(REG[%d]|REG[%d]);\n", rd, rs, rt);
			break;
		case XOR:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: XOR, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]^REG[%d];\n", rd, rs, rt);
			break;
		case SLL:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: SLL, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]<<%d;\n", rd, rt, shamt);
			break;
		case SRL:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: SRL, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]>>%d;\n", rd, rt, shamt);
			break;
		case SLLV:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: SLLV, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]<<REG[%d];\n", rd, rt, rs);
			break;
		case SRLV:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: SRLV, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]>>REG[%d];\n", rd, rt, rs);
			break;
		case SRA:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: SRA, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]arith>>shamt;\n", rd, rt);
			break;
		case SRAV:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: SRAV, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]arith>>REG[%d];\n", rd, rt, rs);
			break;
		case SLTU:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: SLTU, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=(REG[%d]<REG[%d])?1:0;\n", rd, rs, rt);
			break;

			// 実験 9 ヒント（５）：整数乗算命令 mult に関する rom8x1024_sim.v 生成用の記述
		case MULT:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: MULT, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "{ Hi, Lo }<=REG[%d]*REG[%d];\n", rs, rt);			
			break;

			// 実験 9 ヒント（６）：ムーブ・フロム・Lo 命令 mflo に関する rom8x1024_sim.v 生成用の記述 
		case MFLO:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: MFLO, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=Lo;\n", rd);
			break;

			// 実験 10 ヒント（５）：符号なし除算命令 divu に関する rom8x1024_sim.v 生成用の記述
			//		case DIVU:
			//			break;

			// 実験 10 ヒント（６）：ムーブ・フロム・Hi 命令 mfhi に関する rom8x1024_sim.v 生成用の記述 
			//		case MFHI:
			//			break;	  

		default:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: R type, unknown. ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "func=%u(10)\n", func);
			break;
		}
		break;
	case LW:
		fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: LW, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "REG[%d]<=RAM[REG[%d]+%d];\n", rt, rs, address);
		break;
	case LB:
		fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: LB, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "REG[%d]<=(RAM[REG[%d]+%d])[7:0]; #NOT YET IMPREMENTED\n", rt, rs, address);
		break;
	case ADDI:
		fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: ADDI, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "REG[%d]<=REG[%d]+%d;\n", rt, rs, immediate);
		break;
	case ADDIU:
		fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: ADDIU, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "REG[%d]<=REG[%d]+%d(=0x%08x);\n", rt, rs, immediate, immediate);
		break;
	case ANDI:
		fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: ANDI, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "REG[%d]<=REG[%d]&0x%08x;\n", rt, rs, immediate);
		break;
	case ORI:
		fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: ORI, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "REG[%d]<=REG[%d]|0x%08x;\n", rt, rs, immediate);
		break;
	case SW:
		fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: SW, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "RAM[REG[%d]+%d]<=REG[%d];\n", rs, address, rt);
		break;
	case SB:
		fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: SB, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "RAM[REG[%d]+%d]<=(REG[%d])[7:0]; #NOT YET IMPREMENTED\n", rs, address, rt);
		break;
	case BEQ:
		fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: BEQ, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "PC<=(REG[%d] == REG[%d])?PC+4+%d*4:PC+4;\n", rs, rt, address);
		break;
	case BNE:
		fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: BNE, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "PC<=(REG[%d] != REG[%d])?PC+4+%d*4:PC+4;\n", rs, rt, address);
		break;
	case BGEZ_X:
		switch (rt) {
		case BGEZ:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: BGEZ\n",   rom_addr, wd, cmt_addr);
			break;
		case BLTZ:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: BLTZ\n",   rom_addr, wd, cmt_addr);
			break;
		case BGEZAL:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: BGEZAL\n",   rom_addr, wd, cmt_addr);
			break;
		case BLTZAL:
			fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: BLTZAL\n",   rom_addr, wd, cmt_addr);
			break;
		}
		break;
	case BLEZ:
		fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: BLEZ\n", rom_addr, wd, cmt_addr);
		break;
	case BGTZ:
		fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: BGTZ\n", rom_addr, wd, cmt_addr);
		break;
	case J:
		fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: J, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "PC<=0x%08x*4(=0x%08x);\n", target_address, target_address*4);
		break;
	case JAL:
		fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: JAL, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "PC<=0x%08x*4(=0x%08x); REG[31]<=PC+4\n", target_address, target_address*4);
		break;
	case XORI:
		fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: XORI\n", rom_addr, wd, cmt_addr);
		break;
	case SLTI:
		fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: SLTI\n", rom_addr, wd, cmt_addr);
		break;
	case SLTIU:
		fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: SLTIU, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "REG[%d]<=(REG[%d]<%d(=0x%08x))?1:0;\n", rt, rs, immediate, immediate);
		break;
	case LUI:
		fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: LUI\n", rom_addr, wd, cmt_addr);
		break;
	case LLO:
		fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: LLO, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "REG[%d].[15:0]<=%d; #NOT YET IMPREMENTED\n", rt, immediate);
		break;
	default:
		fprintf(outfp, "10'h%03x: data = 32'h%08x; // %08x: other type! ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "opcode=%u(10)\n", wd >> 26);
		break;
	}
}

void fprint_mif(FILE *outfp, unsigned int wd, unsigned int op_cnt) {
	unsigned int rs;
	unsigned int rt;
	unsigned int rd;
	unsigned int shamt;
	unsigned int func;
	unsigned int address;
	unsigned int target_address;
	unsigned int immediate;
	unsigned int rom_addr;
	unsigned int cmt_addr;

	/*
	  R 形式
	  31      26 25    21 20   16 15   11 10    6 5      0
	  ----------------------------------------------------
	  | op      | rs     | rt    | rd    | shamt | func  |
	  | (6-bit) |(5-bit) |(5-bit)|(5-bit)|(5-bit)|(6-bit)|
	  ----------------------------------------------------

	  I 形式
	  31      26 25    21 20   16 15                     0 
	  ----------------------------------------------------
	  | op      | rs     | rt    | address/immediate     |
	  | (6-bit) |(5-bit) |(5-bit)|(16-bit)               |
	  ----------------------------------------------------

	  J 形式
	  31      26 25                                     0
	  ---------------------------------------------------
	  |op       |target address                         |
	  | (6-bit) | (26-bit)                              |
	  ---------------------------------------------------
	*/

	rs             = ((wd >> 21) & (unsigned int)0x0000001f);
	rt             = ((wd >> 16) & (unsigned int)0x0000001f);
	rd             = ((wd >> 11) & (unsigned int)0x0000001f);
	shamt          = ( (wd >> 6) & (unsigned int)0x0000001f);
	address        = (wd & (((unsigned int)1 << 16)-1));
	immediate      = address;
	target_address = (wd & (((unsigned int)1 << 26)-1));
	func      = (wd & (unsigned int)63);
  
	rom_addr = ((op_cnt * 4 + PRG_START_ADDR) >> 2) & (((unsigned int)1<<17) - 1);
	cmt_addr = op_cnt * 4 + PRG_START_ADDR;
  
	fprintf(outfp, "      ");
	switch (wd >> 26) {
	case R:
		switch (func) {
		case ADD:
			fprintf(outfp, "%03x : %08x ; %% %08x: ADD, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]+REG[%d]; %%\n", rd, rs, rt);
			break;
		case ADDU:
			fprintf(outfp, "%03x : %08x ; %% %08x: ADDU, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]+REG[%d]; %%\n", rd, rs, rt);
			break;
		case SUB:
			fprintf(outfp, "%03x : %08x ; %% %08x: SUB, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]-REG[%d]; %%\n", rd, rs, rt);
			break;
		case SUBU:
			fprintf(outfp, "%03x : %08x ; %% %08x: SUBU, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]-REG[%d]; %%\n", rd, rs, rt);
			break;
		case AND:
			fprintf(outfp, "%03x : %08x ; %% %08x: AND, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]&REG[%d]; %%\n", rd, rs, rt);
			break;
		case OR:
			fprintf(outfp, "%03x : %08x ; %% %08x: OR, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]|REG[%d]; %%\n", rd, rs, rt);
			break;
		case SLT:
			fprintf(outfp, "%03x : %08x ; %% %08x: SLT, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=(REG[%d]<REG[%d])?1:0; %%\n", rd, rs, rt);
			break;
		case JALR:
			fprintf(outfp, "%03x : %08x ; %% %08x: JALR, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=PC+4; PC<=REG[%d]; %%\n", rd, rs);
			break;
		case JR:
			fprintf(outfp, "%03x : %08x ; %% %08x: JR, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "PC<=REG[%d]; %%\n", rs);
			break;
		case NOR:
			fprintf(outfp, "%03x : %08x ; %% %08x: NOR, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=~(REG[%d]|REG[%d]); %%\n", rd, rs, rt);
			break;
		case XOR:
			fprintf(outfp, "%03x : %08x ; %% %08x: XOR, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]^REG[%d]; %%\n", rd, rs, rt);
			break;
		case SLL:
			fprintf(outfp, "%03x : %08x ; %% %08x: SLL, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]<<%d; %%\n", rd, rt, shamt);
			break;
		case SRL:
			fprintf(outfp, "%03x : %08x ; %% %08x: SRL, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]>>%d; %%\n", rd, rt, shamt);
			break;
		case SLLV:
			fprintf(outfp, "%03x : %08x ; %% %08x: SLLV, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]<<REG[%d]; %%\n", rd, rt, rs);
			break;
		case SRLV:
			fprintf(outfp, "%03x : %08x ; %% %08x: SRLV, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]>>REG[%d]; %%\n", rd, rt, rs);
			break;
		case SRA:
			fprintf(outfp, "%03x : %08x ; %% %08x: SRA, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]arith>>shamt; %%\n", rd, rt);
			break;
		case SRAV:
			fprintf(outfp, "%03x : %08x ; %% %08x: SRAV, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=REG[%d]arith>>REG[%d]; %%\n", rd, rt, rs);
			break;
		case SLTU:
			fprintf(outfp, "%03x : %08x ; %% %08x: SLTU, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=(REG[%d]<REG[%d])?1:0; %%\n", rd, rs, rt);
			break;

			// 実験 9 ヒント（７）：整数乗算命令 mult に関する rom8x1024_DE2.mif 生成用の記述
		case MULT:
			fprintf(outfp, "%03x : %08x ; %% %08x: MULT, ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "REG[%d]<=(REG[%d]<REG[%d])?1:0; %%\n", rd, rs, rt);
			break;

			// 実験 9 ヒント（８）：ムーブ・フロム・Lo 命令 mflo に関する rom8x1024_DE2.mif 生成用の記述 
			//		case MFLO:
			//			break;
	  
			// 実験 10 ヒント（７）：符号なし除算命令 divu に関する rom8x1024_DE2.mif 生成用の記述
			//		case DIVU:
			//			break;

			// 実験 10 ヒント（８）：ムーブ・フロム・Hi 命令 mfhi に関する rom8x1024_DE2.mif 生成用の記述 
			//		case MFHI:
			//			break;
	  
		default:
			fprintf(outfp, "%03x : %08x ; %% %08x: R type, unknown. %% ", rom_addr, wd, cmt_addr);
			fprintf(outfp, "func=%u(10) %%\n", func);
			break;
		}
		break;
	case LW:
		fprintf(outfp, "%03x : %08x ; %% %08x: LW, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "REG[%d]<=RAM[REG[%d]+%d]; %%\n", rt, rs, address);
		break;
	case LB:
		fprintf(outfp, "%03x : %08x ; %% %08x: LB, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "REG[%d]<=(RAM[REG[%d]+%d])[7:0]; #NOT YET IMPREMENTED %%\n", rt, rs, address);
		break;
	case ADDI:
		fprintf(outfp, "%03x : %08x ; %% %08x: ADDI, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "REG[%d]<=REG[%d]+%d; %%\n", rt, rs, immediate);
		break;
	case ADDIU:
		fprintf(outfp, "%03x : %08x ; %% %08x: ADDIU, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "REG[%d]<=REG[%d]+%d(=0x%08x); %%\n", rt, rs, immediate, immediate);
		break;
	case ANDI:
		fprintf(outfp, "%03x : %08x ; %% %08x: ANDI, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "REG[%d]<=REG[%d]&0x%08x; %%\n", rt, rs, immediate);
		break;
	case ORI:
		fprintf(outfp, "%03x : %08x ; %% %08x: ORI, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "REG[%d]<=REG[%d]|0x%08x; %%\n", rt, rs, immediate);
		break;
	case SW:
		fprintf(outfp, "%03x : %08x ; %% %08x: SW, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "RAM[REG[%d]+%d]<=REG[%d]; %%\n", rs, address, rt);
		break;
	case SB:
		fprintf(outfp, "%03x : %08x ; %% %08x: SB, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "RAM[REG[%d]+%d]<=(REG[%d])[7:0]; #NOT YET IMPREMENTED %%\n", rs, address, rt);
		break;
	case BEQ:
		fprintf(outfp, "%03x : %08x ; %% %08x: BEQ, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "PC<=(REG[%d] == REG[%d])?PC+4+%d*4:PC+4; %%\n", rs, rt, address);
		break;
	case BNE:
		fprintf(outfp, "%03x : %08x ; %% %08x: BNE, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "PC<=(REG[%d] != REG[%d])?PC+4+%d*4:PC+4; %%\n", rs, rt, address);
		break;
	case BGEZ_X:
		switch (rt) {
		case BGEZ:
			fprintf(outfp, "%03x : %08x ; %% %08x: BGEZ %%\n",   rom_addr, wd, cmt_addr);
			break;
		case BLTZ:
			fprintf(outfp, "%03x : %08x ; %% %08x: BLTZ %%\n",   rom_addr, wd, cmt_addr);
			break;
		case BGEZAL:
			fprintf(outfp, "%03x : %08x ; %% %08x: BGEZAL %%\n",   rom_addr, wd, cmt_addr);
			break;
		case BLTZAL:
			fprintf(outfp, "%03x : %08x ; %% %08x: BLTZAL %%\n",   rom_addr, wd, cmt_addr);
			break;
		}
		break;
	case BLEZ:
		fprintf(outfp, "%03x : %08x ; %% %08x: BLEZ %%\n", rom_addr, wd, cmt_addr);
		break;
	case BGTZ:
		fprintf(outfp, "%03x : %08x ; %% %08x: BGTZ %%\n", rom_addr, wd, cmt_addr);
		break;
	case J:
		fprintf(outfp, "%03x : %08x ; %% %08x: J, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "PC<=0x%08x*4(=0x%08x); %%\n", target_address, target_address*4);
		break;
	case JAL:
		fprintf(outfp, "%03x : %08x ; %% %08x: JAL, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "PC<=0x%08x*4(=0x%08x); REG[31]<=PC+4 %%\n", target_address, target_address*4);
		break;
	case XORI:
		fprintf(outfp, "%03x : %08x ; %% %08x: XORI %%\n", rom_addr, wd, cmt_addr);
		break;
	case SLTI:
		fprintf(outfp, "%03x : %08x ; %% %08x: SLTI %%\n", rom_addr, wd, cmt_addr);
		break;
	case SLTIU:
		fprintf(outfp, "%03x : %08x ; %% %08x: SLTIU, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "REG[%d]<=(REG[%d]<%d(=0x%08x))?1:0; %%\n", rt, rs, immediate, immediate);
		break;
	case LUI:
		fprintf(outfp, "%03x : %08x ; %% %08x: LUI %%\n", rom_addr, wd, cmt_addr);
		break;
	case LLO:
		fprintf(outfp, "%03x : %08x ; %% %08x: LLO, ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "REG[%d].[15:0]<=%d; #NOT YET IMPREMENTED %%\n", rt, immediate);
		break;
	default:
		fprintf(outfp, "%03x : %08x ; %% %08x: other type! %% ", rom_addr, wd, cmt_addr);
		fprintf(outfp, "opcode=%u(10) %%\n", wd >> 26);
		break;
	}
}
