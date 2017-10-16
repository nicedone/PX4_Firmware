include(posix/px4_impl_posix)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${PX4_SOURCE_DIR}/cmake/cmake_hexagon")

# Disable the creation of the parameters.xml file by scanning individual
# source files, and scan all source files.  This will create a parameters.xml
# file that contains all possible parameters, even if the associated module
# is not used.  This is necessary for parameter synchronization between the 
# ARM and DSP processors.
set(DISABLE_PARAMS_MODULE_SCOPING TRUE)

# Get $QC_SOC_TARGET from environment if existing.
if (DEFINED ENV{QC_SOC_TARGET})
	set(QC_SOC_TARGET $ENV{QC_SOC_TARGET})
else()
	set(QC_SOC_TARGET "APQ8074")
endif()

set(CONFIG_SHMEM "1")


set(config_module_list
	src/drivers/device
	src/drivers/blinkm
	src/drivers/linux_sbus
	src/drivers/pwm_out_sim
	src/drivers/rgbled
	src/drivers/led
	src/drivers/boards
	src/drivers/qshell/posix

	src/systemcmds/param
	src/systemcmds/led_control
	src/systemcmds/mixer
	src/systemcmds/ver
	src/systemcmds/topic_listener

	src/modules/mavlink

	src/modules/attitude_estimator_q
	src/modules/position_estimator_inav
	src/modules/local_position_estimator
	src/modules/ekf2

	src/modules/mc_pos_control
	src/modules/mc_att_control

	src/modules/systemlib/param
	src/modules/systemlib
	src/modules/systemlib/mixer
	src/modules/uORB
	src/modules/muorb/krait
	src/modules/sensors
	src/modules/dataman
	src/modules/sdlog2
	src/modules/logger
	src/modules/simulator
	src/modules/commander
	src/modules/navigator

	# micro RTPS
	src/modules/micrortps_bridge/micrortps_client

	src/lib/controllib
	src/lib/mathlib
	src/lib/mathlib/math/filter
	src/lib/conversion
	src/lib/ecl
	src/lib/geo
	src/lib/geo_lookup
	src/lib/led
	src/lib/terrain_estimation
	src/lib/runway_takeoff
	src/lib/tailsitter_recovery
	src/lib/version
	src/lib/DriverFramework/framework

	src/platforms/common
	src/platforms/posix/px4_layer
	src/platforms/posix/work_queue
	)
