include(nuttx/px4_impl_nuttx)

px4_nuttx_configure(HWCLASS m7 CONFIG nsh ROMFS y ROMFSROOT px4fmu_common)

set(config_uavcan_num_ifaces 2)

set(config_module_list
	#
	# Board support modules
	#
	src/drivers/airspeed
	src/drivers/blinkm
	src/drivers/bma180
	src/drivers/bmi055
	src/drivers/bmi160
	src/drivers/bmp280
	src/drivers/boards
	src/drivers/bst
	src/drivers/camera_trigger
	src/drivers/device
	src/drivers/ets_airspeed
	src/drivers/frsky_telemetry
	src/drivers/gps
	src/drivers/hmc5883
	src/drivers/hott
	src/drivers/hott/hott_sensors
	src/drivers/hott/hott_telemetry
	src/drivers/iridiumsbd
	src/drivers/ist8310
	src/drivers/led
	src/drivers/lis3mdl
	src/drivers/ll40ls
	src/drivers/mb12xx
	src/drivers/mkblctrl
	src/drivers/mpu6000
	src/drivers/mpu9250
	src/drivers/ms4525_airspeed
	src/drivers/ms5525_airspeed
	src/drivers/ms5611
	src/drivers/oreoled
	src/drivers/pwm_input
	src/drivers/pwm_out_sim
	src/drivers/px4flow
	src/drivers/px4fmu
	src/drivers/rgbled
	src/drivers/rgbled_pwm
	src/drivers/sdp3x_airspeed
	src/drivers/sf0x
	src/drivers/sf1xx
	src/drivers/snapdragon_rc_pwm
	src/drivers/srf02
	src/drivers/stm32
	src/drivers/stm32/adc
	src/drivers/stm32/tone_alarm
	src/drivers/tap_esc
	src/drivers/teraranger
	src/drivers/vmount
	src/modules/sensors

	#
	# System commands
	#
	src/systemcmds/bl_update
	src/systemcmds/config
	src/systemcmds/dumpfile
	src/systemcmds/esc_calib
	src/systemcmds/hardfault_log
	src/systemcmds/led_control
	src/systemcmds/mixer
	src/systemcmds/motor_ramp
	src/systemcmds/mtd
	src/systemcmds/nshterm
	src/systemcmds/param
	src/systemcmds/perf
	src/systemcmds/pwm
	src/systemcmds/reboot
	src/systemcmds/sd_bench
	src/systemcmds/top
	src/systemcmds/topic_listener
	src/systemcmds/ver

	#
	# Testing
	#
	src/drivers/sf0x/sf0x_tests
	src/drivers/test_ppm
	#src/lib/rc/rc_tests
	src/modules/commander/commander_tests
	src/lib/controllib/controllib_test
	src/modules/mavlink/mavlink_tests
	src/modules/mc_pos_control/mc_pos_control_tests
	src/modules/uORB/uORB_tests
	src/systemcmds/tests

	#
	# General system control
	#
	src/modules/commander
	src/modules/events
	src/modules/gpio_led
	src/modules/land_detector
	src/modules/load_mon
	src/modules/mavlink
	src/modules/navigator
	src/modules/uavcan
	src/modules/camera_feedback

	#
	# Estimation modules
	#
	src/modules/attitude_estimator_q
	src/modules/ekf2
	src/modules/local_position_estimator
	src/modules/position_estimator_inav

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
	src/modules/sdlog2

	#
	# Library modules
	#
	src/modules/dataman
	src/modules/systemlib/param
	src/modules/systemlib
	src/modules/systemlib/mixer
	src/modules/uORB

	# micro RTPS
	src/modules/micrortps_bridge/micrortps_client

	#
	# Libraries
	#
	src/lib/controllib
	src/lib/conversion
	src/lib/DriverFramework/framework
	src/lib/ecl
	src/lib/external_lgpl
	src/lib/geo
	src/lib/geo_lookup
	src/lib/launchdetection
	src/lib/led
	src/lib/mathlib
	src/lib/mathlib/math/filter
	src/lib/rc
	src/lib/runway_takeoff
	src/lib/tailsitter_recovery
	src/lib/terrain_estimation
	src/lib/version

	#
	# Platform
	#
	src/platforms/common
	src/platforms/nuttx
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
	# Segway
	#
	#examples/segway

	#
	# Demo apps
	#

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

	# EKF
	#examples/ekf_att_pos_estimator
)

set(config_rtps_send_topics
   sensor_combined
   )

set(config_rtps_receive_topics
   sensor_baro
   )
