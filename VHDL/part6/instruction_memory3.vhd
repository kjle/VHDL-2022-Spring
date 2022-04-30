library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity instruction_memory3 is
	port(
		PC: in std_logic_vector (31 downto 0);
		Instruction: out std_logic_vector (31 downto 0)
	);
end entity;

architecture behave of instruction_memory3 is
	type RAM64x32 is array (0 to 63) of std_logic_vector (31 downto 0);
	
function init_mem return RAM64x32 is 
	variable result : RAM64x32;
begin
	for i in 63 downto 0 loop
		result (i):=(others=>'0');
	end loop;  				   	-- PC         -- INSTRUCTION      -- COMMENTAIRE
		result (0) :=x"E3A00020";-- 0x0 _start-- MOV R0,#0x20     -- R0 = 0x20
		result (1) :=x"E3A02001";-- 0x1		  -- MOV R2,#1        -- R2 = 1
		result (2) :=x"E3A02000";-- 0x2 _while-- MOV R2,#0        -- R2 = 0 
		result (3) :=x"E3A01001";-- 0x3		  -- MOV R1,#1        -- R1 = 1
		result (4) :=x"E6103000";-- 0x4 _for  -- LDR R3,[R0]      -- R3 = DATAMEM[R0]
		result (5) :=x"E6104001";-- 0x5		  -- LDR R4,R0,#1     -- R4 = DATAMEM[R0+1]
		result (6) :=x"E1530004";-- 0x6		  -- CMP R3, R4       -- si R3 < R4
		result (7) :=x"C6004000";-- 0x7		  -- STRGT R4,[R0]    -- DATAMEM[R0] = R4
		result (8) :=x"C6003001";-- 0x8		  -- STRGT R3,[R0,#1] -- DATAMEM[R0+1] = R3
		result (9) :=x"C2822001";-- 0x9		  -- ADDGT R2,R2,#1   -- R2 = R2 + 1
		result (10):=x"E2800001";-- 0xA       -- ADD R0, R0, #1   -- R0 = R0 + 1
		result (11):=x"E2811001";-- 0xB       -- ADD R1, R1, #1   -- R1 = R1 + 1
		result (12):=x"E3510007";-- 0xC       -- CMP R1, #0x07    -- si R1 < 7
		result (13):=x"BAFFFFF6";-- 0xD       -- BLT FOR	      -- PC = PC + 1 + (-10)
		result (14):=x"E3520000";-- 0xE       -- CMP R2, #0	      -- si R2 < 0
		result (15):=x"E3A00020";-- 0xF       -- MOV R0, #0x20    -- R0 = 0x20
		result (16):=x"1AFFFFF1";-- 0x10      -- BNE WHILE        -- PC = PC + 1 + (-15)
		result (17):=x"EAFFFFFF";-- 0x11 _wait-- BAL wait	      -- PC = PC + 1 + (-1)
	return result;
end init_mem;	

signal mem: RAM64x32 := init_mem;

begin 
	Instruction <= mem(to_integer (unsigned (PC(5 downto 0))));
end architecture;