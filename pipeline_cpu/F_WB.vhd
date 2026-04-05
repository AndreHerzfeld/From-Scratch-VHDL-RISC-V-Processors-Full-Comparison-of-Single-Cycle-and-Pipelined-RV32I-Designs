library IEEE;

use ieee.std_logic_1164.all;

library work;
use work.mux_pkg.all;

entity F_WB is
port(

----------
-- Inputs
----------

-- Control lines for WB
	i_WE 			:  in std_logic;
	i_MemToReg  :  in std_logic;

-- Memory output
	i_MEM  :  in std_logic_vector (31 downto 0);
	
-- ALU output
	i_ALU_Result  :  in std_logic_vector (31 downto 0);

-- RD
	i_RD  :  in std_logic_vector (4 downto 0);
	
----------
-- Outputs
----------

	o_MUX_WB  :  out std_logic_vector (31 downto 0);
	o_RD 	    :  out std_logic_vector (4 downto 0);
	o_WE		 :  out std_logic

);
end F_WB;

architecture arch_wb of F_WB is


component mux2x1_32bit is
port(
	 i_0   : in data_bus;
	 i_1   : in data_bus;
    i_SEL : in std_logic;
    o_S   : out data_bus
);
end component;

begin

		u_mux  :  mux2x1_32bit
		port map(
				 i_0 => i_MEM,
				 i_1 => i_ALU_Result,
				 i_SEL => i_MemToReg,
				 o_S => O_MUX_WB
);

o_RD <= i_RD;
o_WE <= i_WE;

end arch_wb;