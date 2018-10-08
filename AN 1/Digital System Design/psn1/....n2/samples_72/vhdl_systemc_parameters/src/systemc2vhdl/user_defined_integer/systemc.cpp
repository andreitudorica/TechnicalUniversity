
#include "systemc.h"

class inst:public sc_foreign_module
{
  public:

  inst(sc_module_name nm, unsigned generic_inst = 0, const char **generic_list = NULL):
    sc_foreign_module(nm, "inst", generic_inst, generic_list)
    {
    }
};


SC_MODULE(top)
{

    inst *_uut;

    SC_CTOR(top)
    {
        const char *generics1[] = {
            ("p=55")
        };

        _uut = new inst("uut", 1, generics1);

    }
};

SC_MODULE_EXPORT(top);
