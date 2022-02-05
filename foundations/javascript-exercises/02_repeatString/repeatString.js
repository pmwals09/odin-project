const repeatString = function (string, n) {
  if (n < 0) return "ERROR";
  let res = "";
  for (let i = 0; i < n; i++) {
    res += string;
  }
  return res;
};

// Do not edit below this line
module.exports = repeatString;
