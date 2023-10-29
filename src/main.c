#include <stdint.h>  // uint_16_t, uint64_t
#include <stdio.h>   // printf

#define FD_STDOUT 1

#define INTERLEAVE_BY_01 0x5555555555555555
#define INTERLEAVE_BY_02 0x3333333333333333
#define INTERLEAVE_BY_04 0x0F0F0F0F0F0F0F0F
#define INTERLEAVE_BY_08 0x00FF00FF00FF00FF
#define INTERLEAVE_BY_16 0x0000FFFF0000FFFF

#ifdef __riscv_zicsr
extern uint64_t get_cycles();
extern uint64_t get_instret();
#endif  // __riscv_zicsr

// return the number of leading zeros in "input in binary"
uint16_t count_leading_zeros(uint64_t x) {
  // fill ones on the right of the first set bit (one)
  x |= (x >> 1);
  x |= (x >> 2);
  x |= (x >> 4);
  x |= (x >> 8);
  x |= (x >> 16);
  x |= (x >> 32);

  // count ones with population count
  x -= (x >> 1) & 0x5555555555555555;
  x = ((x >> 2) & 0x3333333333333333) + (x & 0x3333333333333333);
  x = ((x >> 4) + x) & 0x0f0f0f0f0f0f0f0f;
  x += x >> 8;
  x += x >> 16;
  x += x >> 32;
  return 64 - (x & 0x7f);
}

int is_palindrome(uint64_t x) {
  uint64_t n_leading_zero = count_leading_zeros(x);
  // n_bit = number of bits to detect palindrome
  uint64_t n_bit = 64 - n_leading_zero;
  uint64_t is_even = n_bit % 2;

  // a = left half of input
  uint64_t a = x >> (n_bit / 2 + is_even);

  // b = right half of input x
  uint64_t n_left_shift = n_bit / 2 + is_even + (64 - n_bit);
  uint64_t b = (x << n_left_shift) >> n_left_shift;

  // reverse a
  uint64_t r = a;
  r = ((r >> 1) & INTERLEAVE_BY_01) + ((r & INTERLEAVE_BY_01) << 1);
  r = ((r >> 2) & INTERLEAVE_BY_02) + ((r & INTERLEAVE_BY_02) << 2);
  r = ((r >> 4) & INTERLEAVE_BY_04) + ((r & INTERLEAVE_BY_04) << 4);
  r = ((r >> 8) & INTERLEAVE_BY_08) + ((r & INTERLEAVE_BY_08) << 8);
  r = ((r >> 16) & INTERLEAVE_BY_16) + ((r & INTERLEAVE_BY_16) << 16);
  r = (r >> 32) + (r << 32);
  r >>= n_left_shift;

  if (r == b)
    return 1;
  else
    return 0;
}

int main() {
  uint64_t test_cases[] = {
      0x0000000000000000,  // palindrome
      0x0000000000000001,  // not palindrome
      0x00000C0000000003,  // palindrome
      0x0F000000000000F0,  // not palindrome
  };

#ifdef __riscv_zicsr
  // print number of instruction retrieved
  uint64_t n_instruction_retrieved = get_instret();
  printf("n_instruction_retrieved: %ld\n",
         (uint32_t)(n_instruction_retrieved & 0xffffffff));

  // measure the number of CSR cycles for each case
  uint64_t t_old;
  uint64_t t_new;
  int result = 2;
  for (int i = 0; i < 4; i++) {
    t_old = get_cycles();
    result = is_palindrome(test_cases[i]);
    t_new = get_cycles();
    printf("result: %d\t", result);
    printf("cycle count: %llu\n", t_new - t_old);
  }
#else
  int result = 2;
  for (int i = 0; i < 4; i++) {
    result = is_palindrome(test_cases[i]);
    printf("result: %d\n", result);
  }
#endif  // __riscv_zicsr
  return 0;
}