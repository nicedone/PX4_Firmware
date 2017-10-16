include(qurt/px4_impl_qurt)

if ("$ENV{HEXAGON_SDK_ROOT}" STREQUAL "")
	message(FATAL_ERROR "Enviroment variable HEXAGON_SDK_ROOT must be set")
else()
	set(HEXAGON_SDK_ROOT $ENV{HEXAGON_SDK_ROOT})
endif()

set(CONFIG_SHMEM "1")

# Get $QC_SOC_TARGET from environment if existing.
if (DEFINED ENV{QC_SOC_TARGET})
	set(QC_SOC_TARGET $ENV{QC_SOC_TARGET})
else()
	set(QC_SOC_TARGET "APQ8074")
endif()

# Disable the creation of the parameters.xml file by scanning individual
# source files, and scan all source files.  This will create a parameters.xml
# file that contains all possible parameters, even if the associated module
# is not used.  This is necessary for parameter synchronization between the 
# ARM and DSP processors.
set(DISABLE_PARAMS_MODULE_SCOPING TRUE)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${PX4_SOURCE_DIR}/cmake/cmake_hexagon")
include(toolchain/Toolchain-qurt)
include(qurt_flags)
include_directories(${HEXAGON_SDK_INCLUDES})


set(config_module_list
	#
	# Board support modules
	#
	src/drivers/device
	src/modules/sensors
	src/platforms/posix/drivers/df_mpu9250_wrapper
	src/platforms/posix/drivers/df_bmp280_wrapper
	src/platforms/posix/drivers/df_hmc5883_wrapper
	src/platforms/posix/drivers/df_trone_wrapper
	src/platforms/posix/drivers/df_isl29501_wrapper

	#
	# System commands
	#
	src/systemcmds/param

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
	src/modules/land_detector

	#
	# PX4 drivers
	#
	src/drivers/gps
	src/drivers/pwm_out_rc_in
	src/drivers/spektrum_rc
	src/drivers/qshell/qurt
	src/drivers/snapdragon_pwm_out

	#
	# Libraries
	#
	src/lib/controllib
	src/lib/mathlib
	src/lib/mathlib/math/filter
	src/lib/geo
	src/lib/ecl
	src/lib/geo_lookup
	src/lib/conversion
	src/lib/terrain_estimation
	src/lib/runway_takeoff
	src/lib/tailsitter_recovery
	src/lib/rc
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

set(config_df_driver_list
	mpu9250
	bmp280
	hmc5883
	trone
	isl29501
	)
