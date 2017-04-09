library verilog;
use verilog.vl_types.all;
entity IR is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        IRWr            : in     vl_logic;
        im_dout         : in     vl_logic_vector(31 downto 0);
        instr           : out    vl_logic_vector(31 downto 0)
    );
end IR;
