library IEEE;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mux_pkg.all;



entity rv32_monociclo is
port (	
			-- Inputs
			i_CLK  :  in std_logic; -- Clock
			i_RESET  :  in std_logic; -- Reset for PC register
			
			-- Outputs
			o_instruction_debug  : out std_logic_vector (31 downto 0); -- Current instruction
			o_RD                 :  out std_logic_vector (4 downto 0);  -- Register to be written (Register Write)
			O_RD1_debug          :  out std_logic_vector (31 downto 0); -- register 1 readen from register file
			o_RD2_debug          :  out std_logic_vector (31 downto 0); -- register 2 readen from register file
			o_Immediate          :  out std_logic_vector (31 downto 0); -- Current Immediate value
			o_PC_debug           :  out std_logic_vector (31 downto 0); -- Current pc value
			o_ALU                :  out std_logic_vector (31 downto 0); -- ALU's result output
			o_RAM						:  out std_logic_vector (31 downto 0);  -- RAM output
			o_CICLOS				   :  out std_logic_vector (7 downto 0)  -- Quantidade de ciclos de clock total
);
end rv32_monociclo;


architecture arch_rv32 of rv32_monociclo is

-- Components

component Cyclecounter_32bit is
port (
    i_RST       : in std_logic;
    i_CLK       : in std_logic;
    o_S         : out std_logic_vector (7 downto 0)
);
end component;


component WriteData_Decision is
port(
		i_AUIPC  :  in std_logic;
		i_LUI	   :  in std_logic;
		i_JAL	   :  in std_logic;
		o_S		:  out std_logic_vector (1 downto 0)
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


component RegisterFile is
port ( i_RESET:  in std_logic; -- Reset
		 i_CLK  :  in std_logic; -- Clock.
	    i_WE   :  in std_logic; -- Write enable.
       i_WD   :  in std_logic_vector (31 downto 0); -- Write data.
       i_RS1  :  in std_logic_vector (4 downto 0); -- Reg 1.
       i_RS2  :  in std_logic_vector (4 downto 0); -- Reg 2.
       i_RD   :  in std_logic_vector (4 downto 0); -- Register write signal.
       o_RD1  :  out std_logic_vector (31 downto 0); -- Read data 1.
       o_RD2  :  out std_logic_vector (31 downto 0)  -- Read data 2.
		 );
end component;

component Rom_32bit is -- Instruction memory
port(
		i_ADDR : in std_logic_vector(31 downto 0); -- Current PC adress
		o_INST : out std_logic_vector(31 downto 0) -- Instruction
	);
end component;

component ALU is
port( i_A    :  in std_logic_vector (31 downto 0);
      i_B    :  in std_logic_vector (31 downto 0);
		i_shamt_i : in std_logic_vector (4 downto 0); -- Shift field for immediate shift instructions (SLLI, SRLI and SRAI)
		i_SEL_shift  :  in std_logic_vector (1 downto 0); -- Selector.
      i_SEL_mux  :  in std_logic_vector (2 downto 0); -- Selector.
		i_SEL_shamt : in std_logic; -- Seleciona se o shamt para a operação de shift será vindo do registrador rd2 ou do campo shamt da instrução
      i_CIN  :  in std_logic; -- ALU's CIN Input.
      o_S    :  out std_logic_vector (31 downto 0); -- Result.
      o_zero : out std_logic; -- Verify if the result is equal to zero.
      o_overflow : out std_logic; -- Detects if there's a signed overflow
		o_menor  :  out std_logic -- Verify if A is smaller than B
);
end component;

component RAM IS
	PORT
	(
		address		: IN STD_LOGIC_VECTOR (8 DOWNTO 0);
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
END component;

component Adder_32bit is -- Somadores do pc
port (i_A    :  in std_logic_vector (31 downto 0); -- Porta A
      i_B    :  in std_logic_vector (31 downto 0); -- Porta B
      i_CIN  :  in std_logic; -- Controle da operacao
      o_S    :  out std_logic_vector (31 downto 0); -- Saida do somador
      o_overflow : out std_logic; -- Sinal que indica overflow
		o_zero : out std_logic -- Sinal que indica se o resultado foi igual a '0' da subtracao entre A e B (nao utilizado nesse somador (remover))
);
end component;

component ImmediateGenerator is -- Immediate Generator unit.
port (
        i_Instruction   : in  std_logic_vector(31 downto 0); -- Full instruction
        i_SEL : in  std_logic_vector(2 downto 0); -- Signal native from main controler for select the proper concatenation
        o_S      : out std_logic_vector(31 downto 0) -- Immediate value properly formatted and sign-extended
    );
end component;

component MainController is
port( i_opcode      :  in std_logic_vector (6 downto 0);
	   o_branch      :  out std_logic;
      o_memtoreg    :  out std_logic;
      o_alu_op      :  out std_logic_vector (1 downto 0);
      o_memWrite    :  out std_logic;
      o_aluscr      :  out std_logic;
      o_we          :  out std_logic;
      o_imm         :  out std_logic_vector (2 downto 0); -- 000
		o_ifid_flush  :  out std_logic;
		o_lui 		  :  out std_logic;
		o_auipc       :  out std_logic;
		o_JALR_sel	  :  out std_logic
);
end component;

component ALU_Control is
    port(
        i_ALU_Op  : in  std_logic_vector(1 downto 0);
        i_funct3 : in  std_logic_vector(2 downto 0);
        i_funct7 : in  std_logic_vector(6 downto 0);
        o_ALU_SEL : out std_logic_vector(2 downto 0);
        o_ALU_CIN : out std_logic;
		  o_SHIFT_SEL : out std_logic_vector(1 downto 0);
		  o_SHAMT_SEL : out std_logic
    );
end component;

component mux2x1_32bit is
port(
    i_0   : in std_logic_vector(31 downto 0);
    i_1   : in std_logic_vector(31 downto 0);
    i_SEL : in std_logic;
    o_S   : out std_logic_vector(31 downto 0)
);
end component;

component mux4x1_32bit is
port (
		 i_data :  in data_bus_4x1; -- 4 arrays of 32 bits each
       i_SEL  :  in std_logic_vector (1 downto 0);
       o_S    :  out data_bus); -- 32 bit output
end component;

component register32_with_reset is
  port (
    i_RESET : in  std_logic;  -- clear/reset
    i_CLK   : in  std_logic;  -- clock
    i_ENA   : in  std_logic;  -- enable    
    i_D     : in  std_logic_vector(31 downto 0);  -- data input
    o_Q     : out std_logic_vector(31 downto 0)   -- data output
);
end component;



-- Program Counter
    signal w_out_pc        : std_logic_vector(31 downto 0);
    signal w_pc_4          : std_logic_vector(31 downto 0);
	 signal w_pc_4_2		   : std_logic_vector(31 downto 0);
    signal w_out_mux_pc    : std_logic_vector(31 downto 0);
    signal w_out_mux2      : std_logic_vector(31 downto 0);
    signal w_OFFSET2       : std_logic_vector(31 downto 0);
    signal w_PC2           : std_logic_vector(31 downto 0);

    -- Instruction & Immediate
    signal w_INSTRUCTION   : std_logic_vector(31 downto 0);
    signal w_imm           : std_logic_vector(31 downto 0);
    signal w_imm_sel       : std_logic_vector(2 downto 0);

    -- Register File
    signal w_rd1           : std_logic_vector(31 downto 0);
    signal w_rd2           : std_logic_vector(31 downto 0);
    signal w_we            : std_logic;

    -- ALU
    signal w_ALU_Result    : std_logic_vector(31 downto 0);
    signal w_out_mux_alu_scr : std_logic_vector(31 downto 0);
    signal w_ALU_SEL       : std_logic_vector(2 downto 0);
    signal w_ALU_CIN       : std_logic;
    signal w_SHIFT_SEL     : std_logic_vector(1 downto 0);
    signal w_SHAMT_SEL     : std_logic;
    signal w_smaller       : std_logic;
    signal w_zero          : std_logic;
    signal w_overflow      : std_logic;
    signal w_overflow2     : std_logic;
    signal w_NO2           : std_logic;

    -- Memory
    signal w_out_ram       : std_logic_vector(31 downto 0);
    signal w_memWrite      : std_logic;
    signal w_memtoreg      : std_logic;
    signal w_wd            : std_logic_vector(31 downto 0);
	 signal w_addr 		   : std_logic_vector (8 downto 0);
	 
    -- Control signals
    signal w_branch        : std_logic;
    signal w_alu_op        : std_logic_vector(1 downto 0);
    signal w_aluscr        : std_logic;
    signal w_MUX2_PC_SEL   : std_logic;
    signal w_lui           : std_logic;
    signal w_auipc         : std_logic;
    signal w_jalr          : std_logic;
    signal w_mux_sel       : std_logic_vector(1 downto 0);
    signal w_sel_rd        : std_logic;

    -- Multiplexadores extra
    signal w_out_mux_source : std_logic_vector(31 downto 0);
    signal w_out_mux_wd     : std_logic_vector(31 downto 0);
    signal w_out_mux_end    : std_logic_vector(31 downto 0); -- aparece no mux4x1

	 -- Branch Identifier
	 signal w_PC_mux_sel  :  std_logic;
	 
	 -- Jalr signal
	 signal w_and  :  std_logic_vector (31 downto 0);
	 
	 -- Not useds
	 signal w_x  :  std_logic;
	 
begin

u_contador_de_ciclos  :  Cyclecounter_32bit
port map(
		 i_RST => i_RESET,
		 i_CLK => i_CLK,
		 o_S	 => o_CICLOS
);

u_PC  :  register32_with_reset  port map( -- PC
									   i_RESET => i_RESET,
										i_CLK => i_CLK,
										i_ENA => '1',
										i_D => w_out_mux_pc, --criar
										o_Q => w_out_pc --criar
);

u_mux2  :  mux2x1_32bit -- PC MUX 2
	 port map(
			 i_0 => w_pc_4,       -- PC+4 (NORMAL) --criar
			 i_1 => w_OFFSET2, -- VEM DOS JALS
			 i_SEL => w_sel_rd,   -- Sinal controlado por jals
			 o_S   => w_out_mux2
);			 

u_mux  :  mux2x1_32bit -- MAIN PC MUX
		port map(
				 i_0 => w_out_mux2,  -- OUT PC MUX 2
				 i_1 => w_PC2, -- PC + OFFSET (BRANCH ADDER)
				 i_SEL => w_PC_mux_sel, -- Branch TAKEN BIT
				 o_S   => w_out_mux_pc -- PC new value
);

u_rom  :  Rom_32bit
		port map(
				 i_ADDR => w_out_pc,
				 o_INST => w_INSTRUCTION
);

		u_adder  :  Adder_32bit -- PC + 4 OFICIAL
    port map(
        i_A        => w_out_pc,
        i_B        => x"00000004",  
        i_CIN      => '0',          
        o_S        => w_pc_4,
        o_overflow => w_overflow, --nao
        o_zero     => w_x--nao
);


w_addr <= w_ALU_Result(10 downto 2);

		u_RAM  :  RAM
		port map(
				 address => w_addr,
				 clock   => i_CLK,
				 data    => w_rd2,
				 wren    => w_memWrite,
				 q			=> w_out_ram
);		
			
		
		u_Control: MainController
        port map(
            i_opcode    => w_INSTRUCTION(6 downto 0),
            o_branch    => w_branch,
            o_memtoreg  => w_memtoreg,
            o_alu_op    => w_alu_op,
            o_memWrite  => w_memWrite,
            o_aluscr    => w_aluscr,
            o_we        => w_we,
            o_imm       => w_imm_sel,
				o_ifid_flush=> w_MUX2_PC_SEL,
				o_lui  		=> w_lui,
				o_auipc	   => w_auipc,
				o_JALR_sel  => w_jalr
        );

    -- 2. Gerador de Imediatos: Gera o valor imediato de 32 bits a partir da instrução.
    u_ImmGen: ImmediateGenerator
        port map(
            i_Instruction => w_INSTRUCTION,
            i_SEL         => w_imm_sel,
            o_S           => w_imm

        );

    -- 3. Banco de Registradores: Lê os registradores fonte (rs1, rs2) e escreve dados do estágio de Write-Back.
    u_RegFile: RegisterFile
        port map(
				i_RESET=> i_RESET,
            i_CLK  => i_CLK,
            i_WE   => w_we,
            i_WD   => w_out_mux_wd, -- vem do mux final
            i_RS1  => w_INSTRUCTION(19 downto 15),
            i_RS2  => w_INSTRUCTION(24 downto 20),
            i_RD   => w_INSTRUCTION(11 downto 7), -- criar
            o_RD1  => w_rd1,
            o_RD2  => w_rd2
        );

	 -- 4. Somador JUMP e branches
	u_somador_jump  :  Adder_32bit
					port map(
						i_A => w_out_mux_source,
						i_B => w_imm,
						i_CIN => '0',
						o_S   => w_PC2
);							

	
	
	u_WriteData_SEL  :  WriteData_Decision
	port map(
				 i_AUIPC => w_auipc,
				 i_LUI   => w_lui,
				 i_JAL   => w_MUX2_PC_SEL,
				 o_S 		=> w_mux_sel
);  

	u_mux_wd  :  mux4x1_32bit
	port map(
	       i_data(0) => w_out_mux_end,-- saida do mux wb
			 i_data(1) => w_PC2, -- saida do somador jump (pro auipc)
			 i_data(2) => w_imm, -- para o lui 
			 i_data(3) => w_pc_4,-- para jal e jalr
			 i_SEL(0) => w_mux_sel(0), 
			 i_SEL(1) => w_mux_sel(1),
			 o_S 		 => w_out_mux_wd
);			

	u_mux_source  :  mux2x1_32bit -- Esse mux serve para decidir qual será a entrada A do somador que serve para fazer (auipc e jal inicial), o que caso o seletor seja '1' (o que indica que a instrução é jalr) selecionamos rd1 para somar com imediato
	port map(
			 i_0   => w_out_pc,
			 i_1   => w_rd1,
			 i_SEL => w_jalr,
			 o_S   => w_out_mux_source
);
			 
w_and <= w_PC2 and "11111111111111111111111111111110";
	 
	u_mux_jals :  mux2x1_32bit
	port map(
			 i_0   => w_PC2,
			 i_1   => w_and,
			 i_SEL => w_jalr,
			 o_S   => w_OFFSET2
);
w_sel_rd <= (w_MUX2_PC_SEL or w_jalr);

u_ALU  :  ALU
		port map(
				i_A  	        => w_rd1,
				i_B    	     => w_out_mux_alu_scr,
				i_shamt_i	  => w_INSTRUCTION(24 downto 20),
				i_SEL_shift   => w_SHIFT_SEL, -- vem do alu control
				i_SEL_mux  	  => w_ALU_SEL, -- vem do alu control
				i_SEL_shamt	  =>	w_SHAMT_SEL, -- vem do alu control
				i_CIN 	     => w_ALU_CIN, -- vem do alu control
				o_S   	     => w_ALU_Result,
				o_zero 	     => w_zero,
				o_overflow    => w_overflow, -- no
				o_menor       => w_smaller
);

-- ALU Controller	
		u_ALU_C: ALU_Control
		port map(
				i_ALU_Op   => w_alu_op,
				i_funct3   => w_INSTRUCTION(14 downto 12),
				i_funct7   => w_INSTRUCTION(31 downto 25),
				o_ALU_SEL  => w_ALU_SEL,
				o_ALU_CIN  => w_ALU_CIN,
				o_SHIFT_SEL => w_SHIFT_SEL,
				o_SHAMT_SEL => w_SHAMT_SEL
);


-- MUX for ALU "B" Input choise
		u_mux_alu_source : mux2x1_32bit
		port map(
				i_0 => w_rd2,
				i_1 => w_imm,
				i_SEL => w_aluscr,
				o_S   => w_out_mux_alu_scr
);

-- Branch Identifier Unit
		u_branch  :  BranchIdentifier
		port map(
				 i_BRANCH      => w_branch,
				 i_EQUAL       => w_zero,
				 i_SMALLER     => w_smaller,
				 i_funct3      => w_INSTRUCTION(14 downto 12),
				 o_TAKE_BRANCH => w_PC_mux_sel
);




u_mux_end  :  mux2x1_32bit
		port map(
				 i_0 => w_out_ram,
				 i_1 => w_ALU_Result,
				 i_SEL => w_memtoreg,
				 o_S => w_out_mux_end
);

			
o_instruction_debug <= w_INSTRUCTION;
o_RD <= w_INSTRUCTION(11 downto 7);
o_RD1_debug <= w_rd1;
o_RD2_debug <= w_rd2;
o_Immediate <= w_imm;
o_PC_debug  <= w_out_pc;
o_ALU 		<= w_ALU_Result;
o_RAM 	   <= w_out_ram;


end arch_rv32;