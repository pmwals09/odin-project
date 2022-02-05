const caesar = function (str, rot) {
  let res = "";
  for (let i = 0; i < str.length; i++) {
    const charCode = str.charCodeAt(i);
    if (!isUpperCase(charCode) && !isLowerCase(charCode)) {
      res += str[i];
    } else {
      res += handleRot(charCode, rot);
    }
  }
  return res;
};

function handleRot(charCode, rot) {
  let newCharCode = charCode + rot;
  let lowerBound, upperBound;
  if (isUpperCase(charCode)) {
    lowerBound = 65;
    upperBound = 90;
  } else {
    lowerBound = 97;
    upperBound = 122;
  }
  if (newCharCode < lowerBound) {
    while (newCharCode < lowerBound) {
      newCharCode = upperBound - (lowerBound - newCharCode - 1);
    }
  }
  if (newCharCode > upperBound) {
    while (newCharCode > upperBound) {
      newCharCode = lowerBound + (newCharCode - upperBound - 1);
    }
  }
  return String.fromCharCode(newCharCode);
}

function isUpperCase(charCode) {
  return charCode >= 65 && charCode <= 90;
}

function isLowerCase(charCode) {
  return charCode >= 97 && charCode <= 122;
}

// Do not edit below this line
module.exports = caesar;
