library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.mux_pkg.all;

entity mux16x1_32bit is
port (
    i_data : in data_bus_16x1; -- 16 arrays of 32 bits each
    i_SEL  : in std_logic_vector(3 downto 0);
    o_S    : out data_bus -- 32 bit output
);
end mux16x1_32bit;

architecture arch_mux16x1 of mux16x1_32bit is

component mux8x1_32bit is
port (
    i_data : in data_bus_8x1;
    i_SEL  : in std_logic_vector(2 downto 0);
    o_S    : out data_bus
);
end component;

component mux2x1_32bit is
port (
    i_0   : in data_bus;
    i_1   : in data_bus;
    i_SEL : in std_logic;
    o_S   : out data_bus
);
end component;

signal w_s0, w_s1 : data_bus;
signal w_in0, w_in1 : data_bus_8x1;

begin
	w_in0 <= (i_data(0),  i_data(1),  i_data(2),  i_data(3),
              i_data(4),  i_data(5),  i_data(6),  i_data(7));
				  
	w_in1 <= (i_data(8),  i_data(9),  i_data(10), i_data(11),
              i_data(12), i_data(13), i_data(14), i_data(15));

-- Primeiro mux8x1 seleciona entre os primeiros 8 inputs
u_0 : mux8x1_32bit port map (
    i_data => w_in0,
    i_SEL  => i_SEL(2 downto 0),
    o_S    => w_s0
);

-- Segundo mux8x1 seleciona entre os últimos 8 inputs
u_1 : mux8x1_32bit port map (
    i_data => w_in1,
    i_SEL  => i_SEL(2 downto 0),
    o_S    => w_s1
);

-- mux2x1 final seleciona entre os resultados dos dois mux8x1
u_2 : mux2x1_32bit port map (
    i_0   => w_s0,
    i_1   => w_s1,
    i_SEL => i_SEL(3),
    o_S   => o_S
);

end arch_mux16x1;