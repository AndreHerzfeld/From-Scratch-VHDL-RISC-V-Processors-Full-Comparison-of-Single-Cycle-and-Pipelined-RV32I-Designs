library IEEE;

use ieee.std_logic_1164.all;

entity rv32_pipeline is
port(

----------
-- Inputs
----------
		
	i_CLK  :  in std_logic;
	i_RESET:  in std_logic;
	
----------
-- Outputs
----------

	o_PC_IF  	:  out std_logic_vector (31 downto 0);
	o_RD2    	:  out std_logic_vector (31 downto 0);
	o_ALU_Res	:  out std_logic_vector (31 downto 0);
	o_RAM_Output:  out std_logic_vector (31 downto 0);
	o_CICLOS	   :  out std_logic_vector (7 downto 0)
);
end rv32_pipeline;

architecture arch_pipeline of rv32_pipeline is

component F_IF is
port(
   i_RESET		   :  in std_logic;
	i_CLK 		   :  in std_logic;
	i_PC_OFFSET    :  in std_logic_vector (31 downto 0); -- PC + Offset, native from MEM stage.
	i_PC_OFFSET2   :  in std_logic_vector (31 downto 0); -- PC + Offset, native from Decode stage.
	i_PC_MUX_SEL   :  in std_logic; -- PC Mux selector, native from MEM stage.
	i_PC_MUX2_SEL  :  in std_logic; -- PC Mux2 selector, native from ID stage.
	o_INSTRUCTION  :  out std_logic_vector (31 downto 0); -- Goes to ID
	o_PC 				:  out std_logic_vector (31 downto 0) -- Goes to ID
);
end component;

component B_IFID is
port(
	i_INSTRUCTION  :  in std_logic_vector(31 downto 0);
	i_ADDRPC  		:  in std_logic_vector(31 downto 0);
	i_CLK	  			:  in std_logic;
	i_RESET			:  in std_logic;
	o_INSTRUCTION  :  out std_logic_vector(31 downto 0);
	o_ADDRPC  		:  out std_logic_vector(31 downto 0)
);
end component;

component F_DECODE is
port(
		  i_RESET 		: in std_logic;
        i_CLK        : in std_logic;
        i_INSTRUCTION: in std_logic_vector(31 downto 0);
		  i_PC 			: in std_logic_vector (31 downto 0);  -- Comes from IF/ID Register for be utilized later in EXE.
        i_WE         : in std_logic; 						     -- Habilita escrita no banco de registradores
        i_RD         : in std_logic_vector  (4 downto 0);   -- Endereço do registrador de destino
        i_WD         : in std_logic_vector  (31 downto 0);  -- Dado a ser escrito
		  o_PC		   : out std_logic_vector (31 downto 0);  -- Goes to EXE to do (pc + offset).
        o_RD1        : out std_logic_vector (31 downto 0);  -- Dado lido do registrador 1
        o_RD2        : out std_logic_vector (31 downto 0);  -- Dado lido do registrador 2
        o_imm        : out std_logic_vector (31 downto 0);  -- Imediato com sinal estendido
        o_RD         : out std_logic_vector (4 downto 0);   -- Endereço do registrador de destino (rd)
        o_RS1        : out std_logic_vector (4 downto 0);   -- Endereço do registrador fonte 1 (rs1)
        o_RS2        : out std_logic_vector (4 downto 0);   -- Endereço do registrador fonte 2 (rs2)
		  o_FUNCT3     : out std_logic_vector (2 downto 0);   -- Funct3 of the instruction (14:12)
		  o_FUNCT7     : out std_logic_vector (6 downto 0);   -- Funct7 of the instruction (31:25)
        o_branch     : out std_logic;
        o_memread    : out std_logic;
        o_memtoreg   : out std_logic;
        o_alu_op     : out std_logic_vector(1 downto 0);
        o_memWrite   : out std_logic;
        o_aluscr     : out std_logic;
        o_we         : out std_logic;
		  o_MUX2_PC_SEL  :  out std_logic;
		  o_PC2			  :  out std_logic_vector (31 downto 0)
);
end component;

component B_IDEX is
port(
	i_ALU_OP  :  in std_logic_vector (1 downto 0); -- Helps to select the operation.
	i_ALU_Scr :  in std_logic; -- Decides if "B" input of ALU will be either "i_imm" or "i_RD2".
	i_BRANCH  :  in std_logic;
	i_MemRead :  in std_logic;
	i_MemWrite:  in std_logic;
	i_WE      :  in std_logic;
	i_MemToReg:  in std_logic;
	i_RD1	 	 :  in std_logic_vector(31 downto 0); -- "A" Input for ALU.
	i_RD2	 	 :  in std_logic_vector(31 downto 0); -- "B" Input for ALU.
	i_IMM		 :  in std_logic_vector(31 downto 0);  -- "B" Input for ALU.
	i_FUNCT3  :  in std_logic_vector(2 downto 0);
	i_FUNCT7  :  in std_logic_vector(6 downto 0);
	i_RS1  	 :  in std_logic_vector(4 downto 0);
	i_RS2  	 :  in std_logic_vector(4 downto 0);
	i_RD  	 :  in std_logic_vector(4 downto 0); -- Register destination Address utilized in Write Back Stage and Fowarding Unit (Not for all instructions).
	i_CLK		 :  in std_logic;
	i_RESET	 :  in std_logic;
	i_PC  	 :  in std_logic_vector(31 downto 0);
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
end component;

component F_EXE is
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
-- Output
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
end component;

component B_EXMEM is
port( 
	i_MemRead      :  in  std_logic;
	i_MemWrite		:  in  std_logic;
	i_WE  	      :  in std_logic;
	i_MemToReg     :  in std_logic;
	i_ALU_Result   :  in std_logic_vector (31 downto 0);
	i_RD2          :  in std_logic_vector (31 downto 0);
	i_RD           :  in std_logic_vector (4 downto 0); -- Utilized in either MEM and WB stages
	i_CLK  		   :  in std_logic;
	i_RESET			:  in std_logic;
	o_MemRead      :  out std_logic;
	o_MemWrite     :  out std_logic;
	o_WE  	      :  out std_logic;
	o_MemToReg     :  out std_logic;
	o_ALU_Result   :  out std_logic_vector (31 downto 0);
	o_RD2  		   :  out std_logic_vector (31 downto 0);
	o_RD  		   :  out std_logic_vector (4 downto 0) -- Utilized in either MEM and WB stages
);
end component;

component F_MEM is
port(
	i_MemRead     :  in  std_logic;
	i_MemWrite    :  in  std_logic;
	i_WE  	     :  in std_logic;
	i_MemToReg    :  in std_logic;
	i_ALU_Result  :  in std_logic_vector (31 downto 0);
	i_RD2         :  in std_logic_vector (31 downto 0);
	i_RD  		  :  in std_logic_vector (4 downto 0); -- Utilized in either MEM and WB stages
	i_CLK  		  :  in std_logic; -- RAM's clock
	o_WE  	     :  out std_logic;
	o_MemToReg    :  out std_logic;
	o_ALU_Result  :  out std_logic_vector (31 downto 0);
	o_MEM    	  :  out std_logic_vector (31 downto 0);
	o_RD  		  :  out std_logic_vector (4 downto 0)
);
end component;

component B_MEMWB is
port(
	i_WE  		  :  in std_logic;
	i_MemToReg    :  in std_logic;
	i_MEM  		  :  in std_logic_vector (31 downto 0);
	i_ALU_Result  :  in std_logic_vector (31 downto 0);
	i_RD  		  :  in std_logic_vector (4 downto 0);
	i_CLK 		  :  in std_logic;
	i_RESET		  :  in std_logic;
	o_WE  		  :  out std_logic;
	o_MemToReg    :  out std_logic;
	o_MEM  		  :  out std_logic_vector (31 downto 0);
	o_ALU_Result  :  out std_logic_vector (31 downto 0);
	o_RD  		  :  out std_logic_vector (4 downto 0)
 );
end component;

component F_WB is
port(
	i_WE 			  :  in std_logic;
	i_MemToReg    :  in std_logic;
	i_MEM  		  :  in std_logic_vector (31 downto 0);
	i_ALU_Result  :  in std_logic_vector (31 downto 0);
	i_RD  		  :  in std_logic_vector (4 downto 0);
	o_MUX_WB      :  out std_logic_vector (31 downto 0);
	o_RD 	        :  out std_logic_vector (4 downto 0);
	o_WE		     :  out std_logic
);
end component;

component Cyclecounter_32bit is
port (
    i_RST       : in std_logic;
    i_CLK       : in std_logic;
    o_S         : out std_logic_vector (7 downto 0)
);
end component;


-- Internal wires
	-- IF
	
		-- Full instruction native from IF.
		signal w_instruction_if  :  std_logic_vector (31 downto 0);

		-- PC Address native from IF.
		signal w_pc_if  :  std_logic_vector (31 downto 0);

	-- IF/ID

		-- IF/ID instruction output.
		signal w_instruction_ifid  :  std_logic_vector (31 downto 0);
		
		-- IF/ID pc address
		signal w_pc_ifid  :  std_logic_vector (31 downto 0);
		
	-- ID
		
		-- RD1 and RD2 outputs, native from ID.
		signal w_rd1_id, w_rd2_id  :  std_logic_vector (31 downto 0);
	
		-- Imm output, native from ID.
		signal w_imm_id  :  std_logic_vector (31 downto 0);
	
		-- PC Address
		signal w_pc_id  :  std_logic_vector (31 downto 0);
		
		-- PC + Offset(jal)
		
		signal w_pc_offset2_id  :  std_logic_vector (31 downto 0);
		
		signal w_pc_mux2_sel_id  :  std_logic;
		
		-- RD native from ID.
		signal w_rd_id  :  std_logic_vector (4 downto 0);
		
		-- RS1 and RS2 addresses
		signal w_rs1_id, w_rs2_id  :  std_logic_vector (4 downto 0);
		
		-- Funct3
		signal w_funct3_id  :  std_logic_vector (2 downto 0);
		
		-- Funct7
		signal w_funct7_id  :  std_logic_vector (6 downto 0);
		
		-- Control lines native from ID stage.
		signal w_branch_id  :  std_logic;
		
		signal w_memread_id  :  std_logic;
		
		signal w_memtoreg_id  :  std_logic;
		
		signal w_alu_op_id    :  std_logic_vector (1 downto 0);
		
		signal w_memwrite_id  :  std_logic;
		
		signal w_aluscr_id  :  std_logic;
		
		signal w_we_id  :  std_logic;
		
		signal w_j_id  :  std_logic;
		
	-- ID/EX
		
	-- Control lines for three last pipeline registers
	
		--  ALU Operation
		signal w_alu_op_idex  :  std_logic_vector (1 downto 0);
		
		-- ALU Source
		signal w_aluscr_idex  :  std_logic;
			
		-- BRANCH Singal
		signal w_branch_idex  :  std_logic;
		
		-- Mem Read
		signal w_memread_idex  :  std_logic;
		
		-- Mem Write
		signal w_memwrite_idex  :  std_logic;
		
		-- Write enable
		signal w_we_idex  :  std_logic;
		
		-- Mem To Reg
		signal w_memtoreg_idex  :  std_logic;
		
	-- Other signals 
		
		-- RD1 and RD2 for ALU
		signal w_rd1_idex, w_rd2_idex  :  std_logic_vector (31 downto 0);
		
		-- Immediate
		signal w_imm_idex  :  std_logic_vector (31 downto 0);
		
		-- Funct 3
		signal w_funct3_idex  :  std_logic_vector (2 downto 0);
		
		-- Funct 7
		signal w_funct7_idex  :  std_logic_vector (6 downto 0);
		
		-- RS1 and RS2
		signal w_rs1_idex, w_rs2_idex  :  std_logic_vector (4 downto 0);
		
		-- RD
		signal w_rd_idex  :  std_logic_vector (4 downto 0);
		
		-- PC
		signal w_pc_idex  :  std_logic_vector (31 downto 0);
		
		
	-- EXE

		-- Control lines for MEM and WB stages from EXE stage.
		signal w_memread_ex, w_memwrite_ex, w_we_ex, w_memtoreg_ex  :  std_logic;
		
		-- ALU Result from EXE stage.
		signal w_alu_result_ex  :  std_logic_vector (31 downto 0);
		
		-- RD2
		signal w_rd2_ex  :  std_logic_vector (31 downto 0);
		
		-- RD
		signal w_rd_ex  :  std_logic_vector (4 downto 0);
		
		-- PC + Offset result
		signal w_pc_offset_result_ex  :  std_logic_vector (31 downto 0);
		
		-- PC's main mux selector from EXE stage
		signal w_PC_mux_sel_ex  :  std_logic;
		
		
	-- EX/MEM
		
		-- Control lines for MEM
		signal w_memread_exmem, w_memwrite_exmem  :  std_logic;
		
		-- Control lines for WB
		signal w_we_exmem, w_memtoreg_exmem  :  std_logic;
		
		-- Other signals
		signal w_alu_result_exmem, w_rd2_exmem  :  std_logic_vector (31 downto 0);
		signal w_RD_exmem  :  std_logic_vector (4 downto 0);
		
		
	-- MEM


			-- Control lines for WB stage
		signal w_we_mem, w_memtoreg_mem  :  std_logic;
		
		signal w_alu_result_mem, w_mem_result_mem  :  std_logic_vector (31 downto 0);
		
		signal w_RD_mem  :  std_logic_vector (4 downto 0);
		
	-- MEM/WB
	
		
		-- Control lines for WB stage
		signal w_we_memwb, w_memtoreg_memwb  :  std_logic;
		
		-- ALU and Memory data
		signal w_alu_result_memwb, w_mem_result_memwb  :  std_logic_vector (31 downto 0);
		
		-- Register destination address for the register file (native from the instruction)
		signal w_RD_memwb  :  std_logic_vector (4 downto 0);
		
	-- WB
		
		-- Write enable native from WB.
		signal w_we_wb  :  std_logic;
		
		-- Write data for Register file unit, native from WB.
		signal w_wd_wb  :  std_logic_vector (31 downto 0);
		
		-- RD native from WB.
		signal w_rd_wb  :  std_logic_vector (4 downto 0);
		
begin

		u_IF  :  F_IF -- Instruction Fetch Stage.
		port map(
				 i_RESET=> i_RESET,
				 i_CLK => i_CLK,
				 i_PC_OFFSET => w_pc_offset_result_ex,
				 i_PC_OFFSET2=> w_pc_offset2_id, --
				 i_PC_MUX_SEL => w_PC_mux_sel_ex,
				 i_PC_MUX2_SEL => w_pc_mux2_sel_id, --
				 o_INSTRUCTION => w_instruction_if,
				 o_PC => w_pc_if
);

		u_IF_ID: B_IFID -- IF/ID Register.
		port map(
				 i_INSTRUCTION => w_instruction_if,
				 i_ADDRPC => w_pc_if,
				 i_CLK => i_CLK,
				 i_RESET => w_pc_mux2_sel_id,
				 o_INSTRUCTION => w_instruction_ifid,
				 o_ADDRPC 	   => w_pc_ifid
);

		u_ID  :  F_DECODE -- Instruction Decode Stage.
		port map(
				 i_RESET=> i_RESET,
				 i_CLK => i_CLK,
				 i_INSTRUCTION => w_instruction_ifid,
				 i_PC				=> w_pc_ifid,
				 i_WE				=> w_we_wb,
				 i_RD 		   => w_rd_wb,
				 i_WD 		   => w_wd_wb,
				 o_PC				=> w_pc_id,
				 o_RD1			=> w_rd1_id,
				 o_RD2		   => w_rd2_id,
				 o_imm 		   => w_imm_id,
				 o_RD 			=> w_rd_id,
				 o_RS1		   => w_rs1_id,
				 o_RS2 			=> w_rs2_id,
				 o_FUNCT3 		=> w_funct3_id,
				 o_FUNCT7 		=> w_funct7_id,
				 o_branch 		=> w_branch_id,
				 o_memread 		=> w_memread_id,
				 o_memtoreg 	=> w_memtoreg_id,
				 o_alu_op 	   => w_alu_op_id,
				 o_memWrite    => w_memwrite_id,
				 o_aluscr  	   => w_aluscr_id,
				 o_we 		   => w_we_id,
				 o_MUX2_PC_SEL => w_pc_mux2_sel_id,
				 o_PC2			=> w_pc_offset2_id
);		

		u_ID_EX  :  B_IDEX
		port map(
				 i_ALU_OP   => w_alu_op_id,
				 i_ALU_Scr  => w_aluscr_id,
				 i_BRANCH 	=> w_branch_id,
				 i_MemRead 	=> w_memread_id,
				 i_MemWrite => w_memwrite_id,
				 i_WE	      => w_we_id,
				 i_MemToReg => w_memtoreg_id,
				 i_RD1		=> w_rd1_id,
				 i_RD2 		=> w_rd2_id,
				 i_IMM 		=> w_imm_id,
				 i_FUNCT3 	=> w_funct3_id,
				 i_FUNCT7	=> w_funct7_id,
				 i_RS1 		=> w_rs1_id,
				 i_RS2		=> w_rs2_id,
				 i_RD		 	=> w_rd_id,
				 i_CLK 		=> i_CLK,
				 i_RESET => i_RESET,
				 i_PC		   => w_pc_id,
				 o_ALU_OP 	=> w_alu_op_idex,
				 o_ALU_Scr  => w_aluscr_idex,
				 o_BRANCH 	=> w_branch_idex,
				 o_MemRead 	=> w_memread_idex,
				 o_MemWrite	=> w_memwrite_idex,
				 o_WE 		=> w_we_idex,
				 o_MemToReg => w_memtoreg_idex,
				 o_RD1 		=> w_rd1_idex,
				 o_RD2 		=> w_rd2_idex,
				 o_IMM		=> w_imm_idex,
				 o_FUNCT3 	=> w_funct3_idex,
				 o_FUNCT7 	=> w_funct7_idex,
				 o_RS1 		=> w_rs1_idex,
				 o_RS2		=> w_rs2_idex,
				 o_RD		   => w_rd_idex,
				 o_PC	 		=> w_pc_idex
);

			
		u_EXE  :  F_EXE
		port map(
				 i_ALU_OP   => w_alu_op_idex,
				 i_ALU_Scr  => w_aluscr_idex,
				 i_BRANCH 	=> w_branch_idex,
				 i_MemRead 	=> w_memread_idex,
				 i_MemWrite	=> w_memwrite_idex,
				 i_WE 		=> w_we_idex,
				 i_MemToReg => w_memtoreg_idex,
				 i_RD1 		=> w_rd1_idex,
				 i_RD2 		=> w_rd2_idex,
				 i_IMM		=> w_imm_idex,
				 i_FUNCT3 	=> w_funct3_idex,
				 i_FUNCT7 	=> w_funct7_idex,
				 i_RS1 		=> w_rs1_idex,
				 i_RS2		=> w_rs2_idex,
				 i_RD		   => w_rd_idex,
				 i_PC	 		=> w_pc_idex,
				 o_MemRead  => w_memread_ex,
				 o_MemWrite => w_memwrite_ex,
				 o_WE	 		=> w_we_ex,
				 o_MemToReg => w_memtoreg_ex,
				 o_ALU_Result => w_alu_result_ex,
				 o_RD2		  => w_rd2_ex,
				 o_RD			  => w_rd_ex,
				 o_PC_Offset_Result => w_pc_offset_result_ex,
				 o_PC_mux_sel 		  => w_PC_mux_sel_ex
);

		
		u_EXMEM  :  B_EXMEM
		port map(
				 i_MemRead    => w_memread_ex,
				 i_MemWrite   => w_memwrite_ex,
				 i_WE	 		  => w_we_ex,
				 i_MemToReg   => w_memtoreg_ex,
				 i_ALU_Result => w_alu_result_ex,
				 i_RD2		  => w_rd2_ex,
				 i_RD			  => w_rd_ex,
				 i_CLK		  => i_CLK,
				 i_RESET      => i_RESET,
				 o_MemRead    => w_memread_exmem,
				 o_MemWrite   => w_memwrite_exmem,
				 o_WE	 		  => w_we_exmem,
				 o_MemToReg   => w_memtoreg_exmem,
				 o_ALU_Result => w_alu_result_exmem,
				 O_RD2  		  => w_rd2_exmem,
				 o_RD			  => w_RD_exmem
);

		
		u_MEM  :  F_MEM
		port map(
				 i_MemRead    => w_memread_exmem,
				 i_MemWrite   => w_memwrite_exmem,
				 i_WE	 		  => w_we_exmem,
				 i_MemToReg   => w_memtoreg_exmem,
				 i_ALU_Result => w_alu_result_exmem,
				 i_RD2  		  => w_rd2_exmem,
				 i_RD			  => w_RD_exmem,
				 i_CLK 		  => i_CLK,
				 o_WE			  => w_we_mem,
				 o_MemToReg   => w_memtoreg_mem,
				 o_ALU_Result => w_alu_result_mem,
				 o_MEM 		  => w_mem_result_mem,
				 o_RD 		  => w_RD_mem
);

		u_MEMWB  :  B_MEMWB
	   port map(
				 i_WE			  => w_we_mem,
				 i_MemToReg   => w_memtoreg_mem,
				 i_MEM 		  => w_mem_result_mem,
				 i_ALU_Result => w_alu_result_mem,
				 i_RD 		  => w_RD_mem,
				 i_CLK 		  => i_CLK,
				 i_RESET => i_RESET,
				 o_WE			  => w_we_memwb,
				 o_MemToReg   => w_memtoreg_memwb,
				 o_MEM 		  => w_mem_result_memwb,
				 o_ALU_Result => w_alu_result_memwb,
				 o_RD 		  => w_RD_memwb
);


		u_WB  :  F_WB
		port map(
				 i_WE			  => w_we_memwb,
				 i_MemToReg   => w_memtoreg_memwb,
				 i_MEM 		  => w_mem_result_memwb,
				 i_ALU_Result => w_alu_result_memwb,
				 i_RD 		  => w_RD_memwb, 
				 o_MUX_WB	  => w_wd_wb,
				 o_RD		     => w_rd_wb,
				 o_WE		     => w_we_wb
);


		u_contador_ciclos  :  Cyclecounter_32bit
		port map(
			    i_RST => i_RESET,
				 i_CLK => i_CLK,
				 o_S   => o_CICLOS
);
		
o_RD2 <= w_rd2_id;
o_Alu_Res <= w_alu_result_ex;
o_PC_IF <= w_pc_if;
o_RAM_Output <= w_mem_result_mem;

end arch_pipeline;						 