############################################################################
#
#   Copyright (c) 2015 PX4 Development Team. All rights reserved.
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# 1. Redistributions of source code must retain the above copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the above copyright
#    notice, this list of conditions and the following disclaimer in
#    the documentation and/or other materials provided with the
#    distribution.
# 3. Neither the name PX4 nor the names of its contributors may be
#    used to endorse or promote products derived from this software
#    without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
# "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
# LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS
# FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE
# COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING,
# BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS
# OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED
# AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT
# LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN
# ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.
#
############################################################################

find_program(OMC omc)

set(model_sources
	Controller_01exo.c
	Controller_02nls.c
	Controller_03lsy.c
	Controller_04set.c
	Controller_05evt.c
	Controller_06inz.c
	Controller_07dly.c
	Controller_08bnd.c
	Controller_09alg.c
	Controller_10asr.c
	Controller_11mix.c
	Controller_12jac.c
	Controller_13opt.c
	Controller_14lnz.c
	Controller_15syn.c
	Controller_16dae.c
	Controller_17inl.c
	Controller_functions.c
	Controller_records.c
	#Controller.c
)

add_custom_command(
	OUTPUT  ${model_sources} ${PX4_BINARY_DIR}/tmp/Controller_init.xml
	COMMAND ${OMC} -s ${CMAKE_CURRENT_SOURCE_DIR}/Controller.mo
	COMMAND sed -i 's/main/main2/g' Controller.c # hack to get rid of main
	COMMAND mkdir -p ${PX4_BINARY_DIR}/tmp && cp Controller_init.xml ${PX4_BINARY_DIR}/tmp
    DEPENDS Controller.mo
)

include_directories(
	src
	/usr/include/omc/c
	${CMAKE_CURRENT_BINARY_DIR}
	)

add_definitions(
	-DOPENMODELICA_XML_FROM_FILE_AT_RUNTIME
	-DOMC_MODEL_PREFIX=Controller
	-DOMC_NUM_MIXED_SYSTEMS=0
	-DOMC_NUM_LINEAR_SYSTEMS=0
	-DOMC_NUM_NONLINEAR_SYSTEMS=0
	-DOMC_NDELAY_EXPRESSIONS=0
	-DOMC_NVAR_STRING=0
	#-Dmain=omc_example_main
	#-DEXIT=void
	)

px4_add_module(
	MODULE modules__omc_example
	MAIN omc_example
	COMPILE_FLAGS
		-Wno-strict-prototypes
		-Wno-float-equal
		-Wno-missing-prototypes
		-Wno-missing-declarations
		-Wno-unused-variable
		-Wno-sign-compare
		-Wno-shadow
		-Wno-unused-function
		-Wno-clobbered
	STACK_MAIN 5700
	STACK_MAX 13000
	SRCS
		omc_example_main.c
		${model_sources}
	DEPENDS
		platforms__common
	)
	
find_library(SimulationRuntimeC NAMES SimulationRuntimeC PATHS /usr/lib/x86_64-linux-gnu/omc)


target_link_libraries(modules__omc_example
	${SimulationRuntimeC}
	)

