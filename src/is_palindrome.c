#include <stdint.h> // uint_16_t, uint64_t
#include <unistd.h> // write
#define FD_STDOUT 1

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

void print_result(int result) {
  char buffer[] = {'\0', '\n', '\0'};
  buffer[0] = result ? '1' : '0';
  write(FD_STDOUT, buffer, 4);
}

int main() {
  uint64_t test_1 = 0x0000000000000000;  // palindrome
  uint64_t test_2 = 0x0000000000000001;  // not palindrome
  uint64_t test_3 = 0x00000C0000000003;  // palindrome
  uint64_t test_4 = 0x0F000000000000F0;  // not palindrome
  print_result(is_palindrome(test_1));
  print_result(is_palindrome(test_2));
  print_result(is_palindrome(test_3));
  print_result(is_palindrome(test_4));
  return 0;
}