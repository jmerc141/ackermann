// try --max-stack-size=NUM
// or --stack-size=NUM

function ack(m, n) {
 return m === 0 ? n + 1 : ack(m - 1, n === 0  ? 1 : ack(m, n - 1));
}

var args = process.argv.slice(2);

console.log(ack(parseInt(args[0]), parseInt(args[1])));
