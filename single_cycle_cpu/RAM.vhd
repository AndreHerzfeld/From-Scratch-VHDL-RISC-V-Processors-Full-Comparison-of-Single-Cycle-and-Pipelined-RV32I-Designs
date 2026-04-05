library IEEE;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity RAM is
    port(
        address : in  std_logic_vector(8 downto 0);
        clock   : in  std_logic;
        data    : in  std_logic_vector(31 downto 0);
        wren    : in  std_logic;
        q       : out std_logic_vector(31 downto 0)
    );
end entity RAM;

architecture Behavioral of RAM is

    -- 1. Define o tipo da memória: um array de 512 posições, cada uma com 32 bits.
    --    Usamos 'signal' em vez de 'constant' para que ela possa ser modificada (escrita).
    type T_RAM_ARRAY is array (0 to 511) of std_logic_vector(31 downto 0);
    signal s_MEMORY : T_RAM_ARRAY;

    -- Sinal interno para o endereço convertido para inteiro, para usar como índice do array.
    signal s_addr_int : natural range 0 to 511;

begin

    -- 2. Conversão de endereço: Converte o vetor de endereço para um inteiro.
    --    Esta operação é combinacional.
    s_addr_int <= to_integer(unsigned(address));

    -- 3. Lógica de LEITURA (Combinacional):
    --    A saída 'q' é diretamente conectada à posição de memória apontada pelo endereço.
    --    Não há clock envolvido aqui. Se 'address' mudar, 'q' mudará logo em seguida.
    --    É isso que garante a leitura no "mesmo ciclo".
    q <= s_MEMORY(s_addr_int);

    -- 4. Lógica de ESCRITA (Síncrona):
    --    A escrita na memória só deve acontecer em um momento controlado, que é a borda
    --    de subida do clock. Isso evita escritas acidentais enquanto os sinais se estabilizam.
    process(clock)
    begin
        if rising_edge(clock) then
            -- Se o sinal de habilitação de escrita (wren) estiver ativo...
            if (wren = '1') then
                -- ...escreve o dado de entrada 'data' na posição de memória apontada pelo endereço.
                s_MEMORY(s_addr_int) <= data;
            end if;
        end if;
    end process;

end Behavioral;