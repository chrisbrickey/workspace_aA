my_arr = [6, 2, 4, 9, 2, 0, 32, 6, 333, 9]

# def merge_sort(arr)
#   n = arr.length
#   return arr if n <= 1
#
#   mid = n / 2
#   left = arr.take(mid)
#   right = arr.drop(mid)
#   sorted_left = merge_sort(left)
#   sorted_right = merge_sort(right)
#   compare_and_merge(sorted_left, sorted_right)
# end
#
#
# def compare_and_merge(left, right)
#   merged_arr = []
#
#   until left.empty? || right.empty?
#     if left[0] < right[0]
#       merged_arr << left.shift
#     else
#       merged_arr << right.shift
#     end
#   end
#
#   merged_arr + left + right
# end
#
# p merge_sort(my_arr)
#
#
# def quick_sort(arr)
#   return arr if arr.length <= 1
#
#   pivot = arr[-1]
#   left = arr[0...-1].select { |element| element < pivot }
#   right = arr[0...-1].select { |element| element >= pivot }
#
#   quick_sort(left) + [pivot] + quick_sort(right)
# end
#
# p quick_sort(my_arr)
#
#
# def bubble_sort(arr)
#   n = arr.length
#   return arr if n <= 1
#
#   loop do
#     swapped = false
#
#     0.upto(n - 2) do |idx|
#       if arr[idx] > arr[idx + 1]
#         arr[idx], arr[idx + 1] = arr[idx + 1], arr[idx]
#         swapped = true
#       end
#     end
#
#     break if swapped == false
#   end
#
#   arr
# end
#
# p bubble_sort(my_arr)



# def merge_sort(arr)
#   n = arr.length
#   return arr if n <= 1
#
#   mid = n / 2
#   left = arr.take(mid)
#   right = arr.drop(mid)
#   sorted_left = merge_sort(left)
#   sorted_right = merge_sort(right)
#   compare_and_merge(sorted_left, sorted_right)
# end
#
# def compare_and_merge(left, right)
#   merged_arr = []
#   until left.empty? || right.empty?
#     if left[0] < right[0]
#       merged_arr << left.shift
#     else
#       merged_arr << right.shift
#     end
#   end
#
#   merged_arr + left + right
# end
#
# p merge_sort(my_arr)


# def merge_sort_proc(arr, &prc)
#   n = arr.length
#   return arr if n <= 1
#
#   mid = n / 2
#   left = arr.take(mid)
#   right = arr.drop(mid)
#   sorted_left = merge_sort_proc(left, &prc)
#   sorted_right = merge_sort_proc(right, &prc)
#   compare_and_merge(sorted_left, sorted_right, &prc)
# end
#
# def compare_and_merge(left, right, &prc)
#   prc ||= Proc.new { |x, y| [x, y].min }
#   merged_arr = []
#
#   until left.empty? || right.empty?
#
#     result = prc.call(left[0], right[0])
#
#     if result == left[0]
#       merged_arr << left.shift
#     else
#       merged_arr << right.shift
#     end
#   end
#
#   merged_arr + left + right
# end
#
#
# p merge_sort_proc(my_arr)
# p merge_sort_proc(my_arr) {|x, y| [x, y].max }


# def bubble_sort(arr)
#   return arr if arr.length <= 1
#
#   loop do
#     sorted = false
#
#     0.upto(arr.length - 2) do |idx|
#       if arr[idx] > arr[idx + 1]
#         arr[idx], arr[idx + 1] = arr[idx + 1], arr[idx]
#         sorted = true
#       end
#     end
#
#     break if sorted == false
#   end
#
#   arr
# end

# p bubble_sort(my_arr)


# def bubble_sort_proc(arr, &prc)
#   # p arr
#   return arr if arr.length <= 1
#   prc ||= Proc.new {|x, y| x <=> y }
#
#   loop do
#     sorted = false
#
#     0.upto(arr.length - 2) do |idx|
#       x = arr[idx]
#       y = arr[idx + 1]
#       result = prc.call(x, y)
#
#       if result == 1
#         arr[idx], arr[idx + 1] = arr[idx + 1], arr[idx]
#         sorted = true
#       end
#     end
#
#     break if sorted == false
#   end
#
#   arr
# end
#
# p bubble_sort_proc(my_arr)
# p bubble_sort_proc(my_arr) {|x, y| y <=> x }


# def quick_sort(arr)
#   return arr if arr.length <= 1
#   pivot = arr[0]
#   left = arr[1..-1].select {|el| el < pivot }
#   right = arr[1..-1].select {|el| el >= pivot }
#   quick_sort(left) + [pivot] + quick_sort(right)
# end
#
# p quick_sort(my_arr)



def bubble_sort_proc(arr, &prc)
  return arr if arr.length <= 1
  prc ||= Proc.new { |x, y| x <=> y }

  loop do
    sorted = false
    0.upto(arr.length - 2) do |idx|
      result = prc.call(arr[idx], arr[idx + 1])
      if result == 1
        arr[idx], arr[idx + 1] = arr[idx + 1], arr[idx]
        sorted = true
      end
    end

    break if sorted == false
  end
  arr
end

# p bubble_sort_proc(my_arr)
# p bubble_sort_proc(my_arr) {|x, y| y <=> x }


def quick_sort(arr)
  return arr if arr.length <= 1
  left = arr[1..-1].select {|el| el < arr[0]}
  right = arr[1..-1].select {|el| el >= arr[0]}
  quick_sort(left) + [arr[0]] + quick_sort(right)
end

# p quick_sort(my_arr)


def merge_sort(arr, &prc)
  n = arr.length
  return arr if n <= 1

  mid = n / 2
  left = arr.take(mid)
  right = arr.drop(mid)
  sorted_left = merge_sort(left, &prc)
  sorted_right = merge_sort(right, &prc)
  combine_and_sort(sorted_left, sorted_right, &prc)
end

def combine_and_sort(left, right, &prc)
  merged = []
  prc ||= Proc.new { |x, y| [x, y].min }

  until left.empty? || right.empty?
    result = prc.call(left[0], right[0])
    if result == left[0]
      merged << left.shift
    else
      merged << right.shift
    end
  end

  merged + left + right
end

p merge_sort(my_arr)

p merge_sort(my_arr) { |x, y| [x, y].max }
