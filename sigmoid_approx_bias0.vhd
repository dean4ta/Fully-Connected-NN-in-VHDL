library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use ieee.fixed_pkg.all;

entity sigmoid_approx_bias0 is
  generic (
  	left	: positive := 7;
  	right : integer  := -24);
  port (
		clk 			: in  std_logic;
		rst 			: in  std_logic;
		mx				: in  sfixed(left downto right);
		x_pos 		: in  std_logic;									
		b					: in  sfixed(left downto right);	
		mx_b			: out sfixed(left downto right);
		x_pos_out	: out std_logic);									
end sigmoid_approx_bias0;

architecture SIG_ARCH of sigmoid_approx_bias0 is
begin
	p_BIAS : process(clk, rst)
		variable temp  : sfixed(left+1 downto right);
	begin
		if rst = '1' then
			mx_b	<= to_sfixed(0, mx);
		elsif (clk = '1' and clk'event) then
			x_pos_out <= x_pos;
			temp  := mx+b;
			mx_b  <= temp(left downto right);
		end if ;
	end process ;

end SIG_ARCH;