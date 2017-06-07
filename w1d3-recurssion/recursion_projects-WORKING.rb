# I do exclude max, so this is like `min...max`.
def range(min, max)
  return [] if max < min
  range(min, max - 1) << max
end

# p range(1, 5)

# def sum_iter(nums)
#
# end

def sum_rec(nums)
  return 0 if nums.length == 0
  sum_rec(nums[0...-1]) + nums[-1]
end

# p sum_rec([1, 2, 3, 4])

def exp1(base, power)
  return 1 if power <= 0
  exp1(base, power - 1) * base
end

# p exp1(3, 3)


def exp2(base, power)
  return 1 if power == 0

  half = exp2(base, power / 2)

  if power.even?
    half * half
  else
    # note that (power / 2) == ((power - 1) / 2) if power.odd?
    base * half * half
  end
end
# p exp2(2, 1)
# p exp2(2, 3)
# p exp2(3, 3)
# p exp2(4, 4)

# class Array
def deep_dup(arr)
  # new_array = []
  # arr.each do |el|
  #   new_array << (el.is_a?(Array) ? deep_dup(el) : el)
  # end
  # new_array
end
# x = [1, [2, 3, [56]], [7, 8]]
# y = deep_dup(x)
# y[2] << "hello"
# p x
# p y

  # The renowned one-line inject version of deep_dup
  # Beware inject!
  def dd_inject(arr)
    arr.inject([]) {|new_array, element| new_array << (element.is_a?(Array) ? dd_inject(element) : element) }
  end

  # x = [1, [2, 3, [56]], [7, 8]]
  # y = dd_inject(x)
  # y[2] << "hello"
  # p x
  # p y

  # Beware map! The ultimate one-liner.
  def dd_map(arr)

  end
# end



def fibs_rec(n)
  if n <= 2
    return [0, 1][0...n]
  else
    previous_arr = fibs_rec(n - 1)
    previous_arr << previous_arr[-2] + previous_arr[-1]
  end
end

# p fibs_rec(0)
# p fibs_rec(1)
# p fibs_rec(2)
# p fibs_rec(3)
# p fibs_rec(4)
# p fibs_rec(5)

# class Array
def subsets (arr)
  return [[]] if arr.length == 0

  interim = subsets(arr[0...-1])
  interim + interim.map do |el|
    el + [arr[-1]]
  end
end
# p subsets ([1, 2, 3])

def permutations(array)
  return [array] if array.length <= 1
  total_permutations = []
  last = array[-1]
  perms = permutations(array[0...-1])

  perms.each do |perm|
    0.upto(perm.length) do |index|
      total_permutations << perm[0...index] + [last] + perm[index..-1]
    end
  end

  total_permutations
end

# p permutations([1, 2, 3])


def cass_bsearch(array, target)
  return nil if array.empty?
  mid_idx = array.length / 2
  return mid_idx if array[mid_idx] == target
  # debugger
  # idx_array = (0..array.length).to_a
  array_left = array[0...mid_idx]
  array_right = array[(mid_idx + 1)..-1]
  # if array[mid_idx] == target
  if array[mid_idx] > target
    cass_bsearch(array_left, target)
  else
    search_results = cass_bsearch(array_right, target)
    search_results.nil? ? nil : search_results + mid_idx + 1
    #need to make sure this isn't nil
    #add mid_idx because you have to account for everything on the left
    #add 1 to account for the fact that indexing starts at 0 not 1
  end
end

# p cass_bsearch([1,2,3,4,5,6], 5) #4


# puts bsearch([1,2,3,4,5,6], 1)
# p bsearch([1,2,3,4,5,6], 2)
# p bsearch([1,2,3,4,5,6], 3)
# p bsearch([1,2,3,4,5,6], 4)
# p bsearch([1,2,3,4,5,6], 5)
# p bsearch([1, 2, 3, 4, 5, 6], 6) #4

# end


def merge_sort(array)
  return array if array.length <= 1
  middle = array.length / 2
  sorted_left = merge_sort(array[0...middle])
  sorted_right = merge_sort(array[middle..-1])
  merge(sorted_right, sorted_left)
end

def merge(left, right)
  merged_array = []

  until left.empty? || right.empty?
    if left.first < right.first
      merged_array << left.shift
    else
      merged_array << right.shift
    end
  end

  merged_array + left + right
end


# p merge_sort([3, 7, 1, 9])


def make_change(target, coins = [25, 10, 5, 1])
  # Don't need any coins to make 0 cents change
  return [] if target == 0
  # Can't make change if all the coins are too big. This is in case
  # the coins are so weird that there isn't a 1 cent piece.
  return nil if coins.none? { |coin| coin <= target }

  # Optimization: make sure coins are always sorted descending in
  # size. We'll see why later.
  coins = coins.sort.reverse

  best_change = nil
  coins.each_with_index do |coin, index|
    # can't use this coin, it's too big
    next if coin > target

    # use this coin
    remainder = target - coin

    # Find the best way to make change with the remainder (recursive
    # call). Why `coins.drop(index)`? This is an optimization. Because
    # we want to avoid double counting; imagine two ways to make
    # change for 6 cents:
    #   (1) first use a nickel, then a penny
    #   (2) first use a penny, then a nickel
    # To avoid double counting, we should require that we use *larger
    # coins first*. This is what `coins.drop(index)` enforces; if we
    # use a smaller coin, we can never go back to using larger coins
    # later.
    best_remainder = make_change(remainder, coins.drop(index))

    # We may not be able to make the remaining amount of change (e.g.,
    # if coins doesn't have a 1cent piece), in which case we shouldn't
    # use this coin.
    next if best_remainder.nil?

    # Otherwise, the best way to make the change **using this coin**,
    # is the best way to make the remainder, plus this one coin.
    this_change = [coin] + best_remainder

    # Is this better than anything we've seen so far?
    if (best_change.nil? || (this_change.count < best_change.count))
      best_change = this_change
    end
  end

  best_change
end

p make_change(27)
