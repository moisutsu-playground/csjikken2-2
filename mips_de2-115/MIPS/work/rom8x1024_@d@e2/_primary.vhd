library verilog;
use verilog.vl_types.all;
entity rom8x1024_DE2 is
    port(
        clock           : in     vl_logic;
        rom_addr        : in     vl_logic_vector(11 downto 0);
        rom_data        : out    vl_logic_vector(31 downto 0)
    );
end rom8x1024_DE2;
