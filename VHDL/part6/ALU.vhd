library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU is
  port(
    op:in std_logic_vector(1 downto 0);
    a,b: in std_logic_vector(31 downto 0);
    s: out std_logic_vector(31 downto 0);
    n: out std_logic;
    Z: out std_logic
  );
end entity;

architecture behav of ALU is
  signal sign: std_logic_vector(31 downto 0);
  begin 
    process (a,b,op)
    begin 
      case op is 
        when"00" => sign <=std_logic_vector(signed(a)+signed(b)); 
        when"01" => sign <= b; 
        when"10" => sign <=std_logic_vector(signed(a)-signed(b)); 
        when"11" => sign <= a;
        when others => sign <= a; 
      end case ;
  end process;
  with sign select
    Z <= '1' when x"00000000",
        '0' when others;
  N <= sign(31);
  s <= sign;
end architecture; 
