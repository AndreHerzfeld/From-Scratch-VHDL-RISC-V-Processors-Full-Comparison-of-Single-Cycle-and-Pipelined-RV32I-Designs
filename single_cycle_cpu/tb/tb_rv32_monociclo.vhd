library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity tb_rv32_monociclo is
end tb_rv32_monociclo;

architecture testbench of tb_rv32_monociclo is

    -- 1. Declarar o componente que será testado (UUT)
    component rv32_monociclo is
        port(
            -- Inputs
            i_CLK  : in std_logic;
            i_RESET: in std_logic;
            
            -- Outputs
            o_instruction_debug : out std_logic_vector(31 downto 0);
            o_RD                 : out std_logic_vector(4 downto 0);
            O_RD1_debug          : out std_logic_vector(31 downto 0);
            o_RD2_debug          : out std_logic_vector(31 downto 0);
            o_Immediate          : out std_logic_vector(31 downto 0);
            o_PC_debug           : out std_logic_vector(31 downto 0);
            o_ALU                : out std_logic_vector(31 downto 0);
            o_RAM                : out std_logic_vector(31 downto 0)
        );
    end component;

    -- 2. Sinais internos do testbench
    signal s_CLK                : std_logic;
    signal s_RESET              : std_logic;
    signal s_instruction_debug  : std_logic_vector(31 downto 0);
    signal s_RD                 : std_logic_vector(4 downto 0);
    signal s_RD1_debug          : std_logic_vector(31 downto 0);
    signal s_RD2_debug          : std_logic_vector(31 downto 0);
    signal s_Immediate          : std_logic_vector(31 downto 0);
    signal s_PC_debug           : std_logic_vector(31 downto 0);
    signal s_ALU                : std_logic_vector(31 downto 0);
    signal s_RAM                : std_logic_vector(31 downto 0);

    constant CLK_PERIOD : time := 100 ns;

begin

    -- 3. Instanciar o processador
    uut: rv32_monociclo
        port map(
            i_CLK                => s_CLK,
            i_RESET              => s_RESET,
            o_instruction_debug  => s_instruction_debug,
            o_RD                 => s_RD,
            O_RD1_debug          => s_RD1_debug,
            o_RD2_debug          => s_RD2_debug,
            o_Immediate          => s_Immediate,
            o_PC_debug           => s_PC_debug,
            o_ALU                => s_ALU,
            o_RAM                => s_RAM
        );

    -- 4. Processo de estímulo (clock manual + reset)
    process
    begin
        -- RESET SÍNCRONO
        report "Aplicando reset síncrono..." severity note;
        s_RESET <= '1';

        s_CLK <= '0';
        wait for 10 ns;
        s_CLK <= '1';
        wait for 10 ns;

        s_RESET <= '0';
	wait for 10 ns;
        report "Reset desativado, processador rodando..." severity note;

        -- CLOCK MANUAL, CICLO A CICLO
        report "Iniciando geracao de clock manual..." severity note;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;

s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;
	
s_CLK <= '0';
wait for 10 ns;
s_CLK <= '1';
wait for 10 ns;



        -- Fim da simulação
    end process;

end architecture testbench;
