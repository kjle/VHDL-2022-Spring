library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Data_Memory_tb is
end entity;

architecture test_bench of Data_Memory_tb is
	signal clk, rst, WE : std_logic;
	signal DataIn, DataOut : std_logic_vector(31 downto 0);
	signal Addr            : std_logic_vector(5 downto 0);
	signal done : std_logic := '0';
	constant clk_period : time:= 10 ns;
begin
	UUT : entity work.Data_Memory(behave) port map(clk => clk, rst => rst, WE => WE, DataIn => DataIn, DataOut => DataOut, Addr => Addr);
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
	
	signal_gen : process is
	begin
		-- init
		WE <= '0';
		DataIn <= (others => '0');
		Addr <= (others => '0');
		wait for clk_period;
		
		WE <= '1';
		DataIn <= x"0000000A"; 
		Addr <= "000000";
		wait for clk_period;
		assert DataOut = x"0000000A" report "ERROR on write " severity error;

		DataIn <= x"0000000B"; 
		Addr <= "000000";
		WE <= '0';
		wait for clk_period;
		assert DataOut = x"0000000A" report "ERROR on read  " severity error;

		report "End of test. Verify that no error was reported.";
		done <= '1';
		wait;
	end process;
	
end architecture;