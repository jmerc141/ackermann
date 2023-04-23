/*
        memoization version using an array (cache)
        to hold previously calculated values
*/

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

unsigned long long int m_bits, n_bits;
unsigned long long int *cache;
unsigned int count;

unsigned long long int ackermann(int m, unsigned long long int n)
{
        count++;
        int idx, res;
        if (!m) return n + 1;

        if (n >= 1<<n_bits) {
                printf("%d, %llu\n", m, n);
                idx = 0;
        } else {
                idx = (m << n_bits) + n;
                if (cache[idx]) return cache[idx];
        }

        if (!n) res = ackermann(m - 1, 1);
        else    res = ackermann(m - 1, ackermann(m, n - 1));

        if (idx) cache[idx] = res;
        return res;
}

int main(int argc, char *argv[])
{
        unsigned long long int m, n;

        m_bits = 3;
        n_bits = 20;  /* can save n values up to 2**20 - 1, that's 1 meg */
        cache = malloc(sizeof(unsigned long long int) * (1 << (m_bits + n_bits)));
        memset(cache, 0, sizeof(unsigned long long int) * (1 << (m_bits + n_bits)));

        char *ptrm;
        char *ptrn;
        m = strtoull(argv[1], &ptrm, 10);
        n = strtoull(argv[2], &ptrn, 10);

        unsigned long long int A;
        A = ackermann(m, n);
        printf("Value: %llu\nCalls: %u\n", A, count);

        return 0;
}