require_relative 'Game.rb'

class Board

  attr_accessor :grid

  def initialize
    @grid = File.readlines('grid.txt')
    @grid.map! do |string|
      string.chomp.split(",").map!(&:to_i)
    end
  end

  def render
    @grid.each_with_index do |row|
      row.each_with_index do |tile|
        if tile == 0
          print '_ '
        else
          print "#{tile} "
        end
      end
      print "\n"
    end
  end

  def [](position)
    p position
    row, col = position
    @grid[row][col]
  end

  def []=(position, value)
    row, col = position
    @grid[row][col] = value
  end

  def game_over?
    @grid.each do |row|
      row.each do |tile|
        return false if tile == 0
      end
    end
    true
  end



end
