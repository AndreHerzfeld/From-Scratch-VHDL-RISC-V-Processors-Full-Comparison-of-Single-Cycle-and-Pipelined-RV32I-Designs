library IEEE;

use IEEE.std_logic_1164.all;

entity a_xor_b is
port(i_A  :  in std_logic_vector (31 downto 0);
	 i_B  :  in std_logic_vector (31 downto 0);
     o_S  :  out std_logic_vector (31 downto 0));
end a_xor_b;

architecture arch_xor of a_xor_b is
begin 

o_S <= i_A xor i_B; 
end arch_xor;