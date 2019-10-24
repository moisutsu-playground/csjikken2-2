module	VGA_OSD_RAM	(	//	Read Out Side
						oRed,
						oGreen,
						oBlue,
						iVGA_ADDR,
						iVGA_CLK,		// 25.175 MHz Clock, rdclock
						//	Write In Side
						iWR_DATA,
						iWR_ADDR,
						iWR_EN,
						iWR_CLK,		// 25.175 MHz Clock
						//	CLUT
						iON_R,
						iON_G,
						iON_B,
						iOFF_R,
						iOFF_G,
						iOFF_B,
						//	Control Signals
						iRST_N	);
//	Read Out Side
output	reg	[9:0]	oRed;
output	reg	[9:0]	oGreen;
output	reg	[9:0]	oBlue;
input	[18:0]		iVGA_ADDR;
input				iVGA_CLK;
//	Write In Side
input	[18:0]		iWR_ADDR;
input				iWR_DATA;
input				iWR_EN;
input				iWR_CLK;
//	CLUT
input	[9:0]	iON_R;
input	[9:0]	iON_G;
input	[9:0]	iON_B;
input	[9:0]	iOFF_R;
input	[9:0]	iOFF_G;
input	[9:0]	iOFF_B;
//	Control Signals
input				iRST_N;
//	Internal Registers/Wires
reg	[2:0]		ADDR_d;
reg	[2:0]		ADDR_dd;
reg	[18:0]		WR_ADDR_d;
reg	[18:0]		WR_ADDR_dd;
reg	[18:0]		WR_ADDR_ddd;
reg	[18:0]		WR_ADDR_dddd;
reg	[18:0]		WR_ADDR_ddddd;
reg			Wen_d;
reg			Wen_dd;
reg			Wen_ddd;
reg			Wen_dddd;
reg			Wen_ddddd;
wire	[7:0]		ROM_DATA;

always@(posedge iVGA_CLK or negedge iRST_N)
begin
	if(!iRST_N)
	begin
		oRed		<=	0;
		oGreen		<=	0;
		oBlue		<=	0;
		ADDR_d		<=	0;
		ADDR_dd		<=	0;
		WR_ADDR_d	<=	0;
		WR_ADDR_dd	<=	0;
		WR_ADDR_ddd	<=	0;
		WR_ADDR_dddd	<=	0;
		WR_ADDR_ddddd	<=	0;
		Wen_d		<=	0;
		Wen_dd		<=	0;
		Wen_ddd		<=	0;
		Wen_dddd	<=	0;
		Wen_ddddd	<=	0;
	end
	else
	begin
		ADDR_d		<=	iVGA_ADDR[2:0];
		ADDR_dd		<=	~ADDR_d;
		oRed		<=	ROM_DATA[ADDR_dd]?	iON_R:iOFF_R;
		oGreen		<=	ROM_DATA[ADDR_dd]?	iON_G:iOFF_G;
		oBlue		<=	ROM_DATA[ADDR_dd]?	iON_B:iOFF_B;
		WR_ADDR_d	<=	{iWR_ADDR[18:3],~iWR_ADDR[2:0]};
		WR_ADDR_dd	<=	WR_ADDR_d;
		WR_ADDR_ddd	<=	WR_ADDR_dd;
		WR_ADDR_dddd	<=	WR_ADDR_ddd;
		WR_ADDR_ddddd	<=	WR_ADDR_dddd;
		Wen_d		<=	iWR_EN;
		Wen_dd		<=	Wen_d;
		Wen_ddd		<=	Wen_dd;
		Wen_dddd	<=	Wen_ddd;
		Wen_ddddd	<=	Wen_dddd;
	end
end

Img_RAM 	u0	(	//	Write In Side
					.data(iWR_DATA),
					.wren(Wen_ddd),
					.wraddress(WR_ADDR_ddd),
					.wrclock(iWR_CLK),		// 25.175 MHz Clock
					//	Read Out Side
					.rdaddress(iVGA_ADDR[18:3]),
					.rdclock(iVGA_CLK),		// 25.175 MHz Clock
					.q(ROM_DATA));

endmodule