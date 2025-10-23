#include "common.h"
#include "testfunc.h"

// Initialize filter
void mean_init(MeanFilter *f) {
    f->count = 0;
    f->mean = 0.0;
}

// Update with new sample and return mean
int32_t mean_update(MeanFilter *f, int32_t sample) {
    f->count++;
    f->mean += (sample - f->mean) / (int32_t)f->count;
    return f->mean;
}

void sliding_init(SlidingMean *f) {
    for (int i = 0; i < WINDOW_SIZE; i++)
        f->buffer[i] = 0;
    f->sum = 0;
    f->index = 0;
    f->count = 0;
}

int32_t sliding_update(SlidingMean *f, int32_t sample) {
    // Subtract the oldest sample from sum
    f->sum -= f->buffer[f->index];

    // Add new sample to sum and buffer
    f->buffer[f->index] = sample;
    f->sum += sample;

    // Move index (circular)
    f->index = (f->index + 1) % WINDOW_SIZE;

    // Track count to handle first WINDOW_SIZE samples
    if (f->count < WINDOW_SIZE)
        f->count++;

    // Return mean of current window
    return f->sum / (int32_t)f->count;
}
