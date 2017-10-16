include(nuttx/px4_impl_nuttx)

px4_nuttx_configure(HWCLASS m4 CONFIG nsh ROMFS y ROMFSROOT tap_common)

set(target_definitions MEMORY_CONSTRAINED_SYSTEM)

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
	src/drivers/boards
	src/drivers/rgbled_pwm
	src/drivers/tap_esc
	src/drivers/mpu6000
	src/drivers/ms5611
	src/drivers/hmc5883
	src/drivers/gps
	src/drivers/airspeed
	src/drivers/ms4525_airspeed
	src/drivers/ms5525_airspeed
	src/modules/sensors
	src/drivers/vmount

	#
	# System commands
	#
	src/systemcmds/bl_update
	src/systemcmds/led_control
	src/systemcmds/mixer
	src/systemcmds/param
	src/systemcmds/perf
	src/systemcmds/pwm
	src/systemcmds/hardfault_log
	src/systemcmds/motor_test
	src/systemcmds/reboot
	src/systemcmds/top
	src/systemcmds/config
	src/systemcmds/nshterm
	src/systemcmds/mtd
	src/systemcmds/dumpfile
	src/systemcmds/ver
	src/systemcmds/topic_listener

	#
	# General system control
	#
	src/modules/commander
	src/modules/load_mon
	src/modules/navigator
	src/modules/mavlink
	src/modules/land_detector

	#
	# Estimation modules (EKF/ SO3 / other filters)
	#
	src/modules/ekf2

	#
	# Vehicle Control
	#
	src/modules/fw_pos_control_l1
	src/modules/fw_att_control
	src/modules/mc_att_control
	src/modules/mc_pos_control
	src/modules/vtol_att_control

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
	src/lib/ecl
	src/lib/external_lgpl
	src/lib/geo
	src/lib/geo_lookup
	src/lib/conversion
	src/lib/launchdetection
	src/lib/led
	src/lib/rc
	src/lib/runway_takeoff
	src/lib/tailsitter_recovery
	src/lib/terrain_estimation
	src/lib/version
	src/lib/DriverFramework/framework
	src/platforms/nuttx

	# had to add for cmake, not sure why wasn't in original config
	src/platforms/common
	src/platforms/nuttx/px4_layer
)