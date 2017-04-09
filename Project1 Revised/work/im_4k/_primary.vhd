library verilog;
use verilog.vl_types.all;
entity im_4k is
    port(
        addr            : in     vl_logic_vector(9 downto 0);
        dout            : out    vl_logic_vector(31 downto 0)
    );
end im_4k;
