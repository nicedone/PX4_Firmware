# This file is shared between posix_rpi_native.cmake
# and posix_rpi_cross.cmake.

include(posix/px4_impl_posix)

# This definition allows to differentiate if this just the usual POSIX build
# or if it is for the RPi.
add_definitions(
	-D__PX4_POSIX_RPI
	-D__DF_LINUX # For DriverFramework
	-D__DF_RPI # For DriverFramework
)


set(config_module_list
	#
	# Board support modules
	#
	src/drivers/device
	src/drivers/airspeed
	src/drivers/ets_airspeed
	src/drivers/ms4525_airspeed
	src/drivers/ms5525_airspeed
	src/drivers/sdp3x_airspeed

	src/modules/sensors
	src/platforms/posix/drivers/df_mpu9250_wrapper
	src/platforms/posix/drivers/df_lsm9ds1_wrapper
	src/platforms/posix/drivers/df_ms5611_wrapper
	src/platforms/posix/drivers/df_hmc5883_wrapper
	src/platforms/posix/drivers/df_trone_wrapper
	src/platforms/posix/drivers/df_isl29501_wrapper

	#
	# System commands
	#
	src/systemcmds/param
	src/systemcmds/led_control
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
	src/modules/fw_att_control
	src/modules/fw_pos_control_l1
	src/modules/gnd_att_control
	src/modules/gnd_pos_control
	src/modules/mc_att_control
	src/modules/mc_pos_control
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
	src/drivers/linux_sbus
	src/drivers/gps
	src/drivers/navio_adc
	src/drivers/navio_sysfs_rc_in
	src/drivers/linux_gpio
	src/drivers/linux_pwm_out
	src/drivers/navio_rgbled
	src/drivers/pwm_out_sim
	src/drivers/rpi_rc_in

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
	src/lib/led
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

#
# DriverFramework driver
#
set(config_df_driver_list
	mpu9250
	lsm9ds1
	ms5611
	hmc5883
	trone
	isl29501
)
