library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.mux_pkg.all;

entity mux8x1_32bit is
port (
    i_data: in data_bus_8x1; -- 8 arrays of 32 bits each
    i_SEL : in std_logic_vector(2 downto 0);
    o_S   : out data_bus -- 32 bit output
);
end mux8x1_32bit;

architecture arch_mux8x1 of mux8x1_32bit is

component mux4x1_32bit is
port (
    i_data: in data_bus_4x1;
    i_SEL : in std_logic_vector(1 downto 0);
    o_S   : out data_bus
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
signal w_in0 : data_bus_4x1;
signal w_in1 : data_bus_4x1;
signal w_s0, w_s1 : data_bus; -- 32 bit signals

begin
	w_in0 <= (i_data(0), i_data(1), i_data(2), i_data(3));
	w_in1 <= (i_data(4), i_data(5), i_data(6), i_data(7));

-- Primeiro mux4x1 seleciona entre os primeiros 4 inputs
u_0 : mux4x1_32bit port map (
    i_data => w_in0,
    i_SEL  => i_SEL(1 downto 0),
    o_S    => w_s0
);

-- Segundo mux4x1 seleciona entre os últimos 4 inputs
u_1 : mux4x1_32bit port map (
    i_data => w_in1,
    i_SEL  => i_SEL(1 downto 0),
    o_S    => w_s1
);

-- mux2x1 final seleciona entre os resultados dos dois mux4x1
u_2 : mux2x1_32bit port map (
    i_0   => w_s0,
    i_1   => w_s1,
    i_SEL => i_SEL(2),
    o_S   => o_S
);

end arch_mux8x1;