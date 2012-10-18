----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    18:46:50 10/28/2006 
-- Design Name: 
-- Module Name:    fastalu - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use work.constants.all;

-- 8/16 bit Arithmetic and Logic Unit - top level entity.

entity fastalu is port (
	op_code	: in  std_logic_vector (3 downto 0);
      -- What operation

	src_1L	: in  std_logic_vector (7 downto 0);
	src_1H	: in  std_logic_vector (7 downto 0);
	src_2L	: in  std_logic_vector (7 downto 0);
	src_2H	: in  std_logic_vector (7 downto 0);
     -- Input Operands each split into Lower(7-0) and Higher(15-8) bits. 
	
	by_wd	: in  std_logic;             -- byte(0)/word(1) instruction
	cy_bw	: in  std_logic;             -- carry/borrow bit
	
	ans_L	: out std_logic_vector (7 downto 0);
	ans_H	: out std_logic_vector (7 downto 0);
     -- Result, lower and higher

	alu_cy	: out std_logic;             -- carry out of bit 7/15
	alu_ac	: out std_logic;		    -- carry out of bit 3/7
	alu_ov	: out std_logic);		    -- overflow

end fastalu; 	  	

architecture fastalu_arch of fastalu is
component csadder is
    Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
           B : in  STD_LOGIC_VECTOR (15 downto 0);
			  S : out STD_LOGIC_VECTOR (15 downto 0);
           cin : in  STD_LOGIC;
           carry4 : out  STD_LOGIC;
           carry7 : out  STD_LOGIC;
		 carry8 : out  STD_LOGIC;
		 carry15 : out  STD_LOGIC;
           carry16 : out  STD_LOGIC);
end component;

signal AI, BI, SI : std_logic_vector(15 downto 0);
signal ci : std_logic;
signal int_c4, int_c7, int_c8, int_c15, int_c16 : std_logic;
signal sub	: std_logic;
begin

adder_comp :		csadder  
						port map 
						(
							A => AI, 
							B => BI, 
							S => SI, 
							cin => ci, 
							carry4 => int_c4, 
							carry7 => int_c7, 
							carry8 => int_c8,
							carry15 => int_c15,
							carry16 => int_c16
						);

process(op_code, src_1L, src_2L, src_1H, src_2H, cy_bw, by_wd, SI,int_c4, int_c7, int_c8, int_c15, int_c16)
begin

	AI <= (others => '0');
	BI <= (others => '0');
	ans_H <= (others => '0');
	ans_L <= (others => '0');
	ci <= '0';
	sub <= '0';

	--alu_ac <= int_ac;
	--alu_ov <= int_ov;
	--alu_cy <= int_cy;

	case op_code is

	when ALU_OPC_ADD =>
		AI	<= src_1H & src_1L;
		BI	<= src_2H & src_2L;
		ans_H <= SI(15 downto 8);
		ans_L <= SI(7 downto 0);
		
		if (by_wd = '0') then
			AI(15 downto 8)	<= (others => '0');
			BI(15 downto 8)	<= (others => '0');
			ans_H <= (others => '0');
		end if;
		
		ci <= '0';
		sub <= '0';

	when ALU_OPC_ADC =>      -- add with carry
		AI	<= src_1H & src_1L;
		BI	<= src_2H & src_2L;
		ans_H <= SI(15 downto 8);
		ans_L <= SI(7 downto 0);
		
		if (by_wd = '0') then
			AI(15 downto 8)	<= (others => '0');
			BI(15 downto 8)	<= (others => '0');
			ans_H <= (others => '0');
		end if;
		
		ci <= cy_bw;
		sub <= '0';

	when ALU_OPC_SUB => -- subtract
		AI	<= src_1H & src_1L;
		BI	<= not(src_2H) & not(src_2L);
		ans_H <= SI(15 downto 8);
		ans_L <= SI(7 downto 0);
		
		if (by_wd = '0') then
			AI(15 downto 8)	<= (others => '0');
			BI(15 downto 8)	<= (others => '0');
			ans_H <= (others => '0');
		end if;
		
		ci <= '1';
		sub <= '1';

	when ALU_OPC_SBB => -- subtract with borrow
		AI	<= src_1H & src_1L;
		BI	<= not(src_2H) & not(src_2L);
		ans_H <= SI(15 downto 8);
		ans_L <= SI(7 downto 0);
		
		if (by_wd = '0') then
			AI(15 downto 8)	<= (others => '0');
			BI(15 downto 8)	<= (others => '0');
			ans_H <= (others => '0');
		end if;
		
		ci <= not(cy_bw);
		sub <= '1';

	when ALU_OPC_DEC => -- decrement
		AI	<= src_1H & src_1L;
		BI	<= (others => '1');
		ans_H <= SI(15 downto 8);
		ans_L	<= SI(7 downto 0);
		
		if (by_wd = '0') then
			AI(15 downto 8)	<= (others => '0');
			BI(15 downto 8)	<= (others => '0');
			ans_H		<= (others => '0');
		end if;
		
		ci <= '0';
		sub <= '0';

	when ALU_OPC_INC => -- increment
		AI	<= src_1H & src_1L;
		BI	<= (others => '0');
		ans_H <= SI(15 downto 8);
		ans_L	<= SI(7 downto 0);
		
		if (by_wd = '0') then
			ans_H		<= (others => '0');
		end if;
		
		ci <= '1';
		sub <= '0';

	-- logic operations
--	when ALU_OPC_NOT =>
--		ans_L		<= not src_1L;
--		
--		if (by_wd = '1') then
--			ans_H		<= not src_1H;
--		else
--			ans_H		<= (others => '0');
--		end if;
--
	when ALU_OPC_AND =>
		ans_L		<= src_1L and src_2L;
		
		if (by_wd = '1') then
			ans_H		<= src_1H and src_2H;
		else
			ans_H		<= (others => '0');
		end if;

	when ALU_OPC_XOR =>
		ans_L		<= src_1L xor src_2L;
		
		if (by_wd = '1') then
			ans_H		<= src_1H xor src_2H;
		else
			ans_H		<= (others => '0');
		end if;

	when ALU_OPC_OR =>
		ans_L		<= src_1L or src_2L;
		
		if (by_wd = '1') then
			ans_H		<= src_1H or src_2H;
		else
			ans_H		<= (others => '0');
		end if;

--	when ALU_OPC_NEG =>
--		AI	<= (others => '0');
--		BI	<= not(src_1H) & not(src_1L);
--		ans_H <= SI(15 downto 8);
--		ans_L <= SI(7 downto 0);
--		
--		if (by_wd = '0') then
--			AI(15 downto 8)	<= (others => '0');
--			BI(15 downto 8)	<= (others => '0');
--			ans_H <= (others => '0');
--		end if;
--		
--		ci <= '1';

	when others =>
   end case;


end process;

   -- flag process
process(by_wd, sub, SI)
   variable v	:	std_logic_vector(1 downto 0);
   begin
   v := by_wd & sub;
	   case v is
		when "00" =>	alu_cy <= int_c8;
					alu_ac <= int_c4;
					alu_ov <= int_c8 xor int_c7;
		when "01" =>	alu_cy <= not int_c8;
					alu_ac <= not int_c4;
					alu_ov <= not int_c8 xor not int_c7;
		when "10" =>	alu_cy <= int_c16;
					alu_ac <= int_c8;
					alu_ov <= int_c16 xor int_c15;
		when "11" =>	alu_cy <= not int_c16;
					alu_ac <= not int_c8;
					alu_ov <= not int_c16 xor not int_c15;
		when others =>	alu_cy <= int_c8;
					alu_ac <= int_c4;
					alu_ov <= int_c8 xor int_c7;
	   end case; 
end process	; -- end flag process

end fastalu_arch;