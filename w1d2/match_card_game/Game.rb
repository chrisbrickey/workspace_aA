require_relative 'Board.rb'
require_relative 'Card.rb'
require 'pry'
class Game

attr_accessor :game_board

  def setup
    @game_board = Board.new
    @game_board.populate
  end

  def play
    setup

    until game_board.game_over?
      game_board.render
      card1 = prompt
      card2 = prompt
      results(card1, card2)
    end

    p "GAME OVER"
  end


  def prompt
    p "Make a guess!!! Use this format: x, y"
    input = gets.chomp.split(", ").map(&:to_i)
    make_guess(input)
  end


  def make_guess(guess)
    current_card = game_board.position_hash[guess]
    #binding.pry
    if current_card.hidden
      current_card.reveal
      game_board.render
      return current_card
      # return current_card.face_value
    else
      p "Card has already been matched. Make a new guess."
      prompt
    end
  end


  def results(card1, card2)
    if card1.face_value == card2.face_value
      p "It's a match!!!"
    else
      p "No match.  :-("
      card1.hide
      card2.hide
    end
  end





end#of class
