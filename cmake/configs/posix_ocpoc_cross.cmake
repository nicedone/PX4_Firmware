#set toolchain
set(CMAKE_TOOLCHAIN_FILE ${PX4_SOURCE_DIR}/cmake/toolchains/Toolchain-arm-xilinx-linux-gnueabi.cmake)

set(CMAKE_PROGRAM_PATH
	"${OCPOC_TOOLCHAIN_DIR}"
	${CMAKE_PROGRAM_PATH}
)

include(posix/px4_impl_posix)

add_definitions(
  -D__PX4_POSIX_OCPOC
  -D__DF_LINUX # For DriverFramework
  -D__DF_OCPOC # For DriverFramework
  -D__PX4_POSIX
)

set(config_module_list
	#
	# Board support modules
	#
	src/drivers/device
	src/modules/sensors
	src/platforms/posix/drivers/df_mpu9250_wrapper
	src/platforms/posix/drivers/df_ms5611_wrapper
	src/platforms/posix/drivers/df_hmc5883_wrapper

	#
	# System commands
	#
	src/systemcmds/param
	src/systemcmds/mixer
	src/systemcmds/ver
	src/systemcmds/esc_calib
	src/systemcmds/reboot
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
	src/drivers/ocpoc_adc
	src/drivers/ocpoc_sbus_rc_in
	src/drivers/linux_pwm_out
	src/drivers/rgbled
	src/drivers/ulanding

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
	src/lib/rc
	src/lib/led

	#
	# POSIX
	#
	src/platforms/common
	src/platforms/posix/px4_layer
	src/platforms/posix/work_queue
	
	examples/px4_simple_app
)

#
# DriverFramework driver
#
set(config_df_driver_list
	mpu9250
	ms5611
	hmc5883
)
