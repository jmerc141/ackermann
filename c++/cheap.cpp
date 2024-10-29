/**
 * g++ ack.cpp -o ack -std=c++14 -O2 -lgmpxx -lgmp
 * 
 * 
**/
#include <iostream>
#include <gmpxx.h>
#include <sstream>

mpz_class ackermann(long long unsigned int i, mpz_class n);


int main(int argc, char *argv[]) {
    std::cout << ackermann(atoi(argv[1]), mpz_class(argv[2])).get_str(10) + "\n";
}

mpz_class ackermann(long long unsigned int i, mpz_class n) {

    mpz_class res = 0;
    mpz_class one = 1;
    mpz_class two = 2;
    mpz_class five0 = 65533;

    switch(i){
        case 0:
            mpz_add_ui(res.get_mpz_t(), n.get_mpz_t(), 1);
            break;
        case 1:
            mpz_add_ui(res.get_mpz_t(), n.get_mpz_t(), 2);
            break;
        case 2:
            mpz_mul(res.get_mpz_t(), two.get_mpz_t(), n.get_mpz_t());
            mpz_add_ui(res.get_mpz_t(), res.get_mpz_t(), 3);
            break;
        case 3:
            mpz_add_ui(n.get_mpz_t(), n.get_mpz_t(), 3);
            mpz_pow_ui(res.get_mpz_t(), two.get_mpz_t(), n.get_ui());
            mpz_sub_ui(res.get_mpz_t(), res.get_mpz_t(), 3);
            break;
        case 4:
            mpz_pow_ui(res.get_mpz_t(), two.get_mpz_t(), n.get_ui());
			mpz_pow_ui(res.get_mpz_t(), two.get_mpz_t(), res.get_ui());
			mpz_pow_ui(res.get_mpz_t(), two.get_mpz_t(), res.get_ui());
			mpz_pow_ui(res.get_mpz_t(), two.get_mpz_t(), res.get_ui());
			mpz_sub_ui(res.get_mpz_t(), res.get_mpz_t(), 3);
            break;
        case 5:
            if (mpz_cmp_ui(n.get_mpz_t(), 0) == 0){
				// A(4, 1) = A(5, 0)
				mpz_pow_ui(res.get_mpz_t(), two.get_mpz_t(), one.get_ui());
				mpz_pow_ui(res.get_mpz_t(), two.get_mpz_t(), res.get_ui());
				mpz_pow_ui(res.get_mpz_t(), two.get_mpz_t(), res.get_ui());
				mpz_pow_ui(res.get_mpz_t(), two.get_mpz_t(), res.get_ui());
				mpz_sub_ui(res.get_mpz_t(), res.get_mpz_t(), 3);
				break;
			}
			if (mpz_cmp_ui(n.get_mpz_t(), 1) == 0){
				// A(4, 65533) = A(5, 1)
				printf("2^2^2^2^65533, good luck\n");
				break;
			}
			break;
    }

    return res;
}