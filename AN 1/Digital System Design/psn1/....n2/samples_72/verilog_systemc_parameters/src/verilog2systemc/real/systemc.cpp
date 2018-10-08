
#include <systemc.h>
#include <iostream>

SC_MODULE(inst)
{
  public:
    sc_in < sc_logic > p;

  SC_CTOR(inst):
    p("p")
    {

        register_real_parameter("g");
    }

    void end_of_elaboration()
    {
        double g = 0;
        sc_get_param("g", g);

        cout << "modul::end_of_elaboration   g = " << g << endl;

    }

};

SC_MODULE_EXPORT(inst);
