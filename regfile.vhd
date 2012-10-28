library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
use work.constants.all;

entity regfile is
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
	erase_int	:	in std_logic;

	P0_in		:	in std_logic_vector(7 downto 0);
	P1_in		:	in std_logic_vector(7 downto 0);
	P2_in		:	in std_logic_vector(7 downto 0);
	P3_in		:	in std_logic_vector(7 downto 0)
);
end entity;

architecture regarch of regfile is

component ext_interrupt is
port 
( 
		clk 		: in  std_logic;
		rst 		: in	std_logic;
		clear 	: in std_logic;
		in_tcon 	: in std_logic_vector (7 downto 0);
    		int_tcon 	: out std_logic_vector (7 downto 0);          
        	oP3_2 	: in std_logic;
		oP3_3 	: in std_logic        
);
end component;

	signal ACC	:	std_logic_vector(7 downto 0);
	signal B	:	std_logic_vector(7 downto 0);
	signal DPH	:	std_logic_vector(7 downto 0);
	signal DPL	:	std_logic_vector(7 downto 0);
	signal IE	:	std_logic_vector(7 downto 0);
	signal IP	:	std_logic_vector(7 downto 0);
	signal PCON	:	std_logic_vector(7 downto 0);
	signal PSW	:	std_logic_vector(7 downto 0);
	signal SBUF	:	std_logic_vector(7 downto 0);
	signal SCON	:	std_logic_vector(7 downto 0);
	signal SP	:	std_logic_vector(7 downto 0);
	signal TCON	:	std_logic_vector(7 downto 0);
	signal TCON_temp	:	std_logic_vector(7 downto 0);
	signal TH0	:	std_logic_vector(7 downto 0);
	signal TH1	:	std_logic_vector(7 downto 0);
	signal TL0	:	std_logic_vector(7 downto 0);
	signal TL1	:	std_logic_vector(7 downto 0);
	signal TMOD	:	std_logic_vector(7 downto 0);
	signal P3	:	std_logic_vector(7 downto 0);
	--signal SCRATCH: std_logic_vector(7 downto 0);

begin

ext_int:	ext_interrupt
port map
(
	clk => clk,
	rst => rst,
	clear => erase_int,
	in_tcon => TCON,
	int_tcon => TCON_temp, 
	oP3_2 => P3(2),
	oP3_3 => P3(3)	
);

	process (clk, rst, rdByte, rdBit, addr)
		variable U	:	std_logic_vector(7 downto 0);
		variable L	:	INTEGER;
begin
	--TCON <= TCON_temp; 
	if (rst = '1') then
		ACC    <= "00111010";
		--SCRATCH <= "00000001";
            B      <= "00000000";
            DPH    <= "00000000";
            DPL    <= "00000000";
            IE     <= "00000000";
            IP     <= "00000000";
            PCON   <= "00000000";
            PSW    <= "00000000";
            SBUF   <= "00000000";
            SCON   <= "00000000";
            SP     <= "00000111";
            TCON   <= "00000000";
            TH0    <= "00000000";
            TH1    <= "00000000";
            TL0    <= "00000000";
            TL1    <= "00000000";
            TMOD   <= "00000000";
            P0_out <= "11111111";
            P1_out <= "11111111";
            P2_out <= "11111111";
            P3_out <= "00000000";
		P3	 <= "00000000";
		doByte <= "ZZZZZZZZ";
		doBit <= 'Z';
  
	elsif (rdByte = '1') then
		case addr is
				when xE0   => doByte <= ACC;
				--when x7F   => doByte <= SCRATCH; --angad
				when xF0   => doByte <= B;	   
				when x83   => doByte <= DPH; 
				when x82   => doByte <= DPL;	
				when xA8   => doByte <= IE;	  
				when xB8   => doByte <= IP;	  
				when x80   => doByte <= P0_in;	  
				when x90   => doByte <= P1_in;	  
				when xA0   => doByte <= P2_in;	  
				when xB0   => doByte <= P3_in;	  
				when x87   => doByte <= PCON;	
				when xD0   => doByte <= PSW;	 
				when x99   => doByte <= SBUF;	 
				when x98   => doByte <= SCON;	 
				when x81   => doByte <= SP;	  
				when x88   => doByte <= TCON;
				when x8C   => doByte <= TH0;	 
				when x8D   => doByte <= TH1;	  
				when x8A   => doByte <= TL0;	  
				when x8B   => doByte <= TL1;	  
				when x89   => doByte <= TMOD;	  
				when others =>	doByte <= "ZZZZZZZZ";		
			end case;

	elsif (rdBit = '1') then
		L := conv_integer(addr(2 downto 0));
		U := addr(7 downto 3)&"000";
			case U is
				when xE0   => doBit <= ACC(L);
				when xF0   => doBit <= B(L);
				when xA8   => doBit <= IE(L);
				when xB8   => doBit <= IP(L);
				when x80   => doBit <= P0_in(L);
				when x90   => doBit <= P1_in(L);
				when xA0   => doBit <= P2_in(L);
				when xB0   => doBit <= P3_in(L);
				when xD0   => doBit <= PSW(L);
				when x81   => doBit <= SP(L);
				when x98   => doBit <= SCON(L);
				when x88   => doBit <= TCON(L);
				when others =>	doBit <= 'Z';	
			end case;
	
	elsif (clk' event and clk = '1') then
		if (wrByte = '1') then
				case addr is
					when xE0   => ACC <= diByte; 
					when xF0   => B <= diByte;	   
					when x83   => DPH <= diByte; 
					when x82   => DPL <= diByte;	
					when xA8   => IE <= diByte;	  
					when xB8   => IP <= diByte;	  
					when x80   => P0_out <= diByte;	  
					when x90   => P1_out <= diByte;	  
					when xA0   => P2_out <= diByte;	  
					when xB0   => P3_out <= diByte;
							  P3	 <= diByte;	  
					when x87   => PCON <= diByte;	
					when xD0   => PSW <= diByte;	 
					when x99   => SBUF <= diByte;	 
					when x98   => SCON <= diByte;	 
					when x81   => SP <= diByte;	  
					when x88   => TCON <= diByte;
					when x8C   => TH0 <= diByte;	 
					when x8D   => TH1 <= diByte;	  
					when x8A   => TL0 <= diByte;	  
					when x8B   => Tl1 <= diByte;	  
					when x89   => TMOD <= diByte;	  
				when others =>			
				end case;		
		
		elsif (wrBit = '1') then
			L := conv_integer(addr(2 downto 0));
			U := addr(7 downto 3)&"000";
			case U is
					when xE0   => ACC(L) <= diBit;
					when xF0   => B(L)<= diBit;
					when xA8   => IE(L)<= diBit;
					when xB8   => IP(L)<= diBit;
					when x80   => P0_out(L)<= diBit;
					when x90   => P1_out(L)<= diBit;
					when xA0   => P2_out(L)<= diBit;
					when xB0   => P3_out(L)<= diBit;
							    P3(L)<= diBit;
					when xD0   => PSW(L)<= diBit;
					when x81   => SP(L)<= diBit;
					when x98   => SCON(L)<= diBit;
					when x88   => TCON(L)<= diBit;
				when others =>			
				end case;

		else
			TCON <= TCON_temp;
		end if;		
	end if;

	IE_out <= IE;
	SCON_out <= SCON;
	TCON_out <= TCON;		

end process;
end regarch;