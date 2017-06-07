require_relative 'cursor.rb'
require 'colorize'
require 'byebug'

class Display

  ELEMENT_MAP = {
    "Null" => "[ ]",
    "Bishop" => " B ",
    "Rook" => " R ",
    "Knight" => " K ",
    "Pawn" => " * ",
    "Queen" => " Q ",
    "King" => " $ "
  }

  def initialize(board)
    @cursor = Cursor.new([0, 0], board)
    @board = board
  end

  def play
    self.render
    puts "Red indicates cursor. Use arrows to navigate board to new position."
    loop do
      @cursor.get_input
      self.render
      puts "placeholder for text update here"
    end
  end

  def render
    arr = Array.new(8) {[]}
    @board.grid.each_with_index do |row, row_idx|
      mapped_row = row.map.with_index do |el, col_idx|
        if @cursor.cursor_pos == [row_idx, col_idx]
          ELEMENT_MAP[el.name].colorize(:red)
        else
          ELEMENT_MAP[el.name]
        end
      end
      print mapped_row.join("|")
      puts "\n"
    end
    puts "---------------------------------"
  end




end
