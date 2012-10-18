library IEEE; 
use IEEE.std_logic_1164.all; 
use IEEE.std_logic_arith.all; 
  
entity divider is  
  port (
  	clk		: in  std_logic;
  	reset		: in  std_logic;
  	dividend_i	: in  std_logic_vector(15 downto 0);
        divisor_i	: in  std_logic_vector(15 downto 0);
        quotient_o	: out std_logic_vector(15 downto 0); 
        remainder_o	: out std_logic_vector(15 downto 0);
	done		: out std_logic
  );
      
end divider;

architecture rtl of divider is
  signal i			: integer range 0 to 15;
  signal ended		: std_logic;
  signal dividend_shift	: std_logic_vector(15 downto 0);
  signal divisor		: std_logic_vector(15 downto 0);
  signal next_quotient	: std_logic_vector(15 downto 0);
  signal next_remainder	: std_logic_vector(15 downto 0);    
  signal quotient		: std_logic_vector(15 downto 0);
  signal remainder	: std_logic_vector(15 downto 0);    
  signal olddividend_i	: std_logic_vector(15 downto 0);  
  signal olddivisor_i	: std_logic_vector(15 downto 0);  
begin  -- rtl
  -- purpose: Divide dividend through divisor and deliver the result to quotient
  --          and the remainder to remainder.
  -- Performs a synchronous tail division.
  
  p_divide: process (dividend_shift, divisor, quotient, remainder, i)
  	variable v_quo : std_logic_vector(15 downto 0);
  	variable v_rem : std_logic_vector(15 downto 0);
  begin  -- process p_divide
	-- initialization	
	v_quo := quotient;
	v_rem := remainder;
	
	-- shift in new bit from dividend
	v_rem(15 downto 1) := remainder(14 downto 0);
	v_rem(0) := dividend_shift(15);
				
	-- if divisor can be subtracted from current remainder, do it and set
	-- current quotient bit to '1'
	if v_rem >= divisor then
       		v_quo(0) := '1';
       		v_rem := conv_std_logic_vector (unsigned (v_rem) - unsigned (divisor), 16);
       	else
       		v_quo(0) := '0';
       	end if;
 	
 	next_quotient <= v_quo;
 	next_remainder <= v_rem;
  end process p_divide;
 
  process (clk)
  begin
  	if (clk'event and clk = '1') then
  		remainder <= next_remainder;
  		quotient(15 downto 1) <= next_quotient(14 downto 0);
  		dividend_shift(15 downto 1) <= dividend_shift(14 downto 0);
  		
  		if (reset = '1' or dividend_i /= olddividend_i or divisor_i /= olddivisor_i) then
  			i <= 15;
  			done <= '0';
  			ended <= '0';
  			remainder <= (others => '0');
  			quotient <= (others => '0');
  			dividend_shift <= dividend_i;
  			divisor <= divisor_i;
			olddividend_i <= dividend_i;
			olddivisor_i <= divisor_i;
  		elsif (i > 0) then
  			i <= i - 1;
  		elsif (ended = '0') then
  			remainder_o <= next_remainder;
  			quotient_o <= next_quotient;
  			done <= '1';
  			ended <= '1';
  		end if;
  	end if;
  end process;

end rtl;
