-- Arquivo: a_and_b.vhd (VERSÃO CORRIGIDA)

library IEEE;
use ieee.std_logic_1164.all;

entity a_and_b is
    port( i_A : in  std_logic_vector(31 downto 0); -- << CORRETO (32 bits)
          i_B : in  std_logic_vector(31 downto 0); -- << CORRETO (32 bits)
          o_S : out std_logic_vector(31 downto 0)  -- << CORRETO (32 bits)
        );
end entity a_and_b;

architecture Behavioral of a_and_b is
begin
    -- Esta lógica funciona para qualquer largura, então não precisa mudar.
    o_S <= i_A and i_B; 
end Behavioral;