const sumAll = function (a, b) {
  if (a < 0 || b < 0) return "ERROR";
  if (typeof a !== "number" || typeof b !== "number") return "ERROR";
  let res = 0;
  let start, end;
  if (a > b) {
    start = b;
    end = a;
  } else {
    start = a;
    end = b;
  }
  for (let i = start; i <= end; i++) {
    res += i;
  }
  return res;
};

// Do not edit below this line
module.exports = sumAll;
