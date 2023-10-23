#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>

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

bool is_palindrome(uint64_t x) {
  uint64_t n_leading_zero = count_leading_zeros(x);
  // n_bit = number of bits to detect palindrome
  uint64_t n_bit = 64 - n_leading_zero;
  uint64_t is_even = n_bit % 2;

  // a = left half of input
  uint64_t a = x >> (n_bit / 2 + is_even);
  printf("a = 0x%lx\n", a);

  // b = right half of input x
  uint64_t n_left_shift = n_bit / 2 + is_even + (64 - n_bit);
  printf("n_left_shift = %lu\n", n_left_shift);
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
  printf("reverse_a = 0x%lx, b = 0x%lx\n", reverse_a, b);

  if (reverse_a == b)
    return true;
  else
    return false;
}

int main() {
  uint64_t test_1 = 0x0000000000000000;  // palindrome
  uint64_t test_2 = 0x0000000000000001;  // not palindrome
  uint64_t test_3 = 0x00000C0000000003;  // palindrome
  uint64_t test_4 = 0x0F000000000000F0;  // not palindrome
  printf("%d\n\n", is_palindrome(test_1));
  printf("%d\n\n", is_palindrome(test_2));
  printf("%d\n\n", is_palindrome(test_3));
  printf("%d\n", is_palindrome(test_4));
}