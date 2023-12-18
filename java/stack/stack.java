/*
	Java program to illustrate Ackermann function
	stack implemetnation
*/

import java.math.BigInteger;
import java.util.Date;
import java.util.List;
import java.util.ArrayList;

class Stack
{
	private static int count;
	private static List<BigInteger> st = new ArrayList<BigInteger>();
	private static int i=0;

	static BigInteger ack(int m, BigInteger n)
	{
		st.add(BigInteger.valueOf(m));
		BigInteger res = n;
		
		while(st.size() > 0){
			if(st.get(i).compareTo(BigInteger.ZERO) == 1 && res.compareTo(BigInteger.ZERO) == 1){
				st.add(st.get(i));
				st.set(i, st.get(i).subtract(BigInteger.ONE));
				res = res.subtract(BigInteger.ONE);
				i++;
			} else if (st.get(i).compareTo(BigInteger.ZERO) == 1 && res.equals(BigInteger.ZERO)) {
				st.set(i, st.get(i).subtract(BigInteger.ONE));
				res = BigInteger.ONE;
			} else if (st.get(i).equals(BigInteger.ZERO)) {
				res = res.add(BigInteger.ONE);
				st.remove(st.size()-1);
				i--;
			}
		}
		return res;		
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
			System.out.println(A);// + "\nLoops: " + count);
			System.out.printf("%.3fs", t / 1000);
			
		}
		else{
			System.out.println("enter 2 arguments");
		}
		
	}
}
