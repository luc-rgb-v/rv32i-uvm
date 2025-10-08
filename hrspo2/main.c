#include "common.h"
#include "testfunc.h"

int main(void) {
    SlidingMean ir_win, red_win;
    sliding_init(&ir_win);
    sliding_init(&red_win);

    int32_t ir_samples[]  = {500, 520, 510, 530, 525};
    int32_t red_samples[] = {300, 310, 305, 295, 290};

    for (int i = 0; i < 5; i++) {
        int32_t ir_mean  = sliding_update(&ir_win, ir_samples[i]);
        int32_t red_mean = sliding_update(&red_win, red_samples[i]);
        printf("Sliding IR mean = %d, RED mean = %d\n", ir_mean, red_mean);
    }
    return 0;
}
