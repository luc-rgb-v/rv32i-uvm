volatile int result = 0;

void func_target(void) {
    result = 0xAA;  // reached by jr
    while (1);
}

int main(void) {
    result = 0x00;

    // --- Test 1: jal (PC-relative jump) ---
    asm volatile(
        "jal ra, 1f\n"        // jump to label 1
        "addi %0, zero, 1\n"  // should be skipped if jump works
        "1:\n"
        : "=r"(result)
        :
        : "ra"
    );
    result = 0x11;            // jal worked and returned

    // --- Test 2: jalr (register indirect jump) ---
    void (*fn_ptr)(void) = func_target;
    asm volatile(
        "mv t0, %0\n"
        "jalr ra, 0(t0)\n"    // jump to func_target, then return
        :
        : "r"(fn_ptr)
        : "t0", "ra"
    );
    result = 0x55;            // jalr worked and returned

    // --- Test 3: jr (no link register) ---
    asm volatile(
        "mv t0, %0\n"
        "jalr x0, 0(t0)\n"    // jr t0 — never returns
        :
        : "r"(fn_ptr)
        : "t0"
    );

    result = 0xFF;            // should not reach here
    while (1);
}
