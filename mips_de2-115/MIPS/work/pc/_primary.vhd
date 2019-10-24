library verilog;
use verilog.vl_types.all;
entity pc is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        pc_next         : in     vl_logic_vector(31 downto 0);
        pc              : out    vl_logic_vector(31 downto 0)
    );
end pc;
