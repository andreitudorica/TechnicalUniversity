	
library IEEE;  
use IEEE.STD_LOGIC_1164.ALL;  
use IEEE.STD_LOGIC_ARITH.ALL;  
use IEEE.STD_LOGIC_UNSIGNED.ALL;  

entity fifo is  
port (  clk : in std_logic;  
        enr : in std_logic;   --enable read,should be '0' when not in use.  
        enw : in std_logic;    --enable write,should be '0' when not in use.  
        dataout : out std_logic_vector(1 downto 0);    --output data  
        datain : in std_logic_vector (1 downto 0);     --input data  
        empty : out std_logic;     --set as '1' when the queue is empty  
        full : out std_logic     --set as '1' when the queue is full  
     );  
end fifo;  

architecture Behavioral of fifo is  
type memory_type is array (0 to 3) of std_logic_vector(1 downto 0);  
signal memory : memory_type :=(others => (others => '0')); --memory for queue.  
signal readptr,writeptr : std_logic_vector(1 downto 0) :="00"; --read/write pointers.  
begin  
  process(clk)  
  begin   
    if(clk'event and clk='1' and enr ='1') then  
      dataout <= memory(conv_integer(readptr));  
      --error <= '0';  
      readptr <= readptr + '1';      --points to next address.  
    end if;  
    if(clk'event and clk='1' and enw ='1') then  
      memory(conv_integer(writeptr)) <= datain;  
      writeptr <= writeptr + '1';   --points to next address.  
    end if;  
    if(readptr = "11") then      --resetting read pointer.  
      readptr <= "00";  
    end if;  
    if(writeptr = "11") then        --checking whether queue is full or not
      full <='1';  
      writeptr <= "00";  
    else  
      full <='0';  
    end if;  
    if(writeptr = "00") then   --checking whether queue is empty or not  
      empty <='1';  
    else  
      empty <='0';  
    end if;  
  end process;  
end Behavioral; 