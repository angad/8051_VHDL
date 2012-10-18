library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ext_interrupt is
    Port ( clk : in  std_logic;
    		 rst : in  std_logic;
		 clear : in std_logic;
		 in_tcon : in std_logic_vector (7 downto 0);   		 
    		 int_tcon : out std_logic_vector (7 downto 0);      
           oP3_2 : in std_logic;
           oP3_3 : in std_logic
           );
end ext_interrupt;

architecture Behavioral of ext_interrupt is

signal fd_out1:std_logic_vector(7 downto 0);
signal fd_out2:std_logic_vector(7 downto 0);
signal old_oP3_2:std_logic;
signal old_oP3_3:std_logic;

begin 

	process (clk, rst, clear, in_tcon, oP3_2, oP3_3)

begin

if (rst = '1') then
	fd_out1 <= (others => '0');
	fd_out2 <= (others => '0');
	old_oP3_2 <= '0';
	old_oP3_3 <= '0';
	--int_tcon(1) <= '0';
	--int_tcon(3) <= '0';

elsif (clear = '1') then
	fd_out1 <= in_tcon;
	fd_out2 <= in_tcon;
	int_tcon <= in_tcon;

else if(clk'event and clk = '1') then

	if(in_tcon(0) = '0') then 
	 	if(oP3_2 = '1') then 
			fd_out1 <= in_tcon or "00000010";
		else
			fd_out1 <= in_tcon and "11111101";
		end if;
	elsif(in_tcon(0) = '1') then
		fd_out1(0) <= in_tcon(0);
		--fd_out1(1) <= in_tcon(1); 
	end if;

	if(in_tcon(2) = '0') then 
	 	if(oP3_3 = '1') then 
			fd_out2 <= in_tcon or "00001000";
		else
			fd_out2 <= in_tcon and "11110111";
		end if;
	elsif(in_tcon(2) = '1') then
		fd_out2(2) <= in_tcon(2);
		--fd_out2(3) <= in_tcon(3);	
	end if;

	old_oP3_2 <= oP3_2;
	old_oP3_3 <= oP3_3;



	if(oP3_2 = '1' and old_oP3_2 = '0' ) then	  --to detect a rising edge of oP3_2
		if(in_tcon(0) = '1') then
			fd_out1 <= in_tcon or "00000010";
		else 
			fd_out1 <= in_tcon and "11111101";
		end if;

	end if;

	--if(oP3_3'event and oP3_3 = '1' ) then
	if(oP3_3 = '1' and old_oP3_3 = '0' ) then	   --to detect a rising edge of oP3_3
		if(in_tcon(2) = '1') then
			fd_out2 <= in_tcon or "00001000";
		else 
			fd_out2 <= in_tcon and "11110111";
		end if;
	
	end if;
	
	int_tcon <= fd_out1(7 downto 4) & fd_out2(3 downto 2) & fd_out1(1 downto 0);
	--int_tcon <= fd_out1(7 downto 4) & fd_out2(3) & fd_out1(2 downto 0);
	
end if;
end if;	
	end process;
end Behavioral; 

