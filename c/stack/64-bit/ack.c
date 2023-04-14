/* C program to illustrate Ackermann function
   may need to edit stack.h MAX to increase stack size

*/

#include <stdio.h>
#include <stdlib.h>
#include <gmp.h>
#include <stack.h>

// Non-recursive form of ackermann, uses a stack struct
unsigned int acknr(int m, mpz_t n){
	st *s = (st *)malloc(sizeof(st));
	createEmptyStack(s);
	push(s,m);

    int i = 0;

    while(1){
    	if (count == 0){
    		break;
    	}
    	if (s->items[i] > 0 && mpz_cmp_ui(n,0) > 0){
    		push(s, s->items[i]);
    		s->items[i]--;
    		mpz_sub_ui(n,n,1);
    		i++;
    	}
    	else if (s->items[i] > 0 && mpz_cmp_ui(n,0) == 0){
    		s->items[i]--;
    		mpz_set_ui(n,1);
    	}
    	else if (s->items[i] == 0){
    		mpz_add_ui(n,n,1);
    		pop(s);
    		i--;
    	}
    }
    return 0;
}

int main(int argc, char *argv[]){
	printf("Start\n");
	if (argc == 3){
		mpz_t resm;
		mpz_init(resm);
		mpz_t resn;
		mpz_init(resn);

		mpz_set_str(resm,argv[1],10);
		mpz_set_str(resn,argv[2],10);

		acknr(mpz_get_ui(resm),resn);
		gmp_printf("Big Number: %Zu\n", resn);

		// ack only good for values up to 4294967295
		//unsigned int A = ack(m, n);
		//printf("Value: %u\nCalls: %u\n", A, calls);
		
		mpz_clear(resn);
		mpz_clear(resm);
	}
	else{
		printf("Enter 2 arguments\n");
	}

	return 0;
}

