'''
	ackcheap

	njit is not helpful, 
	only works if result is < 18446744073709551615
	and calc times are not better for those numbers
	
'''

import sys
import time
from sys import platform

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

if __name__ == "__main__":
	# 20,000 digits
	sys.set_int_max_str_digits(56000000)

	m = int(sys.argv[1])
	n = int(sys.argv[2])

	start = time.perf_counter()
	a = ackcheap(m, n)
	nd = time.perf_counter()
	
	#print(a, '\n')
	print(nd-start)
	

