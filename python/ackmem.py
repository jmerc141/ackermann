# Python program to illustrate Ackermann function
# uses list to hold previouly calculated values
# takes less time
import sys, time

count = 0
m = int(sys.argv[1])
n = int(sys.argv[2])

memo = {}

def ackmem(m, n):
	global count
	count += 1

	if not (m, n) in memo:
		if m == 0:
			result = n + 1
		elif n == 0:
			result = ackmem(m-1, 1)
		else:
			result = ackmem(m-1, ackmem(m, n-1))
		memo[(m ,n)] = result
	return memo[(m,n)]

if __name__ == '__main__':
	# if return value is more than recursionlimit
	# then a maximum recursion depth error will occur
	recursionlimit = 5000000
	sys.setrecursionlimit(recursionlimit)

	# number of digits that n can be
	inputlimit = 4300
	#sys.set_int_max_str_digits(inputlimit)

	start = time.perf_counter()
	
	print('Value:', ackmem(m,n))

	print("Calls:", count)
	print(time.perf_counter() - start)
	#print(memo)
