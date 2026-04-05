library ieee;
use ieee.std_logic_1164.all;

entity decoder is
port ( i_A  :  in std_logic_vector (4 downto 0);
	   o_Q :  out std_logic_vector (31 downto 0));
end decoder;

architecture arch_decoder of decoder is
begin 
o_Q(0)  <= not i_A(4) and not i_A(3) and not i_A(2) and not i_A(1) and not i_A(0);
    o_Q(1)  <= not i_A(4) and not i_A(3) and not i_A(2) and not i_A(1) and     i_A(0);
    o_Q(2)  <= not i_A(4) and not i_A(3) and not i_A(2) and     i_A(1) and not i_A(0);
    o_Q(3)  <= not i_A(4) and not i_A(3) and not i_A(2) and     i_A(1) and     i_A(0);
    o_Q(4)  <= not i_A(4) and not i_A(3) and     i_A(2) and not i_A(1) and not i_A(0);
    o_Q(5)  <= not i_A(4) and not i_A(3) and     i_A(2) and not i_A(1) and     i_A(0);
    o_Q(6)  <= not i_A(4) and not i_A(3) and     i_A(2) and     i_A(1) and not i_A(0);
    o_Q(7)  <= not i_A(4) and not i_A(3) and     i_A(2) and     i_A(1) and     i_A(0);
    o_Q(8)  <= not i_A(4) and     i_A(3) and not i_A(2) and not i_A(1) and not i_A(0);
    o_Q(9)  <= not i_A(4) and     i_A(3) and not i_A(2) and not i_A(1) and     i_A(0);
    o_Q(10) <= not i_A(4) and     i_A(3) and not i_A(2) and     i_A(1) and not i_A(0);
    o_Q(11) <= not i_A(4) and     i_A(3) and not i_A(2) and     i_A(1) and     i_A(0);
    o_Q(12) <= not i_A(4) and     i_A(3) and     i_A(2) and not i_A(1) and not i_A(0);
    o_Q(13) <= not i_A(4) and     i_A(3) and     i_A(2) and not i_A(1) and     i_A(0);
    o_Q(14) <= not i_A(4) and     i_A(3) and     i_A(2) and     i_A(1) and not i_A(0);
    o_Q(15) <= not i_A(4) and     i_A(3) and     i_A(2) and     i_A(1) and     i_A(0);
    o_Q(16) <=     i_A(4) and not i_A(3) and not i_A(2) and not i_A(1) and not i_A(0);
    o_Q(17) <=     i_A(4) and not i_A(3) and not i_A(2) and not i_A(1) and     i_A(0);
    o_Q(18) <=     i_A(4) and not i_A(3) and not i_A(2) and     i_A(1) and not i_A(0);
    o_Q(19) <=     i_A(4) and not i_A(3) and not i_A(2) and     i_A(1) and     i_A(0);
    o_Q(20) <=     i_A(4) and not i_A(3) and     i_A(2) and not i_A(1) and not i_A(0);
    o_Q(21) <=     i_A(4) and not i_A(3) and     i_A(2) and not i_A(1) and     i_A(0);
    o_Q(22) <=     i_A(4) and not i_A(3) and     i_A(2) and     i_A(1) and not i_A(0);
    o_Q(23) <=     i_A(4) and not i_A(3) and     i_A(2) and     i_A(1) and     i_A(0);
    o_Q(24) <=     i_A(4) and     i_A(3) and not i_A(2) and not i_A(1) and not i_A(0);
    o_Q(25) <=     i_A(4) and     i_A(3) and not i_A(2) and not i_A(1) and     i_A(0);
    o_Q(26) <=     i_A(4) and     i_A(3) and not i_A(2) and     i_A(1) and not i_A(0);
    o_Q(27) <=     i_A(4) and     i_A(3) and not i_A(2) and     i_A(1) and     i_A(0);
    o_Q(28) <=     i_A(4) and     i_A(3) and     i_A(2) and not i_A(1) and not i_A(0);
    o_Q(29) <=     i_A(4) and     i_A(3) and     i_A(2) and not i_A(1) and     i_A(0);
    o_Q(30) <=     i_A(4) and     i_A(3) and     i_A(2) and     i_A(1) and not i_A(0);
    o_Q(31) <=     i_A(4) and     i_A(3) and     i_A(2) and     i_A(1) and     i_A(0);
end arch_decoder;