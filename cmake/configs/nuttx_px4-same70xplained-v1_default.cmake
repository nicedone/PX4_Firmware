include(nuttx/px4_impl_nuttx)

px4_nuttx_configure(HWCLASS m7 CONFIG nsh ROMFS y ROMFSROOT px4fmu_common)

##set(config_uavcan_num_ifaces 2)

set(config_module_list
	#
	# Board support modules
	#
	src/drivers/device
	src/drivers/samv7
#WIP 	drivers/samv7/adc
	src/drivers/samv7/tone_alarm
	src/drivers/led
	src/drivers/px4fmu
	src/drivers/boards
	src/drivers/rgbled
	src/drivers/mpu6000
	src/drivers/mpu9250
	src/drivers/ms4525_airspeed
	src/drivers/ms5525_airspeed
	src/drivers/lsm303d
	src/drivers/l3gd20
	src/drivers/hmc5883
	src/drivers/ms5611
	src/drivers/mb12xx
	src/drivers/srf02
	src/drivers/sf0x
	src/drivers/ll40ls
	src/drivers/teraranger
	src/drivers/gps
#WIP 	drivers/pwm_out_sim
	src/drivers/hott
	src/drivers/hott/hott_telemetry
	src/drivers/hott/hott_sensors
	src/drivers/blinkm
	src/drivers/airspeed
	src/drivers/ets_airspeed
	src/drivers/frsky_telemetry
	src/modules/sensors
	#src/drivers/mkblctrl
	src/drivers/px4flow
	src/drivers/oreoled
##	drivers/gimbal
#WIP  	drivers/pwm_input
#WIP  	drivers/camera_trigger
	src/drivers/bst
	src/drivers/snapdragon_rc_pwm
	src/drivers/lis3mdl

	#
	# System commands
	#
	src/systemcmds/bl_update
	src/systemcmds/mixer
	src/systemcmds/param
	src/systemcmds/perf
	src/systemcmds/pwm
	src/systemcmds/esc_calib
#WIP systemcmds/hardfault_log
	src/systemcmds/reboot
	#systemcmds/topic_listener
	src/systemcmds/top
	src/systemcmds/config
	src/systemcmds/nshterm
#	systemcmds/mtd Excluded until TWIHS works
	src/systemcmds/dumpfile
	src/systemcmds/ver

	#
	# General system control
	#
	src/modules/commander
	src/modules/navigator
	src/modules/mavlink
	src/modules/gpio_led
##WIP	modules/uavcan
	src/modules/land_detector

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
	src/modules/fw_pos_control_l1
	src/modules/fw_att_control
	src/modules/mc_att_control
	src/modules/mc_pos_control
	src/modules/vtol_att_control

	#
	# Logging
	#
	src/modules/sdlog2
##	modules/logger

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
	src/lib/led
	src/lib/DriverFramework/framework
	src/lib/launchdetection
	src/lib/version
	src/lib/terrain_estimation
	src/lib/runway_takeoff
	src/lib/tailsitter_recovery
	src/platforms/nuttx

	# had to add for cmake, not sure why wasn't in original config
	src/platforms/common
	src/platforms/nuttx/px4_layer

	#
	# OBC challenge
	#
	#src/modules/bottle_drop

	#
	# Rover apps
	#
	#examples/rover_steering_control

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