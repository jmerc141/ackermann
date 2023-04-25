'''
	Non recursive form of Ackermann function,
	generally performes better because of recusion depth
	
    to run normal stack, comment @njit out
'''
import sys, time
from numba import njit, types

loops = 0

@njit(types.uint64(types.uint64, types.uint64), fastmath=True, cache=True)
def old_stack(m,n):
    right = [m]
    result = n
    i = 0

    while True:
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

if __name__ == "__main__":
    start = time.perf_counter()
    ack = old_stack(int(sys.argv[1]), int(sys.argv[2]))
    end = time.perf_counter()

    print('%u\n%f seconds' %(ack, (end-start)))

