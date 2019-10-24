library verilog;
use verilog.vl_types.all;
entity ram8x2048_sim is
    port(
        clk             : in     vl_logic;
        ram_addr        : in     vl_logic_vector(12 downto 0);
        ram_write_enable: in     vl_logic;
        ram_write_data  : in     vl_logic_vector(31 downto 0);
        ram_read_data   : out    vl_logic_vector(31 downto 0);
        key_ram_addr    : in     vl_logic_vector(12 downto 0);
        key_ram_wdata   : in     vl_logic_vector(31 downto 0);
        key_ram_wen     : in     vl_logic
    );
end ram8x2048_sim;
