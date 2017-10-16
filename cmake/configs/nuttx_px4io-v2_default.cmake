include(nuttx/px4_impl_nuttx)

px4_nuttx_configure(HWCLASS m3 CONFIG nsh)

set(config_module_list
	src/drivers/boards/px4io-v2
	src/drivers/stm32
	src/lib/rc
	src/modules/px4iofirmware
	src/modules/systemlib/mixer
	src/platforms/common

)
