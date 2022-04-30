library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Instruction_Management_Unit is 
	port (
		clk, rst, nPCsel : in  std_logic ; 
		Instruction : out std_logic_vector(31 downto 0);
		Offset : in std_logic_vector(23 downto 0)
	);
end entity;


architecture behave of Instruction_Management_Unit is
	signal PC, S : std_logic_vector(31 downto 0);  
begin

	Instruction_memory2 : entity work.instruction_memory2 port map (PC=> PC, Instruction=> Instruction); 
	Sign_Extension  : entity work.Sign_Extension  generic map(N=> 24) port map ( E => Offset, S => S); 

	process(clk, rst) 
	begin 
	if rst ='1' then 
		PC <= (others => '0'); 
	elsif rising_edge(clk) then 
		if nPCsel = '0' then 
			PC <= std_logic_vector(unsigned(PC)+1);	
		else 
			PC <= std_logic_vector(unsigned(PC)+1+ unsigned(S));	
		end if; 
	end if; 
	end process; 
end architecture;
