function ack(m, n) {

    if(mem.has(m + " " + n)){
        
    }
    else{
        if(m==0){
            mem.set(m + " " + n, n+1n)
        }
        else if(n==0n){
            mem.set(m + " " + n, ack(m-1, 1n));
        }
        else{
            mem.set(m + " " + n, ack(m-1, ack(m, n-1n)));
        }
    }

    return mem.get(m + " " + n);
}

var args = process.argv.slice(2);
const mem = new Map();

var start = Date.now();
var A = ack(parseInt(args[0]), BigInt(args[1]));
var end = (Date.now() - start) / 1000;
console.log(A + "\n" + end + "s");