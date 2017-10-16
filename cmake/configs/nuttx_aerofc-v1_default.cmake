include(nuttx/px4_impl_nuttx)

px4_nuttx_configure(HWCLASS m4 CONFIG nsh ROMFS y ROMFSROOT px4fmu_common)

set(config_uavcan_num_ifaces 2)

set(config_module_list
	#
	# Board support modules
	#
	src/drivers/device
	src/drivers/stm32
	src/drivers/led
	src/drivers/px4fmu
	src/drivers/boards
	src/drivers/tap_esc
	src/drivers/mpu9250
	src/drivers/ms5611
	src/drivers/hmc5883
	src/drivers/gps
	src/drivers/ist8310
	src/drivers/ll40ls
	src/drivers/aerofc_adc
	src/modules/sensors

	#
	# System commands
	#
	src/systemcmds/mixer
	src/systemcmds/param
	src/systemcmds/perf
	src/systemcmds/pwm
	src/systemcmds/motor_test
	src/systemcmds/reboot
	src/systemcmds/top
	src/systemcmds/config
	src/systemcmds/nshterm
	src/systemcmds/dumpfile
	src/systemcmds/ver

	#
	# General system control
	#
	src/modules/commander
	src/modules/load_mon
	src/modules/navigator
	src/modules/mavlink
	src/modules/land_detector

	#
	# Estimation modules
	#
	src/modules/attitude_estimator_q
	src/modules/local_position_estimator
	src/modules/ekf2

	#
	# Vehicle Control
	#
	src/modules/mc_att_control
	src/modules/mc_pos_control

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
	src/lib/geo
	src/lib/geo_lookup
	src/lib/conversion
	src/lib/tailsitter_recovery
	src/lib/version
	src/lib/DriverFramework/framework
	src/lib/rc
	src/platforms/nuttx
	src/platforms/common
	src/platforms/nuttx/px4_layer
)
