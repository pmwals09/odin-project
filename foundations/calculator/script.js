const numbers = document.querySelectorAll(".number");
const operators = document.querySelectorAll(".operator");
const accessories = document.querySelectorAll(".accessory");
const display = document.querySelector(".display");
let total = 0;
let displayVal = 0;
let operator = "";
let shouldClear = false;

numbers.forEach((number) => {
  number.addEventListener("click", handleNumberClick);
});

accessories.forEach((accessory) => {
  accessory.addEventListener("click", handleAccessoryClick);
});

operators.forEach((operator) => {
  operator.addEventListener("click", handleOperatorClick);
});

function handleNumberClick(e) {
  debugger;
  const oldVal = display.innerHTML;
  const n = e.target.innerText;
  if ([0, "0"].includes(displayVal) || shouldClear) {
    displayVal = n;
    if (shouldClear) shouldClear = false;
  } else {
    displayVal = oldVal + n;
  }
  drawDisplay(displayVal);
}

function handleAccessoryClick(e) {
  const buttonName = e.target.innerText;
  const options = {
    AC: () => {
      debugger;
      if ([0, "0"].includes(displayVal) && operator) {
        total = 0;
        operator = "";
      }
      displayVal = 0;
    },
    "+/-": () => (displayVal *= -1),
    "%": () => (displayVal /= 100),
  };

  options[buttonName]();
  drawDisplay(displayVal);
}

function handleOperatorClick(e) {
  debugger;
  const op = e.target.innerText;
  setOp(op);
}

function drawDisplay(val) {
  displayVal = val;
  if ([0, "0"].includes(total)) total = displayVal;
  display.innerHTML = displayVal;
}

function setOp(op) {
  if (operator) {
    total = operate({ op: operator, a: total, b: displayVal });
    displayVal = total;
    drawDisplay(displayVal);
    operator = op === "=" ? "" : op;
  } else {
    operator = op;
  }
  shouldClear = true;
}

function operate({ op, a, b }) {
  debugger;
  const operations = {
    "/": () => +a / +b,
    x: () => +a * +b,
    "-": () => +a - +b,
    "+": () => +a + +b,
  };
  return operations[op]();
}
