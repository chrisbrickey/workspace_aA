require_relative 'Game.rb'
require_relative 'Board.rb'
class Card

attr_accessor :face_value, :hidden, :position

  def initialize(face_value, pos_array)
    @hidden = true
    @face_value = face_value
    @position = pos_array
  end

  def hide
    @hidden = true
  end

  def reveal
    @hidden = false
  end

  def to_s
    @face_value.to_s
  end

  def match?(other_card)
    @face_value == other_card.face_value
  end

end
