library verilog;
use verilog.vl_types.all;
entity ID_EX is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        IDEX_InPC       : in     vl_logic_vector(31 downto 0);
        IDEX_InReadData1: in     vl_logic_vector(31 downto 0);
        IDEX_InReadData2: in     vl_logic_vector(31 downto 0);
        IDEX_InImm32    : in     vl_logic_vector(31 downto 0);
        IDEX_InRt       : in     vl_logic_vector(4 downto 0);
        IDEX_InRd       : in     vl_logic_vector(4 downto 0);
        IDEX_InALUSrc   : in     vl_logic;
        IDEX_InALUCtrl  : in     vl_logic_vector(2 downto 0);
        IDEX_InRegDst   : in     vl_logic;
        IDEX_InJump     : in     vl_logic;
        IDEX_InBranch   : in     vl_logic;
        IDEX_InMemWrite : in     vl_logic;
        IDEX_InMemRead  : in     vl_logic;
        IDEX_InMemtoReg : in     vl_logic;
        IDEX_InRegWrite : in     vl_logic;
        IDEX_OutPC      : out    vl_logic_vector(31 downto 0);
        IDEX_OutReadData1: out    vl_logic_vector(31 downto 0);
        IDEX_OutReadData2: out    vl_logic_vector(31 downto 0);
        IDEX_OutImm32   : out    vl_logic_vector(31 downto 0);
        IDEX_OutRt      : out    vl_logic_vector(4 downto 0);
        IDEX_OutRd      : out    vl_logic_vector(4 downto 0);
        IDEX_OutALUSrc  : out    vl_logic;
        IDEX_OutALUCtrl : out    vl_logic_vector(2 downto 0);
        IDEX_OutRegDst  : out    vl_logic;
        IDEX_OutJump    : out    vl_logic;
        IDEX_OutBranch  : out    vl_logic;
        IDEX_OutMemWrite: out    vl_logic;
        IDEX_OutMemRead : out    vl_logic;
        IDEX_OutMemtoReg: out    vl_logic;
        IDEX_OutRegWrite: out    vl_logic;
        IDEX_WriteEn    : in     vl_logic
    );
end ID_EX;
