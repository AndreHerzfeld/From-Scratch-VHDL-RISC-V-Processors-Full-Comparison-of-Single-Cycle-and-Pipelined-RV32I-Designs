library IEEE;
use IEEE.std_logic_1164.all;

entity B_IFID is
port(
    ----------
    -- Inputs
    ----------
    i_INSTRUCTION  : in  std_logic_vector(31 downto 0);
    i_ADDRPC       : in  std_logic_vector(31 downto 0);
    i_CLK          : in  std_logic;
    i_RESET        : in  std_logic;

    ----------
    -- Outputs
    ----------
    o_INSTRUCTION  : out std_logic_vector(31 downto 0);
    o_ADDRPC       : out std_logic_vector(31 downto 0)
);
end B_IFID;

architecture arch of B_IFID is
begin
    process(i_CLK)
    begin
        if rising_edge(i_CLK) then
            if (i_RESET = '1') then
                o_INSTRUCTION <= (others => '0');
                o_ADDRPC      <= (others => '0');
            else
                o_INSTRUCTION <= i_INSTRUCTION;
                o_ADDRPC      <= i_ADDRPC;
            end if;
        end if;
    end process;
end arch;
