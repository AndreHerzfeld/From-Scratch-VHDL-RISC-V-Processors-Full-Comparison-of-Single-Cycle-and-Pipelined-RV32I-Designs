library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

-- A entidade do testbench é vazia, pois ele não possui portas externas.
entity tb_rv32_pipeline is
end tb_rv32_pipeline;

architecture testbench of tb_rv32_pipeline is

    -- 1. Declarar o componente que será testado (Unit Under Test - UUT)
    -- A declaração deve ser idêntica à entidade do seu pipeline.
    component rv32_pipeline is
        port(
            -- Inputs
            i_CLK   : in std_logic;
            i_RESET : in std_logic;

            -- Outputs
            o_PC_IF      : out std_logic_vector (31 downto 0);
            o_RD2        : out std_logic_vector (31 downto 0);
            o_ALU_Res    : out std_logic_vector (31 downto 0);
            o_RAM_Output : out std_logic_vector (31 downto 0)
        );
    end component;

    -- 2. Declarar os sinais internos do testbench para conectar ao UUT.
    -- Inputs para o UUT
    signal s_CLK   : std_logic := '0';
    signal s_RESET : std_logic;

    -- Sinais para capturar as saídas do UUT
    signal s_PC_IF      : std_logic_vector (31 downto 0);
    signal s_RD2        : std_logic_vector (31 downto 0);
    signal s_ALU_Res    : std_logic_vector (31 downto 0);
    signal s_RAM_Output : std_logic_vector (31 downto 0);
    
    -- Período do clock para facilitar a leitura
    constant CLK_PERIOD : time := 6.22 ns;

begin

    -- 3. Instanciar o UUT
    -- Conecta as portas do componente rv32_pipeline aos sinais locais do testbench.
    uut: rv32_pipeline
        port map(
            i_CLK        => s_CLK,
            i_RESET      => s_RESET,
            o_PC_IF      => s_PC_IF,
            o_RD2        => s_RD2,
            o_ALU_Res    => s_ALU_Res,
            o_RAM_Output => s_RAM_Output
        );

    -- 4. Processo de estímulo (gerador de reset e clock manual)
    stimulus_proc: process
    begin
        -- ================================================================
        -- FASE 1: RESET ASSÍNCRONO
        -- Ativa o reset antes de qualquer pulso de clock.
        -- ================================================================
        report "Iniciando Testbench: Aplicando Reset Assincrono." severity note;
        s_RESET <= '1';
        wait for 6.22 ns; -- Mantém o reset ativo por um tempo para garantir a inicialização
		          -- Ciclo 1
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);

        wait for (CLK_PERIOD / 2); -- Espera um pouco antes do primeiro clock subir

		  
		  s_CLK <= '1';
		  wait for 6.22 ns;
		  
		  s_RESET <= '0';
		  wait for 6.22 ns;
        -- ================================================================
        -- FASE 2: CLOCK MANUAL, CICLO A CICLO
        -- Geramos pulsos de clock um por um para avançar o pipeline.
        -- ================================================================
        report "Iniciando geracao de clock manual..." severity note;

        -- Ciclo 1
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        report "Fim do ciclo 1." severity note;

        -- Ciclo 2
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        report "Fim do ciclo 2." severity note;

        -- Ciclo 3
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        report "Fim do ciclo 3." severity note;

        -- Ciclo 4
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        report "Fim do ciclo 4." severity note;
        
        -- Ciclo 5
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        report "Fim do ciclo 5." severity note;

        -- Ciclo 6
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        report "Fim do ciclo 6." severity note;

        -- Ciclo 7
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        report "Fim do ciclo 7." severity note;
        
        -- Ciclo 8
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        report "Fim do ciclo 8." severity note;
        
        -- Ciclo 9
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        report "Fim do ciclo 9." severity note;
        
        -- Ciclo 10
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        report "Fim do ciclo 10." severity note;
		  
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
		  
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
		  
		  s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
		  
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);

        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);
        s_CLK <= '1'; wait for (CLK_PERIOD / 2);
        s_CLK <= '0'; wait for (CLK_PERIOD / 2);		  
		  
        -- Fim da simulação
        report "Geracao de clock finalizada. Fim do Testbench." severity failure;
        wait; -- Interrompe o processo e a simulação

    end process stimulus_proc;

end architecture testbench;