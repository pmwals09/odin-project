const buttons = document.querySelectorAll("button");
const playerScore = document.querySelector("#player");
const computerScore = document.querySelector("#computer");
const messageP = document.querySelector(".message");
const score = {
  player: 0,
  computer: 0,
};
buttons.forEach((button) => {
  button.addEventListener("click", handleClick);
});

function handleClick(e) {
  if (Object.values(score).includes(5)) return;
  const playerSelection = e.target.innerText;
  const computerSelection = computerPlay();
  const message = playRound({
    playerSelection,
    computerSelection,
  });
  playerResult = message.split(" ")[1];
  if (playerResult === "Win!") {
    score.player++;
  } else if (playerResult === "Lose!") {
    score.computer++;
  }
  if (Object.values(score).includes(5)) {
    const winner = Object.keys(score).find((ea) => score[ea] === 5);
    messageP.innerText = `${winner[0].toUpperCase() + winner.slice(1)} wins!`;
  } else {
    messageP.innerText = message;
  }
  playerScore.innerText = `Player: ${score.player}`;
  computerScore.innerText = `Computer: ${score.computer}`;
}

const options = ["Paper", "Scissors", "Rock"];

function computerPlay() {
  const index = Math.floor(Math.random() * options.length);
  return options[index];
}

function playRound({ playerSelection, computerSelection }) {
  playerSelection =
    playerSelection.charAt(0).toUpperCase() +
    playerSelection.slice(1).toLowerCase();
  const playerIndex = options.findIndex((ea) => ea === playerSelection);
  const computerIndex = options.findIndex((ea) => ea === computerSelection);

  let result;
  if (computerIndex === 0 && playerIndex === 2) {
    result = "Lose";
  } else if (
    (playerIndex === 0 && computerIndex === 2) ||
    playerIndex > computerIndex
  ) {
    result = "Win";
  } else if (playerIndex === computerIndex) {
    result = "Tie";
  } else {
    result = "Lose";
  }

  const message = `You ${result}! ${getResult({
    playerSelection,
    computerSelection,
    result,
  })}`;

  return message;
}

function getResult({ playerSelection, computerSelection, result }) {
  if (result === "Tie") {
    return `You both picked ${playerSelection}`;
  } else {
    if (result === "Win") {
      return `${playerSelection} beats ${computerSelection}`;
    } else {
      return `${computerSelection} beats ${playerSelection}`;
    }
  }
}

function game() {
  const score = {
    player: 0,
    computer: 0,
  };

  let rounds = 5;
  for (let i = 0; i < rounds; i++) {
    const playerSelection = prompt("CHOOSE YOUR WEAPON: ");
    const computerSelection = computerPlay();

    const result = playRound({ playerSelection, computerSelection });

    playerResult = result.split(" ")[1];
    if (playerResult === "Win!") {
      score.player++;
    } else if (playerResult === "Lose!") {
      score.computer++;
    }
  }

  console.log("Player wins:", score.player);
  console.log("Computer wins:", score.computer);
  console.log(
    `You ${
      score.player > score.computer
        ? "win"
        : score.player === score.computer
        ? "tie"
        : "lose"
    } the match!`
  );
}
