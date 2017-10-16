include(posix/px4_impl_posix)

set(CMAKE_TOOLCHAIN_FILE ${PX4_SOURCE_DIR}/cmake/toolchains/Toolchain-arm-linux-gnueabihf.cmake)

add_definitions(
	-D__PX4_POSIX_BEBOP
	-D__DF_LINUX # Define needed DriverFramework
	-D__DF_BEBOP # Define needed DriverFramework
	)

set(config_module_list

	#
	# Board support modules
	#
	src/drivers/device
	src/drivers/linux_sbus
	src/modules/sensors
	src/platforms/posix/drivers/df_ms5607_wrapper
	src/platforms/posix/drivers/df_mpu6050_wrapper
	src/platforms/posix/drivers/df_ak8963_wrapper
	src/platforms/posix/drivers/df_bebop_bus_wrapper
	src/platforms/posix/drivers/df_bebop_rangefinder_wrapper
	src/platforms/posix/drivers/bebop_flow

	#
	# System commands
	#
	src/systemcmds/param
	src/systemcmds/mixer
	src/systemcmds/ver
	src/systemcmds/esc_calib
	src/systemcmds/topic_listener
	src/systemcmds/perf

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
	src/modules/fw_att_control
	src/modules/fw_pos_control_l1
	src/modules/vtol_att_control

	#
	# Library modules
	#
	src/modules/sdlog2
	src/modules/logger
	src/modules/commander
	src/modules/systemlib/param
	src/modules/systemlib
	src/modules/systemlib/mixer
	src/modules/uORB
	src/modules/dataman
	src/modules/land_detector
	src/modules/navigator
	src/modules/mavlink

	#
	# PX4 drivers
	#
	src/drivers/gps

	#
	# Libraries
	#
	src/lib/controllib
	src/lib/mathlib
	src/lib/mathlib/math/filter
	src/lib/geo
	src/lib/ecl
	src/lib/geo_lookup
	src/lib/launchdetection
	src/lib/external_lgpl
	src/lib/conversion
	src/lib/terrain_estimation
	src/lib/runway_takeoff
	src/lib/tailsitter_recovery
	src/lib/version
	src/lib/DriverFramework/framework

	#
	# POSIX
	#
	src/platforms/common
	src/platforms/posix/px4_layer
	src/platforms/posix/work_queue
)

set(config_df_driver_list
	ms5607
	mpu6050
	ak8963
	bebop_bus
	bebop_rangefinder
	mt9v117
)
