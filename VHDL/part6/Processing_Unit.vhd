library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Processing_Unit is 
  port (
    clk, rst, MemWr, RegWr, ALUsrc, WrSrc ,RegSel, PSREn: in  std_logic ; 
    Rn, Rm, Rd : in std_logic_vector(3 downto 0);
    busout : out std_logic_vector(31 downto 0);--PSR[31..0]
    Imm : in std_logic_vector(7 downto 0); 
    ALUctr : in std_logic_vector(1 downto 0)
  );
end entity;

architecture behave of Processing_Unit is
  signal busA,busB,ALUS,busExtension,busMux, busW : std_logic_vector(31 downto 0);
  signal DataOut ,fl: std_logic_vector(31 downto 0);
  signal Rb : std_logic_vector(3 downto 0); 
  signal N,Z: std_logic;
begin

  Register_File : entity work.Register_File port map(Clk => clk, rst => rst, WE=> RegWr, Ra => Rn, Rb => Rb, Rw => Rd, A => busA, B => busB, W=> busW); 

  ALU : entity work.ALU port map(A => busA, B=> busMux, S => ALUS, OP => ALUctr, N => N, Z=> Z); 

  Sign_Extension : entity work.Sign_Extension port map ( E => Imm, S => busExtension);

  MUX1 : entity work.MUX port map (A => busB, B=> busExtension, S=> busMux, COM => ALUSrc); 

  MUX2 : entity work.MUX port map (A => ALUS, B=> DataOut, S=> busW, COM => WrSrc);

  Data_Memory : entity work.Data_Memory port map (Clk => clk, rst => rst, Addr => ALUS(5 downto 0), WE => MemWr, DataIn => busB, DataOut => DataOut); 

  MUX3 : entity work.MUX generic map( N=> 4) port map (A => Rm, B => Rd, COM => RegSel, S=> Rb); 

  Register_Charge : entity work.Register_Charge port map (clk => clk, rst => rst, WE => PSREn, DataIn => fl, DataOut => busout); 

  fl <= N&Z&"00"&X"0000000";

end architecture;
