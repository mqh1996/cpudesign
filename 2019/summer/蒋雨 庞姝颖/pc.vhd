library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
entity pc is
	port(
		clk:in std_logic;
		auipc: in std_logic;
		jal:in std_logic;
		jalr:in std_logic;
		be:in std_logic;
		jud:in std_logic;
		jum:in std_logic_vector(7 downto 0);
		load: in std_logic;
	    store: in std_logic;
		q:out std_logic_vector(7 downto 0));
end pc;
architecture test of pc is
	signal lx:std_logic:='0';
	signal q1:std_logic_vector(7 downto 0):="00000000";
	begin
	process(clk)
	variable tem:std_logic_vector(31 downto 0);
	begin
		if(clk'event and clk='1') then
		   if(auipc='1' or jal='1') then
		   q1<=q1+jum; 
		   elsif(jalr='1') then
           q1<=jum;
		   elsif(be='1' and jud='1') then
		   q1<=q1+jum;
           elsif(load='1' or store='1') then
		   if(lx='1') then
		   q1<=q1+1;
		   end if;
	       case lx is
		   when '0'=>
		   lx<='1';
		   when '1'=>
		   lx<='0';
		   end case;
		   else
		   q1<=q1+1;
		   end if;
		end if;
	end process;
	q<=q1;
end test;