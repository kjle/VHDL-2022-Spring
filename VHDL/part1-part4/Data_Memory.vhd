library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Data_Memory  is 
	port (
		clk, rst, WE : in  std_logic ; 
		Addr : in std_logic_vector(5 downto 0);
		DataOut : out std_logic_vector(31 downto 0);
		DataIn : in std_logic_vector(31 downto 0)
	);
end entity;

architecture behave of Data_Memory  is
	type matrix is array(63 downto 0) of std_logic_vector(31 downto 0);
	signal datas: matrix;
begin

	DataOut <= datas(to_integer(unsigned(Addr))); 
	process(clk, rst) 
	begin 
		if rst ='1' then 
			for i in 63 downto 0 loop
				datas(i) <= std_logic_vector(to_unsigned(i,32));
			end loop;
			-- data initialization for part 6
			-- datas(32) <= x"00000003";
			-- datas(33) <= x"0000006B";
			-- datas(34) <= x"0000001B";
			-- datas(35) <= x"0000000C";
			-- datas(36) <= x"00000142";
			-- datas(37) <= x"0000009B";
			-- datas(39) <= x"0000003F";
		elsif rising_edge(clk) then 
			if WE = '1' then 
				datas(to_integer(unsigned(Addr)))<=DataIn; 
			end if; 
		end if; 
	end process; 

end architecture;
