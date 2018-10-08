#ifndef __TESTER_H__
#define __TESTER_H__

#include <systemc.h>
#include "test.h"
#include "transactor.h"

SC_MODULE(tester)
{
  public :
    sc_in<sc_logic>     WR_CLK;
    sc_in<sc_logic>     RD_CLK;
    sc_in<sc_logic>     FULL;

    sc_out<sc_logic>    RST;

    sc_out<bool>        VALID;
    sc_out<sc_uint<3> > ID;
    sc_out<sc_int<12> > VALUE;


    test *ptst;
    transactor *ptrans;

    SC_CTOR(tester) :
      WR_CLK("WR_CLK"),
      RD_CLK("RD_CLK"),
      FULL("FULL"),
      RST("RST"),
      VALID("VALID"),
      ID("ID"),
      VALUE("VALUE")
    {
      ptst = new test("tst");
      ptrans = new transactor("trans");

      ptrans->WR_CLK(WR_CLK);
      ptrans->RD_CLK(RD_CLK);
      ptrans->RST(RST);
      ptrans->FULL(FULL);
      ptrans->VALID(VALID);
      ptrans->ID(ID);
      ptrans->VALUE(VALUE);

      ptst->transactor_interface.bind(*ptrans);
    }

    ~tester()
    {
      delete ptst;
      delete ptrans;
    }
};

SC_MODULE_EXPORT(tester);

#endif //__TESTER_H__
