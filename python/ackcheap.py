'''
	ackcheap

	njit is not helpful, 
	only works if result is < 18446744073709551615
	and calc times are not better for those numbers
	
'''

import sys
import time
from sys import platform
from hyperop import hyperop

def exp(base, ex, n):
	return base**ex**n

def ackcheap(m, n):
	if m == 0:
		return n + 1
	elif m == 1:
		return n + 2
	elif m == 2:
		return (2 * n) + 3
	elif m == 3:
		return 2**(n + 3) - 3
	elif m == 4: 
		return (2**2**2**2**n) - 3
	elif m == 5:
		if n == 0:
			return (2**2**2**2**1) - 3
		if n == 1:
			# not possible
			return (2**2**2**2**65536) - 3
	elif m == 6:
		H4 = hyperop(4)
		return H4(2,5)

if __name__ == "__main__":
	if platform == "win32":
		# 20,000 digits
		sys.set_int_max_str_digits(56000000)

	m = int(sys.argv[1])
	n = int(sys.argv[2])

	start = time.perf_counter()
	print(ackcheap(m, n), '\n')
	print(time.perf_counter() - start)

