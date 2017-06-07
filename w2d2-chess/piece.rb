# require_relative 'piece.rb'
require 'singleton'

class Piece

  attr_reader :color, :name, :position

  def initialize(color, position)
    # @name = "Piece"
    @color = color
    @position = position
  end

  def morph
    @position
  end


  def valid_moves
    #array of moves that can actually be done (no 'own' piece in the way)
  end

end

class NullPiece < Piece
include Singleton
  def initialize
    @name = "Null"
    @color = nil
  end
end


class Bishop < Piece
  def initialize(color)
    @name = "Bishop"
    @color = color
  end

  def moves #unique to piece subclass
    #array of potential moves
  end
end


class Rook < Piece
  def initialize(color)
    @name = "Rook"
    @color = color
  end

  def moves #unique to piece subclass
    #array of potential moves
  end
end

class Queen < Piece
  def initialize(color)
    @name = "Queen"
    @color = color
  end

  def moves #unique to piece subclass
    #array of potential moves
  end
end

class King < Piece
  def initialize(color)
    @name = "King"
    @color = color
  end

  def moves #unique to piece subclass
    #array of potential moves
  end
end

class Knight < Piece
  def initialize(color)
    @name = "Knight"
    @color = color
  end

  def moves #unique to piece subclass
    #array of potential moves
  end
end

class Pawn < Piece
  def initialize(color)
    @name = "Pawn"
    @color = color
  end

  def moves #unique to piece subclass
    #array of potential moves
  end
end
