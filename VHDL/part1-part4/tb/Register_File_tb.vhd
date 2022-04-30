library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Register_File_tb is
end entity;

architecture test_bench of Register_File_tb is
	signal clk, rst, WE : std_logic;
	signal W, A, B      : std_logic_vector(31 downto 0);
	signal Rw, Ra, Rb   : std_logic_vector(3 downto 0);
	signal done : std_logic := '0';
	constant clk_period : time:= 10 ns;
begin

	UUT : entity work.Register_File(behav) port map(clk => clk, rst => rst, W => W, Ra => Ra, Rb => Rb, Rw => Rw, WE => WE, A => A, B => B);
	rst <= '1', '0' after clk_period;
	clock : process is 
	begin
		if done = '0' then
			clk <= '0';
			wait for clk_period/2;
			clk <= '1';
			wait for clk_period/2;
		else
			wait;
		end if;
	end process;
	
               process is
	begin
		WE <= '0';
		Rw <= "0000";
		W  <= x"00000000";
		Rb <= "0000";
		Ra <= "0000";
		wait for clk_period;
		
		WE <= '1';
		Rw <= "0011";
		W  <= x"00000001";
		Rb <= "0011";
		wait for clk_period;
		assert B = x"00000001" report "ERROR on B" severity error;
		
		WE <= '1';
		Rw <= "0011";
		W  <= x"00000002";
		Rb <= "0011";
		wait for clk_period;
		assert B = x"00000002" report "ERROR on  B" severity error;

		WE <= '1';
		Rw <= "1010";
		W  <= x"00000005";
		Ra <= "1010";
		wait for clk_period;
		assert A = x"00000005" report "ERROR on write or read A" severity error;
		
		report "End of test. Verify that no error was reported.";
		done <= '1';
		wait;
	end process;
end architecture;
