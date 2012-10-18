library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.std_logic_unsigned.all;
use work.constants.all;

entity sequencer2 is
    port(
		rst                : in  std_logic;
		clk              	 : in  std_logic;
		ale		  	 : out std_logic;
		psen		 	 : out std_logic;

		alu_op_code	 	 : out  std_logic_vector (3 downto 0);
		alu_src_1L		 : out  std_logic_vector (7 downto 0);
		alu_src_1H		 : out  std_logic_vector (7 downto 0);
		alu_src_2L		 : out  std_logic_vector (7 downto 0);
		alu_src_2H		 : out  std_logic_vector (7 downto 0);
		alu_by_wd		 : out  std_logic;             -- byte(0)/word(1) instruction
		alu_cy_bw		 : out  std_logic;             -- carry/borrow bit
		alu_ans_L		 : in std_logic_vector (7 downto 0);
		alu_ans_H		 : in std_logic_vector (7 downto 0);
		alu_cy		 	 : in std_logic;             -- carry out of bit 7/15
		alu_ac		 	 : in std_logic;		    -- carry out of bit 3/7
		alu_ov		 	 : in std_logic;		    -- overflow

		dividend_i		 : out  std_logic_vector(15 downto 0);
		divisor_i		 : out  std_logic_vector(15 downto 0);
		quotient_o		 : in std_logic_vector(15 downto 0); 
		remainder_o	 	 : in std_logic_vector(15 downto 0);
		div_done		 : in std_logic ;

		mul_a_i		 	 : out  std_logic_vector(15 downto 0);  -- Multiplicand
		mul_b_i		 	 : out  std_logic_vector(15 downto 0);  -- Multiplicator
		mul_prod_o 	 	 : in std_logic_vector(31 downto 0) ;-- Product

		i_ram_wrByte   	 : out std_logic; 
		i_ram_wrBit   	 : out std_logic; 
		i_ram_rdByte   	 : out std_logic; 
		i_ram_rdBit   	 : out std_logic; 
		i_ram_addr 	 	 : out std_logic_vector(7 downto 0); 
		i_ram_diByte  	 : out std_logic_vector(7 downto 0); 
		i_ram_diBit   	 : out std_logic; 
		i_ram_doByte   	 : in std_logic_vector(7 downto 0); 
		i_ram_doBit   	 : in std_logic; 
		
		i_rom_addr       : out std_logic_vector (15 downto 0);
		i_rom_data       : in  std_logic_vector (7 downto 0);
		i_rom_rd         : out std_logic;
		
		pc_debug	 	 : out std_logic_vector (15 downto 0);
		interrupt_flag	 : in  std_logic_vector (2 downto 0);
		erase_flag	 : out std_logic);

end sequencer2;

-------------------------------------------------------------------------------
--	--3rd Oct
--	"00000011", --RR A (Rotate ACC Right)
--	"00010011", --RRC A (Rotate ACC right through carry flag)
--	"00100011", --RL A (Rotate ACC Left)
--	"00110011", --RLC A (Rotate ACC Left through carry flag)
--	"11000100", --SWAP (Swap nibbles through ACC)
--	--


architecture seq_arch of sequencer2 is

    type t_cpu_state is (S1,S2,S3,S4,S5,S6); -- FETCH / DECODE / EXECUTE
    type t_exe_state is (P1,P2); 
    
	signal cpu_state 		: t_cpu_state;
   signal exe_state 		: t_exe_state;
   signal IR				: std_logic_vector(7 downto 0);		-- Instruction Register
	signal PC				: std_logic_vector(15 downto 0);	-- Program Counter
	signal AR				: std_logic_vector(7 downto 0);		-- Address Register
	signal DR				: std_logic_vector(7 downto 0);		-- Data Register
	signal int_hold		: std_logic;

begin

	process(rst, clk) 
------------------------------------------------------------------
	procedure RESET_ALU is
        begin
			alu_src_1H <= "00000000";
			alu_src_1L <= "--------";
			alu_src_2H <= "00000000";
			alu_src_2L <= "--------";
			alu_by_wd <= '-';
			alu_cy_bw <= '-';
			alu_op_code <= ALU_OPC_NONE;
    end RESET_ALU;
------------------------------------------------------------------
	procedure RAM_READ_BIT (addr: std_logic_vector(7 downto 0)) is
	begin
		i_ram_addr <= addr;
		i_ram_wrBit <= '0';
		i_ram_wrByte <= '0';
		i_ram_rdBit <= '1';
		i_ram_rdByte <= '0';
	end RAM_READ_BIT;
------------------------------------------------------------------
	procedure RAM_READ_BYTE (addr: std_logic_vector(7 downto 0)) is
	begin
		i_ram_addr <= addr;
		i_ram_wrBit <= '0';
		i_ram_wrByte <= '0';
		i_ram_rdBit <= '0';
		i_ram_rdByte <= '1';
	end RAM_READ_BYTE;
------------------------------------------------------------------
	procedure RAM_WRITE_BIT (addr: std_logic_vector(7 downto 0)) is
	begin
		i_ram_addr <= addr;
		i_ram_wrBit <= '1';
		i_ram_wrByte <= '0';
		i_ram_rdBit <= '0';
		i_ram_rdByte <= '0';
	end RAM_WRITE_BIT;
------------------------------------------------------------------
	procedure RAM_WRITE_BYTE (addr: std_logic_vector(7 downto 0)) is
	begin
		i_ram_addr <= addr;
		i_ram_wrBit <= '0';
		i_ram_wrByte <= '1';
		i_ram_rdBit <= '0';
		i_ram_rdByte <= '0';
	end RAM_WRITE_BYTE;
------------------------------------------------------------------
	procedure RAM_STOP is
	begin
		i_ram_addr <= "--------";
		i_ram_diBit <= '-';
		i_ram_diByte <= "--------";
		i_ram_wrBit <= '0';
		i_ram_wrByte <= '0';
		i_ram_rdBit <= '0';
		i_ram_rdByte <= '0';
	end RAM_STOP;
------------------------------------------------------------------
	procedure ROM_READ (addr: std_logic_vector(15 downto 0)) is
	begin
		i_rom_addr <= addr;
		i_rom_rd <= '1';
	end ROM_READ;
------------------------------------------------------------------
	procedure ROM_STOP is
	begin
		i_rom_addr <= "----------------";
		i_rom_rd <= '0';
	end ROM_STOP;
------------------------------------------------------------------
 
    begin
    if( rst = '1' ) then
   	cpu_state <= S1;
		exe_state <= P1;
		ale <= '0'; psen <= '0';
		mul_a_i <= (others => '0'); mul_b_i <= (others => '0');
		dividend_i <= (others => '0'); divisor_i <= (others => '1');
		i_ram_wrByte <= '0'; i_ram_rdByte <= '0'; i_ram_wrBit <= '0'; i_ram_rdBit <= '0';
		IR <= (others => '0');
		PC <= (others => '0');
		--PC <= "0000000000100111";
		AR <= (others => '0');
		DR <= (others => '0');
		pc_debug <= (others => '1');
		int_hold <= '0';
		erase_flag <= '0';

		RESET_ALU;
    
	elsif (clk'event and clk = '1') then
	case cpu_state is

-- Angad

-- ADD A, Rn
-- NOP 
-- MOV A, Rn


		when S1 => -- Fetch
			case exe_state is
				when P1 =>
					ROM_READ(PC);
					RAM_READ_BYTE(xD0); --PSW
					exe_state <= P2;
				
				when P2 =>
					IR <= i_rom_data;
					PC <= PC + 1;
					
					AR <= i_ram_doByte; --put PSW into AR
					cpu_state <= S2;
					exe_state <= P1;
					
			end case; -- exe_state (FETCH)
			
		
		when S2 => -- Decode
			case IR is
			
				-- NOP
				when "00000000" =>
					case exe_state is
						when P1 =>
							exe_state <= P2;
						
						when P2 =>
							exe_state <= P1;
							cpu_state <=S3;
					end case;
					
				-- MOV A, Rn
				when "11101000" | "11101001" | "11101010" | "11101011" | "11101100" | "11101101" | "11101110" | "11101111" =>
					case exe_state is 
						when P1 =>
							RAM_READ_BYTE("000" & i_ram_doByte(4 downto 3) & IR(2 downto 0)); --Rn
							exe_state <= P2;
						
						when P2 =>
							DR <= i_ram_doByte;
							cpu_state <= S3;
							exe_state <= P1;
					end case;
				
				-- ANL A, Rn
				when "01011000" | "01011001" | "01011010" | "01011011" | "01011100" | "01011101" | "01011110" | "01011111" =>
					case exe_state is
						when P1 =>
							RAM_READ_BYTE("000" & i_ram_doByte(4 downto 3) & IR(2 downto 0)); --Rn
							exe_state <= P2;
						
						when P2 =>
							DR <= i_ram_doByte;
							RAM_READ_BYTE(xE0);
							
							exe_state <= P1;
							cpu_state <= S3;
						end case;

				-- ANL A, direct
				when "01010101" =>
					case exe_state is
						when P1 =>
							RAM_READ_BYTE(xE0); -- Get AC Value
							exe_state <= P2;
						
						when P2 =>
							DR <= i_ram_doByte;
							
							exe_state <= P1;
							cpu_state <= S3;
						end case;

				-- ANL A, @Ri
				when "01010110" | "01010111" =>
					case exe_state is
						when P1 =>
							RAM_READ_BYTE("000" & i_ram_doByte(4 downto 3) & "00" & IR(0));	-- Compute and get Rn value
							exe_state <= P2;
						
						when P2 =>
							RAM_READ_BYTE(i_ram_doByte);							
							exe_state <= P1;
							cpu_state <= S3;
						end case;

				-- ANL A, #data
				when "01010100" =>
					case exe_state is
						when P1 =>
							RAM_READ_BYTE(xE0);
							exe_state <= P2;
						
						when P2 =>
							exe_state <= P1;
							cpu_state <= S3;
						end case;				

				-- ANL direct, A
				when "01010010" =>
					case exe_state is
						when P1 =>
							RAM_READ_BYTE(xE0); -- Get AC Value
							exe_state <= P2;
						
						when P2 =>
							DR <= i_ram_doByte; -- Store AC value into DR
							exe_state <= P1; 
							cpu_state <= S3;
						end case;
	
				-- ANL direct, #data
				when "01010011" =>
					case exe_state is
						when P1 =>
							exe_state <= P2;
						
						when P2 =>
							exe_state <= P1; 
							cpu_state <= S3;
						end case;
					

				-- ADD A, Rn
				when "00101000" | "00101001" | "00101010" | "00101011" | "00101100" | "00101101" | "00101110" | "00101111" =>
					case exe_state is
						when P1 =>
							RAM_READ_BYTE("000" & i_ram_doByte(4 downto 3) & IR(2 downto 0)); --Rn
							exe_state <= P2;
						
						when P2 =>
							DR <= i_ram_doByte;
							RAM_READ_BYTE(xE0);
							
							cpu_state <= S3;
							exe_state <= P1;
					end case; --exe_state Decode
				
				when others =>
			end case; --IR
		
		when S3 => -- Execute
			case IR is

				-- NOP
				when "00000000" =>
					case exe_state is
						when P1 =>
							exe_state <= P2;
						
						when P2 =>
							exe_state <= P1;
							cpu_state <=S4;
					end case;

				-- MOV A, Rn
				when "11101000" | "11101001" | "11101010" | "11101011" | "11101100" | "11101101" | "11101110" | "11101111" =>
					case exe_state is 
						when P1 =>
							i_ram_diByte <= i_ram_doByte;
							RAM_WRITE_BYTE(xE0);
							exe_state <= P2;
						
						when P2 =>

							cpu_state <= S4;
							exe_state <= P1;
					end case;							

				-- ANL A, Rn
				when "01011000" | "01011001" | "01011010" | "01011011" | "01011100" | "01011101" | "01011110" | "01011111" =>
					case exe_state is
						when P1 =>
							alu_src_2L <= i_ram_doByte;
							alu_src_2H <= "00000000";	
							alu_src_1L <= DR;
							alu_src_1H <= "00000000";	
							alu_op_code <= ALU_OPC_AND;
							alu_by_wd <= '0';
							alu_cy_bw <= '0';

							exe_state <= P2;
						
						when P2 =>
							i_ram_diByte = <= alu_ans_L;
							RAM_WRITE_BYTE(xE0);
							
							exe_state <= P1;
							cpu_state <= S4;
						end case;

				-- ANL A, direct
				when "01010101" =>
					case exe_state is
						when P1 =>
							exe_state <= P2;
						
						when P2 =>
							exe_state <= P1;
							cpu_state <= S4;
						end case;

				-- ANL A, @Ri
				when "01010110" | "01010111" =>
					case exe_state is
						when P1 =>
							DR <= i_ram_doByte; -- Save Rn in DR
							RAM_READ_BYTE(xE0); -- Get AC Value
							exe_state <= S2;
						
						when P2 =>
							alu_src_1H <= "00000000";	-- Perform AND operation
							alu_src_1L <= i_ram_doByte;
							alu_src_2H <= "00000000";
							alu_src_2L <= DR;
							alu_by_wd <= '0';
							alu_cy_bw <= '0';
							alu_op_code <= ALU_OPC_AND;

							exe_state <= P1;
							cpu_state <= S3;
						end case;

				-- ANL A, #data
				when "01010100" =>
					case exe_state is
						when P1 =>
							exe_state <= P2;
						
						when P2 =>
							exe_state <= P1;
							cpu_state <= S4;
						end case;

				-- ANL direct, A
				when "01010010" =>
					case exe_state is
						when P1 =>
							exe_state <= P2;
						
						when P2 =>
							exe_state <= P1; 
							cpu_state <= S4;
						end case;

				-- ANL direct, #data
				when "01010011" =>
					case exe_state is
						when P1 =>
							exe_state <= P2;
						
						when P2 =>
							exe_state <= P1; 
							cpu_state <= S4;
						end case;


				-- ADD A, Rn
				when "00101000" | "00101001" | "00101010" | "00101011" | "00101100" | "00101101" | "00101110" | "00101111" =>
					case exe_state is
						when P1 =>
							alu_src_2L <= i_ram_doByte;
							alu_src_2H <= "00000000";	
							alu_src_1L <= DR;
							alu_src_1H <= "00000000";	
							alu_op_code <= ALU_OPC_ADD;
							alu_by_wd <= BYTE;
							alu_cy_bw <= '0';

							exe_state <= P2;
						
						when P2 =>
							RAM_WRITE_BYTE(xE0);
							i_ram_diByte <= alu_ans_L;	
							RESET_ALU;
							
							cpu_state <= S4;
							exe_state <= P1;
					end case;	
				when others =>
				end case;
		
		when S4 => -- Fetch
			case IR is
			
				-- NOP
				when "00000000" =>
					case exe_state is
						when P1 =>
							exe_state <= P2;
						
						when P2 =>
							exe_state <= P1;
							cpu_state <=S5;
					end case;

				-- MOV A, Rn
				when "11101000" | "11101001" | "11101010" | "11101011" | "11101100" | "11101101" | "11101110" | "11101111" =>
					case exe_state is 
						when P1 =>
							exe_state <= P2;
						when P2 =>
							cpu_state <= S5;
							exe_state <= P1;
					end case;

				-- ANL A, Rn
				when "01011000" | "01011001" | "01011010" | "01011011" | "01011100" | "01011101" | "01011110" | "01011111" =>
					case exe_state is
						when P1 =>
							exe_state <= P2;
							
						when P2 =>
							cpu_state <=S5;
							exe_state <=P1;
					end case;

				-- ANL A, direct
				when "01010101" =>
					case exe_state is
						when P1 =>
							ROM_READ(PC); -- Get "direct" in next instruction
							PC <= PC + 1;
							exe_state <= P2;
						
						when P2 =>
							RAM_READ_BYTE(i_rom_data); -- Get "direct" value

							exe_state <= P1;
							cpu_state <= S5;
						end case;


				-- ANL A, @Ri
				when "01010110" | "01010111" =>
					case exe_state is
						when P1 =>
							exe_state <= P2;
							
						when P2 =>
							cpu_state <=S5;
							exe_state <=P1;
					end case;

				-- ANL A, #data
				when "01010100" =>
					case exe_state is
						when P1 =>
							ROM_READ(PC); -- Get "direct" in next instruction
							PC <= PC + 1;
							exe_state <= P2;
	
						when P2 =>
							exe_state <= P1;
							cpu_state <= S5;
						end case;
	
				-- ANL direct, A
				when "01010010" =>
					case exe_state is
						when P1 =>
							ROM_READ(PC); -- Get "direct" in next instruction
							PC <= PC + 1;						
							exe_state <= P2;
						
						when P2 =>
							RAM_READ_BYTE(i_rom_data); -- Get "direct" value
							AR <= i_rom_data;
							exe_state <= P1; 
							cpu_state <= S5;
					end case;
	
				-- ANL direct, #data
				when "01010011" =>
					case exe_state is
						when P1 =>
							ROM_READ(PC); -- Get "direct" in next instruction
							PC <= PC + 1;						
							exe_state <= P2;
						
						when P2 =>
							RAM_READ_BYTE(i_rom_data);	-- Get "direct" value
							AR <= i_rom_data;	-- Store "direct" address in AR
							ROM_READ(PC);		-- Get #data
							PC <= PC + 1;
							
							exe_state <= P1; 
							cpu_state <= S5;
						end case;


	
				-- ADD A, Rn
				when "00101000" | "00101001" | "00101010" | "00101011" | "00101100" | "00101101" | "00101110" | "00101111" =>
					case exe_state is
						when P1 =>
							exe_state <= P2;
							
						when P2 =>
							cpu_state <=S5;
							exe_state <=P1;
					end case;
					
				when others =>	
			end case;
			
		when S5 => -- Decode
			case IR is
			
				-- NOP
				when "00000000" =>
					case exe_state is
						when P1 =>
							exe_state <= P2;
						
						when P2 =>
							exe_state <= P1;
							cpu_state <=S6;
					end case;

				-- MOV A, Rn
				when "11101000" | "11101001" | "11101010" | "11101011" | "11101100" | "11101101" | "11101110" | "11101111" =>
					case exe_state is 
						when P1 =>
							exe_state <= P2;
						when P2 =>
							cpu_state <= S6;
							exe_state <= P1;
					end case;

				-- ANL A, Rn
				when "01011000" | "01011001" | "01011010" | "01011011" | "01011100" | "01011101" | "01011110" | "01011111" =>
					case exe_state is
						when P1 =>
							exe_state <= P2;
							
						when P2 =>
							cpu_state <=S6;
							exe_state <=P1;
					end case;

				-- ANL A, direct
				when "01010101" =>
					case exe_state is
						when P1 =>						
							exe_state <= P2;
						
						when P2 =>
							exe_state <= P1;
							cpu_state <= S6;
					end case;

				-- ANL A, @Ri
				when "01010110" | "01010111" =>
					case exe_state is
						when P1 =>
							exe_state <= P2;
							
						when P2 =>
							cpu_state <=S6;
							exe_state <=P1;
					end case;

				-- ANL A, #data
				when "01010100" =>
					case exe_state is
						when P1 =>
							exe_state <= P2;
	
						when P2 =>
							exe_state <= P1;
							cpu_state <= S6;
						end case;

				-- ANL direct, A
				when "01010010" =>
					case exe_state is
						when P1 =>
							exe_state <= P2;
						
						when P2 =>
							exe_state <= P1; 
							cpu_state <= S6;
					end case;


				-- ANL direct, #data
				when "01010011" =>
					case exe_state is
						when P1 =>
							exe_state <= P2;
						
						when P2 =>
							exe_state <= P1; 
							cpu_state <= S6;
					end case;




				-- ADD A, Rn
				when "00101000" | "00101001" | "00101010" | "00101011" | "00101100" | "00101101" | "00101110" | "00101111" =>
					case exe_state is
						when P1 =>
							exe_state <= P2;
						
						when P2 =>							
							cpu_state <=S6;
							exe_state <=P1;
					end case;
					
					
				when others =>
			end case;
		
		when S6 => -- Execute
			case IR is
			
				-- NOP
				when "00000000" =>
					case exe_state is
						when P1 =>
							exe_state <= P2;
						
						when P2 =>
							exe_state <= P1;
							cpu_state <=S1;
					end case;
			
				-- MOV A, Rn
				when "11101000" | "11101001" | "11101010" | "11101011" | "11101100" | "11101101" | "11101110" | "11101111" =>
					case exe_state is 
						when P1 =>
							exe_state <= P2;
						when P2 =>
							cpu_state <= S1;
							exe_state <= P1;
					end case;

				-- ANL A, Rn
				when "01011000" | "01011001" | "01011010" | "01011011" | "01011100" | "01011101" | "01011110" | "01011111" =>
					case exe_state is
						when P1 =>
							RAM_WRITE_BYTE(xE0);
							i_ram_diByte <= alu_ans_L;	
							RESET_ALU;

							exe_state <= P2;

						when P2 =>							
							cpu_state <=S1;
							exe_state <=P1;
					end case;

				-- ANL A, direct
				when "01010101" =>
					case exe_state is
						when P1 =>
							alu_src_1H <= "00000000";	-- Perform AND operation
							alu_src_1L <= i_ram_doByte;
							alu_src_2H <= "00000000";
							alu_src_2L <= DR;
							alu_by_wd <= '0';
							alu_cy_bw <= '0';
							alu_op_code <= ALU_OPC_AND;
						
							exe_state <= P2;
						
						when P2 =>
							i_ram_diByte = <= alu_ans_L;
							RAM_WRITE_BYTE(xE0);						

							exe_state <= P1;
							cpu_state <= S1;
					end case;
					
				-- ANL A, @Ri
				when "01010110" | "01010111" =>
					case exe_state is
						when P1 =>
							exe_state <= P2;
							
						when P2 =>
							cpu_state <= S1;
							exe_state <= P1;
					end case;

				-- ANL A, #data
				when "01010100" =>
					case exe_state is
						when P1 =>
							alu_src_1H <= "00000000";	-- Perform AND operation
							alu_src_1L <= i_ram_doByte;
							alu_src_2H <= "00000000";
							alu_src_2L <= i_rom_data;
							alu_by_wd <= '0';
							alu_cy_bw <= '0';
							alu_op_code <= ALU_OPC_AND;
							exe_state <= P2;
	
						when P2 =>
							i_ram_diByte <= alu_ans_L;	-- Write result to AC
							RAM_WRITE_BYTE(xE0);
							
							RESET_ALU;
							exe_state <= P1;
							cpu_state <= S1;
						end case;

				-- ANL direct, A
				when "01010010" =>
					case exe_state is
						when P1 =>
							alu_src_1H <= "00000000";	-- Perform AND operation
							alu_src_1L <= i_ram_doByte;
							alu_src_2H <= "00000000";
							alu_src_2L <= DR;
							alu_by_wd <= '0';
							alu_cy_bw <= '0';
							alu_op_code <= ALU_OPC_AND;
							exe_state <= P2;
						
						when P2 =>
							i_ram_diByte <= alu_ans_L;	-- Write result to "direct"
							RAM_WRITE_BYTE(AR);

							RESET_ALU;
							exe_state <= P1; 
							cpu_state <= S1;
					end case;

				-- ANL direct, #data
				when "01010011" =>
					case exe_state is
						when P1 =>
							alu_src_1H <= "00000000";	-- Perform AND operation
							alu_src_1L <= i_ram_doByte;
							alu_src_2H <= "00000000";
							alu_src_2L <= i_rom_data;
							alu_by_wd <= '0';
							alu_cy_bw <= '0';
							alu_op_code <= ALU_OPC_AND;
							exe_state <= P2;
						
						when P2 =>
							i_ram_diByte <= alu_ans_L;	-- Write result to "direct"
							RAM_WRITE_BYTE(AR);

							RESET_ALU;

							exe_state <= P1; 
							cpu_state <= S1;
					end case;


				-- ADD A, Rn
				when "00101000" | "00101001" | "00101010" | "00101011" | "00101100" | "00101101" | "00101110" | "00101111" =>
					case exe_state is
						when P1 =>
							RAM_WRITE_BYTE(xD0);
							i_ram_diByte <= alu_cy & alu_ac & AR(5 downto 3) & alu_ov & AR(1 downto 0);
							RESET_ALU;

							exe_state <= P2;

						when P2 =>
							cpu_state <= S1;
							exe_state <= P1;
					end case;
					
				when others =>
			end case;
		
	end case; --cpu_state
end if;
end process;
end seq_arch;

-------------------------------------------------------------------------------

-- end of file --
