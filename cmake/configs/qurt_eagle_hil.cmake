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
	src/drivers/boards
	src/drivers/pwm_out_sim
	src/drivers/led
	src/drivers/rgbled
	src/modules/sensors

	#
	# System commands
	#
	src/systemcmds/param
	src/systemcmds/led
	src/systemcmds/mixer

	#
	# Estimation modules
	#
	src/modules/attitude_estimator_q
	src/modules/position_estimator_inav
	src/modules/local_position_estimator
	src/modules/ekf2

	#
	# Vehicle Control
	#
	src/modules/mc_att_control
	src/modules/mc_pos_control

	#
	# Library modules
	#
	src/modules/systemlib/param
	src/modules/systemlib
	src/modules/systemlib/mixer
	src/modules/uORB
	src/modules/commander

	#
	# Libraries
	#
	src/lib/mathlib
	src/lib/mathlib/math/filter
	src/lib/geo
	src/lib/geo_lookup
	src/lib/conversion
	src/lib/led
	src/lib/terrain_estimation
	src/lib/runway_takeoff
	src/lib/tailsitter_recovery
	src/lib/controllib
	src/lib/version
	src/lib/DriverFramework/framework

	#
	# QuRT port
	#
	src/platforms/common
	src/platforms/qurt/px4_layer
	src/platforms/posix/work_queue

	#
	# sources for muorb over fastrpc
	#
	src/modules/muorb/adsp
	)
