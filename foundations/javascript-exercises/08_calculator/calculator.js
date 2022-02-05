const add = function (a, b) {
  return a + b;
};

const subtract = function (a, b) {
  return a - b;
};

const sum = function (arr) {
  return arr.reduce((sum, n) => sum + n, 0);
};

const multiply = function (arr) {
  return arr.reduce((tot, n) => tot * n, 1);
};

const power = function (n, exp) {
  return Math.pow(n, exp);
};

const factorial = function (n) {
  if (n === 0) return 1;
  return n * factorial(n - 1);
};

// Do not edit below this line
module.exports = {
  add,
  subtract,
  sum,
  multiply,
  power,
  factorial,
};
