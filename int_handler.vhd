library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

--  Uncomment the following lines to use the declarations that are
--  provided for instantiating Xilinx primitive components.
--library UNISIM;
--use UNISIM.VComponents.all;

entity int_handler is
    Port ( clk : in std_logic;
           rst : in std_logic;
           IE_reg : in std_logic_vector(7 downto 0);
           SCON_reg : in std_logic_vector(7 downto 0);
           TCON_reg : in std_logic_vector(7 downto 0);
           int_select : out std_logic_vector(2 downto 0));
end int_handler;

architecture Behavioral of int_handler is

begin

	process (clk, rst, IE_reg, SCON_reg, TCON_reg)

begin

if (rst = '1') then
	int_select <= "000";

elsif(clk'event and clk = '1') then

	if(IE_reg(7) = '0') then
		int_select <= "000";

	elsif(IE_reg(0) = '1' and TCON_reg(1) = '1') then
		int_select <= "001";
	
	elsif(IE_reg(1) = '1' and TCON_reg(5) = '1') then
		int_select <= "010";

	elsif(IE_reg(2) = '1' and TCON_reg(3) = '1') then
		int_select <= "011";
	
	elsif(IE_reg(3) = '1' and TCON_reg(7) = '1') then
		int_select <= "100";

	elsif(IE_reg(4) = '1' and (SCON_reg(1) = '1' or SCON_reg(0) = '1')) then
		int_select <= "101";

	else
		int_select <= "000";

	end if;
	
end if;

end process;

end Behavioral;
