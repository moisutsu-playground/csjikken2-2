/*
  PC=xxxx,ALUY=xxxxxxxx,
*/

`define   SCAN_ACT       1'b1
`define   SCAN_INACT     1'b0

`define   SCAN_ASCII_STORING 32'hffffffff

`define   SCAN_ASCII_ADDR  13'h0310
`define   SCAN_ASCII_WEN   1'b1

`define   SCAN_REQ_ADDR  13'h030c
`define   SCAN_REQ_WEN   1'b1

`define   SCAN_STROKE_ADDR  13'h0308
`define   SCAN_STROKE_WEN   1'b1

`define   PRINT_STROKE_ADDR  13'h0300
`define   PRINT_STROKE_WEN   1'b1

`define   PRINT_ASCII_ADDR   13'h0304
`define   PRINT_ASCII_WEN    1'b1

`define   SCANst_SLEEP    2'b00
`define   SCANst_STORE    2'b01
`define   SCANst_SEND     2'b10

`define   InitMONITORst  8'd0
`define UpdateMONITORst  8'd1
`define      GetKEYINst  8'd2

`define InitMONITORst00_00 10'd0
`define InitMONITORst00_01 10'd1
`define InitMONITORst00_02 10'd2
`define InitMONITORst00_03 10'd3
`define InitMONITORst00_04 10'd4
`define InitMONITORst00_05 10'd5
`define InitMONITORst00_06 10'd6
`define InitMONITORst00_07 10'd7
`define InitMONITORst00_08 10'd8
`define InitMONITORst00_09 10'd9
`define InitMONITORst00_10 10'd10
`define InitMONITORst00_11 10'd11
`define InitMONITORst00_12 10'd12
`define InitMONITORst00_13 10'd13
`define InitMONITORst00_14 10'd14
`define InitMONITORst00_15 10'd15
`define InitMONITORst00_16 10'd16
`define InitMONITORst00_17 10'd17
`define InitMONITORst00_18 10'd18
`define InitMONITORst00_19 10'd19
`define InitMONITORst00_20 10'd20
`define InitMONITORst00_21 10'd21
`define InitMONITORst00_22 10'd22
`define InitMONITORst00_23 10'd23
`define InitMONITORst00_24 10'd24
`define InitMONITORst00_25 10'd25
`define InitMONITORst00_26 10'd26
`define InitMONITORst00_27 10'd27
`define InitMONITORst00_28 10'd28
`define InitMONITORst00_29 10'd29
`define InitMONITORst00_30 10'd30
`define InitMONITORst00_31 10'd31
`define InitMONITORst00_32 10'd32
`define InitMONITORst00_33 10'd33
`define InitMONITORst00_34 10'd34
`define InitMONITORst00_35 10'd35
`define InitMONITORst00_36 10'd36
`define InitMONITORst00_37 10'd37
`define InitMONITORst00_38 10'd38
`define InitMONITORst00_39 10'd39

`define InitMONITORst01_00 10'd40
`define InitMONITORst01_01 10'd41
`define InitMONITORst01_02 10'd42
`define InitMONITORst01_03 10'd43
`define InitMONITORst01_04 10'd44
`define InitMONITORst01_05 10'd45
`define InitMONITORst01_06 10'd46
`define InitMONITORst01_07 10'd47
`define InitMONITORst01_08 10'd48
`define InitMONITORst01_09 10'd49
`define InitMONITORst01_10 10'd50
`define InitMONITORst01_11 10'd51
`define InitMONITORst01_12 10'd52
`define InitMONITORst01_13 10'd53
`define InitMONITORst01_14 10'd54
`define InitMONITORst01_15 10'd55
`define InitMONITORst01_16 10'd56
`define InitMONITORst01_17 10'd57
`define InitMONITORst01_18 10'd58
`define InitMONITORst01_19 10'd59
`define InitMONITORst01_20 10'd60
`define InitMONITORst01_21 10'd61
`define InitMONITORst01_22 10'd62
`define InitMONITORst01_23 10'd63
`define InitMONITORst01_24 10'd64
`define InitMONITORst01_25 10'd65
`define InitMONITORst01_26 10'd66
`define InitMONITORst01_27 10'd67
`define InitMONITORst01_28 10'd68
`define InitMONITORst01_29 10'd69
`define InitMONITORst01_30 10'd70
`define InitMONITORst01_31 10'd71
`define InitMONITORst01_32 10'd72
`define InitMONITORst01_33 10'd73
`define InitMONITORst01_34 10'd74
`define InitMONITORst01_35 10'd75
`define InitMONITORst01_36 10'd76
`define InitMONITORst01_37 10'd77
`define InitMONITORst01_38 10'd78
`define InitMONITORst01_39 10'd79

`define InitMONITORst02_00 10'd80
`define InitMONITORst02_01 10'd81
`define InitMONITORst02_02 10'd82
`define InitMONITORst02_03 10'd83
`define InitMONITORst02_04 10'd84
`define InitMONITORst02_05 10'd85
`define InitMONITORst02_06 10'd86
`define InitMONITORst02_07 10'd87
`define InitMONITORst02_08 10'd88
`define InitMONITORst02_09 10'd89
`define InitMONITORst02_10 10'd90
`define InitMONITORst02_11 10'd91
`define InitMONITORst02_12 10'd92
`define InitMONITORst02_13 10'd93
`define InitMONITORst02_14 10'd94
`define InitMONITORst02_15 10'd95
`define InitMONITORst02_16 10'd96
`define InitMONITORst02_17 10'd97
`define InitMONITORst02_18 10'd98
`define InitMONITORst02_19 10'd99
`define InitMONITORst02_20 10'd100
`define InitMONITORst02_21 10'd101
`define InitMONITORst02_22 10'd102
`define InitMONITORst02_23 10'd103
`define InitMONITORst02_24 10'd104
`define InitMONITORst02_25 10'd105
`define InitMONITORst02_26 10'd106
`define InitMONITORst02_27 10'd107
`define InitMONITORst02_28 10'd108
`define InitMONITORst02_29 10'd109
`define InitMONITORst02_30 10'd110
`define InitMONITORst02_31 10'd111
`define InitMONITORst02_32 10'd112
`define InitMONITORst02_33 10'd113
`define InitMONITORst02_34 10'd114
`define InitMONITORst02_35 10'd115
`define InitMONITORst02_36 10'd116
`define InitMONITORst02_37 10'd117
`define InitMONITORst02_38 10'd118
`define InitMONITORst02_39 10'd119

`define InitMONITORst03_00 10'd120
`define InitMONITORst03_01 10'd121
`define InitMONITORst03_02 10'd122
`define InitMONITORst03_03 10'd123
`define InitMONITORst03_04 10'd124
`define InitMONITORst03_05 10'd125
`define InitMONITORst03_06 10'd126
`define InitMONITORst03_07 10'd127
`define InitMONITORst03_08 10'd128
`define InitMONITORst03_09 10'd129
`define InitMONITORst03_10 10'd130
`define InitMONITORst03_11 10'd131
`define InitMONITORst03_12 10'd132
`define InitMONITORst03_13 10'd133
`define InitMONITORst03_14 10'd134
`define InitMONITORst03_15 10'd135
`define InitMONITORst03_16 10'd136
`define InitMONITORst03_17 10'd137
`define InitMONITORst03_18 10'd138
`define InitMONITORst03_19 10'd139
`define InitMONITORst03_20 10'd140
`define InitMONITORst03_21 10'd141
`define InitMONITORst03_22 10'd142
`define InitMONITORst03_23 10'd143
`define InitMONITORst03_24 10'd144
`define InitMONITORst03_25 10'd145
`define InitMONITORst03_26 10'd146
`define InitMONITORst03_27 10'd147
`define InitMONITORst03_28 10'd148
`define InitMONITORst03_29 10'd149
`define InitMONITORst03_30 10'd150
`define InitMONITORst03_31 10'd151
`define InitMONITORst03_32 10'd152
`define InitMONITORst03_33 10'd153
`define InitMONITORst03_34 10'd154
`define InitMONITORst03_35 10'd155
`define InitMONITORst03_36 10'd156
`define InitMONITORst03_37 10'd157
`define InitMONITORst03_38 10'd158
`define InitMONITORst03_39 10'd159

`define InitMONITORst04_00 10'd160
`define InitMONITORst04_01 10'd161
`define InitMONITORst04_02 10'd162
`define InitMONITORst04_03 10'd163
`define InitMONITORst04_04 10'd164
`define InitMONITORst04_05 10'd165
`define InitMONITORst04_06 10'd166
`define InitMONITORst04_07 10'd167
`define InitMONITORst04_08 10'd168
`define InitMONITORst04_09 10'd169
`define InitMONITORst04_10 10'd170
`define InitMONITORst04_11 10'd171
`define InitMONITORst04_12 10'd172
`define InitMONITORst04_13 10'd173
`define InitMONITORst04_14 10'd174
`define InitMONITORst04_15 10'd175
`define InitMONITORst04_16 10'd176
`define InitMONITORst04_17 10'd177
`define InitMONITORst04_18 10'd178
`define InitMONITORst04_19 10'd179
`define InitMONITORst04_20 10'd180
`define InitMONITORst04_21 10'd181
`define InitMONITORst04_22 10'd182
`define InitMONITORst04_23 10'd183
`define InitMONITORst04_24 10'd184
`define InitMONITORst04_25 10'd185
`define InitMONITORst04_26 10'd186
`define InitMONITORst04_27 10'd187
`define InitMONITORst04_28 10'd188
`define InitMONITORst04_29 10'd189
`define InitMONITORst04_30 10'd190
`define InitMONITORst04_31 10'd191
`define InitMONITORst04_32 10'd192
`define InitMONITORst04_33 10'd193
`define InitMONITORst04_34 10'd194
`define InitMONITORst04_35 10'd195
`define InitMONITORst04_36 10'd196
`define InitMONITORst04_37 10'd197
`define InitMONITORst04_38 10'd198
`define InitMONITORst04_39 10'd199

`define InitMONITORst14_00 10'd560
`define InitMONITORst14_01 10'd561
`define InitMONITORst14_02 10'd562
`define InitMONITORst14_03 10'd563
`define InitMONITORst14_04 10'd564
`define InitMONITORst14_05 10'd565
`define InitMONITORst14_06 10'd566
`define InitMONITORst14_07 10'd567
`define InitMONITORst14_08 10'd568
`define InitMONITORst14_09 10'd569
`define InitMONITORst14_10 10'd570
`define InitMONITORst14_11 10'd571
`define InitMONITORst14_12 10'd572
`define InitMONITORst14_13 10'd573
`define InitMONITORst14_14 10'd574
`define InitMONITORst14_15 10'd575
`define InitMONITORst14_16 10'd576
`define InitMONITORst14_17 10'd577
`define InitMONITORst14_18 10'd578
`define InitMONITORst14_19 10'd579
`define InitMONITORst14_20 10'd580
`define InitMONITORst14_21 10'd581
`define InitMONITORst14_22 10'd582
`define InitMONITORst14_23 10'd583
`define InitMONITORst14_24 10'd584
`define InitMONITORst14_25 10'd585
`define InitMONITORst14_26 10'd586
`define InitMONITORst14_27 10'd587
`define InitMONITORst14_28 10'd588
`define InitMONITORst14_29 10'd589
`define InitMONITORst14_30 10'd590
`define InitMONITORst14_31 10'd591
`define InitMONITORst14_32 10'd592
`define InitMONITORst14_33 10'd593
`define InitMONITORst14_34 10'd594
`define InitMONITORst14_35 10'd595
`define InitMONITORst14_36 10'd596
`define InitMONITORst14_37 10'd597
`define InitMONITORst14_38 10'd598
`define InitMONITORst14_39 10'd599
`define InitMONITORst14_40 10'd600

// PC
`define UpdateMONITORst00_03 10'd3
`define UpdateMONITORst00_04 10'd4
`define UpdateMONITORst00_05 10'd5
`define UpdateMONITORst00_06 10'd6

// ALUY
`define UpdateMONITORst00_13 10'd13
`define UpdateMONITORst00_14 10'd14
`define UpdateMONITORst00_15 10'd15
`define UpdateMONITORst00_16 10'd16
`define UpdateMONITORst00_17 10'd17
`define UpdateMONITORst00_18 10'd18
`define UpdateMONITORst00_19 10'd19
`define UpdateMONITORst00_20 10'd20
`define UpdateMONITORst00_21 10'd21

// ALUA
`define UpdateMONITORst00_24 10'd24
`define UpdateMONITORst00_25 10'd25
`define UpdateMONITORst00_26 10'd26
`define UpdateMONITORst00_27 10'd27
`define UpdateMONITORst00_28 10'd28
`define UpdateMONITORst00_29 10'd29
`define UpdateMONITORst00_30 10'd30
`define UpdateMONITORst00_31 10'd31
`define UpdateMONITORst00_32 10'd32

//ALUCTRL
`define UpdateMONITORst00_38 10'd38

// ALUB
`define UpdateMONITORst01_02 10'd42
`define UpdateMONITORst01_03 10'd43
`define UpdateMONITORst01_04 10'd44
`define UpdateMONITORst01_05 10'd45
`define UpdateMONITORst01_06 10'd46
`define UpdateMONITORst01_07 10'd47
`define UpdateMONITORst01_08 10'd48
`define UpdateMONITORst01_09 10'd49
`define UpdateMONITORst01_10 10'd50

// ALUCOMP
`define UpdateMONITORst01_16 10'd56
`define UpdateMONITORst01_17 10'd57

// REGDATA1
`define UpdateMONITORst01_24 10'd64
`define UpdateMONITORst01_25 10'd65
`define UpdateMONITORst01_26 10'd66
`define UpdateMONITORst01_27 10'd67
`define UpdateMONITORst01_28 10'd68
`define UpdateMONITORst01_29 10'd69
`define UpdateMONITORst01_30 10'd70
`define UpdateMONITORst01_31 10'd71

//REGIDX1
`define UpdateMONITORst01_37 10'd77
`define UpdateMONITORst01_38 10'd78

// REGDATA2
`define UpdateMONITORst02_06 10'd86
`define UpdateMONITORst02_07 10'd87
`define UpdateMONITORst02_08 10'd88
`define UpdateMONITORst02_09 10'd89
`define UpdateMONITORst02_10 10'd90
`define UpdateMONITORst02_11 10'd91
`define UpdateMONITORst02_12 10'd92
`define UpdateMONITORst02_13 10'd93

//REGIDX2
`define UpdateMONITORst02_19 10'd99
`define UpdateMONITORst02_20 10'd100

// REGWDATA
`define UpdateMONITORst02_32 10'd112
`define UpdateMONITORst02_33 10'd113
`define UpdateMONITORst02_34 10'd114
`define UpdateMONITORst02_35 10'd115
`define UpdateMONITORst02_36 10'd116
`define UpdateMONITORst02_37 10'd117
`define UpdateMONITORst02_38 10'd118
`define UpdateMONITORst02_39 10'd119

//REGWIDX
`define UpdateMONITORst03_05 10'd125
`define UpdateMONITORst03_06 10'd126

//REGWEN
`define UpdateMONITORst03_12 10'd132
`define UpdateMONITORst03_13 10'd133

//RAMRDATA
`define UpdateMONITORst03_22 10'd142
`define UpdateMONITORst03_23 10'd143
`define UpdateMONITORst03_24 10'd144
`define UpdateMONITORst03_25 10'd145
`define UpdateMONITORst03_26 10'd146
`define UpdateMONITORst03_27 10'd147
`define UpdateMONITORst03_28 10'd148
`define UpdateMONITORst03_29 10'd149

//RAMADDR
`define UpdateMONITORst03_36 10'd156
`define UpdateMONITORst03_37 10'd157
`define UpdateMONITORst03_38 10'd158
`define UpdateMONITORst03_39 10'd159

//RAMWDATA
`define UpdateMONITORst04_06 10'd166
`define UpdateMONITORst04_07 10'd167
`define UpdateMONITORst04_08 10'd168
`define UpdateMONITORst04_09 10'd169
`define UpdateMONITORst04_10 10'd170
`define UpdateMONITORst04_11 10'd171
`define UpdateMONITORst04_12 10'd172
`define UpdateMONITORst04_13 10'd173

//RAMWEN
`define UpdateMONITORst04_19 10'd179
`define UpdateMONITORst04_20 10'd180

//PC
`define PC3col 6'd3
`define PC3row 5'd0
`define PC2col 6'd4
`define PC2row 5'd0
`define PC1col 6'd5
`define PC1row 5'd0
`define PC0col 6'd6
`define PC0row 5'd0

//ALUY
`define ALUY7col 6'd13
`define ALUY7row 5'd0
`define ALUY6col 6'd14
`define ALUY6row 5'd0
`define ALUY5col 6'd15
`define ALUY5row 5'd0
`define ALUY4col 6'd16
`define ALUY4row 5'd0
`define ALUY3col 6'd17
`define ALUY3row 5'd0
`define ALUY2col 6'd18
`define ALUY2row 5'd0
`define ALUY1col 6'd19
`define ALUY1row 5'd0
`define ALUY0col 6'd20
`define ALUY0row 5'd0

//ALUA
`define ALUA7col 6'd24
`define ALUA7row 5'd0
`define ALUA6col 6'd25
`define ALUA6row 5'd0
`define ALUA5col 6'd26
`define ALUA5row 5'd0
`define ALUA4col 6'd27
`define ALUA4row 5'd0
`define ALUA3col 6'd28
`define ALUA3row 5'd0
`define ALUA2col 6'd29
`define ALUA2row 5'd0
`define ALUA1col 6'd30
`define ALUA1row 5'd0
`define ALUA0col 6'd31
`define ALUA0row 5'd0

//ALUCTRL
`define ALUCTRL0col 6'd38
`define ALUCTRL0row 5'd0

//ALUB
`define ALUB7col 6'd2
`define ALUB7row 5'd1
`define ALUB6col 6'd3
`define ALUB6row 5'd1
`define ALUB5col 6'd4
`define ALUB5row 5'd1
`define ALUB4col 6'd5
`define ALUB4row 5'd1
`define ALUB3col 6'd6
`define ALUB3row 5'd1
`define ALUB2col 6'd7
`define ALUB2row 5'd1
`define ALUB1col 6'd8
`define ALUB1row 5'd1
`define ALUB0col 6'd9
`define ALUB0row 5'd1

//ALUCOMP
`define ALUCOMP0col 6'd16
`define ALUCOMP0row 5'd1

//REGDATA1
`define REGDATA1_7col 6'd24
`define REGDATA1_7row 5'd1
`define REGDATA1_6col 6'd25
`define REGDATA1_6row 5'd1
`define REGDATA1_5col 6'd26
`define REGDATA1_5row 5'd1
`define REGDATA1_4col 6'd27
`define REGDATA1_4row 5'd1
`define REGDATA1_3col 6'd28
`define REGDATA1_3row 5'd1
`define REGDATA1_2col 6'd29
`define REGDATA1_2row 5'd1
`define REGDATA1_1col 6'd30
`define REGDATA1_1row 5'd1
`define REGDATA1_0col 6'd31
`define REGDATA1_0row 5'd1

//REGIDX1
`define REGIDX1_1col 6'd37
`define REGIDX1_1row 5'd1
`define REGIDX1_0col 6'd38
`define REGIDX1_0row 5'd1

//REGDATA2
`define REGDATA2_7col 6'd6
`define REGDATA2_7row 5'd2
`define REGDATA2_6col 6'd7
`define REGDATA2_6row 5'd2
`define REGDATA2_5col 6'd8
`define REGDATA2_5row 5'd2
`define REGDATA2_4col 6'd9
`define REGDATA2_4row 5'd2
`define REGDATA2_3col 6'd10
`define REGDATA2_3row 5'd2
`define REGDATA2_2col 6'd11
`define REGDATA2_2row 5'd2
`define REGDATA2_1col 6'd12
`define REGDATA2_1row 5'd2
`define REGDATA2_0col 6'd13
`define REGDATA2_0row 5'd2

//REGIDX2
`define REGIDX2_1col 6'd19
`define REGIDX2_1row 5'd2
`define REGIDX2_0col 6'd20
`define REGIDX2_0row 5'd2

//REGWDATA
`define REGWDATA_7col 6'd32
`define REGWDATA_7row 5'd2
`define REGWDATA_6col 6'd33
`define REGWDATA_6row 5'd2
`define REGWDATA_5col 6'd34
`define REGWDATA_5row 5'd2
`define REGWDATA_4col 6'd35
`define REGWDATA_4row 5'd2
`define REGWDATA_3col 6'd36
`define REGWDATA_3row 5'd2
`define REGWDATA_2col 6'd37
`define REGWDATA_2row 5'd2
`define REGWDATA_1col 6'd38
`define REGWDATA_1row 5'd2
`define REGWDATA_0col 6'd39
`define REGWDATA_0row 5'd2

//REGWIDX
`define REGWIDX_1col 6'd05
`define REGWIDX_1row 5'd3
`define REGWIDX_0col 6'd06
`define REGWIDX_0row 5'd3

//REGWEN
`define REGWENcol 6'd12
`define REGWENrow 5'd3

//RAMRDATA
`define RAMRDATA_7col 6'd22
`define RAMRDATA_7row 5'd3
`define RAMRDATA_6col 6'd23
`define RAMRDATA_6row 5'd3
`define RAMRDATA_5col 6'd24
`define RAMRDATA_5row 5'd3
`define RAMRDATA_4col 6'd25
`define RAMRDATA_4row 5'd3
`define RAMRDATA_3col 6'd26
`define RAMRDATA_3row 5'd3
`define RAMRDATA_2col 6'd27
`define RAMRDATA_2row 5'd3
`define RAMRDATA_1col 6'd28
`define RAMRDATA_1row 5'd3
`define RAMRDATA_0col 6'd29
`define RAMRDATA_0row 5'd3

//RAMADDR
`define RAMADDR_3col 6'd36
`define RAMADDR_3row 5'd3
`define RAMADDR_2col 6'd37
`define RAMADDR_2row 5'd3
`define RAMADDR_1col 6'd38
`define RAMADDR_1row 5'd3
`define RAMADDR_0col 6'd39
`define RAMADDR_0row 5'd3

//RAMWDATA
`define RAMWDATA_7col 6'd6
`define RAMWDATA_7row 5'd4
`define RAMWDATA_6col 6'd7
`define RAMWDATA_6row 5'd4
`define RAMWDATA_5col 6'd8
`define RAMWDATA_5row 5'd4
`define RAMWDATA_4col 6'd9
`define RAMWDATA_4row 5'd4
`define RAMWDATA_3col 6'd10
`define RAMWDATA_3row 5'd4
`define RAMWDATA_2col 6'd11
`define RAMWDATA_2row 5'd4
`define RAMWDATA_1col 6'd12
`define RAMWDATA_1row 5'd4
`define RAMWDATA_0col 6'd13
`define RAMWDATA_0row 5'd4

//RAMWEN
`define RAMWENcol 6'd19
`define RAMWENrow 5'd4

module	VGA_CHAR_Ctrl	(	//	Read Out Side
						ikey_ascii_D,
						ikey_stroke,
						imVGA_WEN,
						iVGA_CLK,		// 25.175 MHz Clock, rdclock
                                                iCLOCK,                 // CLOCK_CPU
						iPC,
						iALU_Y,
						iALU_A,
						iALU_B,
						iALU_CTRL,
						iALU_COMP,
						iREG_DATA1,
						iREG_IDX1,
						iREG_DATA2,
						iREG_IDX2,
						iREG_WDATA,
						iREG_WIDX,
						iREG_WEN,
						iRAM_ADDR,
						iRAM_RDATA,
						iRAM_WDATA,
						iRAM_WEN,
						oCurrentPosRow,
						oCurrentPosCol,
						oPUT_EN,
						oPUT_DATA,
						oRAM_ADDR,
						oRAM_WDATA,
						oRAM_WEN,

                        iROMmonitorRDAT,
                        oROMmonitorADDR,
						//	Control Signals
						iRST_N);

//	Read Out Side
input	[7:0]		ikey_ascii_D;
input			ikey_stroke;
input			imVGA_WEN;
input			iVGA_CLK;
input			iCLOCK;
input	[11:0]		iPC;
input	[31:0]		iALU_Y;
input	[31:0]		iALU_A;
input	[31:0]		iALU_B;
input	[3:0]		iALU_CTRL;
input	[1:0]		iALU_COMP;
input	[31:0]		iREG_DATA1;
input	[4:0]		iREG_IDX1;
input	[31:0]		iREG_DATA2;
input	[4:0]		iREG_IDX2;
input	[31:0]		iREG_WDATA;
input	[4:0]		iREG_WIDX;
input			iREG_WEN;
input	[12:0]		iRAM_ADDR;
input	[31:0]		iRAM_RDATA;
input	[31:0]		iRAM_WDATA;
input			iRAM_WEN;

output	[4:0]		oCurrentPosRow;
output	[5:0]		oCurrentPosCol;
output			oPUT_EN;
output	[7:0]		oPUT_DATA;
output	[12:0]		oRAM_ADDR;
output	[31:0]		oRAM_WDATA;
output			oRAM_WEN;

input  [31:0] iROMmonitorRDAT;
reg    [31:0] iROMmonitorRDAT_reg;
output [9:0]  oROMmonitorADDR;

//	Control Signals
input				iRST_N;

//	Internal Registers/Wires
reg	[4:0]	CurrentPosRow_reg;
reg	[5:0]	CurrentPosCol_reg;
reg	[4:0]	KeyCurrentPosRow_reg;
reg	[5:0]	KeyCurrentPosCol_reg;
reg		key_stroke_reg;
reg		PUT_EN_reg;
reg     [7:0]   PUT_DATA_reg;
reg     [7:0]   PUT_DATA_tmp;
reg     [3:0]   PUT_DATA_src_tmp;

reg     [7:0]   main_st_reg;
reg     [9:0]   monitor_st_reg;

reg	[11:0]	PC_reg;
reg	[11:0]	iPCd_reg;
reg	[11:0]	iPCdd_reg;

reg	[31:0]	print_ascii_reg;
reg	[31:0]	print_stroke_reg;
reg	[31:0]	current_print_stroke_reg;
reg	[31:0]	scan_stroke_reg;
reg	[31:0]	current_scan_stroke_reg;
reg	[31:0]	scan_req_reg;
reg		imVGA_WEN_reg;
reg	[11:0]	iPC_reg;
reg	[31:0]	iALU_Y_reg;
reg	[31:0]	iALU_A_reg;
reg	[31:0]	iALU_B_reg;
reg	[3:0]	iALU_CTRL_reg;
reg	[1:0]	iALU_COMP_reg;
reg	[31:0]	iREG_DATA1_reg;
reg	[4:0]	iREG_IDX1_reg;
reg	[31:0]	iREG_DATA2_reg;
reg	[4:0]	iREG_IDX2_reg;
reg	[31:0]	iREG_WDATA_reg;
reg	[4:0]	iREG_WIDX_reg;
reg		iREG_WEN_reg;
reg	[12:0]	iRAM_ADDR_reg;
reg	[31:0]	iRAM_RDATA_reg;
reg	[31:0]	iRAM_WDATA_reg;
reg		iRAM_WEN_reg;

  // Registers
  reg [7:0] regs_00;
  reg [7:0] regs_01;
  reg [7:0] regs_02;
  reg [7:0] regs_03;
  reg [7:0] regs_04;
  reg [7:0] regs_05;
  reg [7:0] regs_06;
  reg [7:0] regs_07;
  reg [7:0] regs_08;
  reg [7:0] regs_09;
  reg [7:0] regs_10;
  reg [7:0] regs_11;
  reg [7:0] regs_12;
  reg [7:0] regs_13;
  reg [7:0] regs_14;
  reg [7:0] regs_15;
  reg [7:0] regs_16;
  reg [7:0] regs_17;
  reg [7:0] regs_18;
  reg [7:0] regs_19;
  reg [7:0] regs_20;
  reg [7:0] regs_21;
  reg [7:0] regs_22;
  reg [7:0] regs_23;
  reg [7:0] regs_24;
  reg [7:0] regs_25;
  reg [7:0] regs_26;
  reg [7:0] regs_27;
  reg [7:0] regs_28;
  reg [7:0] regs_29;
  reg [7:0] regs_30;
  reg [7:0] regs_31;
  reg [5:0] reg_idx;

  reg	[12:0]		RAM_ADDR_reg;
  reg	[31:0]		RAM_WDATA_reg;
  reg			RAM_WEN_reg;
  reg   [1:0]           scan_st_reg;

assign	oCurrentPosRow = CurrentPosRow_reg;
assign	oCurrentPosCol = CurrentPosCol_reg;
assign	oPUT_EN = PUT_EN_reg;
//assign	oPUT_DATA = (ikey_ascii_D[5:0] == 6'b111111) ? 8'b00100000 : ikey_ascii_D;
assign	oPUT_DATA = PUT_DATA_reg;

assign oRAM_ADDR  = RAM_ADDR_reg;
assign oRAM_WDATA = RAM_WDATA_reg;
assign oRAM_WEN   = RAM_WEN_reg;

////モニタ処理用命令列を含むROMのアドレス：毎クロック読む
assign oROMmonitorADDR = monitor_st_reg;

always @(posedge iCLOCK or negedge iRST_N) begin
    if (iRST_N == 1'b0) begin
        iPC_reg              <= 12'b000000000000;
        iALU_Y_reg           <= 32'h00000000;
        iALU_A_reg           <= 32'h00000000;
        iALU_B_reg           <= 32'h00000000;
        iALU_CTRL_reg        <= 4'b0000;
        iALU_COMP_reg        <= 2'b00;
        iREG_DATA1_reg       <= 32'h00000000;
        iREG_IDX1_reg        <= 4'b0000;
        iREG_DATA2_reg       <= 32'h00000000;
        iREG_IDX2_reg        <= 4'b0000;
        iREG_WDATA_reg       <= 32'h00000000;
        iREG_WIDX_reg        <= 4'b0000;
        iREG_WEN_reg         <= 1'b0;
        iRAM_ADDR_reg        <= 13'h0000;
        iRAM_RDATA_reg       <= 32'h00000000;
        iRAM_WDATA_reg       <= 32'h00000000;
        iRAM_WEN_reg         <= 1'b0;
    end else begin
        iPC_reg              <= iPC;
        iALU_Y_reg           <= iALU_Y;
        iALU_A_reg           <= iALU_A;
        iALU_B_reg           <= iALU_B;
        iALU_CTRL_reg        <= iALU_CTRL;
        iALU_COMP_reg        <= iALU_COMP;
        iREG_DATA1_reg       <= iREG_DATA1;
        iREG_IDX1_reg        <= iREG_IDX1;
        iREG_DATA2_reg       <= iREG_DATA2;
        iREG_IDX2_reg        <= iREG_IDX2;
        iREG_WDATA_reg       <= iREG_WDATA;
        iREG_WIDX_reg        <= iREG_WIDX;
        iREG_WEN_reg         <= iREG_WEN;
        iRAM_ADDR_reg        <= iRAM_ADDR;
        iRAM_RDATA_reg       <= iRAM_RDATA;
        iRAM_WDATA_reg       <= iRAM_WDATA;
        iRAM_WEN_reg         <= iRAM_WEN;
        iROMmonitorRDAT_reg  <= iROMmonitorRDAT;
    end
end

always @(posedge iVGA_CLK or negedge iRST_N) begin
    if (iRST_N == 1'b0) begin
        CurrentPosCol_reg    <= 6'b000000;
        CurrentPosRow_reg    <= 5'b00000;
        KeyCurrentPosCol_reg <= 6'b000000;
        KeyCurrentPosRow_reg <= 5'b01111;
        key_stroke_reg       <= 1'b0;
        PUT_EN_reg           <= 1'b0;
        PUT_DATA_reg         <= 8'b00000000;
        PC_reg               <= 12'b000000000000;
        iPCd_reg             <= 12'b000000000000;
        iPCdd_reg            <= 12'b000000000000;
        print_ascii_reg          <= 32'h00000000;
        print_stroke_reg         <= 32'h00000000;
        current_print_stroke_reg <= 32'h00000000;
        scan_stroke_reg          <= 32'h00000000;
        current_scan_stroke_reg  <= 32'h00000000;
        scan_st_reg              <= 2'b00;
        regs_00               <= 8'h00;
        regs_01               <= 8'h00;
        regs_02               <= 8'h00;
        regs_03               <= 8'h00;
        regs_04               <= 8'h00;
        regs_05               <= 8'h00;
        regs_06               <= 8'h00;
        regs_07               <= 8'h00;
        regs_08               <= 8'h00;
        regs_09               <= 8'h00;
        regs_10              <= 8'h00;
        regs_11              <= 8'h00;
        regs_12              <= 8'h00;
        regs_13              <= 8'h00;
        regs_14              <= 8'h00;
        regs_15              <= 8'h00;
        regs_16              <= 8'h00;
        regs_17              <= 8'h00;
        regs_18              <= 8'h00;
        regs_19              <= 8'h00;
        regs_20              <= 8'h00;
        regs_21              <= 8'h00;
        regs_22              <= 8'h00;
        regs_23              <= 8'h00;
        regs_24              <= 8'h00;
        regs_25              <= 8'h00;
        regs_26              <= 8'h00;
        regs_27              <= 8'h00;
        regs_28              <= 8'h00;
        regs_29              <= 8'h00;
        regs_30              <= 8'h00;
        regs_31              <= 8'h00;
        reg_idx              <= 6'h00;
        RAM_ADDR_reg         <= 13'h0000;
        RAM_WDATA_reg        <= 32'h00000000;
        RAM_WEN_reg          <= 1'b0;
        imVGA_WEN_reg        <= 1'b0;
        main_st_reg          <= `InitMONITORst;
        monitor_st_reg       <= `InitMONITORst00_00;
    end else begin

    imVGA_WEN_reg <= imVGA_WEN;
    iPCd_reg      <=  iPC_reg;
    iPCdd_reg     <= iPCd_reg;

    if (imVGA_WEN_reg == 1'b1) begin 
    end else begin
        case (main_st_reg)
            `InitMONITORst: begin
                main_st_reg       <= `UpdateMONITORst;
                monitor_st_reg    <= 0;
//                if(PUT_EN_reg == 1'b1) begin
//                    monitor_st_reg <= monitor_st_reg + 1;
//                    PUT_EN_reg     <= 1'b0;
//                end else begin
//                    {CurrentPosCol_reg, CurrentPosRow_reg, PUT_DATA_reg[5:0]} <= iROMmonitorRDAT_reg[17:1]; 
//                    PUT_EN_reg <= 1'b1;
//                end
//                if(monitor_st_reg == `InitMONITORst14_40)begin
//                    //main_st_reg       <= `UpdateMONITORst;
//                    //monitor_st_reg    <= `UpdateMONITORst00_03;
//                    //CurrentPosCol_reg <= 6'd2; CurrentPosRow_reg <= 5'd0;
//                    main_st_reg       <= `InitMONITORst;
//                    monitor_st_reg    <= `InitMONITORst14_40;
//                end 
            end
            `UpdateMONITORst: begin //モニタ上のPC値などアップデートする処理
                if(PUT_EN_reg == 1'b1) begin
                    monitor_st_reg <= monitor_st_reg + 1;
                    PUT_EN_reg     <= 1'b0;
                end else if (monitor_st_reg == 82) begin
                    CurrentPosCol_reg <= KeyCurrentPosCol_reg;
                    CurrentPosRow_reg <= KeyCurrentPosRow_reg;
                    main_st_reg       <= `GetKEYINst;
                end else begin
                    {CurrentPosCol_reg, CurrentPosRow_reg} <= iROMmonitorRDAT_reg[17:7];
                    PUT_DATA_reg[5:0] <= PUT_DATA_tmp;
                    PUT_EN_reg <= 1'b1;
                end
            end
            default: begin // GetKEYINst 
                if ((PC_reg != iPC_reg) && (PUT_EN_reg != 1'b1)
                     && (iPCd_reg == iPC_reg) && (iPCdd_reg == iPC_reg)) begin
                    PC_reg <= iPC_reg;
                    main_st_reg          <= `UpdateMONITORst;
                    monitor_st_reg       <= 0; //`UpdateMONITORst00_03;
                    KeyCurrentPosCol_reg <= CurrentPosCol_reg;
                    KeyCurrentPosRow_reg <= CurrentPosRow_reg;
                    CurrentPosCol_reg    <= 6'd2;
                    CurrentPosRow_reg    <= 5'd0;
                end else begin
                    if ((iRAM_ADDR == `PRINT_ASCII_ADDR) && (iRAM_WEN == `PRINT_ASCII_WEN)) begin
                        print_ascii_reg          <= iRAM_WDATA;
                    end
    
                    if ((iRAM_ADDR == `PRINT_STROKE_ADDR) && (iRAM_WEN == `PRINT_STROKE_WEN)) begin
                        print_stroke_reg         <= iRAM_WDATA;
                        current_print_stroke_reg <= print_stroke_reg;
                    end

                    if ((iRAM_ADDR == `SCAN_STROKE_ADDR) && (iRAM_WEN == `SCAN_STROKE_WEN)) begin
                        scan_stroke_reg         <= iRAM_WDATA;
                        current_scan_stroke_reg <= scan_stroke_reg;
                    end

                    if ((iRAM_ADDR == `SCAN_REQ_ADDR) && (iRAM_WEN == `SCAN_REQ_WEN)) begin
                        scan_req_reg <= iRAM_WDATA;  // iRAM_WDATA = SCAN_ACT or iRAM_WDATA = SCAN_INACT
                    end

                    if ((current_scan_stroke_reg != scan_stroke_reg)
                          && (scan_stroke_reg == 32'h00000001)) begin
                        case (scan_st_reg)
                            `SCANst_SLEEP: begin
                                if (scan_req_reg[0] == `SCAN_ACT) begin
                                    scan_st_reg <= `SCANst_STORE;
                                    reg_idx <= 6'd0;
                                end else begin
                                end
                            end
                            `SCANst_STORE: begin
                                RAM_ADDR_reg  <= `SCAN_ASCII_ADDR;
                                RAM_WEN_reg   <= 1'b1;
                                RAM_WDATA_reg <= `SCAN_ASCII_STORING;
                            end
                            default: begin    // `SCAN_SEND
                                RAM_ADDR_reg <= `SCAN_ASCII_ADDR;
                                RAM_WEN_reg  <= 1'b1;
                                case (reg_idx)
                                    6'd0: begin    RAM_WDATA_reg <= regs_00;    end
                                    6'd1: begin    RAM_WDATA_reg <= regs_01;    end
                                    6'd2: begin    RAM_WDATA_reg <= regs_02;    end
                                    6'd3: begin    RAM_WDATA_reg <= regs_03;    end
                                    6'd4: begin    RAM_WDATA_reg <= regs_04;    end
                                    6'd5: begin    RAM_WDATA_reg <= regs_05;    end
                                    6'd6: begin    RAM_WDATA_reg <= regs_06;    end
                                    6'd7: begin    RAM_WDATA_reg <= regs_07;    end
                                    6'd8: begin    RAM_WDATA_reg <= regs_08;    end
                                    6'd9: begin    RAM_WDATA_reg <= regs_09;    end
                                    6'd10: begin    RAM_WDATA_reg <= regs_10;    end
                                    6'd11: begin    RAM_WDATA_reg <= regs_11;    end
                                    6'd12: begin    RAM_WDATA_reg <= regs_12;    end
                                    6'd13: begin    RAM_WDATA_reg <= regs_13;    end
                                    6'd14: begin    RAM_WDATA_reg <= regs_14;    end
                                    6'd15: begin    RAM_WDATA_reg <= regs_15;    end
                                    6'd16: begin    RAM_WDATA_reg <= regs_16;    end
                                    6'd17: begin    RAM_WDATA_reg <= regs_17;    end
                                    6'd18: begin    RAM_WDATA_reg <= regs_18;    end
                                    6'd19: begin    RAM_WDATA_reg <= regs_19;    end
                                    6'd20: begin    RAM_WDATA_reg <= regs_20;    end
                                    6'd21: begin    RAM_WDATA_reg <= regs_21;    end
                                    6'd22: begin    RAM_WDATA_reg <= regs_22;    end
                                    6'd23: begin    RAM_WDATA_reg <= regs_23;    end
                                    6'd24: begin    RAM_WDATA_reg <= regs_24;    end
                                    6'd25: begin    RAM_WDATA_reg <= regs_25;    end
                                    6'd26: begin    RAM_WDATA_reg <= regs_26;    end
                                    6'd27: begin    RAM_WDATA_reg <= regs_27;    end
                                    6'd28: begin    RAM_WDATA_reg <= regs_28;    end
                                    6'd29: begin    RAM_WDATA_reg <= regs_29;    end
                                    6'd30: begin    RAM_WDATA_reg <= regs_30;    end
                                    default: begin    RAM_WDATA_reg <= regs_31;    end
                                endcase
                                reg_idx <= reg_idx + 1;
                                if (scan_req_reg == `SCAN_INACT) begin
                                    scan_st_reg <= `SCANst_SLEEP;
                                    RAM_ADDR_reg  <= 13'h000;
                                    RAM_WEN_reg   <= 1'b0;
                                    RAM_WDATA_reg <= 32'h00000000;
                                    reg_idx <= 6'd0;
                                end else begin
                                end
                            end
                        endcase
                    end  // End:                if ((current_scan_stroke_reg != scan_stroke_reg)
                         //                          && (scan_stroke_reg == 32'h00000001)) begin


                    if ((key_stroke_reg != ikey_stroke)
                         || ((current_print_stroke_reg != print_stroke_reg)
                              && (print_stroke_reg == 32'h00000001))) begin
                        if (iRAM_ADDR != `PRINT_STROKE_ADDR) begin
                            //
                            // Input from keyboard
                            //
                            PUT_DATA_reg <= ikey_ascii_D;
    
                            key_stroke_reg <= ikey_stroke;
    
                            if (ikey_ascii_D[5:0] == 6'b111111) begin             // Back Space
                                PUT_EN_reg    <= 1'b1;
                                if (CurrentPosCol_reg == 6'b000000) begin
                                    CurrentPosCol_reg <= 6'b100111;
                                    if (CurrentPosRow_reg == 5'b01111) begin
                                        CurrentPosRow_reg <= 5'b11101;
                                    end else begin
                                        CurrentPosRow_reg <= CurrentPosRow_reg - 1;
                                    end
                                end else begin
                                    CurrentPosCol_reg <= CurrentPosCol_reg - 1;
                                end
                            end else if (ikey_ascii_D[5:0] == 6'b111110) begin    // Return
                                PUT_EN_reg <= 1'b1;
                            end else begin
                                PUT_EN_reg <= 1'b1;
                            end

                            if (scan_st_reg == `SCANst_STORE) begin
                                case (reg_idx)
                                    6'd0: begin    regs_00 <= ikey_ascii_D;    end
                                    6'd1: begin    regs_01 <= ikey_ascii_D;    end
                                    6'd2: begin    regs_02 <= ikey_ascii_D;    end
                                    6'd3: begin    regs_03 <= ikey_ascii_D;    end
                                    6'd4: begin    regs_04 <= ikey_ascii_D;    end
                                    6'd5: begin    regs_05 <= ikey_ascii_D;    end
                                    6'd6: begin    regs_06 <= ikey_ascii_D;    end
                                    6'd7: begin    regs_07 <= ikey_ascii_D;    end
                                    6'd8: begin    regs_08 <= ikey_ascii_D;    end
                                    6'd9: begin    regs_09 <= ikey_ascii_D;    end
                                    6'd10: begin    regs_10 <= ikey_ascii_D;    end
                                    6'd11: begin    regs_11 <= ikey_ascii_D;    end
                                    6'd12: begin    regs_12 <= ikey_ascii_D;    end
                                    6'd13: begin    regs_13 <= ikey_ascii_D;    end
                                    6'd14: begin    regs_14 <= ikey_ascii_D;    end
                                    6'd15: begin    regs_15 <= ikey_ascii_D;    end
                                    6'd16: begin    regs_16 <= ikey_ascii_D;    end
                                    6'd17: begin    regs_17 <= ikey_ascii_D;    end
                                    6'd18: begin    regs_18 <= ikey_ascii_D;    end
                                    6'd19: begin    regs_19 <= ikey_ascii_D;    end
                                    6'd20: begin    regs_20 <= ikey_ascii_D;    end
                                    6'd21: begin    regs_21 <= ikey_ascii_D;    end
                                    6'd22: begin    regs_22 <= ikey_ascii_D;    end
                                    6'd23: begin    regs_23 <= ikey_ascii_D;    end
                                    6'd24: begin    regs_24 <= ikey_ascii_D;    end
                                    6'd25: begin    regs_25 <= ikey_ascii_D;    end
                                    6'd26: begin    regs_26 <= ikey_ascii_D;    end
                                    6'd27: begin    regs_27 <= ikey_ascii_D;    end
                                    6'd28: begin    regs_28 <= ikey_ascii_D;    end
                                    6'd29: begin    regs_29 <= ikey_ascii_D;    end
                                    6'd30: begin    regs_30 <= ikey_ascii_D;    end
                                    default: begin    regs_31 <= ikey_ascii_D;    end
                                endcase

                                if (ikey_ascii_D[5:0] == 6'b111111) begin  // Back Space
                                    if (reg_idx != 6'd0) begin
                                        reg_idx <= reg_idx - 1;
                                    end else begin
                                        reg_idx <= 6'd0;
                                    end
                                end else if (ikey_ascii_D[5:0] == 6'b111110) begin    // Return
                                    reg_idx     <= 6'd0;
                                    scan_st_reg <= `SCANst_SEND;
                                end else begin
                                    if (reg_idx == 6'd31) begin
                                        reg_idx <= 6'd0;
                                    end else begin
                                        reg_idx <= reg_idx + 1;
                                    end
                                end
                            end
                        end else begin  // Else: if (iRAM_ADDR != `PRINT_STROKE_ADDR) begin
                            //
                            // Input from CPU
                            //
                            PUT_DATA_reg <= print_ascii_reg[7:0];
    
                            if (print_ascii_reg[5:0] == 6'b111111) begin             // Back Space
                                PUT_EN_reg    <= 1'b1;
                                if (CurrentPosCol_reg == 6'b000000) begin
                                    CurrentPosCol_reg <= 6'b100111;
                                    if (CurrentPosRow_reg == 5'b01111) begin
                                        CurrentPosRow_reg <= 5'b11101;
                                    end else begin
                                        CurrentPosRow_reg <= CurrentPosRow_reg - 1;
                                    end
                                end else begin
                                    CurrentPosCol_reg <= CurrentPosCol_reg - 1;
                                end
                            end else if (print_ascii_reg[5:0] == 6'b111110) begin    // Return
                                PUT_EN_reg <= 1'b1;
                            end else begin
                                PUT_EN_reg <= 1'b1;
                            end
                        end

                    end else begin // Else: if (key_stroke_reg != ikey_stroke) begin
                        if (PUT_EN_reg == 1'b1) begin
                            PUT_EN_reg <= 1'b0;
    
                            if (iRAM_ADDR != `PRINT_STROKE_ADDR) begin
                                //
                                // Input from keyboard
                                //
                                if (ikey_ascii_D[5:0] == 6'b111111) begin             // Back Space
                                end else if (ikey_ascii_D[5:0] == 6'b111110) begin    // Return
                                   CurrentPosCol_reg <= 6'b000000;
                                   if (CurrentPosRow_reg == 5'b11101) begin
                                       CurrentPosRow_reg <= 5'b01111;
                                   end else begin
                                       CurrentPosRow_reg <= CurrentPosRow_reg + 1;
                                   end
                                end else begin
                                    if (CurrentPosCol_reg == 6'b100111) begin
                                        CurrentPosCol_reg <= 6'b000000;
                                        if (CurrentPosRow_reg == 5'b11101) begin
                                            CurrentPosRow_reg <= 5'b01111;
                                        end else begin
                                            CurrentPosRow_reg <= CurrentPosRow_reg + 1;
                                        end
                                    end else begin
                                        CurrentPosCol_reg <= CurrentPosCol_reg + 1;
                                    end
                                end
                            end else begin  // Else: if (iRAM_ADDR != `PRINT_STROKE_ADDR) begin
                                //
                                // Input from CPU
                                //
                                if (print_ascii_reg[5:0] == 6'b111111) begin             // Back Space
                                end else if (print_ascii_reg[5:0] == 6'b111110) begin    // Return
                                   CurrentPosCol_reg <= 6'b000000;
                                   if (CurrentPosRow_reg == 5'b11101) begin
                                       CurrentPosRow_reg <= 5'b01111;
                                   end else begin
                                       CurrentPosRow_reg <= CurrentPosRow_reg + 1;
                                   end
                                end else begin
                                    if (CurrentPosCol_reg == 6'b100111) begin
                                        CurrentPosCol_reg <= 6'b000000;
                                        if (CurrentPosRow_reg == 5'b11101) begin
                                            CurrentPosRow_reg <= 5'b01111;
                                        end else begin
                                            CurrentPosRow_reg <= CurrentPosRow_reg + 1;
                                        end
                                    end else begin
                                        CurrentPosCol_reg <= CurrentPosCol_reg + 1;
                                    end
                                end
                            end
                        end  // End: if (PUT_EN_reg == 1'b1) begin
                    end // End: if (key_stroke_reg != ikey_stroke) begin
                end  // End: if ((PC_reg != iPC_reg) && (PUT_EN_reg != 1'b1)) begin
            end  // End: default:
        endcase
    end  // End: if (imVGA_WEN_reg == 1'b1)
    end
end

always @(posedge iCLOCK or negedge iRST_N) begin
    if (~iRST_N) begin
        PUT_DATA_src_tmp <= 0;
    end else begin

        if(main_st_reg == `UpdateMONITORst) begin
            if (monitor_st_reg == 0) begin  // PC3
                PUT_DATA_src_tmp <= 0;
            end else if (monitor_st_reg == 1) begin  // PC2
                PUT_DATA_src_tmp <= iPC_reg[11:8];
            end else if (monitor_st_reg == 2) begin  // PC1
                PUT_DATA_src_tmp <= iPC_reg[7:4];
            end else if (monitor_st_reg == 3) begin  // PC0
                PUT_DATA_src_tmp <= iPC_reg[3:0];
            end else if (monitor_st_reg == 4) begin  // ALUY7
                PUT_DATA_src_tmp <= iALU_Y_reg[31:28];
            end else if (monitor_st_reg == 5) begin  // ALUY6
                PUT_DATA_src_tmp <= iALU_Y_reg[27:24];
            end else if (monitor_st_reg == 6) begin  // ALUY5
                PUT_DATA_src_tmp <= iALU_Y_reg[23:20];
            end else if (monitor_st_reg == 7) begin  // ALUY4
                PUT_DATA_src_tmp <= iALU_Y_reg[19:16];
            end else if (monitor_st_reg == 8) begin  // ALUY3
                PUT_DATA_src_tmp <= iALU_Y_reg[15:12];
            end else if (monitor_st_reg == 9) begin  // ALUY2
                PUT_DATA_src_tmp <= iALU_Y_reg[11:8];
            end else if (monitor_st_reg == 10) begin  // ALUY1
                PUT_DATA_src_tmp <= iALU_Y_reg[7:4];
            end else if (monitor_st_reg == 11) begin  // ALUY0
                PUT_DATA_src_tmp <= iALU_Y_reg[3:0];
            end else if (monitor_st_reg == 12) begin  // ALUA7
                PUT_DATA_src_tmp <= iALU_A_reg[31:28];
            end else if (monitor_st_reg == 13) begin  // ALUA6
                PUT_DATA_src_tmp <= iALU_A_reg[27:24];
            end else if (monitor_st_reg == 14) begin  // ALUA5
                PUT_DATA_src_tmp <= iALU_A_reg[23:20];
            end else if (monitor_st_reg == 15) begin  // ALUA4
                PUT_DATA_src_tmp <= iALU_A_reg[19:16];
            end else if (monitor_st_reg == 16) begin  // ALUA3
                PUT_DATA_src_tmp <= iALU_A_reg[15:12];
            end else if (monitor_st_reg == 17) begin  // ALUA2
                PUT_DATA_src_tmp <= iALU_A_reg[11:8];
            end else if (monitor_st_reg == 18) begin  // ALUA1
                PUT_DATA_src_tmp <= iALU_A_reg[7:4];
            end else if (monitor_st_reg == 19) begin  // ALUA0
                PUT_DATA_src_tmp <= iALU_A_reg[3:0];
            end else if (monitor_st_reg == 20) begin  // ALUCTRL0
                PUT_DATA_src_tmp <= iALU_CTRL_reg[3:0];
            end else if (monitor_st_reg == 21) begin  // ALUB7
                PUT_DATA_src_tmp <= iALU_B_reg[31:28];
            end else if (monitor_st_reg == 22) begin  // ALUB6
                PUT_DATA_src_tmp <= iALU_B_reg[27:24];
            end else if (monitor_st_reg == 23) begin  // ALUB5
                PUT_DATA_src_tmp <= iALU_B_reg[23:20];
            end else if (monitor_st_reg == 24) begin  // ALUB4
                PUT_DATA_src_tmp <= iALU_B_reg[19:16];
            end else if (monitor_st_reg == 25) begin  // ALUB3
                PUT_DATA_src_tmp <= iALU_B_reg[15:12];
            end else if (monitor_st_reg == 26) begin  // ALUB2
                PUT_DATA_src_tmp <= iALU_B_reg[11:8];
            end else if (monitor_st_reg == 27) begin  // ALUB1
                PUT_DATA_src_tmp <= iALU_B_reg[7:4];
            end else if (monitor_st_reg == 28) begin  // ALUB0
                PUT_DATA_src_tmp <= iALU_B_reg[3:0];
            end else if (monitor_st_reg == 29) begin  // ALUCOMP0
                PUT_DATA_src_tmp <= {2'b00, iALU_COMP_reg[1:0]};
            end else if (monitor_st_reg == 30) begin  // REGDATA1_7
                PUT_DATA_src_tmp <= iREG_DATA1_reg[31:28];
            end else if (monitor_st_reg == 31) begin  // REGDATA1_6
                PUT_DATA_src_tmp <= iREG_DATA1_reg[27:24];
            end else if (monitor_st_reg == 32) begin  // REGDATA1_5
                PUT_DATA_src_tmp <= iREG_DATA1_reg[23:20];
            end else if (monitor_st_reg == 33) begin  // REGDATA1_4
                PUT_DATA_src_tmp <= iREG_DATA1_reg[19:16];
            end else if (monitor_st_reg == 34) begin  // REGDATA1_3
                PUT_DATA_src_tmp <= iREG_DATA1_reg[15:12];
            end else if (monitor_st_reg == 35) begin  // REGDATA1_2
                PUT_DATA_src_tmp <= iREG_DATA1_reg[11:8];
            end else if (monitor_st_reg == 36) begin  // REGDATA1_1
                PUT_DATA_src_tmp <= iREG_DATA1_reg[7:4];
            end else if (monitor_st_reg == 37) begin  // REGDATA1_0
                PUT_DATA_src_tmp <= iREG_DATA1_reg[3:0];
            end else if (monitor_st_reg == 38) begin  // REGIDX1_1
                PUT_DATA_src_tmp <= {3'b000, iREG_IDX1_reg[4]};
            end else if (monitor_st_reg == 39) begin  // REGIDX1_0
                PUT_DATA_src_tmp <= iREG_IDX1_reg[3:0];
            end else if (monitor_st_reg == 40) begin  // REGDATA2_7
                PUT_DATA_src_tmp <= iREG_DATA2_reg[31:28];
            end else if (monitor_st_reg == 41) begin  // REGDATA2_6
                PUT_DATA_src_tmp <= iREG_DATA2_reg[27:24];
            end else if (monitor_st_reg == 42) begin  // REGDATA2_5
                PUT_DATA_src_tmp <= iREG_DATA2_reg[23:20];
            end else if (monitor_st_reg == 43) begin  // REGDATA2_4
                PUT_DATA_src_tmp <= iREG_DATA2_reg[19:16];
            end else if (monitor_st_reg == 44) begin  // REGDATA2_3
                PUT_DATA_src_tmp <= iREG_DATA2_reg[15:12];
            end else if (monitor_st_reg == 45) begin  // REGDATA2_2
                PUT_DATA_src_tmp <= iREG_DATA2_reg[11:8];
            end else if (monitor_st_reg == 46) begin  // REGDATA2_1
                PUT_DATA_src_tmp <= iREG_DATA2_reg[7:4];
            end else if (monitor_st_reg == 47) begin  // REGDATA2_0
                PUT_DATA_src_tmp <= iREG_DATA2_reg[3:0];
            end else if (monitor_st_reg == 48) begin  // REGIDX2_1
                PUT_DATA_src_tmp <= {3'b000, iREG_IDX2_reg[4]};
            end else if (monitor_st_reg == 49) begin  // REGIDX2_0
                PUT_DATA_src_tmp <= iREG_IDX2_reg[3:0];
            end else if (monitor_st_reg == 50) begin  // REGWDATA_7
                PUT_DATA_src_tmp <= iREG_WDATA_reg[31:28];
            end else if (monitor_st_reg == 51) begin  // REGWDATA_6
                PUT_DATA_src_tmp <= iREG_WDATA_reg[27:24];
            end else if (monitor_st_reg == 52) begin  // REGWDATA_5
                PUT_DATA_src_tmp <= iREG_WDATA_reg[23:20];
            end else if (monitor_st_reg == 53) begin  // REGWDATA_4
                PUT_DATA_src_tmp <= iREG_WDATA_reg[19:16];
            end else if (monitor_st_reg == 54) begin  // REGWDATA_3
                PUT_DATA_src_tmp <= iREG_WDATA_reg[15:12];
            end else if (monitor_st_reg == 55) begin  // REGWDATA_2
                PUT_DATA_src_tmp <= iREG_WDATA_reg[11:8];
            end else if (monitor_st_reg == 56) begin  // REGWDATA_1
                PUT_DATA_src_tmp <= iREG_WDATA_reg[7:4];
            end else if (monitor_st_reg == 57) begin  // REGWDATA_0
                PUT_DATA_src_tmp <= iREG_WDATA_reg[3:0];
            end else if (monitor_st_reg == 58) begin  // REGWIDX_1
                PUT_DATA_src_tmp <= {3'b000, iREG_WIDX_reg[4]};
            end else if (monitor_st_reg == 59) begin  // REGWIDX_0
                PUT_DATA_src_tmp <= iREG_WIDX_reg[3:0];
            end else if (monitor_st_reg == 60) begin  // REGWEN
                PUT_DATA_src_tmp <= {3'b000, iREG_WEN_reg};
            end else if (monitor_st_reg == 61) begin  // RAMRDATA_7
                PUT_DATA_src_tmp <= iRAM_RDATA_reg[31:28];
            end else if (monitor_st_reg == 62) begin  // RAMRDATA_6
                PUT_DATA_src_tmp <= iRAM_RDATA_reg[27:24];
            end else if (monitor_st_reg == 63) begin  // RAMRDATA_5
                PUT_DATA_src_tmp <= iRAM_RDATA_reg[23:20];
            end else if (monitor_st_reg == 64) begin  // RAMRDATA_4
                PUT_DATA_src_tmp <= iRAM_RDATA_reg[19:16];
            end else if (monitor_st_reg == 65) begin  // RAMRDATA_3
                PUT_DATA_src_tmp <= iRAM_RDATA_reg[15:12];
            end else if (monitor_st_reg == 66) begin  // RAMRDATA_2
                PUT_DATA_src_tmp <= iRAM_RDATA_reg[11:8];
            end else if (monitor_st_reg == 67) begin  // RAMRDATA_1
                PUT_DATA_src_tmp <= iRAM_RDATA_reg[7:4];
            end else if (monitor_st_reg == 68) begin  // RAMRDATA_0
                PUT_DATA_src_tmp <= iRAM_RDATA_reg[3:0];
            end else if (monitor_st_reg == 69) begin  // RAMADDR_3
                PUT_DATA_src_tmp <= {3'b000, iRAM_ADDR_reg[12]};
            end else if (monitor_st_reg == 70) begin  // RAMADDR_2
                PUT_DATA_src_tmp <= iRAM_ADDR_reg[11:8];
            end else if (monitor_st_reg == 71) begin  // RAMADDR_1
                PUT_DATA_src_tmp <= iRAM_ADDR_reg[7:4];
            end else if (monitor_st_reg == 72) begin  // RAMADDR_0
                PUT_DATA_src_tmp <= iRAM_ADDR_reg[3:0];
            end else if (monitor_st_reg == 73) begin  // RAMWDATA_7
                PUT_DATA_src_tmp <= iRAM_WDATA_reg[31:28];
            end else if (monitor_st_reg == 74) begin  // RAMWDATA_6
                PUT_DATA_src_tmp <= iRAM_WDATA_reg[27:24];
            end else if (monitor_st_reg == 75) begin  // RAMWDATA_5
                PUT_DATA_src_tmp <= iRAM_WDATA_reg[23:20];
            end else if (monitor_st_reg == 76) begin  // RAMWDATA_4
                PUT_DATA_src_tmp <= iRAM_WDATA_reg[19:16];
            end else if (monitor_st_reg == 77) begin  // RAMWDATA_3
                PUT_DATA_src_tmp <= iRAM_WDATA_reg[15:12];
            end else if (monitor_st_reg == 78) begin  // RAMWDATA_2
                PUT_DATA_src_tmp <= iRAM_WDATA_reg[11:8];
            end else if (monitor_st_reg == 79) begin  // RAMWDATA_1
                PUT_DATA_src_tmp <= iRAM_WDATA_reg[7:4];
            end else if (monitor_st_reg == 80) begin  // RAMWDATA_0
                PUT_DATA_src_tmp <= iRAM_WDATA_reg[3:0];
            end else if (monitor_st_reg == 81) begin  // RAMWEN
                PUT_DATA_src_tmp <= {3'b000, iRAM_WEN_reg};
            end else begin
                PUT_DATA_src_tmp <= 4'b1111;
            end
        end else begin
            PUT_DATA_src_tmp <= 4'b1111;
        end
    end
end

//always @(CurrentPosCol_reg or CurrentPosRow_reg
//        or iPC_reg or iALU_Y_reg or iALU_A_reg or iALU_B_reg or iALU_CTRL_reg or iALU_COMP_reg
//        or iREG_DATA1_reg or iREG_IDX1_reg or iREG_DATA2_reg or iREG_IDX2_reg
//        or iREG_WDATA_reg or iREG_WIDX_reg or iREG_WEN_reg) begin
//    if (CurrentPosCol_reg == 6'd2 && CurrentPosRow_reg == 5'd0) begin  // PC3
//        PUT_DATA_src_tmp = 0;
//    end else if (CurrentPosCol_reg == `PC3col && CurrentPosRow_reg == `PC3row) begin  // PC2
//        PUT_DATA_src_tmp = iPC_reg[11:8];
//    end else if (CurrentPosCol_reg == `PC2col && CurrentPosRow_reg == `PC2row) begin  // PC1
//        PUT_DATA_src_tmp = iPC_reg[7:4];
//    end else if (CurrentPosCol_reg == `PC1col && CurrentPosRow_reg == `PC1row) begin  // PC0
//        PUT_DATA_src_tmp = iPC_reg[3:0];
//    end else if ((CurrentPosCol_reg == 6'd12 && CurrentPosRow_reg == 5'd0)
//            || (CurrentPosCol_reg == `PC0col && CurrentPosRow_reg == `PC0row)) begin  // ALUY7
//        PUT_DATA_src_tmp = iALU_Y_reg[31:28];
//    end else if (CurrentPosCol_reg == `ALUY7col && CurrentPosRow_reg == `ALUY7row) begin  // ALUY6
//        PUT_DATA_src_tmp = iALU_Y_reg[27:24];
//    end else if (CurrentPosCol_reg == `ALUY6col && CurrentPosRow_reg == `ALUY6row) begin  // ALUY5
//        PUT_DATA_src_tmp = iALU_Y_reg[23:20];
//    end else if (CurrentPosCol_reg == `ALUY5col && CurrentPosRow_reg == `ALUY5row) begin  // ALUY4
//        PUT_DATA_src_tmp = iALU_Y_reg[19:16];
//    end else if (CurrentPosCol_reg == `ALUY4col && CurrentPosRow_reg == `ALUY4row) begin  // ALUY3
//        PUT_DATA_src_tmp = iALU_Y_reg[15:12];
//    end else if (CurrentPosCol_reg == `ALUY3col && CurrentPosRow_reg == `ALUY3row) begin  // ALUY2
//        PUT_DATA_src_tmp = iALU_Y_reg[11:8];
//    end else if (CurrentPosCol_reg == `ALUY2col && CurrentPosRow_reg == `ALUY2row) begin  // ALUY1
//        PUT_DATA_src_tmp = iALU_Y_reg[7:4];
//    end else if (CurrentPosCol_reg == `ALUY1col && CurrentPosRow_reg == `ALUY1row) begin  // ALUY0
//        PUT_DATA_src_tmp = iALU_Y_reg[3:0];
//    end else if ((CurrentPosCol_reg == 6'd23 && CurrentPosRow_reg == 5'd0)
//            || (CurrentPosCol_reg == `ALUY0col && CurrentPosRow_reg == `ALUY0row)) begin  // ALUA7
//        PUT_DATA_src_tmp = iALU_A_reg[31:28];
//    end else if (CurrentPosCol_reg == `ALUA7col && CurrentPosRow_reg == `ALUA7row) begin  // ALUA6
//        PUT_DATA_src_tmp = iALU_A_reg[27:24];
//    end else if (CurrentPosCol_reg == `ALUA6col && CurrentPosRow_reg == `ALUA6row) begin  // ALUA5
//        PUT_DATA_src_tmp = iALU_A_reg[23:20];
//    end else if (CurrentPosCol_reg == `ALUA5col && CurrentPosRow_reg == `ALUA5row) begin  // ALUA4
//        PUT_DATA_src_tmp = iALU_A_reg[19:16];
//    end else if (CurrentPosCol_reg == `ALUA4col && CurrentPosRow_reg == `ALUA4row) begin  // ALUA3
//        PUT_DATA_src_tmp = iALU_A_reg[15:12];
//    end else if (CurrentPosCol_reg == `ALUA3col && CurrentPosRow_reg == `ALUA3row) begin  // ALUA2
//        PUT_DATA_src_tmp = iALU_A_reg[11:8];
//    end else if (CurrentPosCol_reg == `ALUA2col && CurrentPosRow_reg == `ALUA2row) begin  // ALUA1
//        PUT_DATA_src_tmp = iALU_A_reg[7:4];
//    end else if (CurrentPosCol_reg == `ALUA1col && CurrentPosRow_reg == `ALUA1row) begin  // ALUA0
//        PUT_DATA_src_tmp = iALU_A_reg[3:0];
//    end else if ((CurrentPosCol_reg == 6'd37 && CurrentPosRow_reg == 5'd0)
//            || (CurrentPosCol_reg == `ALUA0col && CurrentPosRow_reg == `ALUA0row)) begin  // ALUCTRL0
//        PUT_DATA_src_tmp = iALU_CTRL_reg[3:0];
//    end else if ((CurrentPosCol_reg == 6'd1 && CurrentPosRow_reg == 5'd1)
//            || (CurrentPosCol_reg == `ALUCTRL0col && CurrentPosRow_reg == `ALUCTRL0row)) begin  // ALUB7
//        PUT_DATA_src_tmp = iALU_B_reg[31:28];
//    end else if (CurrentPosCol_reg == `ALUB7col && CurrentPosRow_reg == `ALUB7row) begin  // ALUB6
//        PUT_DATA_src_tmp = iALU_B_reg[27:24];
//    end else if (CurrentPosCol_reg == `ALUB6col && CurrentPosRow_reg == `ALUB6row) begin  // ALUB5
//        PUT_DATA_src_tmp = iALU_B_reg[23:20];
//    end else if (CurrentPosCol_reg == `ALUB5col && CurrentPosRow_reg == `ALUB5row) begin  // ALUB4
//        PUT_DATA_src_tmp = iALU_B_reg[19:16];
//    end else if (CurrentPosCol_reg == `ALUB4col && CurrentPosRow_reg == `ALUB4row) begin  // ALUB3
//        PUT_DATA_src_tmp = iALU_B_reg[15:12];
//    end else if (CurrentPosCol_reg == `ALUB3col && CurrentPosRow_reg == `ALUB3row) begin  // ALUB2
//        PUT_DATA_src_tmp = iALU_B_reg[11:8];
//    end else if (CurrentPosCol_reg == `ALUB2col && CurrentPosRow_reg == `ALUB2row) begin  // ALUB1
//        PUT_DATA_src_tmp = iALU_B_reg[7:4];
//    end else if (CurrentPosCol_reg == `ALUB1col && CurrentPosRow_reg == `ALUB1row) begin  // ALUB0
//        PUT_DATA_src_tmp = iALU_B_reg[3:0];
//    end else if ((CurrentPosCol_reg == 6'd15 && CurrentPosRow_reg == 5'd1)
//            || (CurrentPosCol_reg == `ALUB0col && CurrentPosRow_reg == `ALUB0row)) begin  // ALUCOMP0
//        PUT_DATA_src_tmp = {2'b00, iALU_COMP_reg[1:0]};
//    end else if ((CurrentPosCol_reg == 6'd23 && CurrentPosRow_reg == 5'd1)
//            || (CurrentPosCol_reg == `ALUCOMP0col && CurrentPosRow_reg == `ALUCOMP0row)) begin  // REGDATA1_7
//        PUT_DATA_src_tmp = iREG_DATA1_reg[31:28];
//    end else if (CurrentPosCol_reg == `REGDATA1_7col && CurrentPosRow_reg == `REGDATA1_7row) begin  // REGDATA1_6
//        PUT_DATA_src_tmp = iREG_DATA1_reg[27:24];
//    end else if (CurrentPosCol_reg == `REGDATA1_6col && CurrentPosRow_reg == `REGDATA1_6row) begin  // REGDATA1_5
//        PUT_DATA_src_tmp = iREG_DATA1_reg[23:20];
//    end else if (CurrentPosCol_reg == `REGDATA1_5col && CurrentPosRow_reg == `REGDATA1_5row) begin  // REGDATA1_4
//        PUT_DATA_src_tmp = iREG_DATA1_reg[19:16];
//    end else if (CurrentPosCol_reg == `REGDATA1_4col && CurrentPosRow_reg == `REGDATA1_4row) begin  // REGDATA1_3
//        PUT_DATA_src_tmp = iREG_DATA1_reg[15:12];
//    end else if (CurrentPosCol_reg == `REGDATA1_3col && CurrentPosRow_reg == `REGDATA1_3row) begin  // REGDATA1_2
//        PUT_DATA_src_tmp = iREG_DATA1_reg[11:8];
//    end else if (CurrentPosCol_reg == `REGDATA1_2col && CurrentPosRow_reg == `REGDATA1_2row) begin  // REGDATA1_1
//        PUT_DATA_src_tmp = iREG_DATA1_reg[7:4];
//    end else if (CurrentPosCol_reg == `REGDATA1_1col && CurrentPosRow_reg == `REGDATA1_1row) begin  // REGDATA1_0
//        PUT_DATA_src_tmp = iREG_DATA1_reg[3:0];
//    end else if ((CurrentPosCol_reg == 6'd36 && CurrentPosRow_reg == 5'd1)
//            || (CurrentPosCol_reg == `REGDATA1_0col && CurrentPosRow_reg == `REGDATA1_0row)) begin  // REGIDX1_1
//        PUT_DATA_src_tmp = {3'b000, iREG_IDX1_reg[4]};
//    end else if (CurrentPosCol_reg == `REGIDX1_1col && CurrentPosRow_reg == `REGIDX1_1row) begin  // REGIDX1_0
//        PUT_DATA_src_tmp = iREG_IDX1_reg[3:0];
//    end else if ((CurrentPosCol_reg == 6'd5 && CurrentPosRow_reg == 5'd2)
//            || (CurrentPosCol_reg == `REGIDX1_0col && CurrentPosRow_reg == `REGIDX1_0row)) begin  // REGDATA2_7
//        PUT_DATA_src_tmp = iREG_DATA2_reg[31:28];
//    end else if (CurrentPosCol_reg == `REGDATA2_7col && CurrentPosRow_reg == `REGDATA2_7row) begin  // REGDATA2_6
//        PUT_DATA_src_tmp = iREG_DATA2_reg[27:24];
//    end else if (CurrentPosCol_reg == `REGDATA2_6col && CurrentPosRow_reg == `REGDATA2_6row) begin  // REGDATA2_5
//        PUT_DATA_src_tmp = iREG_DATA2_reg[23:20];
//    end else if (CurrentPosCol_reg == `REGDATA2_5col && CurrentPosRow_reg == `REGDATA2_5row) begin  // REGDATA2_4
//        PUT_DATA_src_tmp = iREG_DATA2_reg[19:16];
//    end else if (CurrentPosCol_reg == `REGDATA2_4col && CurrentPosRow_reg == `REGDATA2_4row) begin  // REGDATA2_3
//        PUT_DATA_src_tmp = iREG_DATA2_reg[15:12];
//    end else if (CurrentPosCol_reg == `REGDATA2_3col && CurrentPosRow_reg == `REGDATA2_3row) begin  // REGDATA2_2
//        PUT_DATA_src_tmp = iREG_DATA2_reg[11:8];
//    end else if (CurrentPosCol_reg == `REGDATA2_2col && CurrentPosRow_reg == `REGDATA2_2row) begin  // REGDATA2_1
//        PUT_DATA_src_tmp = iREG_DATA2_reg[7:4];
//    end else if (CurrentPosCol_reg == `REGDATA2_1col && CurrentPosRow_reg == `REGDATA2_1row) begin  // REGDATA2_0
//        PUT_DATA_src_tmp = iREG_DATA2_reg[3:0];
//    end else if ((CurrentPosCol_reg == 6'd18 && CurrentPosRow_reg == 5'd2)
//            || (CurrentPosCol_reg == `REGDATA2_0col && CurrentPosRow_reg == `REGDATA2_0row)) begin  // REGIDX2_1
//        PUT_DATA_src_tmp = {3'b000, iREG_IDX2_reg[4]};
//    end else if (CurrentPosCol_reg == `REGIDX2_1col && CurrentPosRow_reg == `REGIDX2_1row) begin  // REGIDX2_0
//        PUT_DATA_src_tmp = iREG_IDX2_reg[3:0];
//    end else if ((CurrentPosCol_reg == 6'd31 && CurrentPosRow_reg == 5'd2)
//            || (CurrentPosCol_reg == `REGIDX2_0col && CurrentPosRow_reg == `REGIDX2_0row)) begin  // REGWDATA_7
//        PUT_DATA_src_tmp = iREG_WDATA_reg[31:28];
//    end else if (CurrentPosCol_reg == `REGWDATA_7col && CurrentPosRow_reg == `REGWDATA_7row) begin  // REGWDATA_6
//        PUT_DATA_src_tmp = iREG_WDATA_reg[27:24];
//    end else if (CurrentPosCol_reg == `REGWDATA_6col && CurrentPosRow_reg == `REGWDATA_6row) begin  // REGWDATA_5
//        PUT_DATA_src_tmp = iREG_WDATA_reg[23:20];
//    end else if (CurrentPosCol_reg == `REGWDATA_5col && CurrentPosRow_reg == `REGWDATA_5row) begin  // REGWDATA_4
//        PUT_DATA_src_tmp = iREG_WDATA_reg[19:16];
//    end else if (CurrentPosCol_reg == `REGWDATA_4col && CurrentPosRow_reg == `REGWDATA_4row) begin  // REGWDATA_3
//        PUT_DATA_src_tmp = iREG_WDATA_reg[15:12];
//    end else if (CurrentPosCol_reg == `REGWDATA_3col && CurrentPosRow_reg == `REGWDATA_3row) begin  // REGWDATA_2
//        PUT_DATA_src_tmp = iREG_WDATA_reg[11:8];
//    end else if (CurrentPosCol_reg == `REGWDATA_2col && CurrentPosRow_reg == `REGWDATA_2row) begin  // REGWDATA_1
//        PUT_DATA_src_tmp = iREG_WDATA_reg[7:4];
//    end else if (CurrentPosCol_reg == `REGWDATA_1col && CurrentPosRow_reg == `REGWDATA_1row) begin  // REGWDATA_0
//        PUT_DATA_src_tmp = iREG_WDATA_reg[3:0];
//    end else if ((CurrentPosCol_reg == 6'd4 && CurrentPosRow_reg == 5'd3)
//            || (CurrentPosCol_reg == `REGWDATA_0col && CurrentPosRow_reg == `REGWDATA_0row)) begin  // REGWIDX_1
//        PUT_DATA_src_tmp = {3'b000, iREG_WIDX_reg[4]};
//    end else if (CurrentPosCol_reg == `REGWIDX_1col && CurrentPosRow_reg == `REGWIDX_1row) begin  // REGWIDX_0
//        PUT_DATA_src_tmp = iREG_WIDX_reg[3:0];
//    end else if ((CurrentPosCol_reg == 6'd11 && CurrentPosRow_reg == 5'd3)
//            || (CurrentPosCol_reg == `REGWIDX_0col && CurrentPosRow_reg == `REGWIDX_0row)) begin  // REGWEN
//        PUT_DATA_src_tmp = {3'b000, iREG_WEN_reg};
//    end else if ((CurrentPosCol_reg == 6'd21 && CurrentPosRow_reg == 5'd3)
//            || (CurrentPosCol_reg == `REGWENcol && CurrentPosRow_reg == `REGWENrow)) begin  // RAMRDATA_7
//        PUT_DATA_src_tmp = iRAM_RDATA_reg[31:28];
//    end else if (CurrentPosCol_reg == `RAMRDATA_7col && CurrentPosRow_reg == `RAMRDATA_7row) begin  // RAMRDATA_6
//        PUT_DATA_src_tmp = iRAM_RDATA_reg[27:24];
//    end else if (CurrentPosCol_reg == `RAMRDATA_6col && CurrentPosRow_reg == `RAMRDATA_6row) begin  // RAMRDATA_5
//        PUT_DATA_src_tmp = iRAM_RDATA_reg[23:20];
//    end else if (CurrentPosCol_reg == `RAMRDATA_5col && CurrentPosRow_reg == `RAMRDATA_5row) begin  // RAMRDATA_4
//        PUT_DATA_src_tmp = iRAM_RDATA_reg[19:16];
//    end else if (CurrentPosCol_reg == `RAMRDATA_4col && CurrentPosRow_reg == `RAMRDATA_4row) begin  // RAMRDATA_3
//        PUT_DATA_src_tmp = iRAM_RDATA_reg[15:12];
//    end else if (CurrentPosCol_reg == `RAMRDATA_3col && CurrentPosRow_reg == `RAMRDATA_3row) begin  // RAMRDATA_2
//        PUT_DATA_src_tmp = iRAM_RDATA_reg[11:8];
//    end else if (CurrentPosCol_reg == `RAMRDATA_2col && CurrentPosRow_reg == `RAMRDATA_2row) begin  // RAMRDATA_1
//        PUT_DATA_src_tmp = iRAM_RDATA_reg[7:4];
//    end else if (CurrentPosCol_reg == `RAMRDATA_1col && CurrentPosRow_reg == `RAMRDATA_1row) begin  // RAMRDATA_0
//        PUT_DATA_src_tmp = iRAM_RDATA_reg[3:0];
//    end else if ((CurrentPosCol_reg == 6'd35 && CurrentPosRow_reg == 5'd3)
//            || (CurrentPosCol_reg == `RAMRDATA_0col && CurrentPosRow_reg == `RAMRDATA_0row)) begin  // RAMADDR_3
//        PUT_DATA_src_tmp = {3'b000, iRAM_ADDR_reg[12]};
//    end else if (CurrentPosCol_reg == `RAMADDR_3col && CurrentPosRow_reg == `RAMADDR_3row) begin  // RAMADDR_2
//        PUT_DATA_src_tmp = iRAM_ADDR_reg[11:8];
//    end else if (CurrentPosCol_reg == `RAMADDR_2col && CurrentPosRow_reg == `RAMADDR_2row) begin  // RAMADDR_1
//        PUT_DATA_src_tmp = iRAM_ADDR_reg[7:4];
//    end else if (CurrentPosCol_reg == `RAMADDR_1col && CurrentPosRow_reg == `RAMADDR_1row) begin  // RAMADDR_0
//        PUT_DATA_src_tmp = iRAM_ADDR_reg[3:0];
//    end else if ((CurrentPosCol_reg == 6'd5 && CurrentPosRow_reg == 5'd4)
//            || (CurrentPosCol_reg == `RAMADDR_0col && CurrentPosRow_reg == `RAMADDR_0row)) begin  // RAMWDATA_7
//        PUT_DATA_src_tmp = iRAM_WDATA_reg[31:28];
//    end else if (CurrentPosCol_reg == `RAMWDATA_7col && CurrentPosRow_reg == `RAMWDATA_7row) begin  // RAMWDATA_6
//        PUT_DATA_src_tmp = iRAM_WDATA_reg[27:24];
//    end else if (CurrentPosCol_reg == `RAMWDATA_6col && CurrentPosRow_reg == `RAMWDATA_6row) begin  // RAMWDATA_5
//        PUT_DATA_src_tmp = iRAM_WDATA_reg[23:20];
//    end else if (CurrentPosCol_reg == `RAMWDATA_5col && CurrentPosRow_reg == `RAMWDATA_5row) begin  // RAMWDATA_4
//        PUT_DATA_src_tmp = iRAM_WDATA_reg[19:16];
//    end else if (CurrentPosCol_reg == `RAMWDATA_4col && CurrentPosRow_reg == `RAMWDATA_4row) begin  // RAMWDATA_3
//        PUT_DATA_src_tmp = iRAM_WDATA_reg[15:12];
//    end else if (CurrentPosCol_reg == `RAMWDATA_3col && CurrentPosRow_reg == `RAMWDATA_3row) begin  // RAMWDATA_2
//        PUT_DATA_src_tmp = iRAM_WDATA_reg[11:8];
//    end else if (CurrentPosCol_reg == `RAMWDATA_2col && CurrentPosRow_reg == `RAMWDATA_2row) begin  // RAMWDATA_1
//        PUT_DATA_src_tmp = iRAM_WDATA_reg[7:4];
//    end else if (CurrentPosCol_reg == `RAMWDATA_1col && CurrentPosRow_reg == `RAMWDATA_1row) begin  // RAMWDATA_0
//        PUT_DATA_src_tmp = iRAM_WDATA_reg[3:0];
//    end else if ((CurrentPosCol_reg == 6'd18 && CurrentPosRow_reg == 5'd4)
//            || (CurrentPosCol_reg == `RAMWDATA_0col && CurrentPosRow_reg == `RAMWDATA_0row)) begin  // RAMWEN
//        PUT_DATA_src_tmp = {3'b000, iRAM_WEN_reg};
//    end else begin
//        PUT_DATA_src_tmp = 4'b1111;
//    end
//end

always @(PUT_DATA_src_tmp) begin
    case (PUT_DATA_src_tmp)
        4'h0: begin    PUT_DATA_tmp = 8'o60;    end  // 0
        4'h1: begin    PUT_DATA_tmp = 8'o61;    end  // 1
        4'h2: begin    PUT_DATA_tmp = 8'o62;    end  // 2
        4'h3: begin    PUT_DATA_tmp = 8'o63;    end  // 3
        4'h4: begin    PUT_DATA_tmp = 8'o64;    end  // 4
        4'h5: begin    PUT_DATA_tmp = 8'o65;    end  // 5
        4'h6: begin    PUT_DATA_tmp = 8'o66;    end  // 6
        4'h7: begin    PUT_DATA_tmp = 8'o67;    end  // 7
        4'h8: begin    PUT_DATA_tmp = 8'o70;    end  // 8
        4'h9: begin    PUT_DATA_tmp = 8'o71;    end  // 9
        4'hA: begin    PUT_DATA_tmp = 8'o01;    end  // A
        4'hB: begin    PUT_DATA_tmp = 8'o02;    end  // B
        4'hC: begin    PUT_DATA_tmp = 8'o03;    end  // C
        4'hD: begin    PUT_DATA_tmp = 8'o04;    end  // D
        4'hE: begin    PUT_DATA_tmp = 8'o05;    end  // E
        default:  // 4'hF:
            begin    PUT_DATA_tmp = 8'o06;    end  // F
    endcase
end

assign o_RAM_ADDR  = RAM_ADDR_reg;
assign o_RAM_WDATA = RAM_WDATA_reg;
assign o_RAM_WEN   = RAM_WEN_reg;

endmodule
