library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity i8051_top is 
port (
        	clk          : in  std_logic;
        	rst          : in  std_logic;
		ale		 : out std_logic;
		psen		 : out std_logic;
		ea		 : in  std_logic;
        	p0_in        : in  std_logic_vector (7 downto 0);
        	p0_out       : out std_logic_vector (7 downto 0);
        	p1_in        : in  std_logic_vector (7 downto 0);
        	p1_out       : out std_logic_vector (7 downto 0);
        	p2_in        : in  std_logic_vector (7 downto 0);
        	p2_out       : out std_logic_vector (7 downto 0);
        	p3_in        : in  std_logic_vector (7 downto 0);
        	p3_out       : out std_logic_vector (7 downto 0);
		
		pc_debug	 : out std_logic_vector (15 downto 0));
		--testing	: in std_logic_vector (1 downto 0));
end i8051_top;

architecture Behavioral of i8051_top is
	component sequencer2 is  
	port(
		rst              	: in  std_logic;
		clk              	: in  std_logic;
		ale		  	: out std_logic;
		psen		 	: out std_logic;
		
		alu_op_code	 	: out  std_logic_vector (3 downto 0);
		alu_src_1L		: out  std_logic_vector (7 downto 0);
		alu_src_1H		: out  std_logic_vector (7 downto 0);
		alu_src_2L		: out  std_logic_vector (7 downto 0);
		alu_src_2H		: out  std_logic_vector (7 downto 0);	
		alu_by_wd		: out  std_logic;             -- byte(0)/word(1) instruction
		alu_cy_bw		: out  std_logic;             -- carry/borrow bit
		alu_ans_L		: in std_logic_vector (7 downto 0);
		alu_ans_H		: in std_logic_vector (7 downto 0);
		alu_cy		: in std_logic;				-- carry out of bit 7/15
		alu_ac		: in std_logic;				-- carry out of bit 3/7
		alu_ov		: in std_logic;				-- overflow
		
		dividend_i		: out std_logic_vector(15 downto 0);
		divisor_i		: out std_logic_vector(15 downto 0);
		quotient_o		: in std_logic_vector(15 downto 0); 
		remainder_o	 	: in std_logic_vector(15 downto 0);
		div_done		: in std_logic ;

		mul_a_i		: out std_logic_vector(15 downto 0);	-- Multiplicand
		mul_b_i		: out std_logic_vector(15 downto 0);	-- Multiplicator
		mul_prod_o 	 	: in std_logic_vector(31 downto 0) ;	-- Product
		
		i_ram_wrByte   	: out std_logic; 
		i_ram_wrBit   	: out std_logic; 
		i_ram_rdByte   	: out std_logic; 
		i_ram_rdBit   	: out std_logic; 
		i_ram_addr 	 	: out std_logic_vector(7 downto 0); 
		i_ram_diByte  	: out std_logic_vector(7 downto 0); 
		i_ram_diBit   	: out std_logic; 
		i_ram_doByte   	: in std_logic_vector(7 downto 0); 
		i_ram_doBit   	: in std_logic; 
		
	    	i_rom_addr        : out std_logic_vector (15 downto 0);
	    	i_rom_data        : in  std_logic_vector (7 downto 0);
		i_rom_rd          : out std_logic;
		
		pc_debug	 	: out std_logic_vector (15 downto 0);
		interrupt_flag	: in  std_logic_vector (2 downto 0);
		erase_flag	 	: out std_logic);

	end component;

	component fastalu is port (
		op_code	: in  std_logic_vector (3 downto 0);
	 	src_1L	: in  std_logic_vector (7 downto 0);
		src_1H	: in  std_logic_vector (7 downto 0);
		src_2L	: in  std_logic_vector (7 downto 0);
		src_2H	: in  std_logic_vector (7 downto 0);
		by_wd		: in  std_logic;             -- byte(0)/word(1) instruction
		cy_bw		: in  std_logic;             -- carry/borrow bit
		ans_L		: out std_logic_vector (7 downto 0);
		ans_H		: out std_logic_vector (7 downto 0);
	 	alu_cy	: out std_logic;            -- carry out of bit 7/15
		alu_ac	: out std_logic;		    -- carry out of bit 3/7
		alu_ov	: out std_logic);		    -- overflow
	end component; 	  

	component regfile is
	port (
	 	rst		:	in std_logic;
		clk		:	in std_logic;
		addr 		: 	in std_logic_vector(7 downto 0);
		wrBit		:	in std_logic;
		wrByte	:	in std_logic;
		rdBit		:	in std_logic;
		rdByte	:	in std_logic;
		
		diBit		:	in std_logic;
		diByte	:	in std_logic_vector(7 downto 0);

		doBit		:	out std_logic;
		doByte	:	out std_logic_vector(7 downto 0);

		P0_out	:	out std_logic_vector(7 downto 0);
		P1_out	:	out std_logic_vector(7 downto 0);
		P2_out	:	out std_logic_vector(7 downto 0);
		P3_out	:	out std_logic_vector(7 downto 0);

		IE_out	:	out std_logic_vector(7 downto 0);
		SCON_out	:	out std_logic_vector(7 downto 0);
		TCON_out	:	out std_logic_vector(7 downto 0);
		erase_int 	:	in std_logic;

		P0_in		:	in std_logic_vector(7 downto 0);
		P1_in		:	in std_logic_vector(7 downto 0);
		P2_in		:	in std_logic_vector(7 downto 0);
		P3_in		:	in std_logic_vector(7 downto 0));
	end component;

	component multiplier is
	  generic (DWIDTH : integer := 16);
	  port (
	  	clk		: in  std_logic;
	  	a_i		: in  std_logic_vector(DWIDTH-1 downto 0);  -- Multiplicand
		b_i		: in  std_logic_vector(DWIDTH-1 downto 0);  -- Multiplicator
		prod_o 	: out std_logic_vector((DWIDTH*2)-1 downto 0)); -- Product
	end component;

	component int_rom is
	port(
	    clk      : in  std_logic;
		rst      : in  std_logic;
		rd       : in  std_logic;
		addr     : in  std_logic_vector (15 downto 0);
		data     : out std_logic_vector (7 downto 0));
	end component;

	component internal_ram is 
	 port (
		clk 	 	: in std_logic;
		rst 	 	: in std_logic; 
	 	
		wrByte   	: in std_logic; 
	 	wrBit    	: in std_logic; 
	 	rdByte   	: in std_logic; 
	 	rdBit    	: in std_logic; 

	 	addr 	 	: in std_logic_vector(7 downto 0); 

	 	diByte   	: in std_logic_vector(7 downto 0); 
	 	diBit    	: in std_logic; 
	 	doByte   	: out std_logic_vector(7 downto 0); 
	 	doBit    	: out std_logic); 
	 end component; 

	 component divider is  
	  port (
	  	clk		: in  std_logic;
	  	reset		: in  std_logic;
	  	dividend_i	: in  std_logic_vector(15 downto 0);
		divisor_i	: in  std_logic_vector(15 downto 0);
		quotient_o	: out std_logic_vector(15 downto 0); 
		remainder_o	: out std_logic_vector(15 downto 0);
		done		: out std_logic);
	end component;

	component int_handler is
	 port (
	 	clk : in std_logic;
          	rst : in std_logic;
          	IE_reg : in std_logic_vector(7 downto 0);
          	SCON_reg : in std_logic_vector(7 downto 0);
          	TCON_reg : in std_logic_vector(7 downto 0);
          	int_select : out std_logic_vector(2 downto 0));
	end component;

signal alu_op_code	 : std_logic_vector (3 downto 0);
signal alu_src_1L		 : std_logic_vector (7 downto 0);
signal alu_src_1H		 : std_logic_vector (7 downto 0);
signal alu_src_2L		 : std_logic_vector (7 downto 0);
signal alu_src_2H		 : std_logic_vector (7 downto 0);
signal alu_by_wd		 : std_logic;				-- byte(0)/word(1) instruction
signal alu_cy_bw		 : std_logic;				-- carry/borrow bit
signal alu_ans_L		 : std_logic_vector (7 downto 0);
signal alu_ans_H		 : std_logic_vector (7 downto 0);
signal alu_cy		 : std_logic;				-- carry out of bit 7/15
signal alu_ac		 : std_logic;				-- carry out of bit 3/7
signal alu_ov		 : std_logic;				-- overflow

signal dividend_i		 : std_logic_vector(15 downto 0);
signal divisor_i		 : std_logic_vector(15 downto 0);
signal quotient_o		 : std_logic_vector(15 downto 0); 
signal remainder_o	 : std_logic_vector(15 downto 0);
signal div_done		 : std_logic ;

signal mul_a_i		 : std_logic_vector(15 downto 0);	-- Multiplicand
signal mul_b_i		 : std_logic_vector(15 downto 0);	-- Multiplicator
signal mul_prod_o 	 : std_logic_vector(31 downto 0);

signal i_ram_wrByte   	 : std_logic; 
signal i_ram_wrBit   	 : std_logic; 
signal i_ram_rdByte   	 : std_logic; 
signal i_ram_rdBit   	 : std_logic; 
signal i_ram_addr 	 : std_logic_vector(7 downto 0); 
signal i_ram_diByte  	 : std_logic_vector(7 downto 0); 
signal i_ram_diBit   	 : std_logic; 
signal i_ram_doByte   	 : std_logic_vector(7 downto 0); 
signal i_ram_doBit   	 : std_logic; 

signal i_rom_addr        : std_logic_vector (15 downto 0);
signal i_rom_data        : std_logic_vector (7 downto 0);
signal i_rom_rd          : std_logic;

signal ie_reg		 : std_logic_vector (7 downto 0);
signal scon_reg		 : std_logic_vector (7 downto 0);
signal tcon_reg		 : std_logic_vector (7 downto 0);

signal i_flag	 	:  std_logic_vector (2 downto 0);
signal clear_flag 	: std_logic;

signal rst_bar          : std_logic;
signal p0_out_bar		: std_logic_vector(7 downto 0);
signal p1_out_bar		: std_logic_vector(7 downto 0);
signal p2_out_bar		: std_logic_vector(7 downto 0);
signal p3_out_bar		: std_logic_vector(7 downto 0);
signal clk_div 			: std_logic;
signal counter2 		: std_logic_vector(17 downto 0) ;

begin

	rst_bar <= not rst;
	p0_out <= not p0_out_bar;
	p1_out <= not p1_out_bar;
	p2_out <= not p2_out_bar;
	p3_out <= not p3_out_bar;
	process (clk,clk_div,counter2) 
		begin
		if( rst = '0' ) then
			counter2 <= (others => '0');
			clk_div <= '0';
	    	elsif clk='1' and clk'event then
	      counter2 <= counter2+1;
			if counter2 = "111111111111111111" then
	      	clk_div <= not clk_div;
			end if;
	    end if;
	end process;

SEQ:sequencer2
	port map(rst_bar, clk_div, ale, psen,
	alu_op_code, alu_src_1L, alu_src_1H, alu_src_2L, alu_src_2H, 
	alu_by_wd, alu_cy_bw, alu_ans_L, alu_ans_H, alu_cy, alu_ac, alu_ov,
	dividend_i, divisor_i, quotient_o, remainder_o, div_done,
	mul_a_i, mul_b_i, mul_prod_o,
	i_ram_wrByte, i_ram_wrBit, i_ram_rdByte, i_ram_rdBit, i_ram_addr, 
	i_ram_diByte, i_ram_diBit, i_ram_doByte, i_ram_doBit,
	i_rom_addr, i_rom_data, i_rom_rd,
	pc_debug, i_flag, clear_flag);
	
ALU1:fastalu
	port map(alu_op_code, alu_src_1L, alu_src_1H, alu_src_2L, alu_src_2H, 
	alu_by_wd, alu_cy_bw, alu_ans_L, alu_ans_H, alu_cy, alu_ac, alu_ov);
	
REG:regfile
	port map(rst_bar, clk_div,
	i_ram_addr, i_ram_wrBit, i_ram_wrByte, i_ram_rdBit, i_ram_rdByte,
	i_ram_diBit, i_ram_diByte, 
	i_ram_doBit, i_ram_doByte,
	p0_out_bar, p1_out_bar, p2_out_bar, p3_out_bar, 
	ie_reg, scon_reg, tcon_reg, clear_flag,
	p0_in, p1_in, p2_in, p3_in);
	
MUL:multiplier
	port map(clk_div, mul_a_i, mul_b_i, mul_prod_o);

ROM:int_rom
	port map(clk_div, rst_bar, i_rom_rd , i_rom_addr, i_rom_data);

RAM:internal_ram
	port map(clk_div, rst_bar, 
	i_ram_wrByte, i_ram_wrBit, i_ram_rdByte, i_ram_rdBit,
	i_ram_addr, 
	i_ram_diByte, i_ram_diBit, i_ram_doByte, i_ram_doBit);
	
DIV:divider
	port map(clk_div, rst_bar, 
	dividend_i, divisor_i, quotient_o, remainder_o, div_done);

INTERRUPT:int_handler
	port map(clk_div, rst_bar, ie_reg, scon_reg, tcon_reg, i_flag);



end Behavioral;
