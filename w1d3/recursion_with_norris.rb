def range_iterative(start_num, end_num)
  (start_num + 1...end_num).to_a
end

def range_recursive(start_num, end_num)
  return [] if end_num <= start_num
  range_recursive(start_num, end_num - 1) << end_num - 1
end

def exponent_recursion_1(base, exponent)
  return 1 if exponent.zero?
  base * exponent_recursion_1(base, exponent - 1)
end

def exponent_recursion_2(base, exponent)
  return 1 if exponent.zero?
  if exponent.even?
    exponent_recursion_2(base, (exponent / 2))**2
  else
    base * (exponent_recursion_2(base, ((exponent - 1) / 2))**2)
  end
end

def deep_dup(source_arr)
  return [source_arr[-1]] if source_arr.length <= 1
  deep_dup(source_arr[0...-1]) << source_arr[-1]
end

def fibonacci_iterative(n)
  starter = [1, 1]
  (n - 2).times do
    starter << (starter[-2] + starter[-1])
  end
  starter
end

def fibonacci_recursive(n)
  return [1] if n == 1
  return [1,1] if n == 2
  sum_of_last_two_digits = fibonacci_recursive(n - 1)[-2] + fibonacci_recursive(n - 1)[-1]
  fibonacci_recursive(n - 1) << sum_of_last_two_digits
end

def subsets(arr)
  return [[]] if arr.empty?
  sub_arr = arr[0...-1]
  subs = subsets(sub_arr)
  subs.concat(subs.map{ |sub| sub + [arr[-1]] })
end

# p subsets([1, 2, 3])

def permutations(arr)
  return [] if helper_method # use helper in recursion??

  arr[i]

  sub_array = arr[1..-1]
  permutations(arr.rotate.map { |num| num.rotate })

end
