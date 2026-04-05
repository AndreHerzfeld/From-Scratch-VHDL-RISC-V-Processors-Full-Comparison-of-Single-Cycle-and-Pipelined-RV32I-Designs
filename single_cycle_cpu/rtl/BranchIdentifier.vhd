library IEEE;
use ieee.std_logic_1164.all;

entity BranchIdentifier is
    port(
        i_BRANCH       : in  std_logic;                      
        i_EQUAL        : in  std_logic;                      -- flag: rs1 == rs2
        i_SMALLER      : in  std_logic;                      -- flag: rs1 < rs2 (signed ou unsigned, conforme ALU)
        i_funct3       : in  std_logic_vector(2 downto 0);   -- campo funct3
        o_TAKE_BRANCH  : out std_logic                       -- saída: 1 se branch deve ser tomado
    );
end BranchIdentifier;

architecture arch_BranchIdentifier of BranchIdentifier is
begin
    o_TAKE_BRANCH <= '1' when
        -- BEQ (branch if equal)
        (i_BRANCH = '1' and i_EQUAL = '1' and i_funct3 = "000") or

        -- BNE (branch if not equal)
        (i_BRANCH = '1' and i_EQUAL = '0' and i_funct3 = "001") or

        -- BLT (branch if less than, signed)
        (i_BRANCH = '1' and i_SMALLER = '1' and i_funct3 = "100") or

        -- BGE (branch if greater or equal, signed)
        (i_BRANCH = '1' and i_SMALLER = '0' and i_funct3 = "101") or

        -- BLTU (branch if less than, unsigned)
        (i_BRANCH = '1' and i_SMALLER = '1' and i_funct3 = "110") or

        -- BGEU (branch if greater or equal, unsigned)
        (i_BRANCH = '1' and i_SMALLER = '0' and i_funct3 = "111")

    else
        '0'; -- padrão
end arch_BranchIdentifier;