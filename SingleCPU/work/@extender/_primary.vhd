library verilog;
use verilog.vl_types.all;
entity Extender is
    port(
        ExtOut          : out    vl_logic_vector(31 downto 0);
        DataIn          : in     vl_logic_vector(15 downto 0);
        ExtOp           : in     vl_logic
    );
end Extender;
