# Python program to illustrate Ackermann function

import sys, time

count = 0

def A(m, n):
	#sglobal count
	#count += 1
	if m == 0:
		return n + 1
	elif m > 0 and n == 0:
		return A(m - 1, 1)
	elif m > 0 and n > 0:
		return A(m-1, A(m, n-1))


# if return value is more than recursionlimit
# then a maximum recursion depth error will occur
recursionlimit = 65536
sys.setrecursionlimit(recursionlimit)

# number of digits that n can be
inputlimit = 4300
sys.set_int_max_str_digits(inputlimit)

m = int(sys.argv[1])
n = int(sys.argv[2])
start = time.perf_counter()
print("Value:", A(m, n))
print("Calls:", count)
print(time.perf_counter() - start)
