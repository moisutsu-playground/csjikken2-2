library verilog;
use verilog.vl_types.all;
entity registers is
    port(
        clock           : in     vl_logic;
        reset           : in     vl_logic;
        reg_read_idx1   : in     vl_logic_vector(4 downto 0);
        reg_read_idx2   : in     vl_logic_vector(4 downto 0);
        reg_write_idx   : in     vl_logic_vector(4 downto 0);
        reg_write_enable: in     vl_logic;
        reg_write_data  : in     vl_logic_vector(31 downto 0);
        reg_read_data1  : out    vl_logic_vector(31 downto 0);
        reg_read_data2  : out    vl_logic_vector(31 downto 0)
    );
end registers;
