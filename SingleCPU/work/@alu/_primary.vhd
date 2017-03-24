library verilog;
use verilog.vl_types.all;
entity Alu is
    port(
        AluResult       : out    vl_logic_vector(31 downto 0);
        Zero            : out    vl_logic;
        DataIn1         : in     vl_logic_vector(31 downto 0);
        DataIn2         : in     vl_logic_vector(31 downto 0);
        AluCtrl         : in     vl_logic_vector(1 downto 0)
    );
end Alu;
