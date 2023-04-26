# Python program to illustrate Ackermann function

import sys, time
from sys import platform

import smtplib
from email.message import EmailMessage

count = 0

def A(m, n):
	#global count
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
		a = A(m, n)
		print("Value:", a)
	except Exception as e:
		print(e)
	print(time.perf_counter() - start)

	msg = EmailMessage()
	msg.set_content(f"({m}, {n}) returned with value: {a}")
	msg['Subject'] = 'ack.py'
	msg['From'] = 'james.merc@yahoo.com'
	msg['To'] = 'james.merc@yahoo.com'
	s = smtplib.SMTP('localhost')
	s.send_message(msg)
	s.quit()