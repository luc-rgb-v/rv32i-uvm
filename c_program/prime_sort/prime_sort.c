#include <stdint.h>

// memory buffer to store result
#define MAX_SIZE 100

// global arrays stored in .data section
int primes[MAX_SIZE];
int sorted[MAX_SIZE];
int prime_count = 0;

void *memcpy(void *d, const void *s, unsigned n) {
    unsigned char *dd = d;
    const unsigned char *ss = s;
    while (n--) *dd++ = *ss++;
    return d;
}

// check if a number is prime
int is_prime(int n) {
    if (n < 2) return 0;
    for (int i = 2; i * i <= n; i++) {
        if (n % i == 0) return 0;
    }
    return 1;
}

// sort array from biggest to lowest (bubble sort)
void sort_desc(int arr[], int size) {
    for (int i = 0; i < size - 1; i++) {
        for (int j = 0; j < size - i - 1; j++) {
            if (arr[j] < arr[j + 1]) {
                int temp = arr[j];
                arr[j] = arr[j + 1];
                arr[j + 1] = temp;
            }
        }
    }
}

int main(void) {
    int max_num = 100;

    // step 1: find prime numbers
    for (int num = 2; num <= max_num; num++) {
        if (is_prime(num)) {
            primes[prime_count] = num;
            prime_count++;
        }
    }

    // step 2: copy primes into sorted array
    for (int i = 0; i < prime_count; i++) {
        sorted[i] = primes[i];
    }

    // step 3: sort descending
    sort_desc(sorted, prime_count);

    // done
    // at this point:
    //  - 'primes' contains unsorted primes ascending
    //  - 'sorted' contains primes sorted from biggest to smallest
    //  - 'prime_count' has number of primes found

    while (1) {
        // infinite loop to keep CPU running
    }

    return 0;
}
