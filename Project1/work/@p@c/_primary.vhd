library verilog;
use verilog.vl_types.all;
entity PC is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        PCWr            : in     vl_logic;
        NPC             : in     vl_logic_vector(31 downto 2);
        PC              : out    vl_logic_vector(31 downto 2)
    );
end PC;
