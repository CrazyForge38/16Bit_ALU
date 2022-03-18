library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ALU_Behav is
    Port ( A : in STD_LOGIC_VECTOR(15 downto 0);
           B : in STD_LOGIC_VECTOR(15 downto 0);
           Mode : in STD_LOGIC;
           OpCode : in STD_LOGIC_VECTOR(2 downto 0);
           ALU_Out : out STD_LOGIC_VECTOR(15 downto 0);
           Cout : out STD_LOGIC);
end ALU_Behav;

architecture Structural of ALU_Behav is

  ------ Controller ---------------------
  component Controller_Mode_OpCode is
    Port ( Mode : in STD_LOGIC;
           OpCode : in STD_LOGIC_VECTOR(2 downto 0);
           Direction : out STD_LOGIC;
           Shift_Type : out STD_LOGIC;
           Arith_Select : out STD_LOGIC_VECTOR(1 downto 0);
           Sel_1 : out STD_LOGIC;
           Sel_Cout : out STD_LOGIC;
           Sel_2 : out STD_LOGIC;
           OpCode_To_Logic : out STD_LOGIC_VECTOR(2 downto 0));
  end component;

  ---AND Gate------------------------------
  component AND_2to1 is
    Port (  A : in STD_LOGIC;
           B : in STD_LOGIC;
           Z : out STD_LOGIC);
  end component;
  
  ----Arithmetic Unit -----------------
  component Arithmetic_16Bit_Unit is
    Port ( A : in STD_LOGIC_VECTOR(15 downto 0); -- 16bit input
           B : in STD_LOGIC_VECTOR(15 downto 0); -- 16bit input
           Op_Sel : in STD_LOGIC_VECTOR(1 downto 0); --Operation selection
           ArithOut : out STD_LOGIC_VECTOR(15 downto 0); --result
           Cout : out STD_LOGIC); --carry out bit of operation
  end component;
  
  -------Logic Unit-------------
  component LogicUnit16Bit is
    Port ( A : in STD_LOGIC_VECTOR (15 downto 0); -- A and B are the two register signals that are inputs
           B : in STD_LOGIC_VECTOR (15 downto 0);
           OpCode : in STD_LOGIC_VECTOR (2 downto 0); -- creating a signal that will slect the instrcution
           LogicOut : out STD_LOGIC_VECTOR (15 downto 0)); -- output after the instruction is complete
   end component;
   
   ----Shifter----------------------
   component Shifter_16Bit is
    Port ( A : in STD_LOGIC_VECTOR(15 downto 0);-- A and B are inputs
           B : in STD_LOGIC_VECTOR(15 downto 0);
           Direction : in STD_LOGIC; --LSB of Op_Sel
           Op_Type : in STD_LOGIC; --MSB of Op_Sel
           ShiftOut : out STD_LOGIC_VECTOR(15 downto 0)); -- output
    end component;
    
    -----Mux--------
    component mux2to1 is
    Port ( a : in STD_LOGIC_VECTOR (15 DOWNTO 0); -- 15 down to 0 means 16 bits
           b : in STD_LOGIC_VECTOR (15 DOWNTO 0); -- with no downto means 1 bit
           sel : in STD_LOGIC; 
           z : out STD_LOGIC_VECTOR (15 DOWNTO 0));
    end component;

-------Controller Signals-------------
signal Contrl_OpCode_To_Logic : std_logic_vector (2 downto 0); --creates signals to transfer data from 
signal Contrl_Dir_To_Shifter : std_logic;                      -- the controler to other compoents
signal Contrl_Type_To_Shifter : std_logic;
signal Contrl_Select_To_Arith : std_logic_vector (1 downto 0);
signal Contrl_SEL_1_To_Arith_Shifter_Mux : std_logic;
signal Contrl_Sel_Cout_To_And : std_logic;
signal Contrl_Sel2_To_Logic_Or_Others_Mux : std_logic;
---------Arith Unit Signals------------
signal Arith_To_Mux1 : std_logic_vector(15 downto 0); -- signals from arithmetic unit
signal Arith_Cout : std_logic;
---------Shifter singal----------
signal Shift_To_Mux1 : std_logic_vector(15 downto 0);  -- signals from arithmetic unit
----------Logic Signal-----------
signal Logic_to_Mux2 : std_logic_vector(15 downto 0); -- signals from arithmetic unit
---------Mux 1------
signal Mux1_To_Mux2 : std_logic_vector(15 downto 0); -- signals from arithmetic unit
------- A and B  _16Bit ------------------
--signal A_16Bit : std_logic_vector (15 downto 0);
--signal B_16Bit : std_logic_vector (15 downto 0);

begin
--signals with there given entity listed in comments
Controller : Controller_Mode_OpCode port map (Mode, OpCode, Contrl_Dir_To_Shifter, Contrl_Type_To_Shifter,Contrl_Select_To_Arith,
    Contrl_SEL_1_To_Arith_Shifter_Mux,Contrl_Sel_Cout_To_And, Contrl_Sel2_To_Logic_Or_Others_Mux, Contrl_OpCode_To_Logic);    --(Mode,OpCode,Direction,Shift_Type,Arith_Select,Sel_1,Sel_Cout,Sel_2,OpCode_To_Logic)
Arithmetic : Arithmetic_16Bit_Unit port map (A,B,Contrl_Select_To_Arith,Arith_To_Mux1,Arith_Cout); --(A,B,Op_Sel,ArithOut,Cout)
Shifter : Shifter_16Bit port map (A,B,Contrl_Dir_To_Shifter,Contrl_Type_To_Shifter,Shift_To_Mux1); --(A,B,Direction,Op_Type,ShiftOut)
Logic : LogicUnit16Bit port map (A,B,Contrl_OpCode_To_Logic,Logic_to_Mux2); --(A,B,OpCode,LogicOut)
Mux1 : mux2to1 port map (Arith_To_Mux1,Shift_To_Mux1,Contrl_SEL_1_To_Arith_Shifter_Mux,Mux1_To_Mux2); --(A,B,Sel,Z)
Mux2 : mux2to1 port map (Logic_to_Mux2,Mux1_To_Mux2,Contrl_Sel2_To_Logic_Or_Others_Mux,ALU_Out); --(A,B,Sel,Z)
AND_Gate : AND_2to1 port map (Arith_Cout,Contrl_Sel_Cout_To_And,Cout); --(A,B,Z)

end Structural;
