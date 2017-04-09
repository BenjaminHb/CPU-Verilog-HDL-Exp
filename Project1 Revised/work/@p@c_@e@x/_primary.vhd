library verilog;
use verilog.vl_types.all;
entity PC_EX is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        PCWr            : in     vl_logic;
        NPC             : in     vl_logic_vector(31 downto 0);
        PC              : out    vl_logic_vector(31 downto 0);
        JUMP            : in     vl_logic;
        JUMPAdr         : in     vl_logic_vector(25 downto 0)
    );
end PC_EX;
