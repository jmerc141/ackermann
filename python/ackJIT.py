# Python program to illustrate Ackermann function
# recursive JIT version, faster but limited to smaller numbers
# not sure why

import sys, time
from numba import njit


@njit
def A(m, n):
	#count += 1
	if m == 0:
		return n + 1
	elif m > 0 and n == 0:
		return A(m - 1, 1)
	elif m > 0 and n > 0:
		return A(m-1, A(m, n-1))



# if return value is more than recursionlimit
# then a maximum recursion depth error will occur
recursionlimit = 262141
sys.setrecursionlimit(recursionlimit)

# number of digits that n can be
inputlimit = 4300
sys.set_int_max_str_digits(inputlimit)

m = int(sys.argv[1])
n = int(sys.argv[2])
start = time.perf_counter()
try:
	print("Value:", A(m, n))
except Exception as e:
	print(e)
print(time.perf_counter() - start)
