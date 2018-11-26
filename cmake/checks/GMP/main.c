#include <assert.h>
#include <gmp.h>

int main() {
  mpz_t a, b, c, r1, r2;
  mpz_inits(a, b, c, r1, r2, NULL);

  mpz_add_ui(a, a, 1);
  mpz_add_ui(b, b, 2);
  mpz_add_ui(c, c, 3);

  mpz_mul(r1, a, b);
  mpz_mul(r2, b, c);

  assert(mpz_cmp(r1, r2) < 0);

  return 0;
}
