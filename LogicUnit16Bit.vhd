library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity LogicUnit16Bit is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0); -- A and B are the two register signals that are inputs
           B : in STD_LOGIC_VECTOR (15 downto 0);
           OpCode : in STD_LOGIC_VECTOR (2 downto 0); -- creating a signal that will slect the instrcution
           LogicOut : out STD_LOGIC_VECTOR (15 downto 0)); -- output after the instruction is complete
end LogicUnit16Bit;

architecture Behavioral of LogicUnit16Bit is
begin
  process (A,B,OpCode) -- outputs do not go in process
  begin
    case (OpCode) is -- there are multiple ways to write cases, when to use which one
      when "000" => LogicOut <= (A nor B);
      when "001" => LogicOut <= (A nand B);
      when "010" => LogicOut <= (A or B);
      when "011" => LogicOut <= (A and B);
      when "100" => LogicOut <= (A xor B);
      when "101" => LogicOut <= (A xnor B);
      when "110" => LogicOut <= (Not A);
      when "111" => LogicOut <= (Not B);
      when others => null;
    end case;
end process;
end Behavioral;
