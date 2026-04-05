library IEEE;

use IEEE.std_logic_1164.all;

entity a_or_b is
port(i_A  :  in std_logic_vector (31 downto 0);
     i_B  :  in std_logic_vector (31 downto 0);
     o_S  :  out std_logic_vector (31 downto 0));
end a_or_b;

architecture arch_or of a_or_b is
begin

o_S <= i_A or i_B; 
end arch_or;