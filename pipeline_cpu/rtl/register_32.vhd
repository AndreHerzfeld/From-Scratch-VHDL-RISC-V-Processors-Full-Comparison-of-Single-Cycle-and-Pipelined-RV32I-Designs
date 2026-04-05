library ieee;
use ieee.std_logic_1164.all;

entity register_32 is
port ( i_CLK   : in  std_logic;  -- clock
       i_D     : in  std_logic_vector(31 downto 0);  -- data input
       o_Q     : out std_logic_vector(31 downto 0)); -- data output
end register_32;


architecture arch_1 of register_32 is
begin
  process(i_CLK) 
  begin
	if (rising_edge(i_CLK)) then
         o_Q <= i_D;
      end if;
  end process;
end arch_1;