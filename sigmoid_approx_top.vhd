library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

use ieee.fixed_pkg.all;

entity sigmoid_approx_top is
  generic (
  	left	: positive := 7;
  	right : integer  := -24);
  port (
		clk : in  std_logic;
		rst : in  std_logic;
		x		: in  sfixed(left downto right);
		y		: out sfixed(left downto right));
end sigmoid_approx_top;

architecture SIG_ARCH of sigmoid_approx_top is

------------------------------------------------
------signal declarations from components-------
------------------------------------------------

	--sigmoid_approx_range sigs
	signal x_pos_range 	: std_logic;
	signal x_range 			: sfixed(left downto right);
	signal m_range 			: sfixed(left downto right);
	signal b_range 			: sfixed(left downto right);

	--sigmoid_approx_mult sigs
	signal x_pos_mult 	: std_logic;
	signal mx_mult 			: sfixed(left downto right);
	signal b_mult 			: sfixed(left downto right);

	--sigmoid_approx_bias0 sigs
	signal x_pos_bias0 	: std_logic;
	signal mx_b_bias0		: sfixed(left downto right);

begin

	------------------------------------------------
	-- Determine Range
	------------------------------------------------	
	U_SIG_RANGE : entity work.sigmoid_approx_range
	generic map(
		left	=> left,
		right	=> right)
	port map(
		clk 	=> clk,
		rst 	=> rst,
		x			=> x,
		x_pos	=> x_pos_range,
		x_out	=> x_range,
		m			=> m_range,
		b			=> b_range);

	------------------------------------------------
	-- Multiply m * x = mx
	------------------------------------------------
	U_SIG_MULT : entity work.sigmoid_approx_mult
	generic map(
		left	=> left,
		right	=> right)
	port map(
		clk 			=> clk,
		rst 			=> rst,
		x					=> x_range,
		x_pos 		=> x_pos_range,
		m					=> m_range,
		b					=> b_range,
		x_pos_out => x_pos_mult,
		b_out			=> b_mult,
		mx				=> mx_mult);

	------------------------------------------------
	-- Add mx + b = mx_b
	------------------------------------------------
	U_SIG_BIAS0 : entity work.sigmoid_approx_bias0
	generic map(
		left	=> left,
		right	=> right)
	port map(
		clk 			=> clk,
		rst 			=> rst,
		mx				=> mx_mult,
		x_pos 		=> x_pos_mult,
		b					=> b_mult,
		mx_b			=> mx_b_bias0,
		x_pos_out	=> x_pos_bias0);

	------------------------------------------------
	-- determine sign
	------------------------------------------------
	U_SIG_BIAS1 : entity work.sigmoid_approx_bias1
	generic map(
		left	=> left,
		right	=> right)
	port map(
		clk 			=> clk,
		rst 			=> rst,
		mx_b_in		=> mx_b_bias0,
		x_pos 		=> x_pos_bias0,
		y					=> y);


end SIG_ARCH;