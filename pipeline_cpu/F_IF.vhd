library IEEE;

use ieee.std_logic_1164.all;

library work;
use work.mux_pkg.all;

entity F_IF is
port(

----------
-- Inputs
----------
	i_RESET		   :  in std_logic;
	i_CLK 		   :  in std_logic;
	i_PC_OFFSET    :  in std_logic_vector (31 downto 0); -- PC + Offset, native from MEM stage.
	i_PC_OFFSET2   :  in std_logic_vector (31 downto 0); -- PC + Offset, native from Decode stage.
	i_PC_MUX_SEL   :  in std_logic; -- PC Mux selector, native from MEM stage.
	i_PC_MUX2_SEL  :  in std_logic; -- PC Mux2 selector, native from ID stage.
	
----------
-- Outputs
----------

	o_INSTRUCTION  :  out std_logic_vector (31 downto 0); -- Goes to ID
	o_PC 				:  out std_logic_vector (31 downto 0) -- Goes to ID
);
end F_IF;

architecture arch1 of F_IF is

-- PC
component register32_with_reset is
port ( i_RESET : in  std_logic;  -- clear/reset
       i_CLK   : in  std_logic;  -- clock
       i_ENA   : in  std_logic;  -- enable    
       i_D     : in  std_logic_vector(31 downto 0);  -- data input
       o_Q     : out std_logic_vector(31 downto 0)); -- data output
end component;

-- ROM
component Rom_32bit is
port(
		i_ADDR : in std_logic_vector(31 downto 0);
		o_INST : out std_logic_vector(31 downto 0)
);
end component;

-- PC + 4 Adder
component Adder_32bit is
port (i_A    :  in std_logic_vector (31 downto 0);
      i_B    :  in std_logic_vector (31 downto 0);
      i_CIN  :  in std_logic;
      o_S    :  out std_logic_vector (31 downto 0);
      o_overflow : out std_logic;
		o_zero : out std_logic
);
end component;

component mux2x1_32bit is
port(
	 i_0   : in data_bus;
	 i_1   : in data_bus;
    i_SEL : in std_logic;
    o_S   : out data_bus
);
end component;


signal w_out_pc, w_out_mux_pc, w_pc_4  :  std_logic_vector (31 downto 0);
signal w_overflow, w_zero  :  std_logic;
signal w_out_mux2  :  std_logic_vector (31 downto 0);

begin

		u_mux  :  mux2x1_32bit
		port map(
				 i_0 => w_out_mux2,
				 i_1 => i_PC_OFFSET,
				 i_SEL => i_PC_MUX_SEL,
				 o_S   => w_out_mux_pc
);

		
		u_pc  :  register32_with_reset
		port map(
				 i_RESET => i_RESET,
				 i_CLK   => i_CLK,
			    i_ENA   => '1',  
				 i_D     => w_out_mux_pc,
				 o_Q     => w_out_pc
);

		u_rom  :  Rom_32bit
		port map(
				 i_ADDR => w_out_pc,
				 o_INST => o_INSTRUCTION
);

		u_adder  :  Adder_32bit
    port map(
        i_A        => w_out_pc,
        i_B        => x"00000004",  
        i_CIN      => '0',          
        o_S        => w_pc_4,
        o_overflow => w_overflow,
        o_zero     => w_zero
    );
	 
	 u_mux2  :  mux2x1_32bit
	 port map(
			 i_0 => w_pc_4,
			 i_1 => i_PC_OFFSET2,
			 i_SEL => i_PC_MUX2_SEL,
			 o_S   => w_out_mux2
);			 
			 
			 
			 
		o_PC <= w_out_pc;

end arch1;