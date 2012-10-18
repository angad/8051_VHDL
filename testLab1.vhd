--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   10:32:26 10/03/2012
-- Design Name:   
-- Module Name:   D:/SAA/Lab1/testLab1.vhd
-- Project Name:  Lab1
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: i8051_top
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY testLab1 IS
END testLab1;
 
ARCHITECTURE behavior OF testLab1 IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT i8051_top
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         ale : OUT  std_logic;
         psen : OUT  std_logic;
         ea : IN  std_logic;
         p0_in : IN  std_logic_vector(7 downto 0);
         p0_out : OUT  std_logic_vector(7 downto 0);
         p1_in : IN  std_logic_vector(7 downto 0);
         p1_out : OUT  std_logic_vector(7 downto 0);
         p2_in : IN  std_logic_vector(7 downto 0);
         p2_out : OUT  std_logic_vector(7 downto 0);
         p3_in : IN  std_logic_vector(7 downto 0);
         p3_out : OUT  std_logic_vector(7 downto 0);
         pc_debug : OUT  std_logic_vector(15 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal ea : std_logic := '0';
   signal p0_in : std_logic_vector(7 downto 0) := (others => '0');
   signal p1_in : std_logic_vector(7 downto 0) := (others => '0');
   signal p2_in : std_logic_vector(7 downto 0) := (others => '0');
   signal p3_in : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal ale : std_logic;
   signal psen : std_logic;
   signal p0_out : std_logic_vector(7 downto 0);
   signal p1_out : std_logic_vector(7 downto 0);
   signal p2_out : std_logic_vector(7 downto 0);
   signal p3_out : std_logic_vector(7 downto 0);
   signal pc_debug : std_logic_vector(15 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: i8051_top PORT MAP (
          clk => clk,
          rst => rst,
          ale => ale,
          psen => psen,
          ea => ea,
          p0_in => p0_in,
          p0_out => p0_out,
          p1_in => p1_in,
          p1_out => p1_out,
          p2_in => p2_in,
          p2_out => p2_out,
          p3_in => p3_in,
          p3_out => p3_out,
          pc_debug => pc_debug
        );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here 
		
		rst <= '1';
		pc_debug <= "0000000000000100";

      wait;
   end process;

END;
