/* C program to illustrate Ackermann function

	32 bit recursive version

   n must be < 18446744073709551614

   Cannot use gmp because a recursive function by definition
   must return and C cannot return struct types
   and may not return because of recursion depth
*/

#include <stdio.h>
#include <stdlib.h>

static unsigned int count = 0;
static unsigned int mem[0][0];

unsigned long long int ack(int m, unsigned long long int n){
	count++;
	unsigned long long int res;
	if (mem[m][n] != NULL){
		if (m == 0){
			res = n+1;
		}
		else if((m > 0) && (n == 0)){
			res = ack(m-1, 1);
		}
		else if((m > 0) && (n > 0)){
			res = ack(m-1, ack(m, n-1));
		}
		mem[m][n] = res;
		return res;
	}
	
}

int main(int argc, char *argv[]){
	unsigned long long int A;

	if (argc == 3){
		char *ptrm;
		char *ptrn;
		unsigned long long int m = strtoull(argv[1], &ptrm, 10);
		unsigned long long int n = strtoull(argv[2], &ptrn, 10);
		mem[m][n];
		A = ack(m, n);
		printf("Value: %llu\nCalls: %u\n", A, count);
		
	}
	else{
		printf("Please run again with 2 paramters");
		getchar();
	}
	return 0;	
}

