library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use ieee.fixed_pkg.all;

entity add is
	generic (
		left	: positive := 7;
		right	: integer  := -24);
  port (
    clk		: in  std_logic;
    rst 	: in  std_logic;
    in1   : in  sfixed(left downto right);
    in2   : in  sfixed(left downto right);
    sum   : out sfixed(left downto right));
end add;

architecture GOOD_ADD of add is
begin  -- GOOD_ADD

  process(clk, rst)
		variable temp : sfixed(left+1 downto right);
  begin
  	if rst = '1' then
  		sum <= to_sfixed(0, in1);
  	elsif (clk = '1' and clk'event) then
  		temp := in1+in2;
  		sum  <= temp(left downto right);
  	end if ;
  end process ; -- fp_adder

end GOOD_ADD;

