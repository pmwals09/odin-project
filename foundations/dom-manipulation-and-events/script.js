const container = document.querySelector("#container");

const p = document.createElement("p");
p.innerText = "Hey I'm red";
p.style.color = "red";
container.appendChild(p);

const h3 = document.createElement("h3");
h3.innerText = "I'm a blue h3!";
h3.style.color = "blue";
container.appendChild(h3);

const div = document.createElement("div");
div.style.border = "1px solid black";
div.style.backgroundColor = "pink";
const divh1 = document.createElement("h1");
divh1.innerText = "I'm in a div";
const divp = document.createElement("p");
divp.innerText = "ME TOO!";
div.appendChild(divh1);
div.appendChild(divp);
container.appendChild(div);
