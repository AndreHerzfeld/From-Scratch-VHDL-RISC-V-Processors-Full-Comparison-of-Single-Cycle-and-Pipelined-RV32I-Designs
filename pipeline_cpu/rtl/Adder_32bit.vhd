library IEEE;
use ieee.std_logic_1164.all;

entity Adder_32bit is
port (i_A    :  in std_logic_vector (31 downto 0);
      i_B    :  in std_logic_vector (31 downto 0);
      i_CIN  :  in std_logic;
      o_S    :  out std_logic_vector (31 downto 0);
      o_overflow : out std_logic;
		o_zero : out std_logic
);
end Adder_32bit;

architecture arch_Adder of Adder_32bit is

    component Full_Adder is
    port (i_A    :  in std_logic;
          i_B    :  in std_logic; 
          i_CIN  :  in std_logic;
          o_COUT : out std_logic;
          o_S    : out std_logic );
    end component;

    signal w_carry  :  std_logic_vector (31 downto 0);
	 signal o_result : std_logic_vector (31 downto 0);

begin 

		u_0  :  Full_Adder port map(
			i_A => i_A(0),
			i_B => i_B(0),
			i_CIN => i_CIN,
			o_COUT => w_carry(0),
			o_S => o_result(0)
   );	
	
	gen_adders  :  for i in 1 to 31 generate
		
		u_adder  :  Full_Adder port map(
			i_A => i_A(i),
			i_B => i_B(i),
			i_CIN => w_carry(i - 1),
			o_COUT => w_carry(i),
			o_S => o_result(i)
	 );
	 end generate;
	 
    
   o_overflow <= w_carry(30) xor w_carry(31); -- Signed overflow detection.
	 
	o_zero <= '1' when o_result = (31 downto 0 => '0') else '0';

	
	o_S <= o_result; -- Result of the Adder


end arch_Adder;