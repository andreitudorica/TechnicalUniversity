entity bcd_zecimal is
	port (Q3,Q2,Q1,Q0: in bit;
	  	  Y9,Y8,Y7,Y6,Y5,Y4,Y3,Y2,Y1,Y0 :out bit);
end bcd_zecimal;

architecture arh_bcd_zecimal of bcd_zecimal is
begin						
	Y0<=not(Q3)and not(Q2) and not(Q1) and not(Q0);
	Y1<=not(Q3)and not(Q2) and not(Q1) and Q0;
	Y2<=not(Q3)and not(Q2) and  Q1 and not(Q0);
	Y3<=not(Q3)and not(Q2) and Q1 and Q0;
	Y4<=not(Q3)and Q2 and not(Q1) and not(Q0);
	Y5<=not(Q3)and not Q2 and not(Q1) and Q0; 
	Y6<=not(Q3)and Q2 and Q1 and not(Q0);
	Y7<=not(Q3)and Q2 and Q1 and Q0;
	Y8<=Q3 and not(Q2) and not(Q1) and not(Q0);
	Y9<=Q3 and not(Q2) and not(Q1) and Q0;	  
end arh_bcd_zecimal;

	
	