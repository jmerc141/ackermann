'''
	Non recursive form of Ackermann function,
	generally performes better because of recusion depth
	try to implement numba decorator
'''
import sys

loops = 0

def acker(m,n):
    right = [m]
    result = n
    i = 0

    while True:
        #print(right)
        #global loops
        #loops += 1
        if len(right) == 0:
            break

        if right[i] > 0 and result > 0:
            right.append(right[i])
            right[i] -= 1
            result -= 1
            i += 1

        elif right[i] > 0 and result == 0:
            right[i] -= 1
            result = 1

        elif right[i] == 0:
            result += 1
            right.pop()
            i -=1

    return result

print(acker(int(sys.argv[1]), int(sys.argv[2])))
