library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use ieee.fixed_pkg.all;

entity reg is
  generic (
    left      : positive := 7;
    right     : integer  := -24);
  port(
    clk       : in  std_logic;
    rst       : in  std_logic;
    en        : in  std_logic;
    input     : in  sfixed(left downto right);
    output    : out sfixed(left downto right));
end reg;

architecture bhv of reg is
begin
  process(clk, rst)
  begin
    if rst = '1' then
      output   <= (others => '0');
    elsif (clk = '1' and clk'event) then
      if (en = '1') then
        output <= input;
      end if;
    end if;
  end process;
end bhv;
