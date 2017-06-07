require_relative 'Game.rb'
require_relative 'Card.rb'
class Board

  attr_accessor :board_array, :pattern_hash, :position_hash

  def initialize
    @board_array = Array.new(4) { Array.new(4) }

    @pattern_hash = {
      flower: 0,
      shovel: 0,
      rake: 0,
      gloves: 0,
      bee: 0,
      weed: 0,
      rabbit: 0,
      tomato: 0
    }

    @position_hash = Hash.new
  end

  def populate
    @board_array.each_with_index do |row, row_index|
      row.each.with_index do |cell, col_index|
        unless cell
          cell_value = assign_key
          position_array = [row_index, col_index]
          new_card = Card.new(cell_value, position_array)
          @position_hash[[row_index, col_index]] = new_card
          @board_array[row_index][col_index] = cell_value
        end
      end
    end

  end#of populate method



    def assign_key
      symbol = @pattern_hash.keys[rand(0...@pattern_hash.length)]
      # symbol = @pattern_array[rand(0...@pattern_hash.length)][0]
      if valid_key?(symbol)
        @pattern_hash[symbol] += 1
        return symbol
      else
        assign_key
      end
    end

    def valid_key?(symbol)
      return true if @pattern_hash[symbol] < 2
      false
    end

    # def game_over?
    #   return true if #none of the cells are hidden
    #   false
    # end

    def render
      @board_array.each_with_index do |row, row_index|
        row.each_with_index do |cell, col_index|
          if @position_hash[[row_index, col_index]].hidden
            print '______'
          else
            print cell.to_s
          end
        end
        print "\n"
      end
    end

    def game_over?
      @board_array.each_with_index do |row, row_index|
        row.each_with_index do |cell, col_index|
          current_card = @position_hash[[row_index, col_index]]
          return false if current_card.hidden
        end
      end
      true
    end

end#of class
