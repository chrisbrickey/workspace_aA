class Board

  attr_reader :board

  def initialize(side_length)
    @board = Array.new(side_length) { Array.new(side_length) }

    @board.each_with_index do |row, row_index|
      row.map!.with_index do |cell, col_index|
        #top and bottom rows all closed
        if row_index == 0 || row_index == side_length - 1
          "X"
        #right and left columns only 1 opening
        elsif col_index == 0 || col_index == side_length - 1
          coin_toss = rand(0..side_length - 1)
          col_index == coin_toss ? "O" : "X"
        #all 'internal' cells get random assignment
        #need to change below to make paths
        else
          coin_toss = rand(1..2)
          coin_toss == 1 ?  "X" : "O"
      end
    end

    def display
      @board.each_with_index do |row, row_index|
        row.each_with_index do |cell, col_index|
          row.length.times { print "#{cell} " }
      end
      print "\n"
    end



  end#of Board class


end


class Game

  puts "How big should the board be?"
  side_length = $stdin.gets.chomp
  new_board = Board.new(side_length)

  # print "Name of Player1: "
  # Player.new($stdin.gets.chomp)
  #
  # print "Name of Player1: "
  # Player.new($stdin.gets.chomp)

  new_board.diplay

  # until game_over?
  #
  #
  # end
  #
  # def game_over?
  #
  # end

  puts "GAME OVER"
  exit
end




if __FILE__ == $0
  Game.new
end
