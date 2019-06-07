---------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.config_pkg.all;
use work.user_pkg.all;
---------------------------------------------------------------------
entity ctrl is
  port(
    clk, rst, go    : in std_logic;
    size            : in std_logic_vector(C_MEM_ADDR_WIDTH downto 0);
    addr_done       : in std_logic;
    addr_size       : out std_logic_vector(C_MEM_ADDR_WIDTH-1 downto 0);
    addr_en   : out std_logic
      );
end ctrl;
---------------------------------------------------------------------
architecture BHV of ctrl is
  type STATE_TYPE is (START,LOAD,CHECK,RESULT);
  signal state, next_state  : STATE_TYPE;
  signal size_s : std_logic_vector(C_MEM_ADDR_WIDTH downto 0);
begin
--2 process model
---------------------------------------------------------------------
  --process for state
  process(clk,rst)
  begin
    if (rst = '1') then
      state <= START;
    elsif(clk = '1' and clk'event) then
      state <= next_state;
    end if;
  end process;
---------------------------------------------------------------------
  --process for behavior
  process(go,state,size,addr_done)
  begin
---------------------------------------------------------------------
    addr_size <= std_logic_vector(resize((unsigned(size) - to_unsigned(1,C_MEM_ADDR_WIDTH)),C_MEM_ADDR_WIDTH));
    addr_en        <= '0';
    next_state     <= state;
---------------------------------------------------------------------
    case state is
---------------------------------------------------------------------
      when START =>
        if (go = '1') then
          next_state <= LOAD;
        end if;
---------------------------------------------------------------------
      when LOAD =>
				--addr_size <= std_logic_vector(resize((unsigned(size) - to_unsigned(1,C_MEM_ADDR_WIDTH)),C_MEM_ADDR_WIDTH));
        addr_en    <= '1';
        next_state <= CHECK;
---------------------------------------------------------------------
      when CHECK =>
        if (addr_done = '1') then
          next_state  <= RESULT;
        end if;
---------------------------------------------------------------------
      when RESULT =>
				if (go = '0') then
					next_state <= START;
				end if;
---------------------------------------------------------------------
      when others => null;
    end case;
  end process;
end BHV;
