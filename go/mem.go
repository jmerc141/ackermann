/*
big doesn't work because of pointers
*/

package main
import (
	"fmt"
	"os"
	"math/big"
	"strconv"
	"runtime/debug"
	"time"
)

var A = map[string]uint64{}


func ackm(m uint64, n uint64) uint64 {
	sm := strconv.FormatUint(m, 10)
	sn := strconv.FormatUint(n, 10)
	if _, ok := A[sm + " " + sn]; ok {
		
	} else {
		if m==0{
			//newn := n.Add(&n, big.NewInt(1))
			A[sm + " " + sn] = n+1
		} else if n==0 {
			A[sm + " " + sn] = ackm(m-1, 1)
		} else {
			//newn := n.Sub(n, big.NewInt(1))
			A[sm + " " + sn] = ackm(m-1, ackm(m, n-1))
		}
	}
	
	return A[sm + " " + sn]
}


func main() {
	debug.SetMaxStack(3000000000)
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

		start := time.Now()
		a := ackm(m.Uint64(), n.Uint64())
		end := time.Since(start)
		fmt.Println(a, "\n", end)
	} else {
		fmt.Println("Needs 3 arguments")
	}
}