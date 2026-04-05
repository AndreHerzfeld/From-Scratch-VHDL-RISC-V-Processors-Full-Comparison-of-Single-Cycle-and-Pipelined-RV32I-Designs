library IEEE;
use ieee.std_logic_1164.all;

entity B_EXMEM is
port( 
----------
-- Inputs
----------
	-- Control line for MEM
	i_MemRead  : in std_logic;
	i_MemWrite : in std_logic;
	
	-- Control lines for WB
	i_WE       : in std_logic;
	i_MemToReg : in std_logic;
	
	-- RAM Address
	i_ALU_Result : in std_logic_vector (31 downto 0);
	
	-- Ram Data in
	i_RD2 : in std_logic_vector (31 downto 0);
	
	-- RD
	i_RD : in std_logic_vector (4 downto 0); -- Utilized in either MEM and WB stages
	
	-- CLK + Reset
	i_CLK   : in std_logic;
	i_RESET : in std_logic;
	
----------
-- Outputs
----------
	o_MemRead    : out std_logic;
	o_MemWrite   : out std_logic;
	o_WE         : out std_logic;
	o_MemToReg   : out std_logic;
	o_ALU_Result : out std_logic_vector (31 downto 0);
	o_RD2        : out std_logic_vector (31 downto 0);
	o_RD         : out std_logic_vector (4 downto 0)
);
end B_EXMEM;

architecture arch_1 of B_EXMEM is
begin
    process(i_CLK)
    begin
        if rising_edge(i_CLK) then
            if (i_RESET = '1') then
                o_MemRead    <= '0';
                o_MemWrite   <= '0';
                o_WE         <= '0';
                o_MemToReg   <= '0';
                o_ALU_Result <= (others => '0');
                o_RD2        <= (others => '0');
                o_RD         <= (others => '0');
            else
                o_MemRead    <= i_MemRead;
                o_MemWrite   <= i_MemWrite;
                o_WE         <= i_WE;
                o_MemToReg   <= i_MemToReg;
                o_ALU_Result <= i_ALU_Result;
                o_RD2        <= i_RD2;
                o_RD         <= i_RD;
            end if;
        end if;
    end process;
end arch_1;
