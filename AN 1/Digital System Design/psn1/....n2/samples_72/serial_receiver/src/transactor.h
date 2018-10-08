#ifndef __TRANSACTOR_H__
#define __TRANSACTOR_H__

#include <systemc.h>
#include "transactor_if.h"


class transactor : public transactor_port_if,
		public transactor_task_if
{
public:
		transactor(sc_module_name nm) : transactor_port_if(nm) {};

public:
		virtual void initialize();
		virtual void send_message (char *msg);
		virtual void terminate();
};

#endif // __TRANSACTOR_H__

