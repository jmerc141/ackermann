/*
math/big runs out of order for m>1 n>1
*/
package main
import (
	"fmt"
	"os"
	"math/big"
)

func ackr(m uint64, n uint64) uint64 {

	if m == 0 {
		return n+1
	}
	if m>0 && n==0 {
		return ackr(m-1,1)
	}
	if m>0 && n>0 {
		return ackr(m-1, ackr(m,n-1))
	}
	
	return 0
}

func main() {
	args := os.Args
	if len(args) == 3 {
		m := new(big.Int)
		m, err := m.SetString(args[1], 10)
		if !err {
			panic(err)
		}

		n := new(big.Int)
		n, ok := n.SetString(args[2], 10)
		if !ok {
			panic(ok)
		}

		a := ackr(m.Uint64(), n.Uint64())

		fmt.Println(a)
	} else {
		fmt.Println("Needs 3 arguments")
	}
	
}