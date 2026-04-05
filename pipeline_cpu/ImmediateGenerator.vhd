library ieee;
use ieee.std_logic_1164.all;

library work;
use work.mux_pkg.all;

entity ImmediateGenerator is
    port (
        i_Instruction   : in  std_logic_vector(31 downto 0); -- Full instruction
        i_SEL : in  std_logic_vector(2 downto 0); -- Signal native from main controler for select the proper concatenation
        o_S      : out std_logic_vector(31 downto 0) -- Immediate value properly formatted and sign-extended
    );
end ImmediateGenerator;

architecture arch_ImmGenerator of ImmediateGenerator is

-- Components

    -- Multiplexor unit
    component mux8x1_32bit is
        port (
    i_data: in data_bus_8x1; -- 8 arrays of 32 bits each
    i_SEL : in std_logic_vector(2 downto 0);
    o_S   : out data_bus -- 32 bit output
);
end component;

	 
-- Internal Signals declaration

    -- Type for the Imm value from all instruction formats
	 subtype Imm is std_logic_vector (31 downto 0);
	 
	
	 -- Signal for post formatted and extended immediate value
	 signal Organized_Immediate_I, Organized_Immediate_S, Organized_Immediate_B, Organized_Immediate_U, Organized_Immediate_J  :  Imm;
	 
	 
    -- Constant 'X' for unused inputs of multiplexer
    constant X_VECTOR : std_logic_vector(31 downto 0) := (others => 'X');

begin

-- Logic design

-- I type
Organized_Immediate_I(31 downto 12) <= (others => i_Instruction(31)); -- Extend the signal bit for upper part of the resultant Immediate value
Organized_Immediate_I(11 downto 0) <= i_Instruction (31 downto 20); -- Concatenate the immediate

-- S type
Organized_Immediate_S(31 downto 12) <= (others => i_Instruction(31));
Organized_Immediate_S(11 downto 5) <= i_Instruction(31 downto 25);
Organized_Immediate_S(4 downto 0) <= i_Instruction(11 downto 7);

-- B type
Organized_Immediate_B(31 downto 13) <= (others => i_Instruction(31));
Organized_Immediate_B(12) <= i_Instruction(31);
Organized_Immediate_B(11) <= i_Instruction(7);
Organized_Immediate_B(10 downto 5) <= i_Instruction(30 downto 25);
Organized_Immediate_B (4 downto 1) <= i_Instruction(11 downto 8);
Organized_Immediate_B (0) <= '0';

-- U type
Organized_Immediate_U(31 downto 12) <= i_Instruction(31 downto 12);
Organized_Immediate_U(11 downto 0) <= (others => '0');

-- J type
Organized_Immediate_J(31 downto 20) <= (others => i_Instruction(31));
Organized_Immediate_J(19 downto 12) <= i_Instruction(19 downto 12);
Organized_Immediate_J(11) <= i_Instruction(20);
Organized_Immediate_J(10 downto 1) <= i_Instruction(30 downto 21);
Organized_Immediate_J(0) <= '0';


    u_multiplexor : mux8x1_32bit port map (
        i_data(0)   => Organized_Immediate_I, -- Selected when i_SEL = "000"
        i_data(1)   => Organized_Immediate_S, -- Selected when i_SEL = "001"
        i_data(2)   => Organized_Immediate_B, -- Selected when i_SEL = "010"
        i_data(3)   => Organized_Immediate_U, -- Selected when i_SEL = "011"
        i_data(4)   => Organized_Immediate_J, -- Selected when i_SEL = "100"
        i_data(5)   => X_VECTOR,
        i_data(6)   => X_VECTOR,
        i_data(7)   => X_VECTOR,
        i_SEL => i_SEL,
        o_S   => o_S
    );

end arch_ImmGenerator;