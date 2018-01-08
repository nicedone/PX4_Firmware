
message(STATUS "arm-none-eabi cortex-m4")

add_compile_options(-mcpu=cortex-m7 -mthumb -mfpu=fpv5-sp-d16 -mfloat-abi=hard)
set(CMAKE_ASM_FLAGS "-D__ASSEMBLY__ -mcpu=cortex-m7 -mthumb -mfpu=fpv5-sp-d16 -mfloat-abi=hard" CACHE INTERNAL "" FORCE)
