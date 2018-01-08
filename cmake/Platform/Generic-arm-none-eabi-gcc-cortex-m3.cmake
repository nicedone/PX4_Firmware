
message(STATUS "arm-none-eabi cortex-m4")

add_compile_options(-mcpu=cortex-m3 -mthumb -march=armv7-m)
set(CMAKE_ASM_FLAGS "-D__ASSEMBLY__ -mcpu=cortex-m3 -mthumb -march=armv7-m" CACHE INTERNAL "" FORCE)
