/*
	Java program to illustrate Ackermann function
	No unsigned types in java
	n limited to 2147483647 because pow
		function takes int

*/
import java.math.*;
import java.util.Date;
import java.lang.Math;

class Cheap
{
	static BigInteger ack(int m, BigInteger n)
	{
		BigInteger base = new BigInteger("2");

		switch(m){
		case 0:
			return n.add(BigInteger.ONE);
		case 1:
			return n.add(BigInteger.TWO);
		case 2:
			n = base.pow(n.intValue());
			return n.add(BigInteger.valueOf(3));
		case 3:
			n = n.add(BigInteger.valueOf(3));
			n = base.pow(n.intValue());
			return n.subtract(BigInteger.valueOf(3));
		case 4:
			n = base.pow(base.pow(base.pow(base.pow(n.intValue())
				.intValue()).intValue()).intValue());
			return n.subtract(BigInteger.valueOf(3));
		case 5:
			if(n.equals(BigInteger.ZERO)){
				return base.pow(base.pow(base.pow(base.pow(1)
					.intValue())
					.intValue()).intValue()).subtract(BigInteger.valueOf(3));
			}
			if(n.equals(BigInteger.ONE)){
				return base.pow(base.pow(base.pow(base.pow(65533)
					.intValue())
					.intValue()).intValue()).subtract(BigInteger.valueOf(3));
			}
		}

		return BigInteger.ZERO;
		
	}

	// Driver code
	public static void main(String args[])
	{
		if(args.length == 2){
			BigInteger n, A;
			int m = Integer.valueOf(args[0]);
			n = new BigInteger(args[1]);

			double start = new Date().getTime();
			A = ack(m, n);
			double t = (new Date().getTime() - start);
			System.out.println(A + " " + start + " " + t);
			System.out.printf("%.3fs", t / 1000);
			
		}
		else{
			System.out.println("enter 2 arguments");
		}
		
	}
}


