require 'byebug'
class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.

  def my_inject(accumulator = nil, &prc)

    if accumulator.nil?
      accumulator = self[0]
      result = self[1..-1].inject(self[0]) { |accumulator, item| prc.call(accumulator, item) }
    else
      result = self.inject(accumulator) { |accumulator, item| prc.call(accumulator, item) }
    end

    result
    #
    #
    # if accumulator.nil?
    #   accumulator = self[0]
    #   result = self[1..-1].inject(accumulator) {|accumulator, x| prc.call(accumulator, x) }
    # else
    #   result = self.inject(accumulator) {|accumulator, x| prc.call(accumulator, x) }
    # end
    # result
  end
end

# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
  return false if num < 2
  return true if num == 2
  (2...num).each do |divisor|
    if num % divisor == 0
      return false
    end
  end
  true
end

def primes(num)
  arr_of_primes = []
  return [] if num == 0
  potential_prime = 2
  num.times do
    until is_prime?(potential_prime)
      potential_prime += 1
    end
    arr_of_primes << potential_prime
    potential_prime += 1
  end
  arr_of_primes
end

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
  return [] if num < 0
  return [1] if num == 1

  prev = factorials_rec(num - 1)
  prev + [prev.last * (num - 1)]
end


class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups
    new_hash = Hash.new {|h, k| h[k] = [] }
    self.each_with_index do |el, index|
      new_hash[el] << index
    end


    new_hash.select! {|_, v| v.length > 1}
    new_hash
  end

end

class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
    new_array = []
    0.upto(self.length - 2) do |idx1|
      (idx1 + 1).upto(self.length - 1) do |idx2|
        substring_arr = self[idx1..idx2].split("")
        if substring_arr == substring_arr.reverse
          new_array << substring_arr.join("")
        end
      end
    end

    new_array
  end
end

class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)
    new_array = self.dup
    n = new_array.length
    return new_array if n <= 1

    mid = n / 2
    left = new_array.take(mid)
    right = new_array.drop(mid)
    sorted_left = left.merge_sort(&prc)
    sorted_right = right.merge_sort(&prc)
    self.class.merge(sorted_left, sorted_right, &prc)

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
