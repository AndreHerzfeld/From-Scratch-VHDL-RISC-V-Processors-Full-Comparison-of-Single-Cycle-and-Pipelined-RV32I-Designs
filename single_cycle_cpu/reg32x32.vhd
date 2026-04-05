library ieee;
use ieee.std_logic_1164.all;

library work;
use work.mux_pkg.all;

-- Reg32x32 is an aggroupment of all general purpose registers.
entity reg32x32 is
    port (
		  i_RESET: in std_logic;
        i_CLK  : in  std_logic;
        i_ENA  : in  std_logic_vector(31 downto 0);
        i_D    : in  std_logic_vector(31 downto 0);
        o_Q    : out data_bus_32x1 -- 32 outputs with 32 bits each.
    );
end reg32x32;

architecture arch_reg32x32 of reg32x32 is

component register32_with_reset is
port ( i_RESET : in  std_logic;  -- clear/reset
       i_CLK   : in  std_logic;  -- clock
       i_ENA   : in  std_logic;  -- enable    
       i_D     : in  std_logic_vector(31 downto 0);  -- data input
       o_Q     : out std_logic_vector(31 downto 0)); -- data output
end component;

begin

gen_regs: for i in 1 to 31 generate -- Registers x1 to x31: General purpose registers.
		u_reg : register32_with_reset port map(
			   i_RESET => i_RESET,
				i_CLK => i_CLK,
				i_ENA => i_ENA(i),
				i_D => i_D,
				o_Q => o_Q(i)
);
end generate gen_regs;


o_Q(0) <= (others => '0'); -- x0: Hardwired to zero as per RISC-V specification.
assert i_ENA(0) = '0' report "Attempted to write to x0 register" severity warning;

end arch_reg32x32;