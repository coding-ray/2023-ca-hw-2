/* v3-write:
 *   This version optimizes the reversing of 64 bits.
 *
 * Results of performance tests:
 *                     -----------   CSR cycles of test cases   ----------
 *          n_inst_ret    1    2    3    4  avg  avg_nonzero -> percentage
 *   -O0            34  756  735    0  752  561          748        100.0%
 *   -O1            38  235    0    0    0   59          235         31.4%
 *   -O2            37  235    0    0    0   59          235         31.4%
 *   -O3            42  223    0    0    0   59          235         29.8%
 *   -Ofast         42  223    0    0    0   59          235         29.8%
 *   -Os    (undefined reference to memcpy, __ashldi3, __lshrdi3)
 *
 * Results of size tests:
 *          text    data     bss     dec  percentage
 *   -O0    3324       0       0    3324      100.0%
 *   -O1    1012       0       0    1012       30.4%
 *   -O2    1008       0       0    1008       30.3%
 *   -O3    1340       0       0    1340       40.3%
 *   -Ofast 1340       0       0    1340       40.3%
 *   -Os    (undefined reference to __ashldi3, __lshrdi3)
 */

// typedef signed char int8_t;
// typedef short int int16_t;
// typedef int int32_t;
// typedef long long int int64_t;
// typedef unsigned char uint8_t;
typedef unsigned short uint16_t;
typedef unsigned int uint32_t;
typedef long long unsigned int uint64_t;

#define INTERLEAVE_BY_01 0x5555555555555555
#define INTERLEAVE_BY_02 0x3333333333333333
#define INTERLEAVE_BY_04 0x0F0F0F0F0F0F0F0F
#define INTERLEAVE_BY_08 0x00FF00FF00FF00FF
#define INTERLEAVE_BY_16 0x0000FFFF0000FFFF

#if defined __riscv_zicsr && defined __riscv_m
#define FD_STDOUT 1

extern uint32_t write(uint32_t fd, const void *buf, uint32_t count);
extern uint64_t get_n_csr_cycle();
extern uint64_t get_n_instruction_retrieved();

#define PRINT_NEWLINE() write(FD_STDOUT, "\n", 1)

void print_n_instruction_retrieved() {
  uint64_t n_instruction_retrieved = get_n_instruction_retrieved() & 0xFFFFFFFF;

  // 33 chars are defined explicitly
  char buffer[34] = "# of instruction retrieved:     \n";

  // 31 = the index of char right before \n
  int i = 31;
  uint64_t divisor = 10;
  uint64_t quo, rem;
  do {
    quo = n_instruction_retrieved / divisor;
    rem = (n_instruction_retrieved % divisor) / (divisor / 10);
    buffer[i] = rem + '0';
    divisor *= 10;
    i--;
  } while (quo > 0);

  PRINT_NEWLINE();
  write(FD_STDOUT, buffer, 33);
  PRINT_NEWLINE();
}

void print_result_header() {
  // 30 chars, including the newline char.
  char header[] = "is palindrome?    # of cycles\n";
  write(FD_STDOUT, header, 30);
}

void print_result(int is_p, uint64_t csr_cycles) {
  // 30 chars are defined explicitly
  char buffer[31] = "                             \n";
  buffer[13] = is_p ? '1' : '0';

  // 28 = the index of char right before \n
  int i = 28;
  uint64_t divisor = 10;
  uint64_t quo, rem;
  do {
    quo = csr_cycles / divisor;
    rem = (csr_cycles % divisor) / (divisor / 10);
    buffer[i] = rem + '0';
    divisor *= 10;
    i--;
  } while (quo > 0);

  write(FD_STDOUT, buffer, 30);
}
#endif  // __riscv_zicsr && __riscv_m

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
  x -= (x >> 1) & INTERLEAVE_BY_01;
  x = ((x >> 2) & INTERLEAVE_BY_02) + (x & INTERLEAVE_BY_02);
  x = ((x >> 4) + x) & INTERLEAVE_BY_04;
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

#if defined __riscv_zicsr && defined __riscv_m
  print_n_instruction_retrieved();

  // measure the number of CSR cycles for each case
  uint64_t t_old;
  uint64_t t_new;
  int result = 2;
  print_result_header();
  for (int i = 0; i < 4; i++) {
    t_old = get_n_csr_cycle();
    result = is_palindrome(test_cases[i]);
    t_new = get_n_csr_cycle();
    print_result(result, t_new - t_old);
  }
  PRINT_NEWLINE();
#else
  for (int i = 0; i < 4; i++) {
    is_palindrome(test_cases[i]);
  }
#endif  // __riscv_zicsr && __riscv_m
  return 0;
}