'''
	Non recursive form of Ackermann function,
	generally performes better because of recusion depth
	try to implement numba decorator
'''
import sys
from collections import deque

loops = 0

def acker(m,n):
    right = [m]
    result = n
    i = 0

    while True:
        #print(right)
        #global loops
        #loops += 1
        if len(right) == 0:
            break

        if right[i] > 0 and result > 0:
            right.append(right[i])
            right[i] -= 1
            result -= 1
            i += 1

        elif right[i] > 0 and result == 0:
            right[i] -= 1
            result = 1

        elif right[i] == 0:
            result += 1
            right.pop()
            i -=1

    return result

def ack_ix(m, n):
    "Paddy3118's iterative with optimisations on m"

    stack = deque([])
    stack.extend([m, n])

    while  len(stack) > 1:
        n, m = stack.pop(), stack.pop()

        if   m == 0:
            stack.append(n + 1)
        elif m == 1:
            stack.append(n + 2)
        elif m == 2:
            stack.append(2*n + 3)
        elif m == 3:
            stack.append(2**(n + 3) - 3)
        elif n == 0:
            stack.extend([m-1, 1])
        else:
            stack.extend([m-1, m, n-1])

    return stack[0]

print(acker(int(sys.argv[1]), int(sys.argv[2])))
