library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.mux_pkg.all;

entity mux32x1_32bit is
port (
    i_data : in data_bus_32x1;          -- 32 arrays de 32 bits
    i_SEL  : in std_logic_vector(4 downto 0);
    o_S    : out data_bus               -- 32 bits de saída
);
end mux32x1_32bit;

architecture arch_mux32x1 of mux32x1_32bit is

component mux16x1_32bit is
port (
    i_data : in data_bus_16x1;          -- 16 arrays de 32 bits
    i_SEL  : in std_logic_vector(3 downto 0);
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
signal w_in0, w_in1 : data_bus_16x1;

begin

-- Mapear entradas para sinais auxiliares
    w_in0 <= (i_data(0),  i_data(1),  i_data(2),  i_data(3),
              i_data(4),  i_data(5),  i_data(6),  i_data(7),
              i_data(8),  i_data(9),  i_data(10), i_data(11),
              i_data(12), i_data(13), i_data(14), i_data(15));

    w_in1 <= (i_data(16), i_data(17), i_data(18), i_data(19),
              i_data(20), i_data(21), i_data(22), i_data(23),
              i_data(24), i_data(25), i_data(26), i_data(27),
              i_data(28), i_data(29), i_data(30), i_data(31));

-- Primeiro mux16x1 seleciona entre os primeiros 16 inputs
u_0 : mux16x1_32bit port map (
    i_data => w_in0,
    i_SEL  => i_SEL(3 downto 0),
    o_S    => w_s0
);

-- Segundo mux16x1 seleciona entre os últimos 16 inputs
u_1 : mux16x1_32bit port map (
    i_data => w_in1,
    i_SEL  => i_SEL(3 downto 0),
    o_S    => w_s1
);

-- mux2x1 final seleciona entre os resultados dos dois mux16x1
u_2 : mux2x1_32bit port map (
    i_0   => w_s0,
    i_1   => w_s1,
    i_SEL => i_SEL(4),
    o_S   => o_S
);

end arch_mux32x1;