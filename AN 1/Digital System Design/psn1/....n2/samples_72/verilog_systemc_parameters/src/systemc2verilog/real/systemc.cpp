
#include "systemc.h"

class inst:public sc_foreign_module
{
  public:
    sc_in < sc_logic > clk;

  inst(sc_module_name nm, unsigned generic_inst = 0, const char **generic_list = NULL):
    sc_foreign_module(nm, "inst", generic_inst, generic_list), clk("clk")
    {
    }
};

SC_MODULE(top)
{
    sc_signal < sc_logic > clok;

    inst *_uut;

    SC_CTOR(top)
    {
        const char *generics1[] = {
            ("p=15.99")
        };

        _uut = new inst("uut", 1, generics1);
        _uut->clk(clok);

    }
};

SC_MODULE_EXPORT(top);
