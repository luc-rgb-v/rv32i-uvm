cmake_minimum_required(VERSION 3.10)
project(rv32i_pipeline_test LANGUAGES NONE)

# set var
set(MIMIC_SOURCE
    mimic_mem.v
    tb_mimic_mem.v
)
# MIMIC MEM TEST

# output name for simulation
set(MIMIC_OUTPUT sim_mimic_mem)
set(MIMIC_VCD mimic.vcd)

# add custom target for build
add_custom_target(build_mimic ALL
    COMMAND iverilog -o ${MIMIC_OUTPUT} ${MIMIC_SOURCE}
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    COMMENT "=== Build mimic_mem simulation ==="
)

# add custom target for running simulation
add_custom_target(run_mimic
    COMMAND vvp ${MIMIC_OUTPUT}
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    DEPENDS build_mimic
    COMMENT "=== Running mimic_mem simulation ===="
)

# Target: gtkwave
add_custom_target(wave_mimic
    COMMAND gtkwave ${MIMIC_VCD}
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    DEPENDS run_mimic
    COMMENT "=== Open GTKwave mimic_mem ==="
)

#MEMORY STAGE TEST

set(MEM_STAGE_SOURCE
    mimic_mem.v
    mem_stage.v
    tb_mem_stage.v
)

set(MEM_STAGE_OUTPUT sim_mem_stage)
set(MEM_STAGE_VCD mem_stage.vcd)

add_custom_target(build_mem_stage
    COMMAND iverilog -o ${MEM_STAGE_OUTPUT} ${MEM_STAGE_SOURCE}
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    COMMENT "=== Build mem stage simulation ==="
)

add_custom_target(run_mem_stage
    COMMAND vvp ${MEM_STAGE_OUTPUT}
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    DEPENDS build_mem_stage
    COMMENT "=== Running mem stage simulation"
)

add_custom_target(wave_mem_stage
    COMMAND gtkwave ${MEM_STAGE_VCD}
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    DEPENDS run_mem_stage
    COMMENT "== Build GTKwave mem stage ==="
)

add_custom_target(build_all
    DEPENDS build_mimic build_mem_stage
    COMMENT "=== Build ALl ==="
)

