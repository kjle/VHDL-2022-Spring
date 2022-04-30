library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Assemble_ALU_and_Register_File  is 
  port (
    clk, rst, WE : in  std_logic ; 
    Ra, Rb, Rw : in std_logic_vector(3 downto 0);
    W : out std_logic_vector(31 downto 0);
    N : out std_logic; 
    op : in std_logic_vector(1 downto 0)
  );
end entity;

architecture behave of Assemble_ALU_and_Register_File  is
  signal busA,busB, busW : std_logic_vector(31 downto 0);
begin

  Register_File : entity work.Register_File port map(clk => clk, rst => rst, WE=> We, Ra => Ra, Rb => Rb, Rw => Rw, 
  A => busA, B => busB, W=> busW); 

  ALU : entity work.ALU port map(a => busA, b=> busB, s => busW, op => op, n => n); 

  W <= busw; 

end architecture;
