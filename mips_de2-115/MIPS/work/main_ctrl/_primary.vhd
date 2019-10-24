library verilog;
use verilog.vl_types.all;
entity main_ctrl is
    port(
        instruction     : in     vl_logic_vector(31 downto 0);
        ram_write_enable: out    vl_logic;
        alu_b_sel1_s    : out    vl_logic;
        alu_b_sel2_s    : out    vl_logic;
        alu_op          : out    vl_logic_vector(2 downto 0);
        is_branch_ctrl  : out    vl_logic_vector(2 downto 0);
        reg_write_enable: out    vl_logic;
        alu_ram_sel_s   : out    vl_logic;
        reg_widx_sel1_s : out    vl_logic;
        jp              : out    vl_logic;
        link            : out    vl_logic;
        jpr             : out    vl_logic;
        shiftv          : out    vl_logic;
        do_sign_ext     : out    vl_logic
    );
end main_ctrl;
