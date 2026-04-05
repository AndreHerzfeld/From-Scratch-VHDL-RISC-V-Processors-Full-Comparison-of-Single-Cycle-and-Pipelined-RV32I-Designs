library ieee;
use ieee.std_logic_1164.all;

entity register32 is
port ( i_CLK   : in  std_logic;  -- clock
       i_ENA   : in  std_logic;  -- enable    
       i_D     : in  std_logic_vector(31 downto 0);  -- data input
       o_Q     : out std_logic_vector(31 downto 0)); -- data output
end register32;


architecture arch_1 of register32 is
begin
  process(i_CLK) 
  begin
	if (rising_edge(i_CLK)) then
      if (i_ENA = '1') then
         o_Q <= i_D;
      end if;
    end if;
  end process;
end arch_1;