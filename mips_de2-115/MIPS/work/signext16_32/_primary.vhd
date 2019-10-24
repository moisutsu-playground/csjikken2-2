library verilog;
use verilog.vl_types.all;
entity signext16_32 is
    port(
        sign_ext        : in     vl_logic;
        a16             : in     vl_logic_vector(15 downto 0);
        y32             : out    vl_logic_vector(31 downto 0)
    );
end signext16_32;
