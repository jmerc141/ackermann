#ackcheap
import sys

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
		return (2**2**2**2**2**n) - 3


if __name__ == "__main__":
	m = int(sys.argv[1])
	n = int(sys.argv[2])

	# 20,000 digits
	sys.set_int_max_str_digits(20000)

	print(ackcheap(m, n))
