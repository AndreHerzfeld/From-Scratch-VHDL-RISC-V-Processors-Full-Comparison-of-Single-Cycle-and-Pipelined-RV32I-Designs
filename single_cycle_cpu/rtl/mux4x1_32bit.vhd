library IEEE;

use IEEE.std_logic_1164.all;

library work;
use work.mux_pkg.all;


entity mux4x1_32bit is
port (
		 i_data :  in data_bus_4x1; -- 4 arrays of 32 bits each
       i_SEL  :  in std_logic_vector (1 downto 0);
       o_S    :  out data_bus); -- 32 bit output
end mux4x1_32bit;

architecture arch_mux4x1 of mux4x1_32bit is

component mux2x1_32bit is 
port(
    i_0   : in data_bus;
    i_1   : in data_bus;
    i_SEL : in std_logic;
    o_S   : out data_bus
);
end component;

signal w_s0,w_s1  :  data_bus;

begin

-- First mux level
u_0  :  mux2x1_32bit port map ( i_0 => i_data(0),
										  i_1 => i_data(1),
                                i_SEL => i_SEL(0),
                                o_S => w_s0
);

u_1  :  mux2x1_32bit port map ( i_0 => i_data(2),
										  i_1 => i_data(3),
                                 i_SEL => i_SEL(0),
                                 o_S => w_s1
);


-- Second mux level
u_2  :  mux2x1_32bit port map ( i_0 => w_s0,
										  i_1 => w_s1,
                                i_SEL => i_SEL(1),
                                o_S => o_S
);

end arch_mux4x1;