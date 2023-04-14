/* C program to illustrate Ackermann function

	32 bit recursive version

   n must be < 18446744073709551614

   Cannot use gmp because a recursive function by definition
   must return and C cannot return struct types
   and may not return because of recursion depth
*/

#include <stdio.h>
#include <stdlib.h>
#include <hash.h>

static unsigned int count = 0;
static long long unsigned int res;
static long long unsigned int mem[1][1];

void p2d(long long unsigned int m){
	for (int i=0; i<10; i++){
		for (int j=0; j<10; j++){
			printf("%llu ", mem[i][j]);
		}
		printf("\n");
	}
	printf("\n");
}

unsigned long long int ack(int m, unsigned long long int n){
	count++;
	if (mem[m][n] == 0){
		if (m == 0){
			res = n+1;
		}
		else if(n == 0){
			res = ack(m-1, 1);
		}
		else{
			res = ack(m-1, ack(m, n-1));
		}
		mem[m][n] = res;
		printf("add %i,%llu: %llu\n", m,n,mem[m][n]);
	}
	printf("skip %i,%llu: %llu\n", m,n,mem[m][n]);
	p2d(mem);
	return mem[m][n];
	
}


int main(int argc, char *argv[]){
	if (argc == 3){
		unsigned long long int A;
		char *ptrm;
		char *ptrn;
		unsigned long long int m = strtoull(argv[1], &ptrm, 10);
		unsigned long long int n = strtoull(argv[2], &ptrn, 10);
		A = ack(m, n);
		printf("Value: %llu\nCalls: %u\n", A, count);
		
	}
	else{
		printf("Please run again with 2 paramters");
		getchar();
	}
	return 0;	
}

