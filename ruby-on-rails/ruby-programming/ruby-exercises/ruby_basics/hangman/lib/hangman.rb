# frozen_string_literal: true

require 'yaml'
require 'date'
require 'pry'

# Hangman game
class Game
  def initialize(word, guesses = [], remaining = 6)
    @word = word.chomp
    @guesses = guesses
    @remaining = remaining
  end

  def play
    draw_field
    while @remaining.positive? && !@word.split('').all? { |c| @guesses.include? c }
      play_round
      draw_field
    end
    puts "You lose! The word was #{@word}" if @remaining.zero?
    puts 'You win!' if @remaining.positive?
  end

  def play_round
    guess = player_guess
    @guesses << guess
    @remaining -= 1 unless @word.include? guess
  end

  def draw_field
    puts `clear`
    @word.each_char do |c|
      @guesses.include?(c) ? print("#{c} ") : print('_ ')
    end
    print "\n"
    puts 'Incorrect letters:'
    puts @guesses.reject { |ea| @word.include? ea }.join(' ')
    puts "Remaining mistakes: #{@remaining}"
  end

  def player_guess
    player_input = nil
    while player_input.nil?
      puts 'Make a guess or save your game.'
      puts 'To save, just type "save" instead of a guess.'
      puts 'To quit, just type "quit" instead of a guess.'
      attempt = gets.chomp.downcase
      player_input = handle_attempt attempt
    end
    player_input
  end

  def handle_attempt(attempt)
    if attempt.match?(/^[a-z]$/) && !@guesses.include?(attempt)
      attempt
    elsif attempt == 'save'
      save_self
      nil
    elsif attempt == 'quit'
      puts 'Good game - goodbye!'
      exit
    end
  end

  def save_self
    Dir.mkdir 'saves' unless Dir.exist? 'saves'
    print 'Filename? '
    filename = gets.chomp
    File.open("./saves/#{filename}.yaml", 'w') do |f|
      f.write YAML.dump(self)
    end
    puts 'Game saved!'
  end
end

# Handles loading or starting a new game
class Loader
  def initialize
    @files = Dir.children 'saves' if Dir.exist? 'saves'
  end

  def load_or_new
    print 'Would you like to load a game from a file? [y/n] '
    case gets.chomp
    when 'y'
      handle_should_load
    when 'n'
      handle_new_game
    else
      puts 'Invalid option. Goodbye!'
      exit
    end
  end

  def handle_should_load
    if @files.nil?
      puts 'No save files available! Loading new game.'
      start_new_game
    else
      puts 'What file would you like to load?'
      load_game @files
    end
  end

  def handle_new_game
    puts 'Loading new game.'
    start_new_game
  end

  def start_new_game
    words = File.readlines('./words.txt')
    word = words.select { |w| w.length >= 5 && w.length <= 12 }.sample.chomp
    game = Game.new word
    game.play
  end

  def load_game(_files)
    puts 'Please select your file by the accompanying number.'
    file_to_load = select_file
    begin
      file_index = file_to_load.to_i - 1
      load_game_file file_index
    rescue StandardError
      puts 'Invalid selection - starting a new game'
      Game.start_new_game
    end
  end

  def select_file
    @files.each_with_index do |f, i|
      puts "#{i + 1}. #{f}"
    end
    gets.chomp
  end

  def load_game_file(file_index)
    File.open("./saves/#{@files[file_index]}", 'r') do |f|
      YAML.safe_load(f, [Game]).play
    end
  end
end

loader = Loader.new
loader.load_or_new
