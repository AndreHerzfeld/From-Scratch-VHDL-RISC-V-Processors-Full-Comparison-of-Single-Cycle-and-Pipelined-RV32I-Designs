library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.mux_pkg.all;

entity mux2x1_32bit is
port(
	 i_0   : in data_bus;
	 i_1   : in data_bus;
    i_SEL : in std_logic;
    o_S   : out data_bus
);
end mux2x1_32bit;

architecture arch_2x1_32bit of mux2x1_32bit is
begin

gen_mux: for i in 0 to 31 generate 

begin
o_S(i) <= (not i_SEL and i_0(i)) or (i_SEL and i_1(i));

end generate gen_mux;


end arch_2x1_32bit;