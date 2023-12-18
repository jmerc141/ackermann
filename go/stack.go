package main
import (
	"fmt"
	"os"
	"math/big"
)

func ackr(m uint64, n big.Int) *big.Int {
	stk := []uint64{m}
	res := &n
	i := 0
	z := big.NewInt(0)
	one := big.NewInt(1)
	
	for len(stk) > 0 {
		if stk[i]>0 && res.Cmp(z)==1 {
			stk = append(stk, stk[i])
			stk[i]--
			res.Sub(res, one)
			i++
		} else if stk[i]>0 && res.Cmp(z)==0 {
			stk[i]--
			res=big.NewInt(1)
		} else if stk[i]==0 {
			res.Add(res, one)
			stk = stk[:len(stk)-1]
			i--
		}
	}
	return res
}


func acks(m uint64, n uint64) uint64 {

	stk := []uint64{m}
	res := n
	i := 0

	for len(stk) > 0 {

		if stk[i]>0 && res>0 {
			stk = append(stk, stk[i])
			stk[i]--
			res--
			i++
		} else if stk[i]>0 && res==0 {
			stk[i]--
			res=1
		} else if stk[i]==0 {
			res++
			stk = stk[:len(stk)-1]
			i--
		}
		
	}
	return res
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

		a := ackr(m.Uint64(), *n)

		fmt.Println(a)
	} else {
		fmt.Println("Needs 3 arguments")
	}
}