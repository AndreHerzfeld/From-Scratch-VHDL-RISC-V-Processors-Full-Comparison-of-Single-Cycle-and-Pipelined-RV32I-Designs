library IEEE;

use ieee.std_logic_1164.all;

entity F_MEM is
port(

----------
-- Inputs
----------

	-- Control line for MEM
	i_MemRead :  in  std_logic;
	i_MemWrite:  in  std_logic;
	
	-- Control lines for WB
	i_WE  	   :  in std_logic;
	i_MemToReg  :  in std_logic;
	
	-- RAM Address
	i_ALU_Result  :  in std_logic_vector (31 downto 0);
	
	-- Ram Data in
	i_RD2  :  in std_logic_vector (31 downto 0);
	
	-- RD
	i_RD  :  in std_logic_vector (4 downto 0); -- Utilized in either MEM and WB stages
	
	i_CLK  :  in std_logic; -- RAM's clock
	
----------
-- Outputs
----------

	-- Control lines
	o_WE  	   :  out std_logic;
	o_MemToReg  :  out std_logic;
	
	-- ALU Result
	o_ALU_Result:  out std_logic_vector (31 downto 0);
	
	-- Memory data out
	o_MEM    	:  out std_logic_vector (31 downto 0);
	
	-- RD
	o_RD  :  out std_logic_vector (4 downto 0)
);
end F_MEM;	

architecture arch_MEM of F_MEM is

component RAM is
	port
	(
		address		: IN STD_LOGIC_VECTOR (8 DOWNTO 0);
		byteena		: IN STD_LOGIC_VECTOR (3 DOWNTO 0) :=  (OTHERS => '1');
		clken		: IN STD_LOGIC  := '1';
		clock		: IN STD_LOGIC  := '1';
		data		: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		rden		: IN STD_LOGIC  := '1';
		wren		: IN STD_LOGIC ;
		q		: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
	);
end component;

signal w_enable_ram  :  std_logic;

signal w_addr  :  std_logic_vector (8 downto 0);

begin

w_enable_ram <= i_MemRead or i_MemWrite;

w_addr <= i_ALU_Result(10 downto 2);

-- Main memory unit
		u_RAM  :  RAM
		port map(
				address => w_addr,
				byteena => "1111",
				clken   => w_enable_ram,
				clock   => i_CLK,
				data    => i_RD2,
				rden    => i_MemRead,
				wren    => i_MemWrite,
				q       => o_MEM
);

--------------------------------
-- EXE Outputs
--------------------------------

-- WB Control lines
o_WE 		  <= i_WE;
o_MemToReg <= i_MemToReg;

-- RD
o_RD <= i_RD;

-- ALU Result
o_ALU_Result <= i_ALU_Result;

end arch_MEM;