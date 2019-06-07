library ieee;
use ieee.std_logic_1164.all;

use work.config_pkg.all;
use work.user_pkg.all;

entity user_app is
	port(
		clk : in std_logic;
		rst : in std_logic;

		-- memory map interface
		mmap_wr_en		: in  std_logic;
		mmap_wr_addr	: in  std_logic_vector(MMAP_ADDR_RANGE); -- 18-1 downto 0
		mmap_wr_data	: in  std_logic_vector(MMAP_DATA_RANGE); -- 32-1 downto 0
		mmap_rd_en		: in  std_logic;
		mmap_rd_addr	: in  std_logic_vector(MMAP_ADDR_RANGE); -- 18-1 downto 0
		mmap_rd_data	: out std_logic_vector(MMAP_DATA_RANGE));
end user_app;

architecture default of user_app is

	signal go 										: std_logic;
	signal size 									: std_logic_vector(C_MEM_ADDR_WIDTH downto 0);
	signal done 									: std_logic;
	signal addr_size 							: std_logic_vector(C_MEM_ADDR_WIDTH-1 downto 0);
	signal addr_en 								: std_logic;

	signal mem_in_wr_data
	signal mem_in_wr_addr       	: std_logic_vector(C_MEM_ADDR_WIDTH-1 downto 0);
	signal mem_in_rd_data       	: std_logic_vector(C_MEM_IN_WIDTH-1 downto 0);
	signal mem_in_rd_addr       	: std_logic_vector(C_MEM_ADDR_WIDTH-1 downto 0);
	signal mem_in_wr_en         	: std_logic;
	signal mem_in_rd_addr_valid 	: std_logic;

	signal mem_out_wr_data       	: std_logic_vector(C_MEM_OUT_WIDTH-1 downto 0);
	signal mem_out_wr_addr       	: std_logic_vector(C_MEM_ADDR_WIDTH-1 downto 0);
	signal mem_out_rd_data       	: std_logic_vector(C_MEM_OUT_WIDTH-1 downto 0);
	signal mem_out_rd_addr       	: std_logic_vector(C_MEM_ADDR_WIDTH-1 downto 0);
	signal mem_out_wr_en         	: std_logic;
	signal mem_out_wr_data_valid 	: std_logic;
	signal mem_out_done          	: std_logic;

	signal class0_sig 						: sfixed(7 downto -24);
	signal class1_sig 						: sfixed(7 downto -24);
	signal class2_sig 						: sfixed(7 downto -24);

	signal feature_size 					: ufixed(2 downto -5)

begin
	
	------------------------------------------------
	-- Memory Map
	-- 	Description
	------------------------------------------------
	U_MMAP : entity work.memory_map
		port map(
			clk 						=> clk,
			rst 						=> rst,
			wr_en 					=> mmap_wr_en,
			wr_addr 				=> mmap_wr_addr,
			wr_data 				=> mmap_wr_data,
			rd_en 					=> mmap_rd_en,
			rd_addr 				=> mmap_rd_addr,
			rd_data 				=> mmap_rd_data,

			--
			go 							=> go,
			size 						=> size,
			done 						=> done,
			mem_in_wr_data	=> mem_in_wr_data,
			mem_in_wr_addr	=> mem_in_wr_addr,
			mem_in_wr_en		=> mem_in_wr_en,
			mem_out_rd_data	=> mem_out_rd_data,
			mem_out_rd_addr	=> mem_out_rd_addr
			);

	U_MEM_IN : entity work.ram(SYNC_READ)
		generic map(
			num_words  => 2**C_MEM_ADDR_WIDTH,
			word_width => C_MEM_IN_WIDTH,
			addr_width => C_MEM_ADDR_WIDTH)
		port map(
			clk   		=> clk,
			-- write
			wen   		=> mem_in_wr_en,
			waddr 		=> mem_in_wr_addr,
			wdata 		=> mem_in_wr_data,
			-- read
			raddr 		=> mem_in_rd_addr,
			rdata 		=> mem_in_rd_data
			);

	U_MEM_OUT : entity work.ram(SYNC_READ)
		generic map(
			num_words  => 2**C_MEM_ADDR_WIDTH,
			word_width => C_MEM_OUT_WIDTH,
			addr_width => C_MEM_ADDR_WIDTH)
		port map(
			clk   		=> clk,
			-- write
			wen   		=> mem_out_wr_en,
			waddr 		=> mem_out_wr_addr,
			wdata 		=> mem_out_wr_data,
			-- read
			raddr 		=> mem_out_rd_addr,
			rdata 		=> mem_out_rd_data
			);

	U_CTRL : entity work.ctrl
		port map(
			clk 			=> clk,
			rst 			=> rst,
			go 				=> go,
			size 			=> size,
			addr_done	=> done,
			addr_size	=> addr_size,
			addr_en 	=> addr_en
			);

	U_NN : entity work.nn_top(nn)
		generic map(
			left				: positive := 7;
			right				: integer  := -24)
		port map(
			clk 			=> clk,
			rst 			=> rst,
			en  			=> '1',
			feature0	=> to_ufixed(mem_in_rd_data(7 downto 0), feature_size),
			feature1	=> to_ufixed(mem_in_rd_data(15 downto 8), feature_size),
			feature2	=> to_ufixed(mem_in_rd_data(23 downto 16), feature_size),
			feature3	=> to_ufixed(mem_in_rd_data(31 downto 24), feature_size),
			class0		=> class0_sig,
			class1		=> class1_sig,
			class2		=> class2_sig
			);

	U_ADDR_GEN_IN : entity work.addr_gen
		generic map(
			addr_width)
		port map(
			inc 		=> in_inc,
			en 			=> en,
			rst 		=> rst,
			address	=> address
			);

	U_ADDR_GEN_OUT : entity work.addr_gen
		generic map(
			addr_width)
		port map(
			inc 		=> out_inc,
			en 			=> en,
			rst 		=> rst,
			address	=> address
			);

end default;