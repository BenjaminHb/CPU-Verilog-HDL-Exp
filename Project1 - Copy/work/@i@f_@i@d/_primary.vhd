library verilog;
use verilog.vl_types.all;
entity IF_ID is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        IFID_InPC       : in     vl_logic_vector(31 downto 0);
        IFID_InOpCode   : in     vl_logic_vector(31 downto 0);
        IFID_OutPC      : out    vl_logic_vector(31 downto 0);
        IFID_OutOpCode  : out    vl_logic_vector(31 downto 0);
        IFID_WriteEn    : in     vl_logic
    );
end IF_ID;
