#ifndef TESTFUNC_H
#define TESTFUNC_H

#define WINDOW_SIZE 5   // number of samples in sliding window

// Structure to hold mean state
typedef struct {
    uint32_t count;
    int32_t mean;
} MeanFilter;

typedef struct {
    int32_t buffer[WINDOW_SIZE];  // store last N samples
    int32_t sum;                  // sum of samples in buffer
    uint32_t index;               // next position to overwrite
    uint32_t count;               // how many samples have been added
} SlidingMean;

// 
void mean_init(MeanFilter *f);

//
void sliding_init(SlidingMean *f);

//
int32_t mean_update(MeanFilter *f, int32_t sample);

//
int32_t sliding_update(SlidingMean *f, int32_t sample);

#endif