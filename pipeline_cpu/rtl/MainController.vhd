library ieee;

use ieee.std_logic_1164.all;

entity MainController is
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
end MainController;

architecture arch_control of MainController is
begin 

o_branch <= i_opcode(6) and i_opcode(5) and not i_opcode(4) and not i_opcode(3) and not i_opcode(2) and i_opcode(1) and i_opcode(0); -- Branches

o_memread <= not i_opcode(6) and not i_opcode(5) and not i_opcode(4) and not i_opcode(3) and not i_opcode(2) and i_opcode(1) and i_opcode(0); -- lw

o_memtoreg <= (not i_opcode(6) and not i_opcode(5) and not i_opcode(4) and not i_opcode(3) and not i_opcode(2) and i_opcode(1) and i_opcode(0)) or (not i_opcode(6) and not i_opcode(5) and i_opcode(4) and not i_opcode(3) and not i_opcode(2) and i_opcode(1) and i_opcode(0)); -- lw

o_alu_op(1) <= (not i_opcode(6) and not i_opcode(5) and i_opcode(4) and not i_opcode(3) and not i_opcode(2) and i_opcode(1) and i_opcode(0)) or (not i_opcode(6) and i_opcode(5) and i_opcode(4) and not i_opcode(3) and not i_opcode(2) and i_opcode(1) and i_opcode(0)); -- imediatos e tipo r

o_alu_op(0) <= (i_opcode(6) and i_opcode(5) and not i_opcode(4) and not i_opcode(3) and not i_opcode(2) and i_opcode(1) and i_opcode(0)) or (not i_opcode(6) and not i_opcode(5) and i_opcode(4) and not i_opcode(3) and not i_opcode(2) and i_opcode(1) and i_opcode(0)); -- Branches

o_memWrite <= not i_opcode(6) and i_opcode(5) and not i_opcode(4) and not i_opcode(3) and not i_opcode(2) and i_opcode(1) and i_opcode(0);

o_aluscr <= (not i_opcode(6) and not i_opcode(5) and i_opcode(4) and not i_opcode(3) and not i_opcode(2) and i_opcode(1) and i_opcode(0)) or (not i_opcode(6) and not i_opcode(5) and not i_opcode(4) and not i_opcode(3) and not i_opcode(2) and i_opcode(1) and i_opcode(0)) or (not i_opcode(6) and i_opcode(5) and not i_opcode(4) and not i_opcode(3) and not i_opcode(2) and i_opcode(1) and i_opcode(0)); -- imediatos, lw e sw

o_we <= (not i_opcode(6) and i_opcode(5) and i_opcode(4) and not i_opcode(3) and not i_opcode(2) and i_opcode(1) and i_opcode(0)) or (not i_opcode(6) and not i_opcode(5) and i_opcode(4) and not i_opcode(3) and not i_opcode(2) and i_opcode(1) and i_opcode(0)) or (not i_opcode(6) and not i_opcode(5) and not i_opcode(4) and not i_opcode(3) and not i_opcode(2) and i_opcode(1) and i_opcode(0)) or (i_opcode(6) and i_opcode(5) and not i_opcode(4) and i_opcode(3) and i_opcode(2) and i_opcode(1) and i_opcode(0));

o_imm(2) <= i_opcode(6) and i_opcode(5) and not i_opcode(4) and i_opcode(3) and i_opcode(2) and i_opcode(1) and i_opcode(0); -- jal

o_imm(1) <= i_opcode(6) and i_opcode(5) and not i_opcode(4) and not i_opcode(3) and not i_opcode(2) and i_opcode(1) and i_opcode(0); -- branches

o_imm(0) <= not i_opcode(6) and i_opcode(5) and not i_opcode(4) and not i_opcode(3) and not i_opcode(2) and i_opcode(1) and i_opcode(0); -- sw

o_ifid_flush <= (i_opcode(6) and i_opcode(5) and not i_opcode(4) and i_opcode(3) and i_opcode(2) and i_opcode(1) and i_opcode(0)) or (i_opcode(6) and i_opcode(5) and not i_opcode(4) and not i_opcode(3) and i_opcode(2) and i_opcode(1) and i_opcode(0)); -- jal and JALR

o_lui <= not i_opcode(6) and i_opcode(5) and i_opcode(4) and not i_opcode(3) and i_opcode(2) and i_opcode(1) and i_opcode(0); -- lui

o_auipc <= not i_opcode(6) and not i_opcode(5) and i_opcode(4) and not i_opcode(3) and i_opcode(2) and i_opcode(1) and i_opcode(0); -- auipc

o_JALR_sel <= i_opcode(6) and i_opcode(5) and not i_opcode(4) and not i_opcode(3) and i_opcode(2) and i_opcode(1) and i_opcode(0);

end arch_control;