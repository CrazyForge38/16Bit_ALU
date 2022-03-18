library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Arithmetic_16Bit_Unit is
    Port ( A : in STD_LOGIC_VECTOR(15 downto 0); -- 16bit input
           B : in STD_LOGIC_VECTOR(15 downto 0); -- 16bit input
           Op_Sel : in STD_LOGIC_VECTOR(1 downto 0); --Operation selection
           ArithOut : out STD_LOGIC_VECTOR(15 downto 0); --result
           Cout : out STD_LOGIC); --carry out bit of operation
end Arithmetic_16Bit_Unit;

architecture Behavioral of Arithmetic_16Bit_Unit is

begin

process (A,B,Op_Sel)
begin
  
   case Op_Sel is --all values are unsigned
    when "00" => ArithOut <= A(7 downto 0) * B(7 downto 0); --grabs the lower 8 bits from each and multiply
      Cout <= '0';
    when "01" => ArithOut <= A+B;
      if (('0' & A) + ('0' & B) > x"FFFF") -- if the addition of both vlaues is greater than xffff, carry becomes 1
        then Cout <= '1';
      else Cout <= '0';
      end if;
    when "10" => ArithOut <= A-B;
      if (B > A) -- if A is greater than B, the carry is set to 1
        then Cout <= '1';
      else
        Cout <= '0';
      end if;
    when "11" => ArithOut <= A+1;
      if (a = x"FFFF") -- carry is fet to 1 when A is saturated
        then Cout <= '1';
      else 
        Cout <= '0';
      end if;  
    when others => ArithOut <= (others => 'X'); --simply putting NULL in your always branch will result in latches being inferred.
      Cout <= 'X';
  end case;                                   -- X = forcing unknown
 
  
end process;
end Behavioral;
