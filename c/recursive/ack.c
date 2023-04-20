/* 
	C program to illustrate Ackermann function
   only good for values up to 18,446,744,073,709,551,615
   and may not return because of recursion depth
*/

#include <stdio.h>
#include <stdlib.h>

static unsigned int count = 0;

unsigned long long int ack(unsigned long long int m, unsigned long long int n)
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
	unsigned long long int A;

	if (argc == 3){
		char *ptrm;
		char *ptrn;

		unsigned long long int m = strtoull(argv[1], &ptrm, 10);
		unsigned long long int n = strtoull(argv[2], &ptrn, 10);
		A = ack(m, n);
		printf("Value: %llu\nCalls: %u\n", A, count);
		
	}
	else{
		printf("Please enter 2 numbers\n", );
		getchar();
	}
	return 0;	
}
