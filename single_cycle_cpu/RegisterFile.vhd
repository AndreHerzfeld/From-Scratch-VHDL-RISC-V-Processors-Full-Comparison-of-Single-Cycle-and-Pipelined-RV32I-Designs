library ieee;
use ieee.std_logic_1164.all;

library work;
use work.mux_pkg.all;

entity RegisterFile is
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
end RegisterFile;

architecture arch_RegFile of RegisterFile is

component mux32x1_32bit is
port (
    i_data : in data_bus_32x1;
    i_SEL  : in std_logic_vector(4 downto 0);
    o_S    : out data_bus
);
end component;

component decoder is
port ( i_A  :  in std_logic_vector (4 downto 0);
	    o_Q :  out std_logic_vector (31 downto 0));
end component;

component reg32x32 is
port (
		  i_RESET: in std_logic;
        i_CLK  : in  std_logic;
        i_ENA  : in  std_logic_vector(31 downto 0);
        i_D    : in  std_logic_vector(31 downto 0);
        o_Q    : out data_bus_32x1
    );
end component;

component verificador_we is
    port (
        we  : in std_logic;
        i_D : in std_logic_vector(31 downto 0);
        o_Q : out std_logic_vector(31 downto 0)
    );
end component;



-- Internal signals

-- w_e get the decoder's output.
-- w_reg get the enble signals to utilizate in the registers.

signal w_e, w_reg  :  std_logic_vector (31 downto 0);
signal w_out_regs  :  data_bus_32x1; -- Values of all registers.

begin

-- Decoder.
u_0  :  decoder port map ( i_A => i_RD,
								   o_Q => w_e
);

-- Verificate if RegEnable signal is on to activate the enable of the registers.
u_we_verify  :  verificador_we port map( we  => i_WE,
											        i_D => w_e,
													  o_Q => w_reg
);
															
-- Registers.
u_2  :  reg32x32 port map ( i_RESET => i_RESET,
									 i_CLK => i_clk,
						          i_ENA => w_reg,
                            i_D => i_WD,
                            o_Q  => w_out_regs
);

-- Register data 1.
u_3  :  mux32x1_32bit port map (
								  i_data  => w_out_regs,
                          i_SEL => i_RS1,
                          o_S => o_RD1
);

-- Register data 2.
u_4  :  mux32x1_32bit port map (
						        i_data  => w_out_regs,
                          i_SEL => i_RS2,
                          o_S => o_RD2
);

end arch_RegFile;