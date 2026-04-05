library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Cyclecounter_32bit is
    port (
        i_RST : in std_logic;
        i_CLK : in std_logic;
        o_S   : out std_logic_vector(7 downto 0) 
    );
end Cyclecounter_32bit;

architecture arch_cyclecounter of Cyclecounter_32bit is
    signal w_soma : unsigned(7 downto 0); 
begin

    process(i_CLK, i_RST)
    begin
        if (i_RST = '1') then
            w_soma <= (others => '0');
        elsif rising_edge(i_CLK) then
            w_soma <= w_soma + 1;
        end if;
    end process;

    o_S <= std_logic_vector(w_soma);

end arch_cyclecounter;
