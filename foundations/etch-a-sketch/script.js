const body = document.querySelector("body");
const resetButton = document.querySelector("button");

// handle reset button click
resetButton.addEventListener("click", handleButtonClick);

// create 16x16 grid
const container = document.createElement("div");
container.classList.add("container");
body.appendChild(container);
draw();

function draw(gridSize = 16) {
  container.innerHTML = "";
  for (let i = 0; i < gridSize; i++) {
    for (let j = 0; j < gridSize; j++) {
      const square = document.createElement("div");
      square.classList.add("square");
      square.style.width = `${(1 / gridSize) * 100}%`;
      square.style.paddingBottom = `${(1 / gridSize) * 100}%`;
      square.addEventListener("mouseenter", handleMouseEnter);
      container.appendChild(square);
    }
  }
}
function handleButtonClick(e) {
  const squares = document.querySelectorAll(".square");
  squares.forEach((square) => square.classList.remove("pencil"));
  let gridSize = prompt("What grid size?");
  if (gridSize > 100) {
    alert("Sorry, maximum grid size of 100!");
    gridSize = 100;
  }
  draw(gridSize);
}

function handleMouseEnter(e) {
  // e.target.classList.add("pencil");

  // e.target.style.backgroundColor = `#${Math.round(
  //   Math.random() * 256 ** 3
  // ).toString(16)}`;

  const bg = e.target.style.backgroundColor.match(/\((.*)\)/);
  if (bg) {
    const [r, g, b, a] = bg[1].split(",");
    const newA = Math.min(+a + 0.1, 1);
    e.target.style.backgroundColor = `rgba(0,0,0,${newA})`;
  } else {
    e.target.style.backgroundColor = `rgba(0,0,0,0.1)`;
  }
}
