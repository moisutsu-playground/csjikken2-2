
module update_monitor_rom(addr, data);

input [9:0] addr;
output [31:0] data;
reg    [31:0] data;

always @(addr) begin
        if(addr == 0) begin
            data[17:7] <= {`PC3col,`PC3row};
        end else 
        if(addr == 1) begin
            data[17:7] <= {`PC2col,`PC2row};
        end else 
        if(addr == 2) begin
            data[17:7] <= {`PC1col,`PC1row};
        end else 
        if(addr == 3) begin
            data[17:7] <= {`PC0col,`PC0row};
        end else 
        if(addr == 4) begin
            data[17:7] <= {`ALUY7col,`ALUY7row};
        end else 
        if(addr == 5) begin
            data[17:7] <= {`ALUY6col,`ALUY6row};
        end else 
        if(addr == 6) begin
            data[17:7] <= {`ALUY5col,`ALUY5row};
        end else 
        if(addr == 7) begin
            data[17:7] <= {`ALUY4col,`ALUY4row};
        end else 
        if(addr == 8) begin
            data[17:7] <= {`ALUY3col,`ALUY3row};
        end else 
        if(addr == 9) begin
            data[17:7] <= {`ALUY2col,`ALUY2row};
        end else 
        if(addr == 10) begin
            data[17:7] <= {`ALUY1col,`ALUY1row};
        end else 
        if(addr == 11) begin
            data[17:7] <= {`ALUY0col,`ALUY0row};
        end else 
        if(addr == 12) begin
            data[17:7] <= {`ALUA7col,`ALUA7row};
        end else 
        if(addr == 13) begin
            data[17:7] <= {`ALUA6col,`ALUA6row};
        end else 
        if(addr == 14) begin
            data[17:7] <= {`ALUA5col,`ALUA5row};
        end else 
        if(addr == 15) begin
            data[17:7] <= {`ALUA4col,`ALUA4row};
        end else 
        if(addr == 16) begin
            data[17:7] <= {`ALUA3col,`ALUA3row};
        end else 
        if(addr == 17) begin
            data[17:7] <= {`ALUA2col,`ALUA2row};
        end else 
        if(addr == 18) begin
            data[17:7] <= {`ALUA1col,`ALUA1row};
        end else 
        if(addr == 19) begin
            data[17:7] <= {`ALUA0col,`ALUA0row};
        end else 
        if(addr == 20) begin
            data[17:7] <= {`ALUCTRL0col,`ALUCTRL0row};
        end else 
        if(addr == 21) begin
            data[17:7] <= {`ALUB7col,`ALUB7row};
        end else 
        if(addr == 22) begin
            data[17:7] <= {`ALUB6col,`ALUB6row};
        end else 
        if(addr == 23) begin
            data[17:7] <= {`ALUB5col,`ALUB5row};
        end else 
        if(addr == 24) begin
            data[17:7] <= {`ALUB4col,`ALUB4row};
        end else 
        if(addr == 25) begin
            data[17:7] <= {`ALUB3col,`ALUB3row};
        end else 
        if(addr == 26) begin
            data[17:7] <= {`ALUB2col,`ALUB2row};
        end else 
        if(addr == 27) begin
            data[17:7] <= {`ALUB1col,`ALUB1row};
        end else 
        if(addr == 28) begin
            data[17:7] <= {`ALUB0col,`ALUB0row};
        end else 
        if(addr == 29) begin
            data[17:7] <= {`ALUCOMP0col,`ALUCOMP0row};
        end else 
        if(addr == 30) begin
            data[17:7] <= {`REGDATA1_7col,`REGDATA1_7row};
        end else 
        if(addr == 31) begin
            data[17:7] <= {`REGDATA1_6col,`REGDATA1_6row};
        end else 
        if(addr == 32) begin
            data[17:7] <= {`REGDATA1_5col,`REGDATA1_5row};
        end else 
        if(addr == 33) begin
            data[17:7] <= {`REGDATA1_4col,`REGDATA1_4row};
        end else 
        if(addr == 34) begin
            data[17:7] <= {`REGDATA1_3col,`REGDATA1_3row};
        end else 
        if(addr == 35) begin
            data[17:7] <= {`REGDATA1_2col,`REGDATA1_2row};
        end else 
        if(addr == 36) begin
            data[17:7] <= {`REGDATA1_1col,`REGDATA1_1row};
        end else 
        if(addr == 37) begin
            data[17:7] <= {`REGDATA1_0col,`REGDATA1_0row};
        end else 
        if(addr == 38) begin
            data[17:7] <= {`REGIDX1_1col,`REGIDX1_1row};
        end else 
        if(addr == 39) begin
            data[17:7] <= {`REGIDX1_0col,`REGIDX1_0row};
        end else 
        if(addr == 40) begin
            data[17:7] <= {`REGDATA2_7col,`REGDATA2_7row};
        end else 
        if(addr == 41) begin
            data[17:7] <= {`REGDATA2_6col,`REGDATA2_6row};
        end else 
        if(addr == 42) begin
            data[17:7] <= {`REGDATA2_5col,`REGDATA2_5row};
        end else 
        if(addr == 43) begin
            data[17:7] <= {`REGDATA2_4col,`REGDATA2_4row};
        end else 
        if(addr == 44) begin
            data[17:7] <= {`REGDATA2_3col,`REGDATA2_3row};
        end else 
        if(addr == 45) begin
            data[17:7] <= {`REGDATA2_2col,`REGDATA2_2row};
        end else 
        if(addr == 46) begin
            data[17:7] <= {`REGDATA2_1col,`REGDATA2_1row};
        end else 
        if(addr == 47) begin
            data[17:7] <= {`REGDATA2_0col,`REGDATA2_0row};
        end else 
        if(addr == 48) begin
            data[17:7] <= {`REGIDX2_1col,`REGIDX2_1row};
        end else 
        if(addr == 49) begin
            data[17:7] <= {`REGIDX2_0col,`REGIDX2_0row};
        end else 
        if(addr == 50) begin
            data[17:7] <= {`REGWDATA_7col,`REGWDATA_7row};
        end else 
        if(addr == 51) begin
            data[17:7] <= {`REGWDATA_6col,`REGWDATA_6row};
        end else 
        if(addr == 52) begin
            data[17:7] <= {`REGWDATA_5col,`REGWDATA_5row};
        end else 
        if(addr == 53) begin
            data[17:7] <= {`REGWDATA_4col,`REGWDATA_4row};
        end else 
        if(addr == 54) begin
            data[17:7] <= {`REGWDATA_3col,`REGWDATA_3row};
        end else 
        if(addr == 55) begin
            data[17:7] <= {`REGWDATA_2col,`REGWDATA_2row};
        end else 
        if(addr == 56) begin
            data[17:7] <= {`REGWDATA_1col,`REGWDATA_1row};
        end else 
        if(addr == 57) begin
            data[17:7] <= {`REGWDATA_0col,`REGWDATA_0row};
        end else 
        if(addr == 58) begin
            data[17:7] <= {`REGWIDX_1col,`REGWIDX_1row};
        end else 
        if(addr == 59) begin
            data[17:7] <= {`REGWIDX_0col,`REGWIDX_0row};
        end else 
        if(addr == 60) begin
            data[17:7] <= {`REGWENcol,`REGWENrow};
        end else 
        if(addr == 61) begin
            data[17:7] <= {`RAMRDATA_7col,`RAMRDATA_7row};
        end else 
        if(addr == 62) begin
            data[17:7] <= {`RAMRDATA_6col,`RAMRDATA_6row};
        end else 
        if(addr == 63) begin
            data[17:7] <= {`RAMRDATA_5col,`RAMRDATA_5row};
        end else 
        if(addr == 64) begin
            data[17:7] <= {`RAMRDATA_4col,`RAMRDATA_4row};
        end else 
        if(addr == 65) begin
            data[17:7] <= {`RAMRDATA_3col,`RAMRDATA_3row};
        end else 
        if(addr == 66) begin
            data[17:7] <= {`RAMRDATA_2col,`RAMRDATA_2row};
        end else 
        if(addr == 67) begin
            data[17:7] <= {`RAMRDATA_1col,`RAMRDATA_1row};
        end else 
        if(addr == 68) begin
            data[17:7] <= {`RAMRDATA_0col,`RAMRDATA_0row};
        end else 
        if(addr == 69) begin
            data[17:7] <= {`RAMADDR_3col,`RAMADDR_3row};
        end else 
        if(addr == 70) begin
            data[17:7] <= {`RAMADDR_2col,`RAMADDR_2row};
        end else 
        if(addr == 71) begin
            data[17:7] <= {`RAMADDR_1col,`RAMADDR_1row};
        end else 
        if(addr == 72) begin
            data[17:7] <= {`RAMADDR_0col,`RAMADDR_0row};
        end else 
        if(addr == 73) begin
            data[17:7] <= {`RAMWDATA_7col,`RAMWDATA_7row};
        end else 
        if(addr == 74) begin
            data[17:7] <= {`RAMWDATA_6col,`RAMWDATA_6row};
        end else 
        if(addr == 75) begin
            data[17:7] <= {`RAMWDATA_5col,`RAMWDATA_5row};
        end else 
        if(addr == 76) begin
            data[17:7] <= {`RAMWDATA_4col,`RAMWDATA_4row};
        end else 
        if(addr == 77) begin
            data[17:7] <= {`RAMWDATA_3col,`RAMWDATA_3row};
        end else 
        if(addr == 78) begin
            data[17:7] <= {`RAMWDATA_2col,`RAMWDATA_2row};
        end else 
        if(addr == 79) begin
            data[17:7] <= {`RAMWDATA_1col,`RAMWDATA_1row};
        end else 
        if(addr == 80) begin
            data[17:7] <= {`RAMWDATA_0col,`RAMWDATA_0row};
        end else 
        if(addr == 81) begin
            data[17:7] <= {`RAMWENcol,`RAMWENrow};
        end else begin
            data <= 32'b0;
        end
end
endmodule
