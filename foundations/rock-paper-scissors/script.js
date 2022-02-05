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
  if (
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

  console.log(message);
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

game();
