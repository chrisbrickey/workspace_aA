
class Game
  attr_accessor :players, :dictionary, :fragment, :index
  def initialize(players=[])
    @players = players
    @index = 0
    @dictionary = {}
    File.readlines("dictionary.txt").each {|key| @dictionary[key] = true }
    @dictionary_string = File.read("dictionary.txt")
    @fragment = ""
  end

  def current_player
    @players[@index % @players.length]
  end

  def next_player
    @index += 1
  end

  def take_turn(player)
    begin
      puts "#{player.name}'s Turn:'"
      puts "\n"
      input = gets.chomp
      input.downcase!
      if !valid_play?(input)
        puts "#{player.name}: invalid input\n"
        raise "error"
      end
    rescue
      retry
    end
    @fragment += input
    puts "Fragment is #{@fragment}\n"
    if @dictionary[@fragment]
      last_player = @players[@index-1]
      last_player.losses += 1
      if last_player.losses == 5
        @players.delete_at(@index-1)
        return take_turn(current_player)
      end
    end
    if @players.length == 1
      "#{@players[0].name} is the winner!"
      return
    end
    next_player
    return take_turn(current_player)
  end

  def valid_play?(string)
    return false if !("a".."z").to_a.include?(string)
    test = @fragment + string
    if !@dictionary_string.match(/(^#{test})/)
      return false
    end
    true
  end

  def play
    take_turn(current_player)
  end
end


class Player
  attr_accessor :name, :losses
  def initialize (name)
    @name = name
    @losses = 0
  end
end

if __FILE__ == $PROGRAM_NAME
  puts "Input Number of Players:"
  num_players = gets.chomp.to_i
  array = []
  num_players.times do
    puts "Enter Player Name\n"
    player_name = gets.chomp
    array << Player.new(player_name)
  end
  Game.new(array).play
end
