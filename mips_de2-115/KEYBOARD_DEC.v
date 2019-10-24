module	KEYBOARD_DEC (	//	Host Side
					iClock, iReset_N,
					//	Keyboard Side
					iKeyboard_DATA, iKeyboard_CLOCK,
					//	Host Side
					oKey_data_D, oKey_parity_D, oKey_stopbit_D, oKey_ascii_D, oKey_stroke	);
//	Host Side
input			iClock, iReset_N;
//	Keyboard Side
input			iKeyboard_DATA, iKeyboard_CLOCK;
//	Host Side
output	[7:0]		oKey_data_D;
output			oKey_parity_D;
output			oKey_stopbit_D;
output	[7:0]		oKey_ascii_D;
output			oKey_stroke;

//	Internal Wires/Registers
wire	[7:0]		rom_address;
wire	[5:0]		rom_out_data;
wire	[5:0]		key_ascii;
wire			parityok;
// reg	[14:0]		cntclk;			// stop_getkey_proc
// reg			stop_getkey;		// stop_getkey_proc
reg	[7:0]		filter;			// filter_proc
reg			keyboard_clk_filt;	// filter_proc
reg			start;			// k_data_proc
reg	[3:0]		cnt;			// k_data_proc
reg	[3:0]		cnter;			// k_data_proc
reg	[9:0]		k_data;			// k_data_proc
reg			receive_key;		// k_data_proc
reg			tmp_stroke;		// main_proc
reg	[5:0]		key_ascii_reg;		// main_proc
reg			parity_reg;		// main_proc
reg			stopbit_reg;		// main_proc
reg			shift_key;		// main_proc
reg			cur_key;		// main_proc
reg			break_code;		// main_proc

// stop_getkey_proc
// always@(posedge iClock or negedge iReset_N)
// begin
//   if (iReset_N == 1'b0) begin
//     cntclk      <= 15'b000000000000000;
//     stop_getkey <= 1'b0;
//   end else begin
//     if (start == 1'b0 || cnt == 4'b0000) begin
//       cntclk      <= 15'b000000000000000;
//       stop_getkey <= 1'b0;
//     end else begin
//       cntclk <= cntclk + 15'b000000000000001;
//       if (cntclk == 15'b100111010000100) begin
//         stop_getkey <= 1'b1;
//       end
//     end
//   end
// end
// End: stop_getkey_proc

// filter_proc
always@(posedge iClock or negedge iReset_N)
begin
  if (iReset_N == 1'b0) begin
    filter      <= 8'b00000000;
    keyboard_clk_filt <= 1'b0;
  end else begin
    filter[6:0] <= filter[7:1];
    filter[7] <= iKeyboard_CLOCK;
    if (filter == 8'b11111111) begin
      keyboard_clk_filt <= 1'b1;
    end else if (filter == 8'b0000) begin
      keyboard_clk_filt <= 1'b0;
    end
  end
end
// End: filter_proc

// k_data_proc
always@(negedge keyboard_clk_filt or negedge iReset_N)
begin
  if (iReset_N == 1'b0) begin
    start       <= 1'b0;
    cnter       <= 4'b0000;
    cnt         <= 4'b0000;
    k_data      <= 10'b0000000000;
    receive_key <= 1'b0; 
  end else begin
    if (iKeyboard_DATA == 1'b0 && start == 1'b0) begin
      start       <= 1'b1;
      cnter       <= 4'b0000;
      k_data      <= 10'b0000000000;
    end else begin
      if (start == 1'b1) begin
        cnter <= cnter + 4'b0001;
        case (cnter)
          4'b0000: begin
            k_data[0] <= iKeyboard_DATA;
          end
          4'b0001: begin
            k_data[1] <= iKeyboard_DATA;
          end
          4'b0010: begin
            k_data[2] <= iKeyboard_DATA;
          end
          4'b0011: begin
            k_data[3] <= iKeyboard_DATA;
          end
          4'b0100: begin
            k_data[4] <= iKeyboard_DATA;
          end
          4'b0101: begin
            k_data[5] <= iKeyboard_DATA;
          end
          4'b0110: begin
            k_data[6] <= iKeyboard_DATA;
          end
          4'b0111: begin
            k_data[7] <= iKeyboard_DATA;
          end
          4'b1000: begin
            k_data[8] <= iKeyboard_DATA;
          end
          default: begin
            k_data[9] <= iKeyboard_DATA;
            start <= 1'b0;
            receive_key <= ~receive_key;
          end
        endcase
      end
    end
    cnt <= cnter;
  end
end
// End: k_data_proc

assign parityok = k_data[0] ^ k_data[1] ^ k_data[2] ^ k_data[3]
			^ k_data[4] ^ k_data[5] ^ k_data[6] ^ k_data[7]
			^ k_data[8] ^ k_data[9];

assign oKey_stroke    = tmp_stroke;
assign oKey_data_D    = k_data[7:0];
assign oKey_ascii_D   = key_ascii_reg;
assign oKey_parity_D  = parity_reg;
assign oKey_stopbit_D = stopbit_reg;

// main_proc
always@(posedge iClock or negedge iReset_N)
begin
  if (iReset_N == 1'b0) begin
    tmp_stroke <= 1'b0;
    cur_key    <= 1'b0;
    break_code <= 1'b0;
    shift_key  <= 1'b0;

    parity_reg    <= 1'b0;
    stopbit_reg   <= 1'b0;
    key_ascii_reg <= 8'b00000000;
  end else begin
    if (cur_key != receive_key) begin
      cur_key     <= receive_key;
      parity_reg  <= parityok;
      stopbit_reg <= k_data[9];
      if (break_code == 1'b0) begin
        if (k_data[7:0] == 8'b11110000) begin
          break_code <= 1'b1;
        end else begin
            // do we have a valid key?
            // if k_data(9) = '1' and parityok = '1' then
            // stop bit and parity check out ok

            // the return, backspace, and shift keys all return key_ascii value
            // of "111111" since these characters are not mapped directly to the
            // tiny character generator ROM.  Therefore, we assume (by default) that
            // any key_ascii value not "111111" is a valid mapped key.
          if (!shift_key) begin    //shift_key off
			if (key_ascii != 6'b111111) begin
            	key_ascii_reg <= {2'b00, key_ascii};
            	tmp_stroke    <= ~tmp_stroke;
          	end else if ( k_data[7:0] == 8'b01100110		// backspace
				) begin
            	key_ascii_reg <= {k_data[6:5], 6'b111111};
            	tmp_stroke    <= ~tmp_stroke;
          	end else if (k_data[7:0] == 8'b01011010) begin		// return
				key_ascii_reg <= {k_data[6:5], 6'b111110};
				tmp_stroke	  <= ~tmp_stroke;
			end
          end else begin    //shift_key on
            if (key_ascii == 6'b110001) begin    // exclamation
              key_ascii_reg <= 6'b00100001;
              tmp_stroke    <= ~tmp_stroke;
            end else if (key_ascii == 6'b110010) begin    //double quotation
              key_ascii_reg <= 6'b00100010;
              tmp_stroke    <= ~tmp_stroke;
            end else if (key_ascii == 6'b110011) begin    //sharpe
              key_ascii_reg <= 6'b00100011;
              tmp_stroke    <= ~tmp_stroke;
            end else if (key_ascii == 6'b110100) begin    //dollar
              key_ascii_reg <= 6'b00100100;
              tmp_stroke    <= ~tmp_stroke;
            end else if (key_ascii == 6'b110101) begin    //percent
              key_ascii_reg <= 6'b00100101;
              tmp_stroke    <= ~tmp_stroke;
            end else if (key_ascii == 6'b110110) begin    //and
              key_ascii_reg <= 6'b00100110;
              tmp_stroke    <= ~tmp_stroke;
            end else if (key_ascii == 6'b110111) begin    //apostololy
              key_ascii_reg <= 6'b00100111;
              tmp_stroke    <= ~tmp_stroke;
            end else if (key_ascii == 6'b111000) begin    //left (
              key_ascii_reg <= 6'b00101000;
              tmp_stroke    <= ~tmp_stroke;
            end else if (key_ascii == 6'b111001) begin    //right )
              key_ascii_reg <= 6'b00101001;
              tmp_stroke    <= ~tmp_stroke;
            end else if (key_ascii == 6'b111100) begin    //astarisk
              key_ascii_reg <= 6'b00101010;
              tmp_stroke    <= ~tmp_stroke;
            end else if (key_ascii == 6'b111101) begin    //plus
              key_ascii_reg <= 6'b00101011;
              tmp_stroke    <= ~tmp_stroke;
            end else if (key_ascii == 6'b101111) begin    //question
              key_ascii_reg <= 6'b00111010;
              tmp_stroke    <= ~tmp_stroke;
            end else if (key_ascii == 6'b101101) begin    //equal
              key_ascii_reg <= 6'b00111011;
              tmp_stroke    <= ~tmp_stroke;
            end
          end


          if (k_data[7:0] == 8'b00010010		// Left Shift
		|| k_data[7:0] == 8'b01011001) begin	// Right Shift
            shift_key <= 1'b1;
          end
        end
      end else begin
        if (k_data[7:0] == 8'b00010010
		|| k_data[7:0] == 8'b01011001) begin
          shift_key <= 1'b0;
        end
        break_code <= 1'b0;
      end  // End: if (break_code == 1'b0) begin
    end
  end
end
// End: main_proc

// SCANCODE_ROM
assign		rom_address = k_data[7:0];
assign		key_ascii   = rom_out_data;
lpm_rom		lpm_rom_component	(
					      .address(rom_address),
					      .inclock(iClock),
					      .outclock(~iClock),
					      .q(rom_out_data)	);
defparam	lpm_rom_component.LPM_WIDTH   = 6,   // 6-bit data
		lpm_rom_component.LPM_WIDTHAD = 8,   // 8-bit address
		lpm_rom_component.LPM_ADDRESS_CONTROL = "REGISTERED",
		lpm_rom_component.LPM_OUTDATA = "REGISTERED",
		lpm_rom_component.LPM_FILE    = "scancode.mif";
// End: SCANCODE_ROM

endmodule
