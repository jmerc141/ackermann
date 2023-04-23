/*
	18446744073709551615
	20,000,000,000
	
*/

#include <stdio.h>
#include <stdlib.h>
#include <gmp.h>

void ackcheap(mpz_t res, long long unsigned int m, mpz_t n){
	mpz_t two;
	mpz_init_set_ui(two,2);
	mpz_t mod;
	mpz_init_set_ui(mod,2);

	switch(m){
		case 0:
			mpz_add_ui(res, n, 1);
			break;
		case 1:
			mpz_add_ui(res, n, 2);
			break;
		case 2:
			mpz_mul(res, two, n);
			mpz_add_ui(res, res, 3);
			break;
		case 3:
			mpz_add_ui(n,n,3);
			mpz_pow_ui(res,two,mpz_get_ui(n));
			mpz_sub_ui(res,res,3);
			break;
		case 4:
			mpz_pow_ui(res, two, mpz_get_ui(n));
			mpz_pow_ui(res, two, mpz_get_ui(res));
			mpz_pow_ui(res, two, mpz_get_ui(res));
			mpz_pow_ui(res, two, mpz_get_ui(res));
			mpz_sub_ui(res, res, 3);
			break;
		case 5:
			mpz_pow_ui(res, two, mpz_get_ui(n));
			mpz_pow_ui(res, two, mpz_get_ui(res));
			mpz_pow_ui(res, two, mpz_get_ui(res));
			mpz_pow_ui(res, two, mpz_get_ui(res));
			mpz_pow_ui(res, two, mpz_get_ui(res));
			mpz_sub_ui(res, res, 3);
			break;
	}
}

int main(int argc, char *argv[]){
	if (argc == 3){
		mpz_t resm;
		mpz_init(resm);
		mpz_t resn;
		mpz_init(resn);
		mpz_t res;
		mpz_init_set_ui(res, 0);

		mpz_set_str(resm,argv[1],10);
		mpz_set_str(resn,argv[2],10);
		ackcheap(res, mpz_get_ui(resm), resn);
		gmp_printf("Value: %Zu\n", res);

		mpz_clear(resm);
		mpz_clear(resn);
		mpz_clear(res);
	}
	else{
		printf("Please run again with 2 paramters");
		getchar();
	}
	return 0;	

}