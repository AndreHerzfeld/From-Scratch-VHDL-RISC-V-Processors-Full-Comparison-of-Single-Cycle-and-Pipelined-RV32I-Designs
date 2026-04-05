library IEEE;

use ieee.std_logic_1164.all;

entity Full_Adder is
port (i_A    :  in std_logic;
	   i_B    :  in std_logic;
      i_CIN  :  in std_logic;
	   o_COUT : out std_logic;
      o_S    : out std_logic );
end Full_Adder;

architecture arch_full_adder of Full_Adder is
begin 

o_S <= (i_A xor i_B) xor i_CIN;
o_COUT <= (i_B and i_CIN) or (i_A and i_B) or (i_A and i_CIN);

end arch_full_adder;