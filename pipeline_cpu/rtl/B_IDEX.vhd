library IEEE;
use IEEE.std_logic_1164.all;

entity B_IDEX is
port(
-- Control lines

	-- Control Lines for EXE.
	i_ALU_OP  :  in std_logic_vector (1 downto 0); -- Helps to select the operation.
	i_ALU_Scr :  in std_logic; -- Decides if "B" input of ALU will be either "i_imm" or "i_RD2".
	
	-- Control Lines for other barrier registers (EX/MEM and MEM/WB).
	i_BRANCH  :  in std_logic;
	i_MemRead :  in std_logic;
	i_MemWrite:  in std_logic;
	i_WE      :  in std_logic;
	i_MemToReg:  in std_logic;

-- Signals for ALU
	i_RD1	 :  in std_logic_vector(31 downto 0); -- "A" Input for ALU.
	i_RD2	 :  in std_logic_vector(31 downto 0); -- "B" Input for ALU.
	i_IMM	 :  in std_logic_vector(31 downto 0); -- Immediate value
	
-- Signals for ALU Control
	i_FUNCT3 : in std_logic_vector(2 downto 0);
	i_FUNCT7 : in std_logic_vector(6 downto 0);
	
-- Signals exclusive for Fowarding Unit
	i_RS1  :  in std_logic_vector(4 downto 0);
	i_RS2  :  in std_logic_vector(4 downto 0);
	
-- RD
	i_RD  :  in std_logic_vector(4 downto 0); -- Register destination Address
	
-- ID/EX Clk + Reset
	i_CLK	 : in std_logic;
	i_RESET : in std_logic;
	
-- Current PC address
	i_PC  :  in std_logic_vector(31 downto 0);
	
-- ID/EX Outputs
	o_ALU_OP  :  out std_logic_vector (1 downto 0);
	o_ALU_Scr :  out std_logic; 
	o_BRANCH  :  out std_logic;
	o_MemRead :  out std_logic;
	o_MemWrite:  out std_logic;
	o_WE      :  out std_logic;
	o_MemToReg:  out std_logic;
	o_RD1	    :  out std_logic_vector(31 downto 0);
	o_RD2	    :  out std_logic_vector(31 downto 0); 
	o_IMM	  	 :  out std_logic_vector(31 downto 0);  
	o_FUNCT3  :  out std_logic_vector(2 downto 0);
	o_FUNCT7  :  out std_logic_vector(6 downto 0);
	o_RS1  	 :  out std_logic_vector(4 downto 0);
	o_RS2  	 :  out std_logic_vector(4 downto 0);
	o_RD  	 :  out std_logic_vector(4 downto 0); 
	o_PC  	 :  out std_logic_vector(31 downto 0)
);
end B_IDEX;

architecture arch of B_IDEX is
begin
    process(i_CLK)
    begin
        if rising_edge(i_CLK) then
            if (i_RESET = '1') then
                o_ALU_OP   <= (others => '0');
                o_ALU_Scr  <= '0';
                o_BRANCH   <= '0';
                o_MemRead  <= '0';
                o_MemWrite <= '0';
                o_WE       <= '0';
                o_MemToReg <= '0';
                o_RD1      <= (others => '0');
                o_RD2      <= (others => '0');
                o_IMM      <= (others => '0');
                o_FUNCT3   <= (others => '0');
                o_FUNCT7   <= (others => '0');
                o_RS1      <= (others => '0');
                o_RS2      <= (others => '0');
                o_RD       <= (others => '0');
                o_PC       <= (others => '0');
            else
                o_ALU_OP   <= i_ALU_OP;
                o_ALU_Scr  <= i_ALU_Scr;
                o_BRANCH   <= i_BRANCH;
                o_MemRead  <= i_MemRead;
                o_MemWrite <= i_MemWrite;
                o_WE       <= i_WE;
                o_MemToReg <= i_MemToReg;
                o_RD1      <= i_RD1;
                o_RD2      <= i_RD2;
                o_IMM      <= i_IMM;
                o_FUNCT3   <= i_FUNCT3;
                o_FUNCT7   <= i_FUNCT7;
                o_RS1      <= i_RS1;
                o_RS2      <= i_RS2;
                o_RD       <= i_RD;
                o_PC       <= i_PC;
            end if;
        end if;
    end process;
end arch;
