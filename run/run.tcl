# ===========================================================
# Vivado TCL script
# ===========================================================

# Get the folder where this TCL script is located
set script_dir [file dirname [info script]]

# Name of the project folder
set proj_dir [file join [pwd] "riscv_uvm_proj"]

# Create project folder if it doesn't exist
if {![file exists $proj_dir]} {
    file mkdir $proj_dir
}

# Create project inside the subfolder
create_project riscv_uvm $proj_dir -part xc7a200tfbg676-2

# -------------------------
# Add RTL source files (relative to script location)
# -------------------------
add_files -norecurse [file join $script_dir ../src/rv32i.v]

# Update compile order for sources
update_compile_order -fileset sources_1
set_property SOURCE_SET sources_1 [get_filesets sim_1]

# -------------------------
# Add testbench files (relative to script location)
# -------------------------
add_files -fileset sim_1 -norecurse [file join $script_dir ../tb/test_46.mem]
add_files -fileset sim_1 -norecurse [file join $script_dir ../tb/instruction.mem]
add_files -fileset sim_1 -norecurse [file join $script_dir ../tb/test_rv32i.v]

# Update compile order for simulation files
update_compile_order -fileset sim_1

# -------------------------
# Launch simulation (behavioral)
# -------------------------
launch_simulation
