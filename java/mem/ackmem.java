/*
	Java program to illustrate Ackermann function
	uses recursive memoization

*/
import java.math.BigInteger;
import java.util.Date;
import java.util.HashMap;

class Memo
{
	static int count;

	static HashMap<String, BigInteger> mem = new HashMap<String, BigInteger>();

	static BigInteger ack(int m, BigInteger n)
	{
		//count++;
		if(mem.keySet().contains(m + " " + n)){
			//System.out.println(m + " " + n);
		}
		else{
			if (m == 0)
			{
				mem.put(m + " " + n, n.add(BigInteger.ONE));
			}
			else if((n.equals(BigInteger.ZERO)))
			{
				mem.put(m + " " + n, ack(m - 1, BigInteger.ONE));
			}
			else
			{
				mem.put(m + " " + n, ack(m - 1, ack(m, n.subtract(BigInteger.ONE))));
			}
		}
		
		return mem.get(m + " " + n);
		
	}

	// Driver code
	public static void main(String args[])
	{
		if(args.length == 2){
			BigInteger n, A;
			int m = Integer.valueOf(args[0]);
			n = new BigInteger(args[1]);

			long start = new Date().getTime();
			A = ack(m, n);
			double t = (new Date().getTime() - start);
			System.out.println(A + "\nLoops: " + count);
			System.out.printf("%.3fs", t / 1000);
			
		}
		else{
			System.out.println("enter 2 arguments");
		}
		
	}
}


