library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use ieee.fixed_pkg.all;

entity sigmoid_approx_range is
  generic (
  	left	: positive := 7;
  	right : integer  := -24);
  port (
		clk 	: in  std_logic;
		rst 	: in  std_logic;
		x			: in  sfixed(left downto right);
		x_pos	: out std_logic;									
		x_out	: out sfixed(left downto right);	--pass-through
		m			: out sfixed(left downto right);
  	b			: out sfixed(left downto right));
end sigmoid_approx_range;

architecture SIG_ARCH of sigmoid_approx_range is
begin

	p_CHECK_SIGN : process(clk, rst)
		variable x_sig			: sfixed(left downto right);
	begin

		if rst = '1' then
			m 		<= to_sfixed(0, x);
			b 		<= to_sfixed(0, x);
			x_out <= to_sfixed(0, x);
			x_pos <= '0';
		elsif (clk = '1' and clk'event) then

			-- check sign and correct if neccessary 
			if (x >= 0) then
				x_pos <= '1';
				x_sig := x;
				--pass-through
				x_out <= x_sig;
			else -- x is negatice
				x_pos <= '0';
				x_sig := resize(x * to_sfixed(-1, x), x);
				--pass-through
				x_out <= x_sig;
			end if ;

			-- assign slope and intercept values
			if (x_sig < 0.89) then 		--y1
				m <= to_sfixed(0.234708059063, x);
				b <= to_sfixed(0.5, x);
			elsif (x_sig < 1.58) then --y2
				m <= to_sfixed(0.174368616538, x);
				b <= to_sfixed(0.553702103847, x);
			elsif (x_sig < 2.13) then --y3
				m <= to_sfixed(0.117419073359, x);
				b <= to_sfixed(0.643682382071, x);
			elsif (x_sig < 2.80) then --y4
				m <= to_sfixed(0.0729713668303, x);
				b <= to_sfixed(0.738355996976, x);
			elsif (x_sig < 3.60) then --y5
				m <= to_sfixed(0.0384089779025, x);
				b <= to_sfixed(0.835130685974, x);
			elsif (x_sig < 4.64) then --y6
				m <= to_sfixed(0.0163766104854, x);
				b <= to_sfixed(0.914447208676, x);
			elsif (x_sig < 6.40) then --y7
				m <= to_sfixed(0.00449233954086, x);
				b <= to_sfixed(0.969590225858, x);
			else 											--y8
				m <= to_sfixed(0, x);
				b <= to_sfixed(1, x);
			end if ;

		end if ;
	end process ; -- p_CHECK_SIGN

end SIG_ARCH;