library verilog;
use verilog.vl_types.all;
entity plus4 is
    port(
        inc_a           : in     vl_logic_vector(31 downto 0);
        inc_y           : out    vl_logic_vector(31 downto 0)
    );
end plus4;
