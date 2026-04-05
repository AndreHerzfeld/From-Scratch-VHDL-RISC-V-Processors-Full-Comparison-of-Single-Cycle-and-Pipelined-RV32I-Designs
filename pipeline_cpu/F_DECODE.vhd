library IEEE;
use IEEE.std_logic_1164.all;

library work;
use work.mux_pkg.all;


-- Módulo do Datapath do Estágio de Decodificação de Instrução (ID)
entity F_DECODE is
    port(
        -- Clock/Reset
		  i_RESET      : in std_logic;
        i_CLK        : in  std_logic;
        
        -- Entrada (vindo do estágio IF)
        i_INSTRUCTION: in std_logic_vector (31 downto 0);
		  i_PC 			: in std_logic_vector (31 downto 0);
        -- Dados de Write-Back (para o Register File)
        i_WE      : in  std_logic; -- Habilita escrita no banco de registradores
        i_RD      : in  std_logic_vector(4 downto 0);   -- Endereço do registrador de destino
        i_WD      : in  std_logic_vector(31 downto 0); -- Dado a ser escrito

        -- Saídas de Dados (para o ID/EX)
		  o_PC 		   : out std_logic_vector (31 downto 0); -- PC address for EXE stage
        o_RD1        : out std_logic_vector (31 downto 0); -- Dado lido do registrador 1
        o_RD2        : out std_logic_vector (31 downto 0); -- Dado lido do registrador 2
        o_imm        : out std_logic_vector (31 downto 0); -- Imediato com sinal estendido
        o_RD         : out std_logic_vector (4 downto 0);   -- Endereço do registrador de destino (rd)
        o_RS1        : out std_logic_vector (4 downto 0);   -- Endereço do registrador fonte 1 (rs1)
        o_RS2        : out std_logic_vector (4 downto 0);   -- Endereço do registrador fonte 2 (rs2)
		  o_FUNCT3     : out std_logic_vector (2 downto 0);   -- Funct3 of the instruction (14:12)
		  o_FUNCT7     : out std_logic_vector (6 downto 0);   -- Funct7 of the instruction (31:25)
        
        -- Saídas de Sinais de Controle (para os estágios EX, MEM, WB)
        o_branch     : out std_logic;
        o_memread    : out std_logic;
        o_memtoreg   : out std_logic;
        o_alu_op     : out std_logic_vector (1 downto 0);
        o_memWrite   : out std_logic;
        o_aluscr     : out std_logic;
        o_we         : out std_logic;
		  
		  -- Saída para novo valor do PC (jump)
		  o_MUX2_PC_SEL  :  out std_logic;
		  o_PC2			  :  out std_logic_vector (31 downto 0)
    );
end F_DECODE;

architecture arch of F_DECODE is

    -- Definição dos componentes
	 
    component MainController is -- Main Controller
	port( i_opcode      :  in std_logic_vector (6 downto 0);
			o_branch      :  out std_logic;
			o_memread     :  out std_logic;
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
    
    component ImmediateGenerator is -- Immediate Generator
        port (
        i_Instruction   : in  std_logic_vector(31 downto 0); -- Full instruction.
        i_SEL : in  std_logic_vector(2 downto 0); 				 -- Signal native from main controler for select the proper concatenation.
        o_S      : out std_logic_vector(31 downto 0) 			 -- Immediate value properly formatted and sign-extended.
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

component Adder_32bit is
port (i_A    :  in std_logic_vector (31 downto 0);
      i_B    :  in std_logic_vector (31 downto 0);
      i_CIN  :  in std_logic;
      o_S    :  out std_logic_vector (31 downto 0);
      o_overflow : out std_logic;
		o_zero : out std_logic
);
end component;

component mux4x1_32bit is
port (
		 i_data :  in data_bus_4x1; -- 4 arrays of 32 bits each
       i_SEL  :  in std_logic_vector (1 downto 0);
       o_S    :  out data_bus); -- 32 bit output
end component;

component mux2x1_32bit is
port(
	 i_0   : in data_bus;
	 i_1   : in data_bus;
    i_SEL : in std_logic;
    o_S   : out data_bus
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

    -- Sinais internos
    signal w_imm_sel  :  std_logic_vector(2 downto 0);
	 signal w_imm, w_and		 :  std_logic_vector (31 downto 0);
	 signal w_lui		 :  std_logic;
	 	 
	 signal w_PC2  :  std_logic_vector (31 downto 0); -- PC + Imm
	 
	 signal w_auipc  :  std_logic;
	 
	 signal w_MUX2_PC_SEL  :  std_logic; -- For IF
	 
	 signal w_mux_sel  :  std_logic_vector (1 downto 0); -- For ID
	 
	 signal w_pc_4  :  std_logic_vector (31 downto 0); -- Para guardar no rd o PC + 4 (JAL)
	 
	 signal w_out_mux  :  std_logic_vector (31 downto 0);
	 
	 signal w_mux_source , w_jalr, w_sel_rd :  std_logic;
	 signal w_MUX_OUT_RD : std_logic_vector(4 downto 0);
	 
	 signal w_out_mux_source  :  std_logic_vector (31 downto 0);
	 
	 signal w_rd1  :  std_logic_vector (31 downto 0);
begin
    	 
    -- =================================================================
    -- ETAPA DE DECODIFICAÇÃO (ID)
    -- =================================================================
	 
    -- 1. Unidade de Controle Principal: Gera os sinais de controle a partir do opcode.
    u_Control: MainController
        port map(
            i_opcode    => i_INSTRUCTION(6 downto 0),
            o_branch    => o_branch,
            o_memread   => o_memread,
            o_memtoreg  => o_memtoreg,
            o_alu_op    => o_alu_op,
            o_memWrite  => o_memWrite,
            o_aluscr    => o_aluscr,
            o_we        => o_we,
            o_imm       => w_imm_sel,
				o_ifid_flush=> w_MUX2_PC_SEL,
				o_lui  		=> w_lui,
				o_auipc	   => w_auipc,
				o_JALR_sel  => w_jalr
        );

    -- 2. Gerador de Imediatos: Gera o valor imediato de 32 bits a partir da instrução.
    u_ImmGen: ImmediateGenerator
        port map(
            i_Instruction => i_INSTRUCTION,
            i_SEL         => w_imm_sel,
            o_S           => w_imm

        );

    -- 3. Banco de Registradores: Lê os registradores fonte (rs1, rs2) e escreve dados do estágio de Write-Back.
    u_RegFile: RegisterFile
        port map(
				i_RESET=> i_RESET,
            i_CLK  => i_CLK,
            i_WE   => i_WE,
            i_WD   => w_out_mux,
            i_RS1  => i_INSTRUCTION(19 downto 15),
            i_RS2  => i_INSTRUCTION(24 downto 20),
            i_RD   => w_MUX_OUT_RD,
            o_RD1  => w_rd1,
            o_RD2  => o_RD2
        );

	 -- 4. Somador JUMP
	u_somador_jump  :  Adder_32bit
					port map(
						i_A => w_out_mux_source,
						i_B => w_imm,
						i_CIN => '0',
						o_S   => w_PC2
);							

	u_somador_pc_4  : Adder_32bit
	port map(
			 i_A => i_PC,
			 i_B => "00000000000000000000000000000100",
			 i_CIN => '0',
			 o_S => w_pc_4
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
	       i_data(0) => i_WD,
			 i_data(1) => w_PC2,
			 i_data(2) => w_imm,
			 i_data(3) => w_pc_4,
			 i_SEL(0) => w_mux_sel(0),
			 i_SEL(1) => w_mux_sel(1),
			 o_S 		 => w_out_mux
);			

	u_mux_source  :  mux2x1_32bit -- Esse mux serve para decidir qual será a entrada A do somador que serve para fazer (auipc e jal inicial), o que caso o seletor seja '1' (o que indica que a instrução é jalr) selecionamos rd1 para somar com imediato
	port map(
			 i_0   => i_PC,
			 i_1   => w_rd1,
			 i_SEL => w_jalr,
			 o_S   => w_out_mux_source
);
			 
w_and <= w_PC2 and "11111111111111111111111111111110";
	 
	u_mux_jals :  mux2x1_32bit -- Esse mux serve para decidir qual será a entrada A do somador que serve para fazer (auipc e jal inicial), o que caso o seletor seja '1' (o que indica que a instrução é jalr) selecionamos rd1 para somar com imediato
	port map(
			 i_0   => w_PC2,
			 i_1   => w_and,
			 i_SEL => w_jalr,
			 o_S   => o_PC2
);
w_sel_rd <= (w_MUX2_PC_SEL or w_jalr);

w_MUX_OUT_RD <= i_INSTRUCTION(11 downto 7) when (w_sel_rd = '1') else  i_RD;
    -- =================================================================
    -- ATRIBUIÇÃO DE SAÍDAS ADICIONAIS
    -- =================================================================
    -- Extrai os endereços dos registradores diretamente da instrução. (Utilizado no ID/EX)
	 
	 o_MUX2_PC_SEL <= w_MUX2_PC_SEL;
	 o_PC  <= i_PC; 								   -- Utilized in PC+Offset adder
    o_RD  <= i_INSTRUCTION(11 downto 7);     -- Utilized in Fowarding Unit and Write Back Stage
	 o_RD1 <= w_rd1;
    o_RS1 <= i_INSTRUCTION(19 downto 15);    -- Utilized in Fowarding Unit
    o_RS2 <= i_INSTRUCTION(24 downto 20);    -- Utilized in Fowarding Unit
	 o_FUNCT3 <= i_INSTRUCTION(14 downto 12); -- Utilized in ALU Control
	 o_FUNCT7 <= i_INSTRUCTION(31 downto 25); -- Utilized in ALU Control
	 o_imm    <= w_imm;

end arch;