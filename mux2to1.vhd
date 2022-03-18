library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mux2to1 is
    Port ( a : in STD_LOGIC_VECTOR (15 DOWNTO 0); -- 15 down to 0 means 16 bits
           b : in STD_LOGIC_VECTOR (15 DOWNTO 0); -- with no downto means 1 bit
           sel : in STD_LOGIC; 
           z : out STD_LOGIC_VECTOR (15 DOWNTO 0));
end mux2to1;

architecture Behavioral of mux2to1 is

begin
mux: process (a,b,sel) -- these are the inputs
    BEGIN 
    IF sel = '0' THEN z <= a; --if sel is 0, the output will be a's data
    ELSE z <= b;              --if sel is 1, the output will be b's data
    END IF;
    END PROCESS mux;
end Behavioral;
