#ifndef __TESTWRAPPER_H__
#define __TESTWRAPPER_H__

#include <systemc.h>
#include "test.h"
#include "transactor.h"

SC_MODULE(testwrapper)
{
	sc_in<sc_logic> clk;
	sc_out<sc_logic> reset;
	sc_out<sc_logic> tx;

	test *ptst;
	transactor *ptrans;

	SC_CTOR(testwrapper) :
		clk("clk"),
		reset("reset"),
		tx("tx")
	{
		ptst = new test("tst");
		ptrans = new transactor("trans");

		ptrans->clk(clk);
		ptrans->reset(reset);
		ptrans->tx(tx);

		ptst->transactor_interface.bind(*ptrans);
	}

	~testwrapper()
	{
		delete ptst;
		delete ptrans;
	}
};

SC_MODULE_EXPORT(testwrapper);

#endif //__TESTWRAPPER_H__

