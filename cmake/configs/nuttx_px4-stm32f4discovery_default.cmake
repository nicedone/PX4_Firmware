include(nuttx/px4_impl_nuttx)

px4_nuttx_configure(HWCLASS m4 CONFIG nsh ROMFS y ROMFSROOT px4fmu_common)

set(config_module_list
	#
	# Board support modules
	#
	src/drivers/device
	src/drivers/stm32
	src/drivers/led
	src/drivers/boards

	#
	# System commands
	#
	src/systemcmds/bl_update
	src/systemcmds/mixer
	src/systemcmds/param
	src/systemcmds/perf
	src/systemcmds/reboot
	src/systemcmds/top
	src/systemcmds/config
	src/systemcmds/nshterm
	src/systemcmds/ver

	#
	# Library modules
	#
	src/modules/systemlib/param
	src/modules/systemlib
	src/modules/systemlib/mixer
	src/modules/uORB

	#
	# Libraries
	#
	#src/lib/mathlib/CMSIS
	src/lib/controllib
	src/lib/mathlib
	src/lib/mathlib/math/filter
	src/lib/ecl
	src/lib/external_lgpl
	src/lib/geo
	src/lib/conversion
	src/lib/version
	src/lib/DriverFramework/framework
	src/platforms/nuttx

	# had to add for cmake, not sure why wasn't in original config
	src/platforms/common
	src/platforms/nuttx/px4_layer

	#
	# Demo apps
	#
	#examples/math_demo
	# Tutorial code from
	# https://px4.io/dev/px4_simple_app
	examples/px4_simple_app

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