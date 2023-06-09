'''
	Python program to illustrate Ackermann function
	recursive JIT version, faster but limited < 9223372036854775806
	cannot assign types to function because return type is function,
	not uint64

	try parallel=True
'''

import sys, time
from numba import njit, types
from sys import platform

@njit(fastmath=True)
def A(m, n):
	#count += 1
	if m == 0:
		return n + 1
	elif m > 0 and n == 0:
		return A(m - 1, 1)
	elif m > 0 and n > 0:
		return A(m-1, A(m, n-1))


if __name__ == "__main__":
	if platform == "win32":
		# 20,000 digits
		#sys.set_int_max_str_digits(20000)
		pass

	# if return value is more than recursionlimit
	# then a maximum recursion depth error will occur
	recursionlimit = 262141
	sys.setrecursionlimit(recursionlimit)

	m = int(sys.argv[1])
	n = int(sys.argv[2])
	start = time.perf_counter()
	try:
		print("Value:", A(m, n))
		#print(A.inspect_types())
	except Exception as e:
		print(e)
	print(time.perf_counter() - start)

