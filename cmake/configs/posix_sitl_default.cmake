include(posix/px4_impl_posix)

set(CMAKE_TOOLCHAIN_FILE ${PX4_SOURCE_DIR}/cmake/toolchains/Toolchain-native.cmake)

set(config_module_list
	src/drivers/boards
	src/drivers/camera_trigger
	src/drivers/device
	src/drivers/gps
	src/drivers/pwm_out_sim
	src/drivers/vmount
	src/drivers/linux_gpio
	src/drivers/airspeed
	src/drivers/ets_airspeed
	src/drivers/ms4525_airspeed
	src/drivers/ms5525_airspeed
	src/drivers/sdp3x_airspeed

	src/modules/sensors
	src/platforms/posix/drivers/accelsim
	src/platforms/posix/drivers/adcsim
	src/platforms/posix/drivers/airspeedsim
	src/platforms/posix/drivers/barosim
	src/platforms/posix/drivers/gpssim
	src/platforms/posix/drivers/gyrosim
	src/platforms/posix/drivers/ledsim
	src/platforms/posix/drivers/tonealrmsim

	#
	# System commands
	#
	#systemcmds/bl_update
	#systemcmds/config
	#systemcmds/dumpfile
	src/systemcmds/esc_calib
	src/systemcmds/led_control
	src/systemcmds/mixer
	src/systemcmds/motor_ramp
	#systemcmds/mtd
	#systemcmds/nshterm
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
	#src/drivers/test_ppm
	src/lib/rc/rc_tests
	src/modules/commander/commander_tests
	src/lib/controllib/controllib_test
	src/modules/mavlink/mavlink_tests
	src/modules/mc_pos_control/mc_pos_control_tests
	src/modules/uORB/uORB_tests
	src/systemcmds/tests

	src/platforms/posix/tests/hello
	src/platforms/posix/tests/hrt_test
	src/platforms/posix/tests/muorb
	src/platforms/posix/tests/vcdev_test
	src/platforms/posix/tests/wqueue

	#
	# General system control
	#
	src/modules/commander
	src/modules/events
	#src/modules/gpio_led
	src/modules/land_detector
	src/modules/load_mon
	src/modules/mavlink
	src/modules/navigator
	src/modules/replay
	src/modules/simulator
	#src/modules/uavcan

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
	src/platforms/posix/px4_layer
	src/platforms/posix/work_queue

	#
	# OBC challenge
	#
	src/modules/bottle_drop

	#
	# Rover apps
	#
	examples/rover_steering_control

	#
	# HippoCampus example (AUV from TUHH)
	#
	examples/uuv_example_app

	#
	# Segway
	#
	examples/segway

	#
	# Demo apps
	#

	# Tutorial code from
	# https://px4.io/dev/px4_simple_app
	examples/px4_simple_app

	# Tutorial code from
	# https://px4.io/dev/daemon
	examples/px4_daemon_app

	# Tutorial code from
	# https://px4.io/dev/debug_values
	examples/px4_mavlink_debug

	# Tutorial code from
	# https://px4.io/dev/example_fixedwing_control
	examples/fixedwing_control

	# Hardware test
	#examples/hwtest

	# EKF
	examples/ekf_att_pos_estimator

	# micro-RTPS
)

set(config_rtps_send_topics
	sensor_baro
	)

set(config_rtps_receive_topics
	sensor_combined
	)

# Default config_sitl_rcS_dir (posix_sitl_default), this is overwritten later
# for the config posix_sitl_efk2 and set again, explicitly, for posix_sitl_lpe,
# which are based on posix_sitl_default.
set(config_sitl_rcS_dir
	posix-configs/SITL/init/ekf2
	CACHE INTERNAL "init script dir for sitl"
	)

set(config_sitl_viewer
	jmavsim
	CACHE STRING "viewer for sitl"
	)
set_property(CACHE config_sitl_viewer
	PROPERTY STRINGS "jmavsim;none")

set(config_sitl_debugger
	disable
	CACHE STRING "debugger for sitl"
	)
set_property(CACHE config_sitl_debugger
	PROPERTY STRINGS "disable;gdb;lldb")

# If the environment variable 'replay' is defined, we are building with replay
# support. In this case, we enable the orb publisher rules.
set(REPLAY_FILE "$ENV{replay}")
if(REPLAY_FILE)
	message("Building with uorb publisher rules support")
	add_definitions(-DORB_USE_PUBLISHER_RULES)
endif()
