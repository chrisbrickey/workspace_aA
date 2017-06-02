require_relative 'Game.rb'
require_relative 'Board.rb'
require_relative 'Card.rb'

if __FILE__ == $0
  game = Game.new
  game.play
end
