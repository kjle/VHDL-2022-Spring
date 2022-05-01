library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Processing_Unit_tb is
end entity;

architecture test_bench of Processing_Unit_tb is
	signal clk, rst, ALUsrc, WrSrc, RegWr, RegSel, MemWr, N, PSREn : std_logic;
	signal Rn, Rd, Rm     : std_logic_vector(3 downto 0);
	signal ALUctr         : std_logic_vector(1 downto 0);
	signal Imm            : std_logic_vector(7 downto 0);
	signal busout         : std_logic_vector(31 downto 0);
	
	signal done : std_logic := '0';
	constant clk_period : time:= 10 ns;
begin
	
	UUT : entity work.Processing_Unit(behave)
	port map(	clk      => clk,
				rst      => rst,
				RegWr    => RegWr,
				RegSel	 => RegSel,
				PSREn 	 => PSREn,
				MemWr    => MemWr,
				Rd       => Rd,
				Rn       => Rn,
				Rm       => Rm,
				ALUsrc   => ALUsrc,
				WrSrc    => WrSrc,
				ALUctr   => ALUctr,
				Imm      => Imm,
				busout   => busout
	);
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
		RegWr <= '0';
		RegSel <= '0';
		PSREn <= '0';
		MemWr <= '0';
		ALUsrc <= '0';
		WrSrc <= '0';
		ALUctr <= "00";
		Rd <= (others => '0');
		Rn <= (others => '0');
		Rm <= (others => '0');
		Imm <= (others => '0');
		wait for clk_period;
		
		-- R(2) = R(1) + R(15)    
		Rd <= "0010";
		Rn <= "0001";
		Rm <= "1111";
		ALUctr <= "00";
		ALUsrc <= '0';
		WrSrc <= '0';
		RegWr <= '1';
		PSREn <= '1';
		RegSel <= '0';
		wait for clk_period;
		assert busout = x"00000030" report "ERROR on ADD of 2 reg" severity error;
		assert N = '0'     report "ERROR on Flag of ADD of 2 reg" severity error;
		
		-- Addition Offset
		Rd <= "1110";
		Rn <= "0010";
		Imm <= x"6B";
		ALUsrc <= '1';
		wait for clk_period;
		assert busout = x"0000009B" report "ERROR on ADD of reg and imm"         severity error;
		assert  N = '0'     report "ERROR on Flag of ADD of reg and imm" severity error;
		
		-- R(2) = R(15) - R(14)
		Rn <= "1111";
		Rm <= "1110";
		Rd <= "0010";
		ALUsrc <= '0';
		ALUctr <= "10";
		wait for clk_period;
		assert busout = x"FFFFFF95" report "ERROR on SUB of 2 reg"         severity error;
		assert  N = '1'      report "ERROR on Flag of SUB of 2 reg" severity error;
	
		-- Soustraction Offset
		Rn <= "1110";
		Rd <= "1110";
		Imm <= x"59";
		ALUsrc <= '1';
		wait for 1 ps;
		assert busout = x"00000042" report "ERROR on SUB of imm from reg"         severity error;
		assert  N = '0'     report "ERROR on Flag of SUB of imm from reg" severity error;
		wait until clk = '1';
	
		-- R(11) = R(2)
		Rn <= "0010";
		Rd <= "1011";
		ALUctr <= "11";
		wait for clk_period;
		assert busout = x"FFFFFF95" report "ERROR on copy from one register to another"         severity error;
		assert  N = '1'       report "ERROR on FLag of copy from one register to another" severity error;

		-- Write
		RegWr <= '0';
		Rm <= "1110";
		Imm <= x"23"; 
		ALUsrc <= '1';
		ALUctr <= "01";
		wait for 1 ps;
		MemWr <= '1';
		wait until clk ='1';
		assert busout = x"00000023" report "ERROR on Addr for write in memory" severity error;
		
		-- Read
		MemWr <= '0';
		Rd <= "1000";
		WrSrc <= '1';
		RegWr <= '1';
		wait for clk_period;
		assert busout = x"00000042" report "ERROR on write or read in memory" severity error;
		
		report "End of test. Verify that no error was reported.";
		done <= '1';
		wait;
	end process;
	
end architecture;