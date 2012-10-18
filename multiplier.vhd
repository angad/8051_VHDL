library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 
  
entity multiplier is
  generic (DWIDTH : integer := 16);

  port (
  	clk	: in  std_logic;
  	a_i	: in  std_logic_vector(DWIDTH-1 downto 0);  -- Multiplicand
      b_i	: in  std_logic_vector(DWIDTH-1 downto 0);  -- Multiplicator
      prod_o 	: out std_logic_vector((DWIDTH*2)-1 downto 0) -- Product
  );
end multiplier;

architecture rtl of multiplier is
        signal prod 	: std_logic_vector((DWIDTH*2)-1 downto 0); -- Product
begin  
  process (a_i, b_i)
    variable v_product : unsigned(DWIDTH*2-1 downto 0);    
  begin
    v_product := conv_unsigned(unsigned(a_i) * unsigned(b_i), DWIDTH*2);
    prod <= std_logic_vector(v_product);
  end process;
  
  clock: process (clk)
  begin
  	if (clk'event and clk = '1') then
	  	prod_o <= std_logic_vector(prod);
  	end if;
  end process;
end rtl;

