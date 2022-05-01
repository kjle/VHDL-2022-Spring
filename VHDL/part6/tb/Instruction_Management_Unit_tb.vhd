library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Instruction_Management_Unit_tb IS

END entity ;

architecture BENCH of Instruction_Management_Unit_tb is
	signal Instruction :  std_logic_vector(31 downto 0);
	signal Clk  :  std_logic := '0';
	signal rst, nPCsel :  std_logic;
	signal Offset : std_logic_vector(23 downto 0);
	signal Done : boolean := False; 
	constant Period : time := 20 ns;
	
begin

	UUT : entity work.Instruction_Management_Unit port map(clk=>clk, rst=> rst, nPCsel =>nPCsel, Offset => Offset,Instruction => Instruction); 
	
	CLK <= '0' when Done else not CLK after Period / 2;
	Rst <= '1', '0' after 5 ns; 
	
	process
	begin
		
		nPCsel<= '0'; 
		Offset <= (others => '0'); -- PC <= PC + 1 
		wait for 20 ns;
		
		nPCsel<= '0'; 
		Offset <= (others => '0'); -- PC <= PC + 1 
		wait for 20 ns;
		
		nPCsel<= '1'; 
		Offset <= x"000001"; -- PC <= PC + 1 + Offset 1 
		wait for 20 ns;
		
		nPCsel<= '0'; 
		Offset <= (others => '0'); -- PC <= PC + 1
		wait for 20 ns;
		
		nPCsel<= '1'; 
		Offset <= x"FFFFFF"; -- PC <= PC + 1 + Offset -1 
		wait for 20 ns;
		
		nPCsel<= '0'; 
		Offset <= (others => '0'); -- PC <= PC + 1 
		wait for 20 ns;
		
		Done <= True; 
		wait;
		
	end process;

end architecture;
