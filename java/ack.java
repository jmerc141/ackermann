// Java program to illustrate Ackermann function
import java.math.BigInteger;
import java.util.Date;

class GFG
{
	static int count;

	static BigInteger ack(int m, BigInteger n)
	{
		//count++;
		if (m == 0)
		{
			return n.add(BigInteger.ONE);
		}
		else if((m > 0) && (n.equals(BigInteger.ZERO)))
		{
			return ack(m - 1, BigInteger.ONE);
		}
		else if((m > 0) && (n.compareTo(BigInteger.ZERO) == 1))
		{
			return ack(m - 1, ack(m, n.subtract(BigInteger.ONE)));
		}else{
			return n.add(BigInteger.ONE);
		}
		
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
			double t = (new Date().getTime() - start) / 1000;
			System.out.println(A + "\nLoops: " + count);
			System.out.printf("%.3fs", t);
			
		}
		else{
			System.out.println("enter 2 arguments");
		}
		
	}
}


