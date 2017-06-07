
require_relative 'piece'
require_relative 'display'

class Board
  attr_reader :grid

  def initialize
    @grid = Array.new(8) {Array.new(8) {NullPiece.instance}}
    @null_piece = NullPiece.instance

    8.times do |row_idx|
      8.times do |col_idx|
        if row_idx == 1
          @grid[row_idx][col_idx] = Pawn.new(:black)
        elsif row_idx == 6
          @grid[row_idx][col_idx] = Pawn.new(:white)
        end

      end
    end

  end


  def move_piece(start_pos, finish_pos)
    if self[start_pos].is_a?(NullPiece)
      raise StandardError, "no piece at start position"
      #build below logic into subclasses of pieces
    elsif self[start_pos].color == self[finish_pos].color#color is not own color
      raise StandardError, "you can't destroy your own piece"
    # elsif #.valid_move?(finish_pos) == false
    #   raise StandardError, "piece cannot move to end position"
    else
      # self[start_pos], self[finish_pos] = self[finish_pos], self[start_pos]

      first_pos_arr = self[start_pos]
      self[start_pos] = self[finish_pos]
      self[finish_pos] = first_pos_arr
    end
  end

  def [](pos)
    x, y = pos
    @grid[x][y]
  end

  def []=(pos, value)
    x, y = pos
    @grid[x][y] = value
  end

  def inbounds(position)
    position.all? { |pos| pos.between?(0, 7) }
  end

end#of class

if __FILE__ == $0
  board = Board.new
  display = Display.new(board)
  display.render

  begin
    board.move_piece([1, 0], [5, 5])
  rescue
    "lalalaal"
  end

  display.render
end
