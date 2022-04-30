library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity Register_Charge is 
	port (
	clk, rst, WE : in  std_logic ; 
	DataOut : out std_logic_vector(31 downto 0);
	DataIn : in std_logic_vector(31 downto 0)
	);
end entity;

architecture behave of Register_Charge is
begin

process(clk, rst) 
	begin 
		if rst ='1' then 
			DataOut <= (others => '0'); 
		elsif rising_edge(clk) then 
			if WE = '1' then 
				DataOut <= DataIn;	
			end if; 
		end if; 
	end process; 

end architecture;
