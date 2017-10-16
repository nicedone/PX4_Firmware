include(posix/px4_impl_posix)

set(CMAKE_MODULE_PATH ${CMAKE_MODULE_PATH} "${PX4_SOURCE_DIR}/cmake/cmake_hexagon")

# Use build stubs unless explicitly set not to
if("${DSPAL_STUBS_ENABLE}" STREQUAL "")
	set(DSPAL_STUBS_ENABLE "1")
endif()

set(CMAKE_TOOLCHAIN_FILE ${PX4_SOURCE_DIR}/cmake/cmake_hexagon/toolchain/Toolchain-arm-linux-gnueabihf.cmake)

set(DISABLE_PARAMS_MODULE_SCOPING TRUE)

# Get $QC_SOC_TARGET from environment if existing.
if (DEFINED ENV{QC_SOC_TARGET})
	set(QC_SOC_TARGET $ENV{QC_SOC_TARGET})
else()
	set(QC_SOC_TARGET "APQ8074")
endif()

set(config_module_list
	src/drivers/device
	src/drivers/boards
	src/drivers/led
	src/drivers/linux_sbus

	src/systemcmds/param
	src/systemcmds/ver

	src/modules/mavlink

	src/modules/systemlib/param
	src/modules/systemlib
	src/modules/uORB
	src/modules/sensors
	src/modules/dataman
	src/modules/sdlog2
	src/modules/logger
	src/modules/simulator
	src/modules/commander

	src/lib/controllib
	src/lib/mathlib
	src/lib/mathlib/math/filter
	src/lib/ecl
	src/lib/geo
	src/lib/geo_lookup
	src/lib/conversion
	src/lib/version
	src/lib/DriverFramework/framework

	src/platforms/common
	src/platforms/posix/px4_layer
	src/platforms/posix/work_queue
	src/modules/muorb/krait
	)

