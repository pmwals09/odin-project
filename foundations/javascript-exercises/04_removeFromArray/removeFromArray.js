const removeFromArray = function (arr, ...vals) {
  return arr.filter((ea) => !vals.includes(ea));
};

// Do not edit below this line
module.exports = removeFromArray;
