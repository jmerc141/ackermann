// Stack implementation in C

#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

// limited to int max
/* 222164505 is the max stack size before something
  goes wrong, idk what
  268,435,455 will give array too large error
  214,748,364
  Stack could be 1.7 GigaBytes
  Decrease 20000000000 to increase stack size
*/
#define MAX (ULONG_MAX / 20000000000)


unsigned long long int count = 0;

// Creating a stack
struct stack {
  unsigned long long int items[MAX];   // 8 bytes each
  unsigned int top;          // +4 bytes
};
typedef struct stack st;

void createEmptyStack(st *s) {
  s->top = -1;
}

// Check if the stack is full
int isfull(st *s) {
  if (s->top == MAX - 1)
    return 1;
  else
    return 0;
}

// Check if the stack is empty
int isempty(st *s) {
  if (s->top == -1)
    return 1;
  else
    return 0;
}

// Add elements into stack
void push(st *s, int newitem) {
  if (isfull(s)) {
    printf("STACK FULL");
  } else {
    s->top++;
    s->items[s->top] = newitem;
  }
  count++;
}

// Remove element from stack
void pop(st *s) {
  if (isempty(s)) {
    printf("\n STACK EMPTY \n");
  } else {
    //printf("Item popped= %d", s->items[s->top]);
    s->top--;
  }
  count--;
  //printf("\n");
}

// Print elements of stack
void printStack(st *s) {
  printf("Stack: ");
  for (int i = 0; i < count; i++) {
    printf("%llu ", s->items[i]);
  }
  printf("\n");
}

// Driver code
/*
int main() {
  int ch;
  st *s = (st *)malloc(sizeof(st));

  createEmptyStack(s);

  push(s, 1);
  push(s, 2);
  push(s, 3);
  push(s, 4);

  printStack(s);

  pop(s);

  printf("\nAfter popping out\n");
  printStack(s);
}
*/
