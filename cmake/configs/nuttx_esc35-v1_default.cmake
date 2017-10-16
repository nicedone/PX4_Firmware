include(nuttx/px4_impl_nuttx)

add_definitions(
	-DFLASH_BASED_PARAMS
	-DPARAM_NO_ORB
	-DPARAM_NO_AUTOSAVE
	-DPARAMETER_BUFFER_SIZE=1024
)

px4_nuttx_configure(HWCLASS m4 CONFIG nsh)

# UAVCAN boot loadable Module ID
set(uavcanblid_sw_version_major 0)
set(uavcanblid_sw_version_minor 1)
add_definitions(
	-DAPP_VERSION_MAJOR=${uavcanblid_sw_version_major}
	-DAPP_VERSION_MINOR=${uavcanblid_sw_version_minor}
	)

# Bring in common uavcan hardware identity definitions
include(configs/uavcan_board_ident/esc35-v1)
add_definitions(
	-DHW_UAVCAN_NAME=${uavcanblid_name}
	-DHW_VERSION_MAJOR=${uavcanblid_hw_version_major}
	-DHW_VERSION_MINOR=${uavcanblid_hw_version_minor}
)

px4_nuttx_make_uavcan_bootloadable(BOARD ${BOARD}
	BIN ${CMAKE_CURRENT_BINARY_DIR}/src/firmware/nuttx/esc35-v1.bin
	HWNAME ${uavcanblid_name}
	HW_MAJOR ${uavcanblid_hw_version_major}
	HW_MINOR ${uavcanblid_hw_version_minor}
	SW_MAJOR ${uavcanblid_sw_version_major}
	SW_MINOR ${uavcanblid_sw_version_minor}
)

set(config_module_list
	#
	# Board support modules
	#
	src/drivers/boards
	src/drivers/device
	src/drivers/led
	src/drivers/stm32

	#
	# System commands
	#
	src/systemcmds/config
	src/systemcmds/reboot
	src/systemcmds/top
	src/systemcmds/param
	src/systemcmds/ver

	#
	# General system control
	#
	src/modules/uavcanesc
	src/modules/uavcanesc/nshterm
	src/modules/uavcanesc/commands/cfg
	src/modules/uavcanesc/commands/selftest
	src/modules/uavcanesc/commands/dc
	src/modules/uavcanesc/commands/rpm
	src/modules/uavcanesc/commands/stat

	#
	# Library modules
	#
	src/lib/version
	src/modules/systemlib
	src/modules/systemlib/param
	src/modules/uORB
	src/platforms/common
	src/platforms/nuttx
	src/platforms/nuttx/px4_layer
)
