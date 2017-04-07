library verilog;
use verilog.vl_types.all;
entity EX_MEM is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        EXMEM_InALUResult: in     vl_logic_vector(31 downto 0);
        EXMEM_InRtData  : in     vl_logic_vector(31 downto 0);
        EXMEM_InRegWriteAdr: in     vl_logic_vector(4 downto 0);
        EXMEM_InMemWrite: in     vl_logic;
        EXMEM_InMemRead : in     vl_logic;
        EXMEM_InMemtoReg: in     vl_logic;
        EXMEM_InRegWrite: in     vl_logic;
        EXMEM_OutALUResult: out    vl_logic_vector(31 downto 0);
        EXMEM_OutRtData : out    vl_logic_vector(31 downto 0);
        EXMEM_OutRegWriteAdr: out    vl_logic_vector(4 downto 0);
        EXMEM_OutMemWrite: out    vl_logic;
        EXMEM_OutMemRead: out    vl_logic;
        EXMEM_OutMemtoReg: out    vl_logic;
        EXMEM_OutRegWrite: out    vl_logic;
        EXMEM_WriteEn   : in     vl_logic
    );
end EX_MEM;
