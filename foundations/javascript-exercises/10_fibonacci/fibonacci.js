const fibonacci = function (n) {
  if (+n < 0) return "OOPS";
  let a;
  let b = 1;
  let total = 0;
  for (let i = 0; i < +n; i++) {
    a = b;
    b = b + total;
    total = a;
  }

  return total;
};

// Do not edit below this line
module.exports = fibonacci;
