# Python program to illustrate Ackermann function
# thread stack size is limited on windows but not linux

import sys, time
from multiprocessing.pool import Pool
from concurrent.futures import ThreadPoolExecutor

count = 0
m = int(sys.argv[1])
n = int(sys.argv[2])

mem = {}

def A(m, n):
	global count
	count += 1
	if m == 0:
		return n + 1
	elif n == 0:
		return A(m-1, 1)
	else:
		return A(m-1, A(m, n-1))

def amem(m, n):
	global count
	count += 1
	if (m, n) not in mem:
		if m == 0:
			result = n + 1
		elif n == 0:
			result = amem(m-1, 1)
		else:
			result = amem(m-1, amem(m, n-1))
		mem[(m ,n)] = result
	return mem[(m, n)]

def trypool():
	with Pool() as pool:
		l = []
		for i in range(m+1):
			for j in range(n+1):
				l.append([i,j])

		i=0
		try:
			for r in pool.starmap(A, l):
				mem[(l[i][0], l[i][1])] = r
				i += 1
			print("Value:", r)
			print("Calls:", count)
			print(mem)
			print(time.perf_counter() - start)
		except Exception as e:
			print(e, mem, count)

def half():
	with ThreadPoolExecutor(max_workers=5) as ex:
		r0 = ex.submit(amem(0, 0))
		r1 = ex.submit(amem(m-1, n-1))
		r2 = ex.submit(amem(m-1, n))
		r3 = ex.submit(amem(m, n-1))

		print(amem(m, n))
		print(time.perf_counter() - start)


if __name__ == '__main__':
	# if return value is more than recursionlimit
	# then a maximum recursion depth error will occur
	recursionlimit = 500000
	sys.setrecursionlimit(recursionlimit)

	# number of digits that n can be
	inputlimit = 4300
	sys.set_int_max_str_digits(inputlimit)

	start = time.perf_counter()

	half()
