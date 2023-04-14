/* C program that repcates Ackermann function
	using a stack struct

	32 bit stack version

	This was compiled with a 32 bit compiler
	but uses the gmp library so n essentially has no limitation
	m is limited to 32 bit unsigned long int MAX
	but good luck getting past 5

	0 n - n can be any number
	1 n - n must be below 214748362 because of stack size
	2 n -
	3 n - 
	
*/

#include <stdio.h>
#include <stdlib.h>
#include <gmp.h>
#include <stack.h>

static unsigned int calls = 0;

void bar(unsigned int l){
	for(int i=0;i<l;i++){
		printf("%s", "#");
	}
	printf("\n");
}

void acknr(unsigned long long int m, mpz_t n){
	st *s = (st *)malloc(sizeof(st));
	createEmptyStack(s);
	push(s,m);
    int i = 0;

    while(1){
    	calls++;
    	//bar(count);
    	//printStack(s);
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
    //return 0;
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
		gmp_printf("\nValue: %Zu\nLoops: %u", resn, calls);
		
		mpz_clear(resn);
		mpz_clear(resm);
	}
	else{
		printf("Enter 2 arguments\n");
	}

	return 0;
}

