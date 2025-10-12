# ===========================
# Makefile for RV32I Project
# ===========================

# Compiler and simulator
IVERILOG = iverilog
VVP = vvp

# Directories
SRC_DIR = src
BUILD_DIR = build

# Top module
TOP_MODULE = top_rv32i

# Output binary
OUT = $(BUILD_DIR)/$(TOP_MODULE).out

# Source files
SRC = $(wildcard $(SRC_DIR)/*.v)

# Optional: testbench file (if you have one)
#TB = $(SRC_DIR)/tb_$(TOP_MODULE).v

# Default target
all: build run

# Build step
build: $(SRC)
	@mkdir -p $(BUILD_DIR)
	$(IVERILOG) -g2012 -o $(OUT) $(SRC)
#	$(IVERILOG) -g2012 -o $(OUT) $(SRC) $(TB)

# Run simulation
run:
	$(VVP) $(OUT)

# Clean build directory
clean:
	rm -rf $(BUILD_DIR)

# Rebuild from scratch
rebuild: clean all
