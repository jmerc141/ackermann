/* C program that repcates Ackermann function
	using a stack struct
	edit stack.h MAX size for more memory
	for linux, apt install libgmp3-dev or some gmp library
 	gcc -Wall -g -lgmp acks.c -o {file}
*/

#include <stdio.h>
#include <stdlib.h>
#include <gmp.h>
#include <stack.h>

unsigned int calls = 0;

void acknr(unsigned long long int m, mpz_t n){
	st *s = (st *)malloc(sizeof(st));
	createEmptyStack(s);
	push(s,m);
    int i = 0;

    while(1){
    	calls++;
    	if (count == 0){
    		break;
    	}
    	if (isfull(s)){
    		printf("%s\n", "Stack is full, stopping");
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
}

int main(int argc, char *argv[]){
	if (argc == 3){
		mpz_t resm;
		mpz_init(resm);
		mpz_t resn;
		mpz_init(resn);

		mpz_set_str(resm,argv[1],10);
		mpz_set_str(resn,argv[2],10);

		acknr(mpz_get_ui(resm),resn);
		gmp_printf("Value: %Zu\nLoops: %u", resn, calls);
		
		mpz_clear(resn);
		mpz_clear(resm);
	}
	else{
		printf("Enter 2 arguments\n");
	}

	return 0;
}

