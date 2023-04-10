/* C program to illustrate Ackermann function
   only good for values up to 4294967295 and
   may not return because of recursion depth
*/

#include <stdio.h>
#include <stdlib.h>

static unsigned int count = 0;

unsigned int ack(int m, int n)
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
	unsigned int A;

	if (argc == 3){
		int m = atoi(argv[1]);
		int n = atoi(argv[2]);
		A = ack(m, n);
		printf("Value: %u\nCalls: %u\n", A, count);
		
	}
	return 0;	
}

// This code is contributed by Amiya Rout
