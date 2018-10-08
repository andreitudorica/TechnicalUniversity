library ieee;
use ieee.std_logic_1164.all;

entity rcv_reg is
  generic
  (
    dw : integer := 9
  );
  port
  (
    clk : in std_logic;
    set : in std_logic;
    sin : in std_logic;
    do  : out std_logic_vector(dw+1 downto 0)
  );
end rcv_reg;


architecture rtl of rcv_reg is

  constant all_set : std_logic_vector(dw downto 0) := (others => '1');
  signal di        : std_logic_vector(dw+1 downto 0);

begin

  process (clk)
  begin

    if rising_edge(clk) then

      if set = '1' then
        di <= sin & all_set;
      else
        di <= sin & di(di'left downto di'right+1);
      end if;

    end if;

  end process;

  do <= di;

end architecture;