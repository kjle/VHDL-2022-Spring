library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity MUX_tb is
end entity;

architecture test_bench of MUX_tb is
	signal A, B, S : std_logic_vector(31 downto 0);
	signal COM     : std_logic;
begin

	UUT : entity work.MUX(behave) generic map(N => 32)
		  port map( A => A, B => B, COM => COM, S => S);
		  
	signal_gen : process is
	begin
		A <= x"FFFFFFF0"; 
		B <= x"00000009";
		COM <= '0';      
		wait for 20 ns;
		assert S = x"FFFFFFF0" report "ERROR on the selection of A" severity error;
		
		COM <= '1';      
		wait for 20 ns;
		assert S = x"00000009" report "ERROR on the selection of B" severity error;
		
		report "End of test. Verify that no error was reported.";
		wait;
		
	end process;

end architecture;