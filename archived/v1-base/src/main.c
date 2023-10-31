/* v1-base:
 *   The version before any optimization.
 *
 * Results of performance tests:
 *                     -----------   CSR cycles of test cases   ----------
 *          n_inst_ret    1    2    3    4  avg  avg_nonzero -> percentage
 *   -O0           720 3674 3653    0 3769 2773         3699        100.0%
 *   -O1           734  923    0    0    0  231          923         25.0%
 *   -O2           734  920    0    0    0  230          920         24.9%
 *   -O3           730  894    0    0    0  224          894         24.2%
 *   -Ofast        730  894    0    0    0  224          894         24.2%
 *   -Os           784  131    0    0    0  229          458         12.4%
 *
 * Results of size tests:
 *          text    data     bss     dec  percentage
 *   -O0    8216    1372     840   10428      100.0%
 *   -O1    6584    1372     840    8796       84.3%
 *   -O2    6580    1372     840    8792       84.3%
 *   -O3    6912    1372     840    9124       87.5%
 *   -Ofast 6912    1372     840    9124       87.5%
 *   -Os    6564    1372     840    8776       84.2%
 */
#include <stdint.h>  // uint_16_t, uint64_t

#define FD_STDOUT 1

#ifdef __riscv_zicsr
#include <stdio.h>   // printf
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
  uint64_t reverse_a = 0;
  uint64_t tmp_a = a;
  for (int i = 0; i < 64; i++) {
    reverse_a <<= 1;
    reverse_a |= tmp_a & 1;
    tmp_a >>= 1;
  }
  reverse_a >>= n_left_shift;

  if (reverse_a == b)
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
  for (int i = 0; i < 4; i++) {
    is_palindrome(test_cases[i]);
  }
#endif  // __riscv_zicsr
  return 0;
}