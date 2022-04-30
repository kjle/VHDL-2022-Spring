library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Processor_tb is
end entity;

architecture test_bench of Processor_tb is
	signal clk, rst: std_logic;
	signal done : std_logic := '0';
	constant clk_period : time:= 10 ns;
begin

	UUT : entity work.Processor(behave)port map(clk => clk,rst => rst);

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
		done <= '0';
		wait for clk_period*180;
		done <= '1';
		wait;
	end process;
	
end architecture;