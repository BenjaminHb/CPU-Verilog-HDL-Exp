library verilog;
use verilog.vl_types.all;
entity MEM_WB is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        MEMWB_InMemReadData: in     vl_logic_vector(31 downto 0);
        MEMWB_InALUResult: in     vl_logic_vector(31 downto 0);
        MEMWB_InRegWriteAdr: in     vl_logic_vector(4 downto 0);
        MEMWB_InMemtoReg: in     vl_logic;
        MEMWB_InRegWrite: in     vl_logic;
        MEMWB_OutMemReadData: out    vl_logic_vector(31 downto 0);
        MEMWB_OutALUResult: out    vl_logic_vector(31 downto 0);
        MEMWB_OutRegWriteAdr: out    vl_logic_vector(4 downto 0);
        MEMWB_OutMemtoReg: out    vl_logic;
        MEMWB_OutRegWrite: out    vl_logic;
        MEMWB_WriteEn   : in     vl_logic
    );
end MEM_WB;
