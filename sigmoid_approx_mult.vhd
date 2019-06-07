library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use ieee.fixed_pkg.all;

entity sigmoid_approx_mult is
  generic (
  	left	: positive := 7;
  	right : integer  := -24);
  port (
		clk 			: in  std_logic;
		rst 			: in  std_logic;
		x					: in  sfixed(left downto right);
		x_pos 		: in  std_logic;									
		m					: in  sfixed(left downto right);
		b					: in  sfixed(left downto right);	
		x_pos_out : out std_logic;									--pass-through
		b_out			: out sfixed(left downto right);  --pass-through
		mx				: out sfixed(left downto right));
end sigmoid_approx_mult;

architecture SIG_ARCH of sigmoid_approx_mult is
begin

	p_MULT : process(clk, rst)
		-- Multiplication
	  -- sfixed(a downto b) * sfixed(c downto d) = sfixed(a+c+1 downto b+d)
		variable temp 	: sfixed(left+left+1 downto right+right);
	begin
		if rst = '1' then
			x_pos_out <= '0';
			b_out 		<= to_sfixed(0, x);
			mx 				<= to_sfixed(0, x);
		elsif (clk = '1' and clk'event) then
			--pass-through
			x_pos_out <= x_pos;
			b_out <= b;

			temp := m*x;
			mx   <= temp(left downto right);
		end if ;
	end process ;

end SIG_ARCH;