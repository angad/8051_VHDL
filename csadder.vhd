library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_SIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity csadder is
    Port ( A : in  STD_LOGIC_VECTOR (15 downto 0);
           B : in  STD_LOGIC_VECTOR (15 downto 0);
			  S : out STD_LOGIC_VECTOR (15 downto 0);
           cin : in  STD_LOGIC;
           carry4 :	out  STD_LOGIC;
		 carry7 : out  STD_LOGIC;
		 carry8 :	out  STD_LOGIC;
		 carry15 : out  STD_LOGIC;
		 carry16 : out  STD_LOGIC);
end csadder;

architecture csadderBeh of csadder is
	signal Da2, Db2, Ea2, Eb2: std_logic_vector(1 downto 0);
	signal Da3, Db3, Ea3, Eb3: std_logic_vector(2 downto 0);
	signal Da4, Db4, Ea4, Eb4: std_logic_vector(3 downto 0);
	signal Da6, Db6, Ea6, Eb6: std_logic_vector(5 downto 0);
	signal C1, C2, C3, C4, C6: std_logic;

	--C(4) is Da3(1) or Db3(1)
	--C(7) is Da4(0) or Db4(0)
	--C(8) is Da4(1) or Db4(1)
	--C(15) is Da6(4) or Db6(4)
	--C(16) is Da6(5) or Db6(5)
	
begin

---- Implement a parallel carry select adder

-- 1-bit carry select adder

-- D - Carry out
-- E - Result

S(0) <= A(0) xor B(0) xor cin;
C1 <= (A(0) and B(0)) or ((A(0) or B(0)) and cin);

-- 2-bit carry select adder

-- D - Carry out
-- E - Result

Da2(0) <= A(1) and B(1);
Db2(0) <= (A(1) and B(1)) or (A(1) or B(1));
Ea2(0) <= A(1) xor B(1);
Eb2(0) <= A(1) xor B(1) xor '1';
S(1) <= Ea2(0) when C1 = '0' else Eb2(0);

Da2(1) <= (A(2) and B(2)) or ((A(2) or B(2)) and Da2(0));
Db2(1) <= (A(2) and B(2)) or ((A(2) or B(2)) and Db2(0));
Ea2(1) <= A(2) xor B(2) xor Da2(0);
Eb2(1) <= A(2) xor B(2) xor Db2(0);
S(2) <= Ea2(1) when C1 = '0' else Eb2(1);

C2 <= Da2(1) when C1 = '0' else Db2(1);


-- 3-bit carry select adder

-- D - Carry out
-- E - Result

Da3(0) <= A(3) and B(3);
Db3(0) <= (A(3) and B(3)) or (A(3) or B(3));
Ea3(0) <= A(3) xor B(3);
Eb3(0) <= A(3) xor B(3) xor '1';
S(3) <= Ea3(0) when C2 = '0' else Eb3(0);

carry4 <= Da3(0) when C2 = '0' else Db3(0);

Da3(1) <= (A(4) and B(4)) or ((A(4) or B(4)) and Da3(0));
Db3(1) <= (A(4) and B(4)) or ((A(4) or B(4)) and Db3(0));
Ea3(1) <= A(4) xor B(4) xor Da3(0);
Eb3(1) <= A(4) xor B(4) xor Db3(0);
S(4) <= Ea3(1) when C2 = '0' else Eb3(1);

Da3(2) <= (A(5) and B(5)) or ((A(5) or B(5)) and Da3(1));
Db3(2) <= (A(5) and B(5)) or ((A(5) or B(5)) and Db3(1));
Ea3(2) <= A(5) xor B(5) xor Da3(1);
Eb3(2) <= A(5) xor B(5) xor Db3(1);
S(5) <= Ea3(2) when C2 = '0' else Eb3(2);

C3 <= Da3(2) when C2 = '0' else Db3(2);


-- 4-bit carry select adder

-- D - Carry out
-- E - Result

Da4(0) <= A(6) and B(6);
Db4(0) <= (A(6) and B(6)) or (A(6) or B(6));
Ea4(0) <= A(6) xor B(6);
Eb4(0) <= A(6) xor B(6) xor '1';
S(6) <= Ea4(0) when C3 = '0' else Eb4(0);

carry7 <= Da4(0) when C3 = '0' else Db4(0);

Da4(1) <= (A(7) and B(7)) or ((A(7) or B(7)) and Da4(0));
Db4(1) <= (A(7) and B(7)) or ((A(7) or B(7)) and Db4(0));
Ea4(1) <= A(7) xor B(7) xor Da4(0);
Eb4(1) <= A(7) xor B(7) xor Db4(0);
S(7) <= Ea4(1) when C3 = '0' else Eb4(1);

carry8 <= Da4(1) when C3 = '0' else Db4(1);

Da4(2) <= (A(8) and B(8)) or ((A(8) or B(8)) and Da4(1));
Db4(2) <= (A(8) and B(8)) or ((A(8) or B(8)) and Db4(1));
Ea4(2) <= A(8) xor B(8) xor Da4(1);
Eb4(2) <= A(8) xor B(8) xor Db4(1);
S(8) <= Ea4(2) when C3 = '0' else Eb4(2);

Da4(3) <= (A(9) and B(9)) or ((A(9) or B(9)) and Da4(2));
Db4(3) <= (A(9) and B(9)) or ((A(9) or B(9)) and Db4(2));
Ea4(3) <= A(9) xor B(9) xor Da4(2);
Eb4(3) <= A(9) xor B(9) xor Db4(2);
S(9) <= Ea4(3) when C3 = '0' else Eb4(3);

C4 <= Da4(3) when C3 = '0' else Db4(3);


-- 6-bit carry select adder

-- D - Carry out
-- E - Result

Da6(0) <= A(10) and B(10);
Db6(0) <= (A(10) and B(10)) or (A(10) or B(10));
Ea6(0) <= A(10) xor B(10);
Eb6(0) <= A(10) xor B(10) xor '1';
S(10) <= Ea6(0) when C4 = '0' else Eb6(0);

Da6(1) <= (A(11) and B(11)) or ((A(11) or B(11)) and Da6(0));
Db6(1) <= (A(11) and B(11)) or ((A(11) or B(11)) and Db6(0));
Ea6(1) <= A(11) xor B(11) xor Da6(0);
Eb6(1) <= A(11) xor B(11) xor Db6(0);
S(11) <= Ea6(1) when C4 = '0' else Eb6(1);

Da6(2) <= (A(12) and B(12)) or ((A(12) or B(12)) and Da6(1));
Db6(2) <= (A(12) and B(12)) or ((A(12) or B(12)) and Db6(1));
Ea6(2) <= A(12) xor B(12) xor Da6(1);
Eb6(2) <= A(12) xor B(12) xor Db6(1);
S(12) <= Ea6(2) when C4 = '0' else Eb6(2);

Da6(3) <= (A(13) and B(13)) or ((A(13) or B(13)) and Da6(2));
Db6(3) <= (A(13) and B(13)) or ((A(13) or B(13)) and Db6(2));
Ea6(3) <= A(13) xor B(13) xor Da6(2);
Eb6(3) <= A(13) xor B(13) xor Db6(2);
S(13) <= Ea6(3) when C4 = '0' else Eb6(3);

Da6(4) <= (A(14) and B(14)) or ((A(14) or B(14)) and Da6(3));
Db6(4) <= (A(14) and B(14)) or ((A(14) or B(14)) and Db6(3));
Ea6(4) <= A(14) xor B(14) xor Da6(3);
Eb6(4) <= A(14) xor B(14) xor Db6(3);
carry15 <= Da6(4) when C4 = '0' else Db6(4);
S(14) <= Ea6(4) when C4 = '0' else Eb6(4);

Da6(5) <= (A(15) and B(15)) or ((A(15) or B(15)) and Da6(4));
Db6(5) <= (A(15) and B(15)) or ((A(15) or B(15)) and Db6(4));
Ea6(5) <= A(15) xor B(15) xor Da6(4);
Eb6(5) <= A(15) xor B(15) xor Db6(4);
carry16 <= Da6(5) when C4 = '0' else Db6(5);
S(15) <= Ea6(5) when C4 = '0' else Eb6(5);

end csadderBeh;