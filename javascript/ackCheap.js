function ack(m, n) {
    switch(m){
    case 0:
        return n + 1n;
    case 1:
        return n + 2n;
    case 2:
        return (2n * n) + 3n;
    case 3:
        return 2n**(n + 3n) - 3n;
    case 4:
        return (2n**2n**2n**2n**n) - 3n;
    case 5:
        if(n==0){return (2n**2n**2n**2n**1n) - 3n;}
        if(n==1){return (2n**2n**2n**2n**65536n) - 3n;}

    }
}

var args = process.argv.slice(2);

console.log(ack(parseInt(args[0]), BigInt(args[1])));
