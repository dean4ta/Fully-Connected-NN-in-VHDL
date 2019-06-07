library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use ieee.fixed_pkg.all;

entity sigmoid_approx_bias1 is
  generic (
  	left	: positive := 7;
  	right : integer  := -24);
  port (
		clk 			: in  std_logic;
		rst 			: in  std_logic;
		mx_b_in		: in  sfixed(left downto right);
		x_pos 		: in  std_logic;
		y					: out sfixed(left downto right));
end sigmoid_approx_bias1;

architecture SIG_ARCH of sigmoid_approx_bias1 is
begin
	p_BIAS : process(clk, rst)
		variable temp  : sfixed(left+1 downto right);
	begin
		if rst = '1' then
			y	<= to_sfixed(0, mx_b_in);
		elsif (clk = '1' and clk'event) then
			if x_pos = '1' then
				y <= mx_b_in;
			else
				temp := 1-mx_b_in;
				y <= temp(left downto right);
			end if ;
		end if ;
	end process ;

end SIG_ARCH;