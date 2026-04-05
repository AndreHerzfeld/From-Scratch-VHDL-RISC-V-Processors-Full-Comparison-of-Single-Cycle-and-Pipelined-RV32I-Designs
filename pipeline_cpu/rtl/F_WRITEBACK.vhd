library IEEE;
use IEEE.std_logic_1164.all;

-- Módulo do Datapath do Estágio de Write-Back (WB)
entity F_WRITEBACK is
    port(
        -- Entradas (vindas do estágio MEM/WB)
        i_ALU_result   : in  std_logic_vector(31 downto 0); -- Resultado da ULA
        i_ReadMem_data : in  std_logic_vector(31 downto 0); -- Dado lido da memória
        
        -- Sinal de controle (vindo do estágio MEM/WB)
        i_MemToReg     : in  std_logic; -- '0' para resultado da ULA, '1' para dado da memória

        -- Saída (para o banco de registradores no estágio ID)
        o_Write_data   : out std_logic_vector(31 downto 0)  -- Dado final a ser escrito
    );
end F_WRITEBACK;

architecture arch of F_WRITEBACK is

    -- Definição do componente MUX
    component mux2x1_32bit is
        port(
            i_0   : in std_logic_vector(31 downto 0);
            i_1   : in std_logic_vector(31 downto 0);
            i_SEL : in std_logic;
            o_S   : out std_logic_vector(31 downto 0)
        );
    end component;

begin

    -- =================================================================
    -- LÓGICA DO DATAPATH DE WRITE-BACK
    -- =================================================================

    -- 1. Mux para selecionar o dado a ser escrito no banco de registradores
    u_wb_mux: mux2x1_32bit
        port map (
            i_0   => i_ALU_result,
            i_1   => i_ReadMem_data,
            i_SEL => i_MemToReg,
            o_S   => o_Write_data
        );

end arch;