library IEEE;
use IEEE.std_logic_1164.all;

entity fifo is
  generic
  (
    data_width  : integer := 16;
    fifo_depth  : integer := 16
  );
  port
  (
    rst       : in std_logic;
    wr_en     : in std_logic;
    wr_clk    : in std_logic;
    wr_data   : in std_logic_vector( data_width-1 downto 0 );
    rd_en     : in std_logic;
    rd_clk    : in std_logic;
    rd_data   : out std_logic_vector( data_width-1 downto 0 );
    empty     : out std_logic;
    full      : out std_logic
  );
end entity;


architecture rtl of fifo is

  type memory_type is array ( 0 to fifo_depth-1 ) of std_logic_vector(wr_data'range);

  signal memory : memory_type;

  signal wr_ptr : integer range memory'range(1);
  signal rd_ptr : integer range memory'range(1);

  signal empty_int    : std_logic;
  signal full_int     : std_logic;
  signal full_delayed : std_logic;

begin

  process ( wr_clk, rst )
  begin

    if rising_edge(wr_clk) then

      if rst='1' then
        wr_ptr       <= 0;
        full_delayed <= '0';
      elsif wr_en='1' then

        if full_delayed='0' then
          memory(wr_ptr) <= wr_data;
        end if;

        if full_int='0' then
          wr_ptr <= (wr_ptr+1) mod fifo_depth;
        end if;

        full_delayed <= full_int;

      end if;

    end if;

  end process;


  process ( rd_clk, rst )
  begin

    if rising_edge(rd_clk) then

      if rst='1' then
        rd_ptr <= 0;
      elsif rd_en='1' then

        if empty_int='0' then
          rd_ptr <= (rd_ptr+1) mod fifo_depth;
        end if;

      end if;

    end if;

  end process;

  rd_data <= memory(rd_ptr);

  empty_int <= '1' when rd_ptr=wr_ptr else
               '0';
  empty     <= empty_int;

  full_int  <= '1' when ((wr_ptr+1) mod fifo_depth)=rd_ptr else
               '0';
  full      <= full_delayed;

end architecture;