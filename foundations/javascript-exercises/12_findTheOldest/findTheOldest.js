const findTheOldest = function (people) {
  const year = new Date().getFullYear();
  return people.reduce((out, curr) => {
    const outAge = (out.yearOfDeath ? out.yearOfDeath : year) - out.yearOfBirth;
    const currAge =
      (curr.yearOfDeath ? curr.yearOfDeath : year) - curr.yearOfBirth;
    return currAge > outAge ? curr : out;
  });
};

// Do not edit below this line
module.exports = findTheOldest;
