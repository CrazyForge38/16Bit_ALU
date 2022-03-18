----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/11/2022 05:32:57 PM
-- Design Name: 
-- Module Name: ALU_16Bit_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_16Bit_tb is
--  Port ( );
end ALU_16Bit_tb;

architecture Behavioral of ALU_16Bit_tb is

component ALU_Behav is
    Port ( A : in STD_LOGIC_VECTOR(15 downto 0);
           B : in STD_LOGIC_VECTOR(15 downto 0);
           Mode : in STD_LOGIC;
           OpCode : in STD_LOGIC_VECTOR(2 downto 0);
           ALU_Out : out STD_LOGIC_VECTOR(15 downto 0);
           Cout : out STD_LOGIC);
end component;

signal A,B,ALU_Out : STD_LOGIC_VECTOR(15 downto 0);
signal OpCode : STD_LOGIC_VECTOR(2 downto 0);
signal Mode,Cout : STD_LOGIC;

begin
utt: ALU_Behav port map (A,B,Mode,OpCode,ALU_Out,Cout);

process
begin

A <= x"f33f";
B <= x"AAAA";

Mode <= '0';
OpCode <= "000";
wait for 40 ns; --A nor B

Mode <= '0';
OpCode <= "001";
wait for 40 ns; -- A nand B

Mode <= '0';
OpCode <= "010";
wait for 40 ns;  -- A or B

Mode <= '0';
OpCode <= "011";
wait for 40 ns; -- A and B

Mode <= '0';
OpCode <= "100";
wait for 40 ns; -- A xor B

Mode <= '0';
OpCode <= "101";
wait for 40 ns; -- A xnor B

Mode <= '0';
OpCode <= "110";
wait for 40 ns; -- Not A

Mode <= '0';
OpCode <= "111";
wait for 40 ns; -- Not B

Mode <= '1';
OpCode <= "000";
wait for 40 ns; -- A * B

A <= x"f33f";
B <= x"AA00";

Mode <= '1';
OpCode <= "000";
wait for 40 ns; -- A * B

-----------------------------------------

A <= x"f33f";
B <= x"AAAA";

Mode <= '1';
OpCode <= "001";
wait for 40 ns; -- A + B with carry

A <= x"f33f";
B <= x"0000";

Mode <= '1';
OpCode <= "001";
wait for 40 ns; -- A + B without carry 

A <= x"f33f";
B <= x"0000";

Mode <= '1';
OpCode <= "001";
wait for 40 ns; -- A + B with b gets 0

-------------------------------------------------
-- subtraction of A and B

A <= x"f33f";
B <= x"AAAA";

Mode <= '1';
OpCode <= "010";
wait for 40 ns; -- A - B 

A <= x"0040";
B <= x"0050";

Mode <= '1';
OpCode <= "010";
wait for 40 ns; -- A - B with carry

------------------------------------------

A <= x"ffff";
B <= x"AAAA";

Mode <= '1';
OpCode <= "011";
wait for 40 ns; -- A++ overflow

A <= x"f33f";
B <= x"AAAA";

Mode <= '1';
OpCode <= "011";
wait for 40 ns; -- A++ 

-----------------------

--Shifter unit

A <= x"0f00";
B <= x"0003";

Mode <= '1';
OpCode <= "100";
wait for 40 ns; -- shift left A by B

A <= x"0f00";
B <= x"000C";

Mode <= '1';
OpCode <= "100";
wait for 40 ns; -- shift left A by B
-------------------------------------------
A <= x"0f00";
B <= x"0003";

Mode <= '1';
OpCode <= "101";
wait for 40 ns; -- shift right A by B

A <= x"0f00";
B <= x"000C";

Mode <= '1';
OpCode <= "101";
wait for 40 ns; -- shift right A by B
-------------------------------------------
A <= x"00f0";
B <= x"0003";

Mode <= '1';
OpCode <= "110";
wait for 40 ns; -- rotate left A by B

A <= x"00f0";
B <= x"000C";

Mode <= '1';
OpCode <= "110";
wait for 40 ns; -- rotate left A by B
------------------------------------------
A <= x"00f0";
B <= x"0003";

Mode <= '1';
OpCode <= "111";
wait for 40 ns; -- rotate right A by B

A <= x"00f0";
B <= x"000C";

Mode <= '1';
OpCode <= "111";
wait for 40 ns; -- rotate right A by B

wait;
end process;
end Behavioral;
