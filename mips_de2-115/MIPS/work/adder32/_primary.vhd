library verilog;
use verilog.vl_types.all;
entity adder32 is
    port(
        add_a           : in     vl_logic_vector(31 downto 0);
        add_b           : in     vl_logic_vector(31 downto 0);
        add_y           : out    vl_logic_vector(31 downto 0)
    );
end adder32;
