package main
import (
	"fmt"
	"os"
	"math/big"
)

func ackr(m big.Int, n big.Int) big.Int {
	two := big.NewInt(2)
	z := big.NewInt(0)
	if m.Cmp(z)==0 {
		n.Add(&n, big.NewInt(1))
		return n
	}
	if m.Cmp(big.NewInt(1))==0 {
		n.Add(&n, two)
		return n
	}
	if m.Cmp(big.NewInt(2))==0 {
		n.Exp(two, &n, z)
		return n
	}
	if m.Cmp(big.NewInt(3))==0 {
		n.Sub(n.Exp(two, n.Add(&n, big.NewInt(3)), z), big.NewInt(3))
		return n
	}
	if m.Cmp(big.NewInt(4))==0 {
		n.Sub(n.Exp(two, n.Exp(two, n.Exp(two, n.Exp(two, &n, z), z), z), z), big.NewInt(3))
		return n
	}
	if m.Cmp(big.NewInt(5))==0 {
		if n.Cmp(z)==0 {
			n.Sub(n.Exp(two, n.Exp(two, n.Exp(two, n.Exp(two, big.NewInt(1), z), z), z), z), big.NewInt(3))
			return n
		}
		if n.Cmp(big.NewInt(1))==0 {
			// not possible
			n.Sub(n.Exp(two, n.Exp(two, n.Exp(two, n.Exp(two, big.NewInt(65536), z), z), z), z), big.NewInt(3))
			return n
		}
	}
	return *big.NewInt(0)
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

		a := ackr(*m, *n)

		fmt.Println(a.String())
	} else {
		fmt.Println("Need 2 arguments")
	}
	
}
