# frozen_string_literal: true

require 'pry'

# Player management - player input vs. computer input, etc.
class Player
  def initialize(h_or_c)
    @h_or_c = h_or_c
    @piece = @h_or_c == :human ? 'x' : 'o'
  end

  def play_round(board)
    puts 'Playing round...'
    selection = if @h_or_c == :computer
                  computer_selection board
                else
                  human_selection board
                end
    board.place_move(selection, @piece)
  end

  private

  def human_selection(board)
    puts 'Make your selection from the available positions'
    selection = nil
    loop do
      selection = gets.chomp.to_i
      break if valid_position?(board, selection)

      puts 'Invalid selection - please select another'
    end
    selection
  end

  def computer_selection(board)
    selection = nil
    loop do
      selection = rand(1..9)
      break if valid_position?(board, selection)
    end
    selection
  end

  def valid_position?(board, selection)
    return false if selection > board.size**2

    row = board.get_row_idx(selection)
    col = board.get_col_idx(selection)
    is_nil = board.board[row][col].nil?
    is_empty = board.board[row][col].to_i.between?(1, 9)
    !is_nil and is_empty
  end
end

# Board management - drawing, updating, etc.
class Board
  attr_reader :board, :size

  def initialize(size = 3)
    @board = Array.new(size) { |i| Array.new(size) { |j| i * size + j + 1 } }
    @size = size
  end

  def draw
    puts `clear`
    puts(@board.map { |row| row.join '  ' })
  end

  def winner
    get_winner
  end

  def get_row_idx(selection)
    ((selection - 1) / @size.to_f).floor
  end

  def get_col_idx(selection)
    (selection - 1) % @size
  end

  def place_move(selection, piece)
    row = get_row_idx selection
    col = get_col_idx selection
    @board[row][col] = piece
  end

  private

  def get_winner(board = @board)
    row_winner = wins_by_row board
    col_winner = wins_by_col board
    diagonal_winner_dr = wins_by_down_right board
    diagonal_winner_ur = wins_by_up_right board
    [row_winner, col_winner, diagonal_winner_dr, diagonal_winner_ur].find { |x| !x.nil? }
  end

  def wins_by_row(board = @board)
    winning_row = nil
    board.each do |row|
      winning_row = row[0] if row.all? do |cell|
        cell == row[0] && !cell.nil?
      end
      break if winning_row
    end
    winning_row
  end

  def wins_by_col(board = @board)
    rotated_board = rotate_board board
    wins_by_row rotated_board
  end

  def wins_by_down_right(board = @board)
    diagonal = board.map.with_index { |row, i| row[i] }
    wins_by_row [diagonal]
  end

  def wins_by_up_right(board = @board)
    diagonal = board.map.with_index { |row, i| row[row.length - 1 - i] }
    wins_by_row [diagonal]
  end

  def rotate_board(board = @board)
    new_board = []
    board.each_with_index do |row, i|
      row.each_with_index do |_col, j|
        new_board[j] = [] if new_board[j].nil?
        new_board[j][i] = board[i][j]
      end
    end

    new_board
  end
end

# Game management - who plays when, updating the board, etc.
class Game
  attr_reader :players

  def initialize(player_one, player_two, board)
    @players = [player_one, player_two]
    @board = board
  end

  def play
    play_round until @board.winner
    puts "#{@board.winner} wins!"
  end

  def play_round
    @board.draw
    @players.each { |player| player.play_round @board }
  end
end

p1 = Player.new(:human)
p2 = Player.new(:computer)
board = Board.new
game = Game.new(p1, p2, board)

game.play
