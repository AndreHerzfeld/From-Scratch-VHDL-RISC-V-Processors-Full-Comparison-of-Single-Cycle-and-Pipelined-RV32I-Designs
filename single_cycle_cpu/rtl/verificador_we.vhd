library ieee;
use ieee.std_logic_1164.all;

entity verificador_we is
    port (
        we  : in std_logic;
        i_D : in std_logic_vector(31 downto 0);
        o_Q : out std_logic_vector(31 downto 0)
    );
end verificador_we;

architecture arch_verificador_we of verificador_we is
begin

    o_Q(0)  <= i_D(0)  and we;
    o_Q(1)  <= i_D(1)  and we;
    o_Q(2)  <= i_D(2)  and we;
    o_Q(3)  <= i_D(3)  and we;
    o_Q(4)  <= i_D(4)  and we;
    o_Q(5)  <= i_D(5)  and we;
    o_Q(6)  <= i_D(6)  and we;
    o_Q(7)  <= i_D(7)  and we;
    o_Q(8)  <= i_D(8)  and we;
    o_Q(9)  <= i_D(9)  and we;
    o_Q(10) <= i_D(10) and we;
    o_Q(11) <= i_D(11) and we;
    o_Q(12) <= i_D(12) and we;
    o_Q(13) <= i_D(13) and we;
    o_Q(14) <= i_D(14) and we;
    o_Q(15) <= i_D(15) and we;
    o_Q(16) <= i_D(16) and we;
    o_Q(17) <= i_D(17) and we;
    o_Q(18) <= i_D(18) and we;
    o_Q(19) <= i_D(19) and we;
    o_Q(20) <= i_D(20) and we;
    o_Q(21) <= i_D(21) and we;
    o_Q(22) <= i_D(22) and we;
    o_Q(23) <= i_D(23) and we;
    o_Q(24) <= i_D(24) and we;
    o_Q(25) <= i_D(25) and we;
    o_Q(26) <= i_D(26) and we;
    o_Q(27) <= i_D(27) and we;
    o_Q(28) <= i_D(28) and we;
    o_Q(29) <= i_D(29) and we;
    o_Q(30) <= i_D(30) and we;
    o_Q(31) <= i_D(31) and we;

end arch_verificador_we;