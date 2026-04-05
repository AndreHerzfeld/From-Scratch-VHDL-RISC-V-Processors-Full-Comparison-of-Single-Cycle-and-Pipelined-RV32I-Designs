library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ALU_Control is
    port(
        -- Entradas de controle
        i_ALU_Op  : in  std_logic_vector(1 downto 0);
        i_funct3 : in  std_logic_vector(2 downto 0);
        i_funct7 : in  std_logic_vector(6 downto 0);

        -- Saídas para controlar a ULA
        o_ALU_SEL : out std_logic_vector(2 downto 0);
        o_ALU_CIN : out std_logic;
		  o_SHIFT_SEL : out std_logic_vector(1 downto 0);
		  o_SHAMT_SEL : out std_logic
    );
end ALU_Control;

architecture arch of ALU_Control is
begin

    process(i_ALU_Op, i_funct3, i_funct7)
    begin
        -- Lógica de decodificação baseada em ALUOp
        case i_ALU_Op is

            -- ALUOp = "00": Operação de SOMA (para loads/stores)
            when "00" =>
                o_ALU_SEL <= "000"; -- Seleciona a saída do somador
                o_ALU_CIN <= '0';  -- Define a operação como soma
					 o_SHIFT_SEL <= "00";
					 o_SHAMT_SEL <= '0';

            -- ALUOp = "01": Operação de SUBTRAÇÃO (para branches)
            when "01" =>
                o_ALU_SEL <= "000"; -- Seleciona a saída do somador
                o_ALU_CIN <= '1';  -- Define a operação como subtração
					 o_SHIFT_SEL <= "00";
					 o_SHAMT_SEL <= '0';

            -- ALUOp = "10": Operação R-Type (usa funct3 e funct7)
            when "10" =>
                if (i_funct7 = "0000000") then -- add, or, and, xor
                    case i_funct3 is
                        when "000" => -- ADD
                            o_ALU_SEL <= "000";
                            o_ALU_CIN <= '0';
									 o_SHIFT_SEL <= "00";
									 o_SHAMT_SEL <= '0';
                        when "110" => -- OR
                            o_ALU_SEL <= "001";
                            o_ALU_CIN <= '0'; -- Don't care
									 o_SHIFT_SEL <= "00";
									 o_SHAMT_SEL <= '0';
                        when "111" => -- AND
                            o_ALU_SEL <= "010";
                            o_ALU_CIN <= '0'; -- Don't care
									 o_SHIFT_SEL <= "00";
									 o_SHAMT_SEL <= '0';
                        when "100" => -- XOR
                            o_ALU_SEL <= "011";
                            o_ALU_CIN <= '0'; -- Don't care
									 o_SHIFT_SEL <= "00";
									 o_SHAMT_SEL <= '0';
								when "001" => -- SLL
                            o_ALU_SEL <= "100";
                            o_ALU_CIN <= '0'; -- Don't care
									 o_SHIFT_SEL <= "01";
									 o_SHAMT_SEL <= '1';
								when "101" => -- SRL
                            o_ALU_SEL <= "100";
                            o_ALU_CIN <= '0'; -- Don't care	
									 o_SHIFT_SEL <= "10";
									 o_SHAMT_SEL <= '1';
                        when others => -- Outras R-Types não implementadas
                            o_ALU_SEL <= "000"; -- Padrão para SOMA
                            o_ALU_CIN <= '0';
									 o_SHIFT_SEL <= "00";
									 o_SHAMT_SEL <= '0';
                    end case;
                elsif (i_funct7 = "0100000") then -- SUB
							case i_funct3 is
                        when "000" => -- sub
									  o_ALU_SEL <= "000";
									  o_ALU_CIN <= '1';
									  o_SHIFT_SEL <= "00";
									  o_SHAMT_SEL <= '0';
                        when "101" => -- sra
                            o_ALU_SEL <= "100";
                            o_ALU_CIN <= '0'; -- Don't care
									 o_SHIFT_SEL <= "11";
									 o_SHAMT_SEL <= '1';
                        when others => -- Outras R-Types não implementadas
                            o_ALU_SEL <= "000"; -- Padrão para SOMA
                            o_ALU_CIN <= '0';
									 o_SHIFT_SEL <= "00";
									 o_SHAMT_SEL <= '0';
                    end case;

                else -- Outras R-Types não implementadas
                    o_ALU_SEL <= "000"; -- Padrão para SOMA
                    o_ALU_CIN <= '0';
						  o_SHIFT_SEL <= "00";
						  o_SHAMT_SEL <= '0';
                end if;
					 
				when "11" =>
					if (i_funct7 = "0000000") then -- INSTRUCOES I
                    case i_funct3 is
                        when "000" => -- ADD
                            o_ALU_SEL <= "000";
                            o_ALU_CIN <= '0';
									 o_SHIFT_SEL <= "00";
									 o_SHAMT_SEL <= '0';
                        when "110" => -- OR
                            o_ALU_SEL <= "001";
                            o_ALU_CIN <= '0'; -- Don't care
									 o_SHIFT_SEL <= "00";
									 o_SHAMT_SEL <= '0';
                        when "111" => -- AND
                            o_ALU_SEL <= "010";
                            o_ALU_CIN <= '0'; -- Don't care
									 o_SHIFT_SEL <= "00";
									 o_SHAMT_SEL <= '0';
                        when "100" => -- XOR
                            o_ALU_SEL <= "011";
                            o_ALU_CIN <= '0'; -- Don't care
									 o_SHIFT_SEL <= "00";
									 o_SHAMT_SEL <= '0';
								when "001" => -- SLL-i
                            o_ALU_SEL <= "100";
                            o_ALU_CIN <= '0'; -- Don't care
									 o_SHIFT_SEL <= "01";
									 o_SHAMT_SEL <= '0';
								when "101" => -- SRL-i
                            o_ALU_SEL <= "100";
                            o_ALU_CIN <= '0'; -- Don't care	
									 o_SHIFT_SEL <= "10";
									 o_SHAMT_SEL <= '0';
                        when others => -- Outras R-Types não implementadas
                            o_ALU_SEL <= "000"; -- Padrão para SOMA
                            o_ALU_CIN <= '0';
									 o_SHIFT_SEL <= "00";
									 o_SHAMT_SEL <= '0';
                    end case;
                elsif (i_funct7 = "0100000") then -- SUB
							case i_funct3 is
                        when "000" => -- sub
									  o_ALU_SEL <= "000";
									  o_ALU_CIN <= '1';
									  o_SHIFT_SEL <= "00";
									  o_SHAMT_SEL <= '0';
                        when "101" => -- sra-i
                            o_ALU_SEL <= "100";
                            o_ALU_CIN <= '0'; -- Don't care
									 o_SHIFT_SEL <= "11";
									 o_SHAMT_SEL <= '0';
                        when others => -- Outras R-Types não implementadas
                            o_ALU_SEL <= "000"; -- Padrão para SOMA
                            o_ALU_CIN <= '0';
									 o_SHIFT_SEL <= "00";
									 o_SHAMT_SEL <= '0';
                    end case;

                else -- Outras R-Types não implementadas
                    o_ALU_SEL <= "000"; -- Padrão para SOMA
                    o_ALU_CIN <= '0';
						  o_SHIFT_SEL <= "00";
						  o_SHAMT_SEL <= '0';
                end if;

            when others =>
                o_ALU_SEL <= "000";
                o_ALU_CIN <= '0';
					 o_SHIFT_SEL <= "00";
					 o_SHAMT_SEL <= '0';

        end case;
    end process;

end arch;