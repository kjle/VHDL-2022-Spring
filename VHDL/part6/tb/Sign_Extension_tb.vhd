library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Sign_Extension_tb is
end entity;

architecture test_bench of Sign_Extension_tb is
  signal E : std_logic_vector(7 downto 0);
  signal S : std_logic_vector(31 downto 0);
begin
	
	UUT : entity work.Sign_Extension(behav) generic map(N => 8) port map(E => E, S => S);
		  
	signal_gen : process is
	begin
		E <= x"F1"; 
		wait for 20 ns;
		assert S = x"FFFFFFF1" report "ERROR on negative sign extension" severity error;
		
		E <= x"0D"; 
		wait for 20 ns;
		assert S = x"0000000D" report "ERROR on positive sign extension" severity error;
		
		report "End of test. Verify that no error was reported.";
		wait;
		
	end process;
end architecture;