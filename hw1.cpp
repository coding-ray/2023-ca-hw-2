#include <stdint.h>
#include <iostream>
#include <cstdio>   


// count how many zeros forwards input number
uint16_t count_leading_zeros(uint64_t x)
{
    x |= (x >> 1);
    x |= (x >> 2);
    x |= (x >> 4);
    x |= (x >> 8);
    x |= (x >> 16);
    x |= (x >> 32);

    /* count ones (population count) */
    x -= ((x >> 1) & 0x5555555555555555 );
    x = ((x >> 2) & 0x3333333333333333) + (x & 0x3333333333333333);
    x = ((x >> 4) + x) & 0x0f0f0f0f0f0f0f0f;
    x += (x >> 8);
    x += (x >> 16);
    x += (x >> 32);

    return (64 - (x & 0x7f));
}


int main(){
    uint64_t testA = 0x0000000000000000;
    uint64_t testB = 0x0000000000000001;
    uint64_t testC = 0x00000C0000000001;
    uint64_t testD = 0xFF00000000000000;
    printf("%d\n", count_leading_zeros(testA));
    printf("%d\n", count_leading_zeros(testB));
    printf("%d\n", count_leading_zeros(testC));
    printf("%d\n", count_leading_zeros(testD));
}