library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Sign_Extension is 
  generic (N : positive :=8);
  port (			
    S : out std_logic_vector(31 downto 0);
    E : in std_logic_vector(N-1 downto 0)			
  );
end entity;

architecture behav of Sign_Extension is

begin

  process(E)
  begin 
    S(N-1 downto 0) <= E; 
    S(31 downto N) <= (others => E(N-1)); 
  end process; 

end architecture;
