require 'byebug'
class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.

  def my_inject(accumulator = nil)
    if accumulator.nil?
      accumulator = self[0]
      result = self[1..-1].inject(accumulator) {|accumulator, element| yield(accumulator, element) }
    else
      result = self.inject(accumulator) {|accumulator, element| yield(accumulator, element) }
    end
    result
  end
end

# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
  return false if num <= 1
  return true if num == 2

  (2...num).each do |divisor|
    if num % divisor == 0
      return false
    end
  end

  true
end

def primes(num)
  prime_array = []
  potential_prime = 2

  num.times do
    until is_prime?(potential_prime)
      potential_prime += 1
    end

    prime_array << potential_prime
    potential_prime += 1
  end

  prime_array
end

# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
  return [] if num < 1
  return [1] if num == 1

  prev_factorials = factorials_rec(num - 1)
  prev_factorials + [prev_factorials.last * (num - 1)]
end


class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  # def dups
  #   new_hash = Hash.new
  #   two_d_arr = self.map.with_index { |el, index| [el, index] }
  #   two_d_arr.each  do |subarray|
  #     if new_hash[subarray[0]].nil?
  #       new_hash[subarray[0]] = [subarray[1]]
  #     else
  #       new_hash[subarray[0]] << subarray[1]
  #     end
  #   end
  #   new_hash.select {|k, v| v.length > 1}
  # end

end

class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
    new_array = []
    0.upto(self.length - 2) do |idx1|
      (idx1 + 1).upto(self.length - 1) do |idx2|
        subarray = self[idx1..idx2]
        if subarray  == subarray.reverse
          new_array << subarray
        end
      end
    end

    new_array
  end
end

class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)
    n = self.length
    return self if n <= 1

    # new_array = self.dup
    mid = n / 2
    left = self.take(mid)
    right = self.drop(mid)
    sorted_left = left.merge_sort(&prc)
    sorted_right = right.merge_sort(&prc)
    self.class.merge(sorted_left, sorted_right, &prc)
  end

  private
  def self.merge(left, right, &prc)
    merged_arr = []
    prc ||= Proc.new { |x, y| x <=> y }

    until left.empty? || right.empty?
      result = prc.call(left[0], right[0])
      if result < 1
        merged_arr << left.shift
      else
        merged_arr << right.shift
      end
    end

    merged_arr + right + left
  end
end

#+================above is real practice assessment===================


# wrong method name, but still good examples
# 5.stringify(10) #=> "5"
# 5.stringify(2)  #=> "101"
# 5.stringify(16) #=> "5"
# 234.stringify(10) #=> "234"
# 234.stringify(2)  #=> "11101010"
# 234.stringify(16) #=> "EA"

# concrete example of how your method might arrive at the conversions
# 234.stringify(10) #=> "234"
# (234 / 1)   % 10  #=> 4
# (234 / 10)  % 10  #=> 3
# (234 / 100) % 10  #=> 2

# 234.stringify(2) #=> "11101010"
# (234 / 1)   % 2  #=> 0
# (234 / 2)   % 2  #=> 1
# (234 / 4)   % 2  #=> 0
# (234 / 8)   % 2  #=> 1
# (234 / 16)  % 2  #=> 0
# (234 / 32)  % 2  #=> 1
# (234 / 64)  % 2  #=> 1
# (234 / 128) % 2  #=> 1                     ^

# The general idea is to each time divide by a greater power of `base`
# and then mod the result by `base` to get the next digit. Continue until
# `num / (base ** pow) == 0`.
#
# You'll get each digit as a number; you need to turn it into a
# character. Make a `Hash` where the keys are digit numbers (up to and
# including 15) and the values are the characters to use (up to and
# including `F`).

# Write a recursive method that takes in a base 10 number n and
# converts it to a base b number. Return the new number as a string
#
# E.g. base_converter(5, 2) == "101"
# base_converter(31, 16) == "1f"


#my nonrecursive solution that passes all tests
# def base_converter(num, b)
#   num_string = ""
#
#   divisor = 1
#   while divisor <= num
#     digit = (num / divisor) % b
#
#     if digit > 9
#       remainder = digit - 9
#       digit = (remainder + 96).chr
#     end
#
#     num_string = digit.to_s + num_string
#
#     divisor *= b
#   end
#
#   num_string
# end

#recursive solution
def base_converter(num, b)
  return "" if num < 1

  digit = num % b
  if digit > 9
    remainder = digit - 9
    digit = (remainder + 96).chr
  end

  base_converter(num/b, b) + "#{digit}"
end


class Array
  # Write a monkey patch of binary search:
  # E.g. [1, 2, 3, 4, 5, 7].my_bsearch(5) => 4
  def my_bsearch(target, &prc)
    return nil if self.length == 0
    probe = self.length / 2

    left = self.take(probe)
    right = self.drop(probe + 1)

    result = target <=> self[probe]
    if result == -1
      left.my_bsearch(target)
    elsif result == 0
      probe
    else
      interim = right.my_bsearch(target)
      interim.nil? ? nil : probe + 1 + interim
    end

  end
end

class Array
  def bubble_sort!
  end

  def bubble_sort!(&prc)
  end

  def bubble_sort(&prc)
  end
end

# Back in the good old days, you used to be able to write a darn near
# uncrackable code by simply taking each letter of a message and incrementing it
# by a fixed number, so "abc" by 2 would look like "cde", wrapping around back
# to "a" when you pass "z".  Write a function, `caesar_cipher(str, shift)` which
# will take a message and an increment amount and outputs the encoded message.
# Assume lowercase and no punctuation. Preserve spaces.
#
# To get an array of letters "a" to "z", you may use `("a".."z").to_a`. To find
# the position of a letter in the array, you may use `Array#find_index`.

# def caesar_cipher(str, shift)
#
# end


# Using recursion and the is_a? method,
# write an Array#deep_dup method that will perform a "deep" duplication of the interior arrays.

def deep_dup(arr)
  return [arr[-1]] if arr.lenth == 1
  deep_dup(arr[0...-1]) << arr[-1]
end


# Write a method, `digital_root(num)`. It should Sum the digits of a positive
# integer. If it is greater than 10, sum the digits of the resulting number.
# Keep repeating until there is only one digit in the result, called the
# "digital root". **Do not use string conversion within your method.**
#
# You may wish to use a helper function, `digital_root_step(num)` which performs
# one step of the process.

def digital_root(num)
  digits = []

  while num > 0
    digits << num % 10
    num /= 10
  end

  digit_sum = digits.inject(&:+)
  digit_sum > 10 ? digital_root(digit_sum) : digit_sum
end


# Write a method that doubles each element in an array
def doubler(array)
  array.map {|el| el * 2 }
end



class Array

  # Write an Array#dups method that will return a hash containing the indices of all
  # duplicate elements. The keys are the duplicate elements; the values are
  # arrays of their indices in ascending order, e.g.
  # [1, 3, 4, 3, 0, 3, 0].dups => { 3 => [1, 3, 5], 0 => [4, 6] }

  def dups
    new_hash = Hash.new {|h, k| h[k] = [] }
    self.each_with_index { |element, index| new_hash[element] << index }
    new_hash.select { |_, v| v.length > 1 }
  end
end




# CHALLENGE: Eight queens puzzle precursor
#
# Write a recursive method that generates all 8! possible unique ways to
# place eight queens on a chess board such that no two queens are in
# the same board row or column (the same diagonal is OK).
#
# Each of the 8! elements in the return array should be an array of positions:
# E.g. [[0,0], [1,1], [2,2], [3,3], [4,4], [5,5], [6,6], [7,7]]
#
# My solution used 3 method parameters: current_row, taken_columns, and
# positions so far
def eight_queens_possibilities(current_row, taken_columns, positions)

end



# return b^n recursively. Your solution should accept negative values
# for n
def exponent(base, n)
  return 1 if n == 0

  if n < 0
    exponent(base, n + 1) / base.to_f
  else
    base * exponent(base, n - 1)
  end
end



# Write a recursive method that returns the first "num" factorial numbers.
# Note that the 1st factorial number is 0!, which equals 1. The 2nd factorial
# is 1!, the 3rd factorial is 2!, etc.

def factorials_rec(num)
  return [] if num < 1
  return [1] if num == 1

  prev_factorials = factorials_rec(num - 1)
  prev_factorials + [prev_factorials.last * (num - 1)]
end

# Write a method that returns the factors of a number in ascending order.

def factors(num)
  factors = []
  (1..num).each do |divisor|
    if num % divisor == 0
      factors << divisor
    end
  end

  factors
end


# Implement a method that finds the sum of the first n
# fibonacci numbers recursively. Assume n > 0
def fibs_sum(n)
  return 0 if n == 0
  return 1 if n == 1
  fibs_sum(n-1) + fibs_sum(n-2) + 1
end

# def fibs_sum(n)
#   p "n: #{n}"
#   sequence = fibonacci(n)
#   p "sequence: #{sequence}"
#   sequence.inject(&:+)
# end
#
# def fibonacci(n)
#   return [1] if n == 1
#   return [1, 1] if n == 2
#   prev_fibs = fibonacci(n - 1)
#   next_num = prev_fibs[-1] + prev_fibs[-2]
#   prev_fibs << next_num
# end


# return the sum of the first n even numbers recursively. Assume n > 0
def first_even_numbers_sum(n)
  return 0 if n == 0
  return 2 if n == 1
  first_even_numbers_sum(n - 1) + (n * 2)
end



# Jumble sort takes a string and an alphabet. It returns a copy of the string
# with the letters re-ordered according to their positions in the alphabet. If
# no alphabet is passed in, it defaults to normal alphabetical order (a-z).

# Example:
# jumble_sort("hello") => "ehllo"
# jumble_sort("hello", ['o', 'l', 'h', 'e']) => 'ollhe'

def jumble_sort(str, alphabet = nil)
  if alphabet.nil?
    return str.split("").sort.join("")
  else
    new_hash = Hash.new(0)
    str.each_char { |l| new_hash[l] += 1 }

    new_string = ""
    alphabet.each do |l|
      if new_hash[l] > 0
        new_hash[l].times { new_string += l }
      end
    end

    return new_string
  end
end


# make better change problem from class
# make_better_change(24, [10,7,1]) should return [10,7,7]
# make change with the fewest number of coins

# To make_better_change, we only take one coin at a time and
# never rule out denominations that we've already used.
# This allows each coin to be available each time we get a new remainder.
# By iterating over the denominations and continuing to search
# for the best change, we assure that we test for 'non-greedy' uses
# of each denomination.

def make_better_change(value, coins)
  coins = coins.sort.reverse
  best_change_arr = []

  while value > 0
    p "value: #{value}"
    coins.each do |coin|
      if coin <= value
        best_change_arr << coin
        p "coin:#{coin}"
        value -=coin
      end
    end
  end

  best_change_arr.sort.reverse
end


# Write a method that returns the median of elements in an array
# If the length is even, return the average of the middle two elements
class Array
  def median
    n = self.length
    return nil if n == 0
    new_arr = self.sort

    if n.odd?
      return new_arr[n / 2]
    else
      return (new_arr[n / 2] + new_arr[(n / 2) - 1]) / 2.to_f
    end
  end
end



class Array

  # Write an Array#merge_sort method; it should not modify the original array.

  def merge_sort(&prc)
    n = self.length
    return self if n <= 1

    mid = n / 2
    left = self.take(mid)
    right = self.drop(mid)
    sorted_left = left.merge_sort(&prc)
    sorted_right = right.merge_sort(&prc)
    self.class.merge(sorted_left, sorted_right, &prc)
  end

  private

  def self.merge(left, right, &prc)
    prc ||= Proc.new { |x, y| x <=> y }
    merged = []

    until left.empty? || right.empty?
      result = prc.call(left[0], right[0])
      if result < 1
        merged << left.shift
      else
        merged << right.shift
      end
    end

    merged + left + right
  end
end


class Array

  def my_each(&prc)
    0.upto(self.length - 1) { |index| prc.call(self[index]) }
  end

  def my_each_with_index(&prc)
    0.upto(self.length - 1) { |index| prc.call(self[index], index) }
  end

  def my_all?(&prc)
    0.upto(self.length - 1) do |index|
      unless prc.call(self[index])
        return false
      end
    end
    true
  end

  def my_any?(&prc)
    0.upto(self.length - 1) do |index|
      if prc.call(self[index])
        return true
      end
    end
    false
  end

end




class Hash

  # Write a version of my each that calls a proc on each key, value pair
  def my_each(&prc)
    my_keys = self.keys
    0.upto(my_keys.length - 1) do |my_key_idx|
      key = my_keys[my_key_idx]
      prc.call(key, self[key])
    end
  end

end


class Array

  # Takes a multi-dimentional array and returns a single array of all the elements
  # [1,[2,3], [4,[5]]].my_controlled_flatten(1) => [1,2,3,4,5]
  def my_flatten
    new_arr = []
    self.each do |element|
      if element.is_a?(Array)
        new_arr += element.flatten
      else
        new_arr << element
      end
    end
    new_arr
  end

  # Write a version of flatten that only flattens n levels of an array.
  # E.g. If you have an array with 3 levels of nested arrays, and run
  # my_flatten(1), you should return an array with 2 levels of nested
  # arrays
  #
  # [1,[2,3], [4,[5]]].my_controlled_flatten(1) => [1,2,3,4,[5]]
  def my_controlled_flatten(n)
    new_arr = []
    self.each do |element|

      if element.is_a?(Array)
        new_arr += element.flatten(n - 1)
      else
        new_arr << element
      end
    end

    new_arr
  end
end


class Array

  # Monkey patch the Array class and add a my_inject method. If my_inject receives
  # no argument, then use the first element of the array as the default accumulator.

  def my_inject(accumulator = nil)
  end
end



class Array

  def my_join(str = "")
    new_str = ""
    self.each_with_index do |el, idx|
      if idx  == self.length - 1
        new_str += "#{el}"
      else
        new_str += "#{el}#{str}"
      end
    end
    new_str
  end

end


class Hash

  # Write a version of merge. This should NOT modify the original hash
  def my_merge(hash2)
    orig_hash = self.dup
    hash2.each do |k, v|
      orig_hash[k] = v
    end
    orig_hash
  end

end



class Array

  def my_reject(&prc)
    prc ||= Proc.new { |item| false }
    arr = self.dup
    0.upto(self.length - 1) do |idx|
      if prc.call(self[idx]) == true
        arr.delete_at(idx)
      end
    end

    arr
  end

end


class Array

  def my_reverse

  end

end



class Array

  def my_rotate(num)

  end

end



class Array

  def my_select(&prc)

  end

end


class Array

  def my_zip(*arrs)

  end

end


# Write a recursive method that returns all of the permutations of an array
def permutations(array)
end



# Write a method that translates a sentence into pig latin. You may want a helper method.
# 'apple' => 'appleay'
# 'pearl' => 'earlpay'
# 'quick' => 'ickquay'
def pig_latinify(sentence)
end



# Write a recursive function that returns the prime factorization of
# a given number. Assume num > 1
#
# prime_factorization(12) => [2,2,3]
def prime_factorization(num)


end

def is_prime?(num)

end


# primes(num) returns an array of the first "num" primes.
# You may wish to use an is_prime? helper method.

def is_prime?(num)
end

def primes(num)
end



class Array

  #Write a monkey patch of quick sort that accepts a block
  def my_quick_sort(&prc)

  end

end



class String
  # Returns an array of all the subwords of the string that appear in the
  # dictionary argument. The method does NOT return any duplicates.

  def real_words_in_string(dictionary)

  end
end


# Write a recursive method that returns the sum of all elements in an array
def rec_sum(nums)
end


# Write a recursive method that takes in a string to search and a key string.
# Return true if the string contains all of the characters in the key
# in the same order that they appear in the key.
#
# string_include_key?("cadbpc", "abc") => true
# string_include_key("cba", "abc") => false
def string_include_key?(string, key)

end


#returns all subsets of an array
def subsets(array)

end



class String

  # Write a String#symmetric_substrings method that returns an array of substrings
  # that are palindromes, e.g. "cool".symmetric_substrings => ["oo"]
  # Only include substrings of length > 1.

  def symmetric_substrings
  end
end



# Write a method that capitalizes each word in a string like a book title
# Do not capitalize words like 'a', 'and', 'of', 'over' or 'the'
def titleize(title)
end



class Array
  # Write a method, `Array#two_sum`, that finds all pairs of positions where the
  # elements at those positions sum to zero.

  # NB: ordering matters. I want each of the pairs to be sorted smaller index
  # before bigger index. I want the array of pairs to be sorted
  # "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

  def two_sum

  end
end
