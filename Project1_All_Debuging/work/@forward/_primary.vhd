library verilog;
use verilog.vl_types.all;
entity Forward is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        IDEX_RegRs      : in     vl_logic_vector(4 downto 0);
        IDEX_RegRt      : in     vl_logic_vector(4 downto 0);
        EXMEM_RegRd     : in     vl_logic_vector(4 downto 0);
        EXMEM_RegWrite  : in     vl_logic;
        MEMWB_RegRd     : in     vl_logic_vector(4 downto 0);
        MEMWB_RegWrite  : in     vl_logic;
        ForwardA        : out    vl_logic_vector(1 downto 0);
        ForwardB        : out    vl_logic_vector(1 downto 0)
    );
end Forward;
