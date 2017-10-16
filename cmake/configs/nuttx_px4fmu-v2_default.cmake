include(nuttx/px4_impl_nuttx)
px4_nuttx_configure(HWCLASS m4 CONFIG nsh ROMFS y ROMFSROOT px4fmu_common IO px4io-v2)

set(config_module_list
	#
	# Board support modules
	#
	src/drivers/device
	src/drivers/stm32
	src/drivers/stm32/adc
	src/drivers/stm32/tone_alarm
	src/drivers/led
	src/drivers/px4fmu
	src/drivers/px4io
	src/drivers/boards
	src/drivers/rgbled
	src/drivers/mpu6000
	src/drivers/mpu9250
	src/drivers/lsm303d
	src/drivers/l3gd20
	src/drivers/hmc5883
	src/drivers/ms5611
	#src/drivers/mb12xx
	#src/drivers/srf02
	src/drivers/sf0x
	src/drivers/ll40ls
	src/drivers/teraranger
	src/drivers/gps
	src/drivers/pwm_out_sim
	#src/drivers/hott
	#src/drivers/hott/hott_telemetry
	#src/drivers/hott/hott_sensors
	#src/drivers/blinkm
	src/drivers/airspeed
	src/drivers/ets_airspeed
	src/drivers/ms4525_airspeed
	src/drivers/ms5525_airspeed
	src/drivers/sdp3x_airspeed
	src/drivers/frsky_telemetry
	src/modules/sensors
	#src/drivers/mkblctrl
	src/drivers/px4flow
	#src/drivers/oreoled
	src/drivers/vmount
	src/drivers/pwm_input
	src/drivers/camera_trigger
	src/drivers/bst
	#src/drivers/snapdragon_rc_pwm
	src/drivers/lis3mdl
	#src/drivers/iridiumsbd
	src/drivers/ulanding

	#
	# System commands
	#
	src/systemcmds/bl_update
	src/systemcmds/config
	#systemcmds/dumpfile
	#systemcmds/esc_calib
	src/systemcmds/hardfault_log
	src/systemcmds/mixer
	#systemcmds/motor_ramp
	src/systemcmds/mtd
	src/systemcmds/nshterm
	src/systemcmds/param
	src/systemcmds/perf
	src/systemcmds/pwm
	src/systemcmds/reboot
	#systemcmds/sd_bench
	src/systemcmds/top
	#systemcmds/topic_listener
	src/systemcmds/ver

	#
	# Testing
	#
	#src/drivers/sf0x/sf0x_tests
	#src/drivers/test_ppm
	#src/lib/rc/rc_tests
	#src/modules/commander/commander_tests
	#src/lib/controllib/controllib_test
	#src/modules/mavlink/mavlink_tests
	#src/modules/uORB/uORB_tests
	#systemcmds/tests

	#
	# General system control
	#
	src/modules/commander
	src/modules/events
	src/modules/load_mon
	src/modules/navigator
	src/modules/mavlink
	src/modules/gpio_led
	#src/modules/uavcan
	src/modules/land_detector
	src/modules/camera_feedback

	#
	# Estimation modules
	#
	#src/modules/attitude_estimator_q
	#src/modules/position_estimator_inav
	#src/modules/local_position_estimator
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
	# Logging
	#
	src/modules/logger
	#src/modules/sdlog2

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
	src/lib/ecl
	src/lib/external_lgpl
	src/lib/geo
	src/lib/geo_lookup
	src/lib/conversion
	src/lib/launchdetection
	src/lib/led
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
