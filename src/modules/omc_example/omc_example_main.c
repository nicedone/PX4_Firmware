
#include "src/modules/omc_example/Controller.c"

/* call the simulation runtime main from our main! */
int omc_example_main(int argc, char **argv)
{
	int res;
	DATA data;
	MODEL_DATA modelData;
	SIMULATION_INFO simInfo;
	data.modelData = &modelData;
	data.simulationInfo = &simInfo;
	measure_time_flag = 0;
	compiledInDAEMode = 0;
	compiledWithSymSolver = 0;
	MMC_INIT(0);
	omc_alloc_interface.init();
	{
		MMC_TRY_TOP()

		MMC_TRY_STACK()

		Controller_setupDataStruc(&data, threadData);
		res = _main_SimulationRuntime(argc, argv, &data, threadData);

		MMC_ELSE()
		rml_execution_failed();
		fprintf(stderr,
			"Stack overflow detected and was not caught.\nSend us a bug report at https://trac.openmodelica.org/OpenModelica/newticket\n    Include the following trace:\n");
		printStacktraceMessages();
		fflush(NULL);
		return 1;
		MMC_CATCH_STACK()

		MMC_CATCH_TOP(return rml_execution_failed());
	}

	return res;
}
