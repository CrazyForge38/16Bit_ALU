library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
--use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Shifter_16Bit is
    Port ( A : in STD_LOGIC_VECTOR(15 downto 0);-- A and B are inputs
           B : in STD_LOGIC_VECTOR(15 downto 0);
           Direction : in STD_LOGIC; --LSB of Op_Sel
           Op_Type : in STD_LOGIC; --MSB of Op_Sel
           ShiftOut : out STD_LOGIC_VECTOR(15 downto 0)); -- output
end Shifter_16Bit;

architecture Behavioral of Shifter_16Bit is

--Signal Op_Sel : std_logic_vector(1 downto 0); -- trouble getting correct value when using a singal

begin

process (A,B,Direction,Op_Type)
variable Sel : std_logic_vector(1 downto 0); --create a vraiable to hold the apended value
                                              -- Sel
begin
Sel := Op_Type & Direction;
--Op_Sel <= Op_Type & Direction;

case (Sel) is
  when "00" => ShiftOut <= std_logic_vector(SHIFT_LEFT(unsigned(A), to_integer(unsigned(B)))); -- uses use IEEE.numeric_std.ALL library to rotate and shift
  when "01" => ShiftOut <= std_logic_vector(SHIFT_Right(unsigned(A), to_integer(unsigned(B)))); --logical shfiting/rotating therefore no need for signed values
  when "10" => ShiftOut <= std_logic_vector(ROTATE_LEFT(unsigned(A), to_integer(unsigned(B))));
  when "11" => ShiftOut <= std_logic_vector(ROTATE_RIGHT(unsigned(A), to_integer(unsigned(B))));
when others => ShiftOut <= (others => 'X'); -- avoid creating a latch
end case;

end process;
end Behavioral;
