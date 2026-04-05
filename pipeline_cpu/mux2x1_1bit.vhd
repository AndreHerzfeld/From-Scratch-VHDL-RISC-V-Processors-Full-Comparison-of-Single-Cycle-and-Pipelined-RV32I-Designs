library IEEE;

use ieee.std_logic_1164.all;

entity mux2x1_1bit is
port( i_0  :  in std_logic;
	  i_1  :  in std_logic;
      i_SEL:  in std_logic;
      o_S  :  out std_logic);
end mux2x1_1bit;

architecture arch_2x1_1bit of mux2x1_1bit is

begin

o_S <= (not i_SEL and i_0) or (i_SEL and i_1);

end arch_2x1_1bit;