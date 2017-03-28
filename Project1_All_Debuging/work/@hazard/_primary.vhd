library verilog;
use verilog.vl_types.all;
entity Hazard is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        IDEX_MemRead    : in     vl_logic;
        IDEX_RegRt      : in     vl_logic_vector(4 downto 0);
        IFID_RegRs      : in     vl_logic_vector(4 downto 0);
        IFID_RegRt      : in     vl_logic_vector(4 downto 0);
        IDEX_Flush      : out    vl_logic;
        IFID_Write      : out    vl_logic;
        PC_Write        : out    vl_logic
    );
end Hazard;
