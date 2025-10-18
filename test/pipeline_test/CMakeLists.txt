cmake_minimum_required(VERSION 3.10)
project(rv32i_pipeline_test LANGUAGES NONE)

#set var
set(SOURCE
    pipeline_test.v
    tb_pipeline.v
)

#output name for simulation
set(OUTPUT sim_pipeline)
set(VCD_FILE tb_pipeline.vcd)

#add custom target for build
add_custom_target(build_sim ALL
    COMMAND iverilog -o ${OUTPUT} ${SOURCE}
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    COMMENT "=== Build simulation icarus ==="
)

#add custom target for running simulation
add_custom_target(run_sim
    COMMAND vvp ${OUTPUT}
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    DEPENDS build_sim
    COMMENT "=== Running Verilog simulation ===="
)

#Target: gtkwave
add_custom_target(run_wave
    COMMAND gtkwave ${VCD_FILE}
    WORKING_DIRECTORY ${CMAKE_CURRENT_SOURCE_DIR}
    DEPENDS run_sim
    COMMENT "=== Opening GTKwave ==="
)

