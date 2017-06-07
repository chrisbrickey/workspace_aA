def factorials (num)
  return [] if num == 0
  return [1] if num == 1
  prev = factorials(num - 1)
  prev + [prev.last * (num - 1)]
end

p factorials(5)


# def subsets(arr)
#   return [[]] if arr.empty?
#   old = subsets(arr[0...-1])
#   old + old.map { |subarray| subarray + [arr[-1]] }
# end

# p subsets([3, 4, 5])

def subsets(arr)
  return [[]] if arr.empty?
  # return arr if arr.length = 1

  old = subsets(arr[0...-1])
  old + old.map {|subarray| subarray + [arr[-1]] }
end

p subsets([1, 2, 3])


def permutations(arr)
  return [arr] if arr.length <= 1
  total_perms = []

  arr.each_index do |index|
    left = arr.take(index)
    right = arr.drop(index + 1)
    subarray = left + right

    total_perms += permutations(subarray).map do |el|
      el << arr[index]
    end
  end
  total_perms
end
p permutations([1, 2, 3])


def deep_dup(arr)
  return [arr[-1]] if arr.length <= 1
  deep_dup(arr[0...-1]) << arr[-1]
end

def fibonacci(n)
  return [] if n == 0
  return [1] if n == 1
  return [1, 1] if n == 2

  prev = fibonacci(n - 1)
  next_item = prev[-2] + prev[-1]
  prev << next_item
end

p fibonacci(5)

def fibonacci_sum(n)
  return 0 if n == 0
  return 1 if n == 1
  # return 2 if n == 2

  prev_sum = fibonacci_sum(n - 1) + fibonacci_sum(n - 2) + 1
end

p fibonacci_sum(5)



def change_base(number, base)

  return "" if number == 0

  digit = number % base
  if digit > 9
    remainder = digit - 9
    digit = (remainder + 96).chr  
  end

  change_base(number/ base, base) + "#{digit}"
end
