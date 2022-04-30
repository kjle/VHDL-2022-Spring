library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Processor is 
    port (
        clk, rst : in  std_logic 
    );
end entity;

architecture behave of Processor is
    signal nPCSel, MemWr, RegWr, ALUsrc, WrSrc, RegSel, PSRen : std_logic ;
    signal ALUctr : std_logic_vector(1 downto 0);
    signal offset : std_logic_vector(23 downto 0);
    signal Immediate: std_logic_vector(7 downto 0);
    signal Instruction, busout : std_logic_vector(31 downto 0);--busout -> PSR
    signal Rn, Rd, Rm : std_logic_vector(3 downto 0); 
begin

    Processing_Unit : entity work.Processing_Unit port map(clk => clk, rst => rst, RegWr=> RegWr, Rn => Rn, Rd => Rd, Rm=> Rm, busout => busout, Imm => Immediate, ALUctr=> ALUctr, MemWr=> MemWr, ALUSrc=> ALUSrc,WrSrc=> WrSrc, RegSel=> RegSel, PSRen => PSRen); 

    Instruction_Management_Unit : entity work.Instruction_Management_Unit port map(Clk => clk, rst => rst, nPCSel=> nPCSel, Instruction=> Instruction, offset => offset); 

    Decoder  : entity work.Decoder  port map(RegWr=> RegWr, Rn => Rn, Rd => Rd, Rm=> Rm, psrout => busout, Immediate =>Immediate, ALUctr=> ALUctr, MemWr=> MemWr, ALUSrc=> ALUSrc, WrSrc=> WrSrc, RegSel=> RegSel, PSRen => PSRen, nPCSel=> nPCSel, Instruction=> Instruction, offset=> offset); 

end architecture;
