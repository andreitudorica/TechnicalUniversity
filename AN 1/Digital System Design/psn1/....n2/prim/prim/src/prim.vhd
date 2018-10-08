entity deplasare is
	port(clk,en,s1,s0:in bit;
	af3,af2,af1,af0:out bit_vector(2 downto 0));
end entity;

architecture fct_depla of deplasare is
begin
	process(clk,s1,s0)
	variable a:bit_vector(23 downto 0):="000000000000001010011100";
	variable v:integer:=0; 
	begin
	  if clk='1' and clk'event then
		  if en='1' then
			  if s1='0' and s0='0' then
				  a:=a rol 3;
		      elsif s1='0' and s0='1' then
			      a:=a ror 3;
		      elsif s1='1' and s0='0' then  
				  a:="001010011100000000000000";
		      elsif s1='1' and s0='1' then 
		          if v=0 then  a:="000000000000001010011100";
				     v:=v+1;
		          elsif v>0 and v<9 then a:=a rol 3; 
				     v:=v+1;
			      elsif v>=9 and v<17 then a:=a ror 3;
			         v:=v+1;
	                  if v=17 then v:=1; end if;
			      end if;
		      end if;
		 end if;
	  end if;
	  af3<=(a(23)& a(22)& a(21));
	  af2<=(a(20)& a(19)& a(18));
	  af1<=(a(17)& a(16)& a(15));
	  af0<=(a(14)& a(13)& a(12));  																		  
   end process;
end architecture;	
	  	