include(nuttx/px4_impl_nuttx)

px4_nuttx_configure(HWCLASS m4 CONFIG nsh ROMFS y ROMFSROOT px4fmu_common)

set(config_module_list
	#
	# Board support modules
	#
	src/drivers/device
	src/drivers/stm32
	src/drivers/led
	src/drivers/px4fmu
	src/drivers/boards
	src/drivers/mpu9250
	src/drivers/lps25h
	src/drivers/gps
	src/modules/sensors

	#
	# System commands
	#
	src/systemcmds/bl_update
	src/systemcmds/mixer
	src/systemcmds/param
	src/systemcmds/perf
	src/systemcmds/pwm
	src/systemcmds/esc_calib
	src/systemcmds/reboot
	src/systemcmds/top
	src/systemcmds/config
	src/systemcmds/nshterm
	src/systemcmds/mtd
	src/systemcmds/dumpfile
	src/systemcmds/ver
	src/systemcmds/hardfault_log

	#
	# General system control
	#
	src/modules/commander
	src/modules/load_mon
	src/modules/navigator
	src/modules/mavlink
	#src/modules/gpio_led
	src/modules/land_detector
	src/modules/syslink

	#
	# Estimation modules (EKF/ SO3 / other filters)
	#
	src/modules/attitude_estimator_q
	src/modules/position_estimator_inav
	src/modules/local_position_estimator
	src/modules/ekf2

	#
	# Vehicle Control
	#
	# modules/segway # XXX Needs GCC 4.7 fix
	# modules/fw_pos_control_l1
	# modules/fw_att_control
	src/modules/mc_att_control
	src/modules/mc_pos_control
	# modules/vtol_att_control

	#
	# Logging
	#
	src/modules/logger

	#
	# Library modules
	#
	src/modules/systemlib/param
	src/modules/systemlib
	src/modules/systemlib/mixer
	src/modules/uORB
	src/modules/dataman

	#
	# Libraries
	#
	src/lib/controllib
	src/lib/mathlib
	src/lib/mathlib/math/filter
	src/lib/rc
	src/lib/ecl
	src/lib/external_lgpl
	src/lib/geo
	src/lib/geo_lookup
	src/lib/conversion
	src/lib/launchdetection
	src/lib/terrain_estimation
	src/lib/runway_takeoff
	src/lib/tailsitter_recovery
	src/lib/version
	src/lib/DriverFramework/framework
	src/platforms/nuttx

	# had to add for cmake, not sure why wasn't in original config
	src/platforms/common
	src/platforms/nuttx/px4_layer

	#
	# OBC challenge
	#
	src/modules/bottle_drop

	#
	# Rover apps
	#
	examples/rover_steering_control

	#
	# Demo apps
	#
	#examples/math_demo
	# Tutorial code from
	# https://px4.io/dev/px4_simple_app
	#examples/px4_simple_app

	# Tutorial code from
	# https://px4.io/dev/daemon
	#examples/px4_daemon_app

	# Tutorial code from
	# https://px4.io/dev/debug_values
	#examples/px4_mavlink_debug

	# Tutorial code from
	# https://px4.io/dev/example_fixedwing_control
	#examples/fixedwing_control

	# Hardware test
	#examples/hwtest
)
