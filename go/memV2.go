/*
big doesn't work because of pointers
*/

package main
import (
	"fmt"
	"os"
	"math/big"
	"runtime/debug"
	"time"
)

// 7 in decimal (m number) (you wont get past 5)
var m_bits uint64 = 3
// number of bits that can be calculated,
// get out of memory for > 31
var n_bits uint64 = 30
var cache = make([]uint64, 1<<(m_bits + n_bits))


func weird(m uint64, n uint64) uint64 {
	var idx, res uint64
	
	if m==0 {
		return n+1
	}
	if n >= 1<<n_bits {
		fmt.Println(m, n)
		idx=0
	} else {
		idx = (m<<n_bits) + n
		//fmt.Println(cache[idx])
		if cache[idx]!=0 {
			return cache[idx]
		}
	}

	if n==0 {
		res = weird(m-1, 1)
	} else {
		res = weird(m-1, weird(m, n-1))
	}

	if idx!=0 {
		cache[idx] = res
	}

	return res
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
		a := weird(m.Uint64(), n.Uint64())
		end := time.Since(start)
		fmt.Println(a, "\n", end)
	} else {
		fmt.Println("Needs 3 arguments")
	}
}