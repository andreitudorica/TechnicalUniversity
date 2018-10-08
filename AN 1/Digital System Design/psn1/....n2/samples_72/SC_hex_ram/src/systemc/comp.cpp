#include <systemc.h>
#include <stdio.h>
#include "comp.h"

//------------------------------------------------------------------------
void ASCII_DEC::Decode()
{
	IS_HEX = sc_logic('1');
	switch(CHR) {
	case '0':
	case '1':
	case '2':
	case '3':
	case '4':
	case '5':
	case '6':
	case '7':
	case '8':
	case '9':
		DGT = CHR & 0x0F;
		break;
	case 'A':
	case 'B':
	case 'C':
	case 'D':
	case 'E':
	case 'F':
		DGT = (CHR & 0x0F) + 9;
		break;
	default:
		IS_HEX = sc_logic('0');
		DGT = 0;
	}
	if(CHR == ':')
		SC = sc_logic('1');
	else
		SC = sc_logic('0');
}
//------------------------------------------------------------------------
void CD4029::LD4029()
{
	if(LD.read() == '1')
		Q = D;
}
//------------------------------------------------------------------------
void CD4029::CLK4029()
{
sc_uint<4> CNT;
	if(LD.read() == '0' && CLK.event() && CLK.read() == '1')
	{
		if(CE.read()=='1')
		{
			CNT = Q;
			if(UP.read()=='1')
			{
				CNT++;
				if(BCD.read()=='1')
					if(CNT==10) CNT = 0;
			}
			else
			{
				CNT--;
				if(BCD.read()=='1')
					if(CNT==15) CNT = 9;
			}
			Q = CNT;
		}
	}
}
//------------------------------------------------------------------------
void CD4029::CEO4029()
{	
	if(CE.read()==sc_logic('1'))
	{
		if(UP.read()== sc_logic('1'))
		{
			if(BCD.read() == sc_logic('1'))
			{
				if(Q.read() == "1001")
					CEO = sc_logic('1');
				else
					CEO = sc_logic('0');
			}
			else
			{
				if(Q.read() == "1111")
					CEO = sc_logic('1');
				else
					CEO = sc_logic('0');
			}
		}
		else
		{
			if(Q.read() == "0000")
				CEO = sc_logic('1');
			else
				CEO = sc_logic('0');
		}
	}
	else
		CEO = sc_logic('0');
}
//------------------------------------------------------------------------
void ADDR_CNT::Q_MAP()
{
	Q.write((QI[3].read(),QI[2].read(),QI[1].read(),QI[0].read()));
}
//------------------------------------------------------------------------
void DAT_CNT::CO_ZD()
{
	if(QI[0].read() == "0000" && QI[1].read() == "0000")
		ZD = sc_logic('1');
	else
		ZD = sc_logic('0');
}
//------------------------------------------------------------------------
void DAT_CNT::AddToTrace(sc_trace_file *tf)
{
char s[255];
	printf("Module name: %s(%s)\n",name(),basename());
	sprintf(s,"QI(0)_%s(%s)",name(),basename());
	printf(" %s\n",s);
	sc_trace(tf,QI[0],s);
	sprintf(s,"QI(1)_%s(%s)",name(),basename());
	printf(" %s\n",s);
	sc_trace(tf,QI[1],s);
}
//------------------------------------------------------------------------
void REG_48::REG_CLK()
{
	if(CLR.read() == '1')
	{
		QI[0] = "0000";		
		QI[1] = "0000";		
	}
	else
	{
		if(CLK.event() && CLK.read()=='1')
		{
			if(CE[0].read()=='1')
				QI[0] = D;
			if(CE[1].read()=='1')
				QI[1] = D;
		}
	}
	Q = (QI[1],QI[0]);
}
//------------------------------------------------------------------------
void SUB::SUB_CLK()
{
sc_uint<8> QI,AI;	
	if(CLK.event() && CLK.read()=='1')
	{
		if(CE.read() == '1')
		{
			QI = Q;
			AI = A;
			QI = QI - AI;
			Q = QI;
		}
	}
}
//------------------------------------------------------------------------
void CMP::CMP_AB()
{
	if(A.read() == B.read())
		EQ = sc_logic('1');
	else
		EQ = sc_logic('0');
}
//------------------------------------------------------------------------
void REG_4::REG_4_CLK()
{
	if(CLK.event() && CLK.read() == '1')
	{
		if(CE.read() == '1')
			Q = D;
	}
}
//------------------------------------------------------------------------
void IHEX_FSM::FSM_CLK()
{
	if(CLR.read() == '1')
		Q = IDLE;
	else
	{
		if(CLK.event() && CLK.read() == '1')
		{
			if(EN.read() == '1')
				Q = next_Q;
		}
	}	
}
//------------------------------------------------------------------------
void IHEX_FSM::FSM_NEXT_Q()
{
	for(i=0;i<2;i++)
	{
		LRC[i] = sc_logic('0');
		ALE[i] = sc_logic('0');
		DLE[i] = sc_logic('0');
		CLE[i] = sc_logic('0');
	}
	for(;i<4;i++)
	{
		LRC[i] = sc_logic('0');
		ALE[i] = sc_logic('0');
	}
	switch(Q) {
	case IDLE:
		if(SC.read() == '1')
			next_Q = DCH;
		break;
	case DCH:
		CLE[1] = sc_logic('1');
		if(IS_HEX.read() == '1')
			next_Q = DCL;
		else
			next_Q = ERR;
		break;
	case DCL:
		CLE[0] = sc_logic('1');
		if(IS_HEX.read() == '1')
			next_Q = ADHH;
		else
			next_Q = ERR;		
		break;
	case ADHH:
		ALE[3] = sc_logic('1');
		if(IS_HEX.read() == '1')
			next_Q = ADHL;
		else
			next_Q = ERR;	
		break;
	case ADHL:
		ALE[2] = sc_logic('1');
		if(IS_HEX.read() == '1')
			next_Q = ADLH;
		else
			next_Q = ERR;	
		break;
	case ADLH:
		ALE[1] = sc_logic('1');
		if(IS_HEX.read() == '1')
			next_Q = ADLL;
		else
			next_Q = ERR;	
		break;
	case ADLL:
		ALE[0] = sc_logic('1');
		if(IS_HEX.read() == '1')
			next_Q = EMH;
		else
			next_Q = ERR;	
		break;
	case EMH:
		if(IS_HEX.read() == '1')
			next_Q = EML;
		else
			next_Q = ERR;	
		break;
	case EML:
		if(IS_HEX.read() == '1')
			if(TDC.read() == '0')
				next_Q = DH;
			else
				next_Q = LRCH;
		else
			next_Q = ERR;	
		break;
	case DH:
		DLE[1] = sc_logic('1');
		if(IS_HEX.read() == '1')			
			next_Q = DL;
		else
			next_Q = ERR;	
		break;
	case DL:
		DLE[0] = sc_logic('1');
		if(IS_HEX.read() == '1')
		{
			if(TDC.read() == '0')
				next_Q = DH;
			else
				next_Q = LRCH;
		}
		else
			next_Q = ERR;	
		break;
	case MEMW:
		break;
	case LRCH:
		if(IS_HEX.read() == '1')
			next_Q = LRCL;
		else
			next_Q = ERR;	
		break;
	case LRCL:
		if(IS_HEX.read() == '1')
			next_Q = IDLE;
		else
			next_Q = ERR;	
		break;
	case CMPLRC:
		break;
	case ERR:
		next_Q = IDLE;
	}
}
//------------------------------------------------------------------------
void RAM64K::ReadRAM()
{
	if(OE.read() == '1')
	{
		DATA = m[ADDR.read().to_long()];
	}
	else
		DATA = "ZZZZZZZZ";
}
//------------------------------------------------------------------------
void RAM64K::WriteRAM()
{
	if((WE.read() == '1') && (OE.read() == '0'))
	{
		m[ADDR.read().to_long()] = DATA.read().to_long();
	}
}
//------------------------------------------------------------------------
int RAM64K::StoreRAM(char *fn, int len)
{
FILE *fh;
	printf("Memory store...");
	fh = fopen(fn,"wb");
	if( len > 65536)
	{
		printf("error: Length excess memory size!\n");
		return 0;
	}
	if(fh)
	{
		fwrite(&m,1,len,fh);
		fclose(fh);
		printf("completed succesfuly\n");
		return 1;
	}
	printf("error: Can't create dump file!\n");
	return 0;
}
//------------------------------------------------------------------------
int RAM64K::LoadRAM(char *fn, int len)
{
FILE *fh;	
	printf("Memory load...");
	if( len > 65536)
	{
		printf("error: Length excess memory size!\n");
		return 0;
	}
	fh = fopen(fn,"rb");
	if(fh)
	{
		fread(&m,1,len,fh);
		fclose(fh);
		printf("completed succesfuly\n");
		return 1;
	}
	printf("error: Can't create dump file!\n");
	return 0;	
}
//------------------------------------------------------------------------
