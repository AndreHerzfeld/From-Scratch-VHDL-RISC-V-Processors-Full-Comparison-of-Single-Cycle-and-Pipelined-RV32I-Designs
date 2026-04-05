library ieee;
use ieee.std_logic_1164.all;

entity register32_with_reset is
  port (
    i_RESET : in  std_logic;  -- clear/reset
    i_CLK   : in  std_logic;  -- clock
    i_ENA   : in  std_logic;  -- enable    
    i_D     : in  std_logic_vector(31 downto 0);  -- data input
    o_Q     : out std_logic_vector(31 downto 0)   -- data output
);
end register32_with_reset;

architecture arch_2 of register32_with_reset is
begin
  process(i_CLK)
  begin
    if rising_edge(i_CLK) then
      if (i_RESET = '1') then
        o_Q <= (others => '0');
      elsif (i_ENA = '1') then
        o_Q <= i_D;
      end if;
    end if;
  end process;
end arch_2;