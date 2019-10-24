library verilog;
use verilog.vl_types.all;
entity shifter32_32_l2 is
    port(
        sh_a            : in     vl_logic_vector(31 downto 0);
        sh_y            : out    vl_logic_vector(31 downto 0)
    );
end shifter32_32_l2;
