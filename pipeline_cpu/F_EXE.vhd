library IEEE;

use ieee.std_logic_1164.all;

library work;
use work.mux_pkg.all;

entity F_EXE is
port(

-- Inputs

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
	i_IMM	 :  in std_logic_vector(31 downto 0); -- "B" Input for ALU.
	
	-- Signals for ALU Control
	i_FUNCT3 : in std_logic_vector(2 downto 0);
	i_FUNCT7 : in std_logic_vector(6 downto 0);
	
	-- Signals exclusive for Fowarding Unit
	i_RS1  :  in std_logic_vector(4 downto 0);
	i_RS2  :  in std_logic_vector(4 downto 0);
	
	-- RD
	i_RD  :  in std_logic_vector(4 downto 0); -- Register destination Address utilized in Write Back Stage and Fowarding Unit (Not for all instructions).
	
	-- Current PC address
	i_PC  :  in std_logic_vector(31 downto 0);

	
-- Outputs

	-- Control Lines for MEM.
	o_MemRead :  out std_logic;
	o_MemWrite:  out std_logic;
	
	-- Control lines for other barrier registers.
	o_WE        :  out std_logic;
	o_MemToReg  :  out std_logic;
	
	-- ALU Result and RD2 operating
	o_ALU_result  :  out std_logic_vector (31 downto 0); -- For RAM ADDR or MEM/WB Register.
	o_RD2         :  out std_logic_vector (31 downto 0); -- For RAM.
	
	-- RD
	o_RD  :  out std_logic_vector (4 downto 0); -- For Fowarding unit and WB stage
	
	-- PC + Offset Adder result
	o_PC_Offset_Result  : out std_logic_vector (31 downto 0);
	
	-- PC main mux selector output (native from branch taken unit)
	o_PC_mux_sel  :  out std_logic
	
	
	
);
end F_EXE;

architecture arch_exe of F_EXE is

component ALU is
port( i_A    :  in std_logic_vector (31 downto 0);
      i_B    :  in std_logic_vector (31 downto 0);
		i_shamt_i : in std_logic_vector (4 downto 0);
		i_SEL_shift  :  in std_logic_vector (1 downto 0); -- Selector.
      i_SEL_mux  :  in std_logic_vector (2 downto 0); -- Selector.
		i_SEL_shamt : in std_logic;
      i_CIN  :  in std_logic; -- ALU's CIN Input.
      o_S    :  out std_logic_vector (31 downto 0); -- Result.
      o_zero : out std_logic; -- Verify if the result is equal to zero.
      o_overflow : out std_logic; -- Detects if there's a signed overflow
		o_menor  :  out std_logic -- Verify if A is smaller than B
);
end component;

component ALU_Control is
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
end component;

-- Adder for PC + OFFSET operation
component Adder_32bit is 
port (i_A    :  in std_logic_vector (31 downto 0);
      i_B    :  in std_logic_vector (31 downto 0);
      i_CIN  :  in std_logic;
      o_S    :  out std_logic_vector (31 downto 0);
      o_overflow : out std_logic;
		o_zero : out std_logic
);
end component;

-- ALU Source MUX
component mux2x1_32bit is
port(
	 i_0   : in data_bus;
	 i_1   : in data_bus;
    i_SEL : in std_logic;
    o_S   : out data_bus
);
end component;

component BranchIdentifier is
    port(
        i_BRANCH       : in  std_logic;                      
        i_EQUAL        : in  std_logic;                      -- flag: rs1 == rs2
        i_SMALLER      : in  std_logic;                      -- flag: rs1 < rs2 (signed ou unsigned, conforme ALU)
        i_funct3       : in  std_logic_vector(2 downto 0);   -- campo funct3
        o_TAKE_BRANCH  : out std_logic                       -- saída: 1 se branch deve ser tomado
    );
end component;


-- ALU's MUX Output
signal w_out_mux_alu_scr  :  std_logic_vector (31 downto 0);

-- ALU Control Results
signal w_ALU_SEL  :  std_logic_vector (2 downto 0);
signal w_ALU_CIN, w_SHAMT_SEL :  std_logic;
signal w_SHIFT_SEL : std_logic_vector(1 downto 0);

-- Não utilizados
signal w_overflow  :  std_logic;
signal w_less      :  std_logic;
signal w_overflow2 :  std_logic;
signal w_NO        :  std_logic;

-- Sinais para o a unidade de branch (nativos da ALU)
signal w_zero, w_smaller  :  std_logic;

begin


-- ALU
		u_ALU  :  ALU
		port map(
				i_A  	        => i_RD1,
				i_B    	     => w_out_mux_alu_scr,
				i_shamt_i	  => i_RS2,
				i_SEL_shift   => w_SHIFT_SEL,
				i_SEL_mux  	  => w_ALU_SEL,
				i_SEL_shamt	  =>	w_SHAMT_SEL,
				i_CIN 	     => w_ALU_CIN,
				o_S   	     => o_ALU_Result,
				o_zero 	     => w_zero,
				o_overflow    => w_overflow, -- no
				o_menor       => w_smaller
);

-- ALU Controller	
		u_ALU_C: ALU_Control
		port map(
				i_ALU_Op   => i_ALU_OP,
				i_funct3   => i_FUNCT3,
				i_funct7   => i_FUNCT7,
				o_ALU_SEL  => w_ALU_SEL,
				o_ALU_CIN  => w_ALU_CIN,
				o_SHIFT_SEL => w_SHIFT_SEL,
				o_SHAMT_SEL => w_SHAMT_SEL
);

-- PC Adder
		u_pc_adder: Adder_32bit
		port map(
				i_A 		  => i_PC,
				i_B 		  => i_IMM,
				i_CIN 	  => '0',
				o_S   	  => o_PC_Offset_Result,
				o_overflow => w_overflow2, -- no
				o_zero     => w_NO -- no
);

-- MUX for ALU "B" Input choise
		u_mux_alu_source : mux2x1_32bit
		port map(
				i_0 => i_RD2,
				i_1 => i_IMM,
				i_SEL => i_ALU_Scr,
				o_S   => w_out_mux_alu_scr
);

-- Branch Identifier Unit
		u_branch  :  BranchIdentifier
		port map(
				 i_BRANCH      => i_BRANCH,
				 i_EQUAL       => w_zero,
				 i_SMALLER     => w_smaller,
				 i_funct3      => i_FUNCT3,
				 o_TAKE_BRANCH => o_PC_mux_sel
);
				 
--------------------------------
-- EXE Outputs
--------------------------------

	-- Control lines
	o_MemRead <= i_MemRead;
	o_MemWrite <= i_MemWrite;
	o_WE <= i_WE;
	o_MemToReg <= i_MemToReg;
	
	-- RAM WR input
	o_RD2 <= i_RD2;
	
	-- Fowarding unit input
	o_RD  <= i_RD;




end arch_exe;