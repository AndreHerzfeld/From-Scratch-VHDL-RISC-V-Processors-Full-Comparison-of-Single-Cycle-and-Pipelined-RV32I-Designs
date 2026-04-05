library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- A entidade da controladora recebe ALUOp, funct3 e funct7
-- e gera os sinais de controle para a ULA_hierarquica.
entity controlador_ula is
    port(
        -- Entradas de controle
        i_ALUOp  : in  std_logic_vector(1 downto 0);
        i_funct3 : in  std_logic_vector(2 downto 0);
        i_funct7 : in  std_logic_vector(6 downto 0);

        -- Saídas para controlar a ULA
        o_ULA_SEL : out std_logic_vector(1 downto 0);
        o_ULA_CIN : out std_logic
    );
end controlador_ula;

architecture arch of controlador_ula is
begin

    process(i_ALUOp, i_funct3, i_funct7)
    begin
        -- Lógica de decodificação baseada em ALUOp
        case i_ALUOp is

            -- ALUOp = "00": Operação de SOMA (para loads/stores)
            when "00" =>
                o_ULA_SEL <= "00"; -- Seleciona a saída do somador
                o_ULA_CIN <= '0';  -- Define a operação como soma

            -- ALUOp = "01": Operação de SUBTRAÇÃO (para branches)
            when "01" =>
                o_ULA_SEL <= "00"; -- Seleciona a saída do somador
                o_ULA_CIN <= '1';  -- Define a operação como subtração

            -- ALUOp = "10": Operação R-Type (usa funct3 e funct7)
            when "10" =>
                if (i_funct7 = "0000000") then -- add, or, and, xor
                    case i_funct3 is
                        when "000" => -- ADD
                            o_ULA_SEL <= "00";
                            o_ULA_CIN <= '0';
                        when "110" => -- OR
                            o_ULA_SEL <= "01";
                            o_ULA_CIN <= '0'; -- Don't care
                        when "111" => -- AND
                            o_ULA_SEL <= "10";
                            o_ULA_CIN <= '0'; -- Don't care
                        when "100" => -- XOR
                            o_ULA_SEL <= "11";
                            o_ULA_CIN <= '0'; -- Don't care
                        when others => -- Outras R-Types não implementadas
                            o_ULA_SEL <= "00"; -- Padrão para SOMA
                            o_ULA_CIN <= '0';
                    end case;
                elsif (i_funct7 = "0100000" and i_funct3 = "000") then -- SUB
                    o_ULA_SEL <= "00";
                    o_ULA_CIN <= '1';
                else -- Outras R-Types não implementadas
                    o_ULA_SEL <= "00"; -- Padrão para SOMA
                    o_ULA_CIN <= '0';
                end if;

            -- ALUOp = "11" (ou outros): Não utilizado, define um padrão seguro (SOMA)
            when others =>
                o_ULA_SEL <= "00";
                o_ULA_CIN <= '0';

        end case;
    end process;

end arch;