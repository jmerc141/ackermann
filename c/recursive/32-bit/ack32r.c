/* C program to illustrate Ackermann function

	32 bit recursive version

   n must be < 4294967295, this is because it is
   compiled using a 32 bit compiler and therefore 
   has a 32 bit limitation for integers

   Cannot use gmp because a recursive function by definition
   must return and C cannot return struct types
   and may not return because of recursion depth
*/

#include <stdio.h>
#include <stdlib.h>

static unsigned int count = 0;

unsigned long long int ack(int m, unsigned int n)
{
	count++;
	if (m == 0){
		return n+1;
	}
	else if((m > 0) && (n == 0)){
		return ack(m-1, 1);
	}
	else if((m > 0) && (n > 0)){
		return ack(m-1, ack(m, n-1));
	}
	return 0;
}

int main(int argc, char *argv[]){
	unsigned long int A;

	if (argc == 3){
		char *ptrm;
		char *ptrn;
		unsigned int m = strtoul(argv[1], &ptrm, 10);
		unsigned long n = strtoul(argv[2], &ptrn, 10);
		A = ack(m, n);
		printf("Value: %lu\nCalls: %u\n", A, count);
		
	}
	else{
		printf("Please run again with 2 paramters");
		getchar();
	}
	return 0;	
}

// This code is contributed by Amiya Rout
