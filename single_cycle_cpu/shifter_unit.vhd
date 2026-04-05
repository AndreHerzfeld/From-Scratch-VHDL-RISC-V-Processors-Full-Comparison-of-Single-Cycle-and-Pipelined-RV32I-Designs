library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity shifter_unit is
    port(
        i_A          : in  std_logic_vector(31 downto 0); -- Dado para deslocar
        i_shamt      : in  std_logic_vector(4 downto 0); -- Usado para a quantidade de deslocamento (shamt)
        i_SEL_SHIFT  : in  std_logic_vector(1 downto 0); -- Seletor: 01=SLL, 10=SRL, 11=SRA
        o_S          : out std_logic_vector(31 downto 0)  -- Resultado
    );
end shifter_unit;

architecture Behavioral of shifter_unit is
    -- Sinal interno para a quantidade de deslocamento (shamt) como inteiro
    signal s_shift_amount : integer range 0 to 31;
begin
    -- A quantidade de deslocamento é tipicamente os 5 bits menos significativos
    s_shift_amount <= to_integer(unsigned(i_shamt(4 downto 0)));

    -- Processo para selecionar a operação de deslocamento
    process(i_A, s_shift_amount, i_SEL_SHIFT)
    begin
        case i_SEL_SHIFT is
            -- SLLI (Shift Left Logical)
            when "01" =>
                o_S <= std_logic_vector(shift_left(unsigned(i_A), s_shift_amount));

            -- SRLI (Shift Right Logical) - Preenche com '0' à esquerda
            when "10" =>
                o_S <= std_logic_vector(shift_right(unsigned(i_A), s_shift_amount));

            -- SRAI (Shift Right Arithmetic) - Preenche com o bit de sinal à esquerda
            when "11" =>
                o_S <= std_logic_vector(shift_right(signed(i_A), s_shift_amount));

            -- Caso padrão, não faz nada
            when others =>
                o_S <= i_A;
        end case;
    end process;

end Behavioral;