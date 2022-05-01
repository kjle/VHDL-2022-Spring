library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_tb is
end entity;

architecture test_bench of ALU_tb is
	signal a, b, s : std_logic_vector(31 downto 0);
	signal op      : std_logic_vector(1 downto 0);
	signal n       : std_logic;
begin

	UUT : entity work.ALU(behav) port map(a => a, b => b, op => op, s => s, n => n);

	signal_gen : process is
	begin
		a  <= x"00000001"; 
		b  <= x"00000002"; 
		op <= "00";
		wait for 20 ns;
		assert s = x"00000003" report "ERROR on ADD " severity error;
		assert n = '0'         report "ERROR on n" severity error;
	
		b <= x"0000001B"; 
		op <= "01";
		wait for 20 ns;
		assert s = x"0000001B" report "ERROR on Copy B" severity error;
		assert n = '0'         report "ERROR on n" severity error;
		

		a  <= x"00000002"; 
		b  <= x"00000001"; 
		op <= "10";
		wait for 20 ns;
		assert s = x"00000001" report "ERROR on SUB " severity error;
		assert n = '0'         report "ERROR on n" severity error;
		
		a <= x"FFFFFCFA"; 
		op <= "11";
		wait for 20 ns;
		assert s = x"FFFFFCFA" report "ERROR on Copy A" severity error;
		assert n = '1'         report "ERROR on n" severity error;
		
		wait;
		
	end process;

end architecture;