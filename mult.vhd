library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use ieee.fixed_pkg.all;

entity mult is
	generic (
		left	: positive := 7;
		right	: integer  := -24);
  port (
    clk		: in  std_logic;
    rst 	: in  std_logic;
    in1   : in  sfixed(left downto right);
    in2   : in  sfixed(left downto right);
    prod  : out sfixed(left downto right));
end mult;

architecture GOOD3 of mult is
begin  -- GOOD3

  process(clk, rst)
    -- Multiplication
    -- sfixed(a downto b) * sfixed(c downto d) = sfixed(a+c+1 downto b+d)
		variable temp : sfixed(left+left+1 downto right+right);
  begin
  	if rst = '1' then
  		prod <= to_sfixed(0, in1);
  	elsif (clk = '1' and clk'event) then
  		temp := in1*in2;
  		prod <= temp(left downto right);
  	end if ;
  end process ; -- fp_multer

end GOOD3;