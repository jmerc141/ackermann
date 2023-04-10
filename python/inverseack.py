import sys

count = 0

def inverse_ackermann(n):
	global count
	count += 1
	# Check if the input is small enough
	# to solve directly
	if n <= 4:
		return n

	# Divide the problem into
	# two smaller problems
	a = inverse_ackermann(n - 1)
	b = inverse_ackermann(n - 2)

	# Combine the solutions of the
	# two smaller problems
	return a + b

# Define the input
n = int(sys.argv[1])

# Solve the problem using the
# inverse Ackermann algorithm
result = inverse_ackermann(n)

# Print the result
print("Result:", result, "Count:", count)

# This code is contributed by lokeshmvs21.
