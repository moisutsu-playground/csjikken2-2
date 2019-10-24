--
--
-- Keyboard module (provides exteranl inputs through PS2 Keyboard)
-- 

-- Library altera,IEEE,lpm;
-- --use altera.maxplus2.all;
-- use IEEE.STD_LOGIC_1164.all;
-- USE lpm.lpm_components.ALL;
-- use IEEE.STD_LOGIC_ARITH.all;
-- use IEEE.STD_LOGIC_signed.all;

library ieee;
use  ieee.std_logic_1164.all;
use  ieee.std_logic_unsigned.all;

-- LIBRARY lpm;
-- USE lpm.lpm_components.all;


entity keyboard is
  port(clock                         : in std_Logic;
       reset                         : in std_Logic;
       keyboard_DATA, keyboard_CLOCK : in std_logic;

       k_data_D            : out std_logic_vector(7 downto 0);       
       parity_D, stopbit_D : out std_logic;
       key_ascii_D         : out std_logic_vector(7 downto 0);
       key_stroke          : out std_logic);
end Keyboard;



--
-- Keyboard architecture
--

architecture behavioral of Keyboard is

  
  component scancode_rom
    port(rom_address  : in std_logic_vector(7 downto 0);
         rom_out_data : out std_logic_vector(5 downto 0)
      );
  end component;

  
  signal k_data : std_logic_vector(9 downto 0);
  signal key_ascii : std_logic_vector(5 downto 0);
  signal receive_key : std_logic;
  signal start, stop_getkey : std_logic;
  signal cnt : std_logic_vector(3 downto 0);
  signal filter : std_logic_vector(7 downto 0);
  signal keyboard_clk_filt : std_logic; 
  signal parityok : std_logic;
  signal shift_key : std_logic;

  signal cntclk : std_logic_vector(14 downto 0);
  signal cnter : std_logic_vector(3 downto 0);
  signal tmp_stroke, cur_key, break_code : std_logic;

  signal key_ascii_reg : std_logic_vector(7 downto 0);
  signal parity_reg  : std_logic;
  signal stopbit_reg : std_logic;

     
  -- Function Defined to Check the parity of the input signal.
  -- If the parity is correct, a '1' is returned else it is a '0';	       
--   function paritycheck(p_data : in std_logic_vector(8 downto 0)) return std_logic is
--     variable Result: std_logic;
--   begin
    
--     xor_loop:
--     FOR N IN p_data'range LOOP
--       Result := Result xor p_data(N);
--     END LOOP xor_loop;
--     return Result;
--   end function paritycheck;       

begin  

  stop_getkey_proc : process (reset, start, clock, cnt)
  begin
    if (reset = '0') then
      cntclk      <= "000000000000000";
      stop_getkey <= '0';
    elsif (clock'event and clock = '1') then
      if (start = '0' or cnt = "0000") then 
        cntclk      <= "000000000000000";
        stop_getkey <= '0';
      else
        cntclk <= cntclk + "000000000000001";
        if (cntclk = "100111010000100") then
          stop_getkey <= '1';
        end if;
      end if;
    end if;
  end process stop_getkey_proc;



  filter_proc : process (reset, clock, keyboard_clock)
  begin
    if (reset = '0') then
      filter            <= "00000000";
      keyboard_clk_filt <= '0';

    elsif (clock'event and clock = '1') then
      filter(6 downto 0) <= filter(7 downto 1);
      filter(7)          <= keyboard_clock;

      if (filter = "11111111") then
        keyboard_clk_filt <= '1';
      elsif (filter = "00000000") then
        keyboard_clk_filt <= '0';
      end if;

    end if;
  end process filter_proc ;


  
--   k_data_proc : process (reset, keyboard_clk_filt, keyboard_data)
--   begin

--     if (reset = '0') then
--       start       <= '0';
--       cnter       <= "0000";
--       k_data      <= "0000000000";
--       receive_key <= '0';
      
--     elsif (keyboard_clk_filt'event and keyboard_clk_filt = '1') then
      
--       if (keyboard_data = '0' and start = '0') then  -- (start = '0' or stop_getkey = '1') then
--         start  <= '1';
--         cnter  <= "0000";
--         k_data <= "0000000000";
--       else 
--         if (start = '1') then
--           cnter <= cnter + "0001";
          
--           case cnter(3 downto 0) is
--             when "0001" => k_data(0) <= keyboard_data;
--             when "0010" => k_data(1) <= keyboard_data;
--             when "0011" => k_data(2) <= keyboard_data;
--             when "0100" => k_data(3) <= keyboard_data;
--             when "0101" => k_data(4) <= keyboard_data;
--             when "0110" => k_data(5) <= keyboard_data;
--             when "0111" => k_data(6) <= keyboard_data;
--             when "1000" => k_data(7) <= keyboard_data;
--             when "1001" => k_data(8) <= keyboard_data;
--             when others => k_data(9) <= keyboard_data;
--                            start <= '0';
--                            receive_key <= not receive_key;	  
--           end case;
--         end if;
--       end if;
      
--     end if;
--   end process k_data_proc ;  -- keyboard clock process
--
--  cnt <= cnter;



process
variable cnter : std_logic_vector(3 downto 0);  -- := "0000";

begin
  wait until keyboard_clk_filt'event and keyboard_clk_filt = '0';

  if keyboard_data ='0' and start = '0' then --(start = '0' or stop_getkey = '1') then
    start <= '1';
    cnter := "0000";
    k_data <= "0000000000";
  else
    if start = '1' then
        cnter := cnter + 1;

        case cnter(3 downto 0) is
          when "0001" => k_data(0) <= Keyboard_DATA;
          when "0010" => k_data(1) <= Keyboard_DATA;
          when "0011" => k_data(2) <= Keyboard_DATA;
          when "0100" => k_data(3) <= Keyboard_DATA;
          when "0101" => k_data(4) <= Keyboard_DATA;
          when "0110" => k_data(5) <= Keyboard_DATA;
          when "0111" => k_data(6) <= Keyboard_DATA;
          when "1000" => k_data(7) <= Keyboard_DATA;
          when "1001" => k_data(8) <= Keyboard_DATA;
          when others => k_data(9) <= Keyboard_DATA;
                         start <= '0';
                         receive_key <= not receive_key;
        end case;
        
    end if;
  end if;
  cnt <= cnter;
end process;  -- keyboard clock process

  scancode_rom1 : scancode_rom
  port map (
    rom_address   => k_data(7 downto 0),
    rom_out_data  => key_ascii
  );


  -- parityok <= paritycheck(k_data(8 downto 0));
  parityok <= k_data(0) xor k_data(1) xor k_data(2)
              xor k_data(3) xor k_data(4) xor k_data(5)
              xor k_data(6) xor k_data(7) xor k_data(8) xor k_data(9);


  key_stroke <= tmp_stroke;


  k_data_D <= k_data(7 downto 0);
--  k_data_D <= "0000000" & keyboard_clk_filt;
  key_ascii_D <= key_ascii_reg;
  parity_D    <= parity_reg;
  stopbit_D   <= stopbit_reg;
  
  process (reset, clock, receive_key, parityok, k_data)
  begin

    if (reset = '0') then
      tmp_stroke  <= '0';
      cur_key     <= '0';
      break_code  <= '0';

      parity_reg  <= '0';
      stopbit_reg   <= '0';
      key_ascii_reg <= "00000000";

    elsif (clock'event and clock = '1') then
--      k_data_D <= k_data(7 downto 0);

      if (cur_key /= receive_key) then
        cur_key     <= receive_key;
        parity_reg  <= parityok;
        stopbit_reg <= k_data(9);
    	
        if (break_code = '0') then
          if (k_data(7 downto 0) = "11110000") then
            break_code <= '1';
          else
            --do we have a valid key?
            --if k_data(9) = '1' and parityok = '1' then
            -- stop bit and parity check out ok

            -- the return, backspace, and shift keys all return key_ascii value
            -- of "111111" since these characters are not mapped directly to the
            -- tiny character generator ROM.  Therefore, we assume (by default) that
            -- any key_ascii value not "111111" is a valid mapped key.
            if (key_ascii /= "111111") then
              key_ascii_reg <= "00" & key_ascii(5 downto 0);
              tmp_stroke    <= not tmp_stroke; 
            elsif (k_data(7 downto 0) = "01011010"           -- return
                   or k_data(7 downto 0) = "01100110") then  --backspace
              key_ascii_reg <= k_data(6 downto 5) & "000000";
              tmp_stroke    <= not tmp_stroke; 
            end if;
            

            if (k_data(7 downto 0) = "00010010"  --Left Shift
                or k_data(7 downto 0) = "01011001") then  -- Right Shift
              shift_key <= '1';
            end if;
            --end if; -- if k_data(9)
            
          end if; -- if k_data(7 downto 0)
        else
          -- turn off shift during the break portion
          if --k_data(9) = '1' and parityok = '1' and
            (k_data(7 downto 0) = "00010010" or k_data(7 downto 0) = "01011001") then
            shift_key <= '0';
          end if;

          break_code <= '0';
          
        end if; -- if break_code
      end if; -- if cur_key
    end if;
    
  end process;

end behavioral;
