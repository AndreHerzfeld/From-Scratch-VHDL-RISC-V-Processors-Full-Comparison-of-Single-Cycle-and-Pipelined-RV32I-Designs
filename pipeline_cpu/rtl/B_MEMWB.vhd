library IEEE;
use IEEE.std_logic_1164.all;

entity B_MEMWB is
port(
----------
-- Inputs
----------

-- Control lines for WB
	i_WE       : in std_logic;
	i_MemToReg : in std_logic;
	 
-- RAM Data output
	i_MEM  : in std_logic_vector (31 downto 0);
	 
-- ALU Result
	i_ALU_Result : in std_logic_vector (31 downto 0);
	
-- RD 
	i_RD  : in std_logic_vector (4 downto 0);

-- CLK + Reset
	i_CLK   : in std_logic;
	i_RESET : in std_logic;
	
----------
-- Outputs
----------
	o_WE        : out std_logic;
	o_MemToReg  : out std_logic;
	o_MEM       : out std_logic_vector (31 downto 0);
	o_ALU_Result: out std_logic_vector (31 downto 0);
	o_RD        : out std_logic_vector (4 downto 0) 
);
end B_MEMWB;

architecture arch of B_MEMWB is
begin
    process(i_CLK)
    begin
        if rising_edge(i_CLK) then
            if (i_RESET = '1') then
                o_WE        <= '0';
                o_MemToReg  <= '0';
                o_MEM       <= (others => '0');
                o_ALU_Result<= (others => '0');
                o_RD        <= (others => '0');
            else
                o_WE        <= i_WE;
                o_MemToReg  <= i_MemToReg;
                o_MEM       <= i_MEM;
                o_ALU_Result<= i_ALU_Result;
                o_RD        <= i_RD;
            end if;
        end if;
    end process;
end arch;
