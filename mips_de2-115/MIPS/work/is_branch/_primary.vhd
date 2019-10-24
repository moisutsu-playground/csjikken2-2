library verilog;
use verilog.vl_types.all;
entity is_branch is
    port(
        d0              : in     vl_logic_vector(2 downto 0);
        d1              : in     vl_logic_vector(1 downto 0);
        y               : out    vl_logic
    );
end is_branch;
