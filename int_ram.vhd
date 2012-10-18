library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_ARITH.all;
use ieee.std_logic_unsigned.all;
use work.constants.all;

entity internal_ram is 
port (
	clk : in std_logic;
	rst : in std_logic; 
 	wrByte   : in std_logic; 
 	wrBit   : in std_logic; 

 	rdByte   : in std_logic; 
 	rdBit   : in std_logic; 

 	addr : in std_logic_vector(7 downto 0); 

 	diByte  : in std_logic_vector(7 downto 0); 
 	diBit   : in std_logic; 

 	doByte   : out std_logic_vector(7 downto 0); 
 	doBit   : out std_logic); 
end internal_ram; 
 
architecture syn of internal_ram is 
type ram_type is array (127 downto 0) of std_logic_vector (7 downto 0); 
signal RAM : ram_type; 
 
begin 
process (clk, rst, rdByte, rdBit, addr) 
	begin 
	if (rst = '1') then
		for i in 1 to 127 loop
			RAM(i) <= "00000000";
		end loop;
		RAM(0) <= "00000011";
		doByte <= "ZZZZZZZZ";
		doBit <= 'Z';

	elsif (rdByte = '1') then
		if (addr(7) = '0') then
			doByte <= RAM(conv_integer(addr(6 downto 0)));
		else
			doByte <= "ZZZZZZZZ";
		end if;
		
	elsif (rdBit = '1') then
		if (addr(7) = '0') then
			doBit <= RAM(conv_integer("0010"&addr(6 downto 3)))(conv_integer(addr(2 downto 0)));
		else
			doBit <= 'Z';
		end if;

	elsif (clk'event and clk = '1') then  
		if (wrByte = '1' and addr(7) = '0') then
			RAM(conv_integer(addr(6 downto 0))) <= diByte;
		end if;
		
		if (wrBit = '1' and addr(7) = '0') then
			RAM(conv_integer("0010"&addr(6 downto 3)))(conv_integer(addr(2 downto 0))) <= diBit;
		end if;
	end if;
end process; 
end syn;
 

