include(qurt/px4_impl_qurt)

if ("$ENV{HEXAGON_SDK_ROOT}" STREQUAL "")
	message(FATAL_ERROR "Enviroment variable HEXAGON_SDK_ROOT must be set")
else()
	set(HEXAGON_SDK_ROOT $ENV{HEXAGON_SDK_ROOT})
endif()

set(DISABLE_PARAMS_MODULE_SCOPING TRUE)

# Get $QC_SOC_TARGET from environment if existing.
if (DEFINED ENV{QC_SOC_TARGET})
	set(QC_SOC_TARGET $ENV{QC_SOC_TARGET})
else()
	set(QC_SOC_TARGET "APQ8074")
endif()

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${PX4_SOURCE_DIR}/cmake/cmake_hexagon")
include(toolchain/Toolchain-qurt)
include(qurt_flags)
include_directories(${HEXAGON_SDK_INCLUDES})

set(config_module_list
	src/drivers/device

	#
	# System commands
	#
	src/systemcmds/param

	#
	# Library modules
	#
	src/modules/systemlib/param
	src/modules/systemlib
	src/modules/uORB

	#
	# Libraries
	#
	src/lib/mathlib
	src/lib/mathlib/math/filter
	src/lib/geo
	src/lib/geo_lookup
	src/lib/conversion
	src/lib/version
	src/lib/DriverFramework/framework

	#
	# QuRT port
	#
	src/platforms/common
	src/platforms/qurt/px4_layer
	src/platforms/posix/work_queue
	src/platforms/qurt/tests/muorb

	#
	# sources for muorb over fastrpc
	#
	src/modules/muorb/adsp
	)
