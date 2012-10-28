library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity int_rom is
port(
		clk      : in  std_logic;
		rst      : in  std_logic;
		rd       : in  std_logic;
		addr     : in  std_logic_vector (15 downto 0);
		data     : out std_logic_vector (7 downto 0)
);
end int_rom;

architecture Behavioral of int_rom is
	type rom_type is array (0 to 4095) of STD_LOGIC_VECTOR (7 downto 0);
	constant PROGRAM : ROM_TYPE := (

	--3rd Oct
-- "00000011", --RR A (Rotate ACC Right)


--	"01011000", -- ANL A, Rn
--	"01001000", -- ORL A, Rn
--	"01101000", -- XRL A, Rn

--	"01010101",	-- ANL A, direct
--	"00111111", --x3f address
	
--	"01000101", -- ORL A, direct
--	"00111111", --x3f address
	
--	"01100101", -- XRL A, direct
--	"00111111", --x3f address

--	"01010110", -- ANL A, @Ri
--	"01100110", -- XRL A, @Ri
--	"01000110", -- ORL A, @Ri

-- "01010100", -- ANL, A, #data
--	"00001010", -- #data
	
-- "01000100", -- ORL, A, #data
--	"00001010", -- #data

-- "01100100", -- XRL, A, #data
--	"00001010", -- #data

	
--	"00010011", --RRC A (Rotate ACC right through carry flag)
-- "00100011", --RL A (Rotate ACC Left)

--	"00110011", --RLC A (Rotate ACC Left through carry flag)
-- "11000100", --SWAP (Swap nibbles through ACC)
	--
	
--	"11101001", --LABEL1: MOV A,R1
--	"00100100", --ADD A,#01H
--	"00000001",
--	"11111001", --MOV R1,A
--	"10111001", --CJNE R1,#04H,LABEL1
--	"00000100",
--	"11111001",
--	"10001001", --MOV 90H,R1
--	"10010000",
	others => "00000000"
);

	begin

	process (rst, rd, addr)
	begin
		if( rst = '1' ) then
			data <= "--------";
		elsif( rd = '1' ) then
			data <= PROGRAM(conv_integer(addr));
		else
			data <= "--------";
		end if;
	end process;
end Behavioral;
