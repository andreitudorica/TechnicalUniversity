#include "transactor.h"
#include <systemc.h>


void transactor::initialize()
{
	reset.write(sc_logic_1);
	tx.write(sc_logic_1);
	for (int j=0; j<4 ; j++)
	{
		wait(clk.posedge_event());
	}
	reset.write(sc_logic_0);
}


void transactor::send_message (char *msg)
{
	int i = 0;

	while (msg[i]!='\0')
	{
		wait(clk.posedge_event());
		tx.write(sc_logic_0);

		char c = msg[i];

		for (int j=0; j<8 ; j++)
		{
			wait(clk.posedge_event());
			(c>>j & 1) ? tx.write(sc_logic_1) : tx.write(sc_logic_0);
		}

		wait(clk.posedge_event());
		tx.write(sc_logic_1);

		i++;
	}
}

void transactor::terminate()
{
	for (int i=0; i<2; i++)
	{
		wait(clk.posedge_event());
	}
	sc_stop();
}
