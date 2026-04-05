library IEEE;

use ieee.std_logic_1164.all;

entity WriteData_Decision is
port(
		i_AUIPC  :  in std_logic;
		i_LUI	   :  in std_logic;
		i_JAL	   :  in std_logic;
		o_S		:  out std_logic_vector (1 downto 0)
);
end WriteData_Decision;

architecture arch_WriteData of WriteData_Decision is

begin

o_S(1) <= i_LUI or i_JAL;
o_S(0) <= i_AUIPC or i_JAL;

end arch_WriteData;