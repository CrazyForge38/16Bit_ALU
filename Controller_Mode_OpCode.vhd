library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Controller_Mode_OpCode is
    Port ( Mode : in STD_LOGIC;
           OpCode : in STD_LOGIC_VECTOR(2 downto 0);
           Direction : out STD_LOGIC;
           Shift_Type : out STD_LOGIC;
           Arith_Select : out STD_LOGIC_VECTOR(1 downto 0);
           Sel_1 : out STD_LOGIC;
           Sel_Cout : out STD_LOGIC;
           Sel_2 : out STD_LOGIC;
           OpCode_To_Logic : out STD_LOGIC_VECTOR(2 downto 0));
end Controller_Mode_OpCode;

architecture Behavioral of Controller_Mode_OpCode is

begin
process (Mode,OpCode)
begin

Direction <= OpCode(0); --the first bit of the opcode decides direction (0 for left and 1 for right)
Shift_Type <= OpCode(1); -- the second bit decides type of shift (0 fir shift and 1 for rotate)
OpCode_To_Logic <= OpCode; --gives the same opcode for logic unit
Arith_Select <= OpCode(1 downto 0); -- sends a 2 bit signal
Sel_1 <= OpCode(2); --sel_1 is the third bit of OpCode
if (Mode = '1' and OpCode(2) = '0') --determines weather to enable the and gate
  then Sel_Cout <= '1';
else Sel_Cout <= '0';
end if;
Sel_2 <= Mode; -- determines (arith/shift) or logic, 0 for logic

end process;
end Behavioral;
