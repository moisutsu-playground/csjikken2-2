module	VGA_CHAR_RAM	(	//	Read Out Side
						oPIXEL_VAL,
						iVGA_ADDR,
						iVGA_CoordX,
						iVGA_CoordY,
						iVGA_CLK,		// 25.175 MHz Clock, rdclock
						//	Write In Side
						iWR_DATA,
						iWR_PUT_ROW,
						iWR_PUT_COL,
						iWR_EN,
						iWR_CLK,		// 25.175 MHz Clock
						//	Control Signals
						iRST_N);

//	Read Out Side
input	[18:0]		iVGA_ADDR;
input	[9:0]		iVGA_CoordX;
input	[9:0]		iVGA_CoordY;
input			iVGA_CLK;
output	reg	[7:0]	oPIXEL_VAL;
//	Write In Side
input	[4:0]		iWR_PUT_ROW;
input	[5:0]		iWR_PUT_COL;
input	[7:0]		iWR_DATA;
input			iWR_EN;
input			iWR_CLK;
//	Control Signals
input				iRST_N;
//	Internal Registers/Wires
reg	[2:0]		pixel_sel_d;
reg	[2:0]		pixel_sel_dd;
wire	[7:0]		char_line;
wire	[7:0]		ascii_D;
wire	[10:0]		ram_address;
wire	[8:0]		rom_address;
wire	[7:0]		rom_out_data;

//
// CHAR_RAM
assign ram_address = (iWR_EN == 1'b1) ? {iWR_PUT_ROW[4:0]*40 + iWR_PUT_COL[5:0]}
						: {iVGA_CoordY[8:4]*40 + iVGA_CoordX[9:4]};
char30x40_ram 	char30x40_ram_component	(	//	Write In Side
					.address(ram_address),
					.data(iWR_DATA),
					.wren(iWR_EN),
					.inclock(iWR_CLK),		// 25.175 MHz Clock
					//	Read Out Side
					.outclock(iVGA_CLK),		// 25.175 MHz Clock
					.q(ascii_D));
// End: CHAR_RAM
//

always @(posedge iVGA_CLK or negedge iRST_N) begin
	if (iRST_N == 1'b0) begin
		oPIXEL_VAL	<= 1'b0;
		pixel_sel_d	<= 3'b000;
		pixel_sel_dd	<= 3'b000;
	end else begin
		pixel_sel_d		<= ~iVGA_ADDR[3:1];
		pixel_sel_dd		<= pixel_sel_d;
		oPIXEL_VAL 		<= char_line[pixel_sel_dd];
	end
end

//
// BMPFONT_ROM
assign          rom_address = {ascii_D[5:0], iVGA_CoordY[3:1]};
assign          char_line   = rom_out_data;
lpm_rom         lpm_rom_component       (
                                              .address(rom_address),
                                              .inclock(iVGA_CLK),
                                              .outclock(iVGA_CLK),
                                              .q(rom_out_data)  );
defparam        lpm_rom_component.LPM_WIDTH   = 8,   // 8-bit data
                lpm_rom_component.LPM_WIDTHAD = 9,   // 9-bit address
                lpm_rom_component.LPM_ADDRESS_CONTROL = "REGISTERED",
                lpm_rom_component.LPM_OUTDATA = "REGISTERED",
                lpm_rom_component.LPM_FILE    = "bmpfont.mif";
// End: BMPFONT_ROM
//

endmodule