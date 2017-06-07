# Write a new `Array#merge_sort` method; it should not modify the
# array it is called on, but create a new sorted array.

class Array

  def merge_sort(&prc)
    new_array = self.dup
    n = new_array.length
    return new_array if n <= 1

    mid = n / 2
    left = new_array.take(mid).merge_sort(&prc)
    right= new_array.drop(mid).merge_sort(&prc)
    self.class.merge(left, right, &prc)
  end

  private
  def self.merge(left, right, &prc)
    merged = []
    prc ||= Proc.new {|x, y| x <=> y }
    until left.empty? || right.empty?
      result = prc.call(left[0], right[0])
      if result <= 0
        merged << left.shift
      else
        merged << right.shift
        end
    end
    merged + left + right
  end

end

class Array
  # Write a new `Array#pair_sum(target)` method that finds all pairs of
  # positions where the elements at those positions sum to the target.

  # NB: ordering matters. I want each of the pairs to be sorted
  # smaller index before bigger index. I want the array of pairs to be
  # sorted "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

  def pair_sum(target)
    arr_of_pairs = []

    two_d_array = self.dup.map.with_index do |element, orig_index|
      [element, orig_index]
    end

    0.upto(two_d_array.length - 2) do |idx1|
      (idx1 + 1).upto(two_d_array.length - 1) do |idx2|
        item1 = two_d_array[idx1][0]
        item2 = two_d_array[idx2][0]

        if item1 + item2 == target
          arr_of_pairs << [two_d_array[idx1][1], two_d_array[idx2][1]]
        end
      end
    end

    # two_d_array.each do |subarray|
    #   if
    # end

    arr_of_pairs
  end
end

# Write a method that recursively finds the first `n` factorial numbers
# and returns them. N! is the product of the numbers 1 to N.
# Be aware that the first factorial number is 0!, which is defined
# to equal 1. The 2nd factorial is 1!, the 3rd factorial is 2!, etc.
# The "calls itself recursively" spec may say that there is no method
# named "and_call_original" if you are using an older version of
# rspec. You may ignore this failure.
def factorials_rec(num)
  return [] if num == 0
  return [1] if num == 1
  prev = factorials_rec(num - 1)
  prev + [prev.last * (num - 1)]
end



# This method returns true if the string can be rearranged to form the
# sentence passed as an argument.

# Example:
# "cats are cool".shuffled_sentence_detector("dogs are cool") => false
# "cool cats are".shuffled_sentence_detector("cats are cool") => true

class String
  def shuffled_sentence_detector(other)
    self_words = self.dup.split(/\s+/)
    other_words = other.split(/\s+/)

    other_words.each do |other_word|
      if self_words.include?(other_word)
        self_words -= [other_word]
      else
        return false
      end
    end

    true
  end
end


def is_prime?(num)
  return false if num < 2
  return true if num == 2
  (2...num).each do |divisor|
    return false if num % divisor == 0
  end
  true
end

# Write a method that returns the nth prime number
def nth_prime(n)
  return nil if n == 0
  # return 2 if n == 1
  prime_array = []
  potential_prime = 2

  n.times do
    until is_prime?(potential_prime)
      potential_prime += 1
    end
    prime_array << potential_prime
    potential_prime += 1
  end

  prime_array.last
end

class Array
  # Write a method that calls a passed block for each element of the array
  def my_each(&prc)
    0.upto(self.length - 1) { |index| prc.call(self[index]) }
    self
  end
end

class Array
  # Write an array method that calls the given block on each element and
  # combines each result one-by-one with a given accumulator. If no accumulator is
  # given, the first element is used.
  def my_inject(accumulator = nil, &prc)
    if accumulator.nil?
      accumulator = self[0]
      result = self[1..-1].inject(accumulator) { |accumulator, element| prc.call(accumulator, element) }
    else
      result = self.inject(accumulator) { |accumulator, element| prc.call(accumulator, element) }
    end
    result
  end

end
