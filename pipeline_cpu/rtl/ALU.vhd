library IEEE;
library work;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.mux_pkg.all;

-- A entidade da ULA, conforme sua reorganizacao
entity ALU is
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
end ALU;

architecture arch_ALU of ALU is
     
-- Components
	  
    component mux8x1_32bit is
    port(
		 i_data :  in data_bus_8x1;
       i_SEL  :  in std_logic_vector (2 downto 0);
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

     
    component Adder_32bit is
    port (i_A    :  in std_logic_vector (31 downto 0);
          i_B    :  in std_logic_vector (31 downto 0);
          i_CIN  :  in std_logic; -- Adder's CIN Input.
          o_S    :  out std_logic_vector (31 downto 0); -- Result.
          o_overflow : out std_logic; -- Signed overflow detection.
			 o_zero : out std_logic -- Verify if the result is equal to zero.
    );
    end component;
     
    component a_and_b is
    port(i_A  :  in std_logic_vector (31 downto 0);
         i_B  :  in std_logic_vector (31 downto 0);
         o_S  :  out std_logic_vector (31 downto 0));
    end component;
     
    component a_or_b is
    port(i_A  :  in std_logic_vector (31 downto 0);
         i_B  :  in std_logic_vector (31 downto 0);
         o_S  :  out std_logic_vector (31 downto 0));
    end component;

    component a_xor_b is
    port(i_A  :  in std_logic_vector (31 downto 0);
         i_B  :  in std_logic_vector (31 downto 0);
         o_S  :  out std_logic_vector (31 downto 0));
    end component;
     
    component register32 is
    port ( i_CLK   : in  std_logic;  -- clock
       i_ENA   : in  std_logic;  -- enable    
       i_D     : in  std_logic_vector(31 downto 0);  -- data input
       o_Q     : out std_logic_vector(31 downto 0)); -- data output
	 end component;
	 
	 component shifter_unit is
	     port(
        i_A          : in  std_logic_vector(31 downto 0); -- Dado para deslocar
        i_shamt      : in  std_logic_vector(4 downto 0); -- Usado para a quantidade de deslocamento (shamt)
        i_SEL_SHIFT  : in  std_logic_vector(1 downto 0); -- Seletor: 01=SLL, 10=SRL, 11=SRA
        o_S          : out std_logic_vector(31 downto 0)  -- Resultado
    );
	end component;

	 -- Internal signals
     
    signal res_adder, res_and, res_or, res_xor, res_shift : std_logic_vector(31 downto 0); -- Result from the operation units
    signal b_xor : std_logic_vector(31 downto 0); -- Signal to invert B value
    signal mux_out : std_logic_vector(31 downto 0); -- ALU's result
	 signal w_ShamtFinal : std_logic_vector (4 downto 0); -- valor final do shamt
	 -- Constant 'X' for unused inputs of multiplexer
    constant X_VECTOR : std_logic_vector(31 downto 0) := (others => 'X');

begin
    
    b_xor <= i_B xor (31 downto 0 => i_CIN); -- Invert B value (for sub in adder unit) if CIN = 1
     
    u_adder : Adder_32bit port map( -- ADD and SUB unit
        i_A => i_A,
        i_B => b_xor,
        i_CIN => i_CIN,
        o_S => res_adder,
        o_overflow => o_overflow,
		  o_zero => o_zero
    );
     
	 u_and_logic : a_and_b port map( -- AND unit
		  i_A => i_A,
	     i_B => i_B,
	     o_S => res_and
	 );
	 
    u_or_logic  : a_or_b  port map( -- OR unit(
	     i_A => i_A,
	     i_B => i_B,
	     o_S => res_or
	 );
	 
    u_xor_logic : a_xor_b port map( -- XOR unit
	     i_A => i_A,
	     i_B => i_B,
	     o_S => res_xor
	 );
     
    u_mux : mux8x1_32bit port map(
        i_data(0) => res_adder,  -- SEL = "000"
        i_data(1) => res_or,     -- SEL = "001"
        i_data(2) => res_and,    -- SEL = "010"
        i_data(3) => res_xor,    -- SEL = "011"
		  i_data(4) => res_shift,  -- SEL = "100"
        i_data(5) => X_VECTOR,     -- SEL = "101"
        i_data(6) => X_VECTOR,    -- SEL = "110"
        i_data(7) => X_VECTOR,    -- SEL = "111"
        i_SEL => i_SEL_mux,
        o_S => mux_out -- ALU result
    );
	 
		w_ShamtFinal <= i_B(4 downto 0) when i_SEL_shamt = '1' else i_shamt_i;												
	 
	 u_shifter : shifter_unit port map(
		  i_A		=>	i_A,
		  i_shamt	=>	w_shamtFinal,
		  i_SEL_SHIFT	=>	i_SEL_shift,
		  o_S		=> res_shift
	 );

	 
	 o_menor <= mux_out(31); -- Propagates the signal of the result
	 o_S <= mux_out;
	 
end arch_ALU;