library IEEE;
use IEEE.std_logic_1164.all;

package mux_pkg is

subtype data_bus is std_logic_vector(31 downto 0); -- Base width for all positions in arrays

type data_bus_2x1 is array (0 to 1) of data_bus;
type data_bus_4x1 is array (0 to 3) of data_bus;
type data_bus_8x1 is array (0 to 7) of data_bus;
type data_bus_16x1 is array (0 to 15) of data_bus;
type data_bus_32x1 is array (0 to 31) of data_bus;

end package mux_pkg;
