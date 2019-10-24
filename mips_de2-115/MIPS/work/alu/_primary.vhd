library verilog;
use verilog.vl_types.all;
entity alu is
    port(
        alu_a           : in     vl_logic_vector(31 downto 0);
        alu_b           : in     vl_logic_vector(31 downto 0);
        alu_ctrl        : in     vl_logic_vector(3 downto 0);
        alu_y           : out    vl_logic_vector(31 downto 0);
        alu_comp        : out    vl_logic_vector(1 downto 0)
    );
end alu;
