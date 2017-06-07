class Stack #LIFO
  def initialize
    @stack = []
  end

  def add(element)
    @stack << element
  end

  def remove
    @stack.pop
  end

  def show
    @stack.dup
  end

end#of class



class Queue #FIFO

  def initialize
    @queue = []
  end

  def enqueue(element)
    @queue.unshift(element)
  end

  def dequeue
    @queue.pop
  end

  def show
    @queue.dup
  end

end#of class


class Map
  def initialize
    @map = []
  end

  def assign(key, value)
    pair_index = @map.index { |pair| pair[0] == key }
    if pair_index.nil?
      @map << [key, value]
    else
      @map[pair_index][1] = value
    end

    [key, value] #why to we need to return the key, value pair?
  end

  # def assign(key, value)
  #   count = 0
  #   @map.each_with_index do |pair, index|
  #     if pair[0] == key
  #       count += 1
  #       @map[index][1] = pair[1]
  #     end
  #   end
  #
  #   if count == 0
  #     @map << [key, value]
  #   end
  # end

  def lookup(key)
    @map.each { |pair| return pair[1] if pair[0] == key }
    nil
  end


  def remove(key)
    @map.reject! { |pair| pair[0] == key }
  end

  def show
    deep_dup(@map)
  end

  private
  def deep_dup(arr)
    arr.map { |element| element.is_a?(Array) ? deep_dup(element) : element }
  end

end#of class
