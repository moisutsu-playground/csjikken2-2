library verilog;
use verilog.vl_types.all;
entity cpu is
    port(
        clk             : in     vl_logic;
        reset           : in     vl_logic;
        clk_ctrl0       : in     vl_logic;
        clk_ctrl1       : in     vl_logic;
        clk_ctrl_clk    : in     vl_logic;
        o_clock         : out    vl_logic;
        o_pc            : out    vl_logic_vector(11 downto 0);
        o_alu_y         : out    vl_logic_vector(31 downto 0);
        o_alu_a         : out    vl_logic_vector(31 downto 0);
        o_alu_b         : out    vl_logic_vector(31 downto 0);
        o_alu_ctrl      : out    vl_logic_vector(3 downto 0);
        o_alu_comp      : out    vl_logic_vector(1 downto 0);
        o_reg_data1     : out    vl_logic_vector(31 downto 0);
        o_reg_idx1      : out    vl_logic_vector(4 downto 0);
        o_reg_data2     : out    vl_logic_vector(31 downto 0);
        o_reg_idx2      : out    vl_logic_vector(4 downto 0);
        o_reg_wdata     : out    vl_logic_vector(31 downto 0);
        o_reg_widx      : out    vl_logic_vector(4 downto 0);
        o_reg_wen       : out    vl_logic;
        o_ram_addr      : out    vl_logic_vector(12 downto 0);
        o_ram_rdata     : out    vl_logic_vector(31 downto 0);
        o_ram_wdata     : out    vl_logic_vector(31 downto 0);
        o_ram_wen       : out    vl_logic;
        i_ram_addr      : in     vl_logic_vector(12 downto 0);
        i_ram_wdata     : in     vl_logic_vector(31 downto 0);
        i_ram_wen       : in     vl_logic
    );
end cpu;
