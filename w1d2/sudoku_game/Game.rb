require_relative 'Board.rb'
# require_relative 'Tile.rb'
require 'pry'

class Game

  attr_accessor :game_board

  def initialize
    @game_board = Board.new
  end

  def play
    game_board.render
    until game_board.game_over?
      prompt
      game_board.render
    end
    p "Game over. Well done!!!"
  end

  def prompt
    p "Please enter a position and number. Format: row, col, value"
    input = gets.chomp.split(", ").map(&:to_i)
    allowed_range = (0..8)
    until input.all? { |num| allowed_range.include?(num) }
      p "Please enter positions and numbers between 0-8"
      prompt
    end

    input_array = [[input[0], input[1]], input[2]]
    if valid_input?(input_array)
      update(input_array)
    else
      p "Not a valid move"
    end
  end


  def valid_input?(input_array)
    if @game_board[input_array] == 0 && valid_move?(input_array)
      update(input_array)
    else
      false
    end
  end

  def update(input_array)
    @game_board.grid[input_array[0]] = input_array[1]
  end

  def valid_move?(input_array)
    if valid_in_row?(input_array)
      if valid_in_column?(input_array)
        if valid_in_square?(input_array)
          return true
        end
      end
    end
    false
  end

  def valid_in_row?(input_array)
    @game_board.grid[input_array[0][0]].each do |tile|
      return false if tile == input_array[1]
    end
    true
  end

  def valid_in_column?(input_array)
    @game_board.grid.each_with_index do |row, row_index|
      target_column = input_array[0][1]
      return false if row[target_column] == input_array[1]
    end
    true
  end

  def valid_in_square?(input_array)
    row_var = square_checker(input_array[0])
    col_var = square_checker(input_array[1])
    (row_var - 2..row_var).each do |row_index|
      (col_var - 2..col_var).each do |col_index|
        return false if @game_board.grid[row_index][col_index] == input_array[1]
      end
    end
    true
  end

  def square_checker(position)
    if (0..2).include?(position[0])
      return 2
    elsif (3..5).include?(position[0])
      return 5
    else
      return 8
    end
  end


end

new_game = Game.new
new_game.play
