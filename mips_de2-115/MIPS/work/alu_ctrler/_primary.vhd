library verilog;
use verilog.vl_types.all;
entity alu_ctrler is
    port(
        alu_op          : in     vl_logic_vector(2 downto 0);
        func            : in     vl_logic_vector(5 downto 0);
        alu_ctrl        : out    vl_logic_vector(3 downto 0)
    );
end alu_ctrler;
