my_arr = [9, 2, 5, 0, 12, 7, 322, 1, -2, 7]
# sorted_arr = my_arr.sort
#
# def binary_search(arr, target)
#   return nil if arr.empty?
#   probe = arr.length / 2
#   result = target <=> arr[probe]
#   if result == -1
#     binary_search(arr.take(probe), target)
#   elsif result == 0
#     probe
#   else
#     interim = binary_search(arr.drop(probe + 1), target)
#     interim.nil? ? nil : probe + 1 + interim
#   end
# end
#
# # p binary_search(sorted_arr, -2)
# # p binary_search(sorted_arr, 5)
# # p binary_search(sorted_arr, 82)
#
#
# def merge_sort(arr, &prc)
#   # p arr
#   return arr if arr.length <= 1
#   mid = arr.length / 2
#   left = arr.take(mid)
#   right = arr.drop(mid)
#   sorted_left = merge_sort(left, &prc)
#   sorted_right = merge_sort(right, &prc)
#   compare_and_merge(sorted_left, sorted_right, &prc)
# end
#
# def compare_and_merge(left, right, &prc)
#   merged = []
#   prc ||= Proc.new {|x, y| [x, y].min }
#
#   until left.empty? || right.empty?
#     result = prc.call(left[0], right[0])
#     if left[0] == result
#       merged << left.shift
#     else
#       merged << right.shift
#     end
#   end
#   merged + left + right
# end
#
# p merge_sort(my_arr)
# p merge_sort(my_arr) { |x, y| [x, y].max }
#
#
# def bubble_sort(arr, &prc)
#   # p arr
#   return arr if arr.length <= 1
#   prc ||= Proc.new { |x, y| x <=> y }
#
#   loop do
#     swapped = false
#
#     0.upto(arr.length - 2) do |idx|
#       x = arr[idx]
#       y = arr[idx + 1]
#       result = prc.call(x, y)
#       if result == 1
#         arr[idx], arr[idx + 1] = arr[idx + 1], arr[idx]
#         swapped = true
#       end
#     end
#
#     break if swapped == false
#   end
#   arr
# end
#
# # p bubble_sort(my_arr)
# # p bubble_sort(my_arr) { |x, y| y <=> x }
#
#
# def quick_sort(arr)
#   return [] if arr.length == 0
#   pivot = arr[0]
#   left = arr[1..-1].select { |el| el < pivot }
#   right = arr[1..-1].select { |el| el >= pivot }
#   quick_sort(left) + [pivot] + quick_sort(right)
# end
#
# p quick_sort(my_arr)



















# def binary_search(arr, target)
#   return nil if arr.empty?
#   probe = arr.length / 2
#   result = target <=> arr[probe]
#   if result == -1
#     binary_search(arr.take(probe), target)
#   elsif result == 0
#     probe
#   else
#     interim = binary_search(arr.drop(probe + 1), target)
#     interim.nil? ? nil : probe + 1 + interim
#   end
# end
#
# # p binary_search(sorted_arr, -2)
# # p binary_search(sorted_arr, 5)
# # p binary_search(sorted_arr, 82)











# def binary_search(arr, target)
#   return nil if arr.empty?
#   probe = arr.length / 2
#   result = target <=> arr[probe]
#   left = arr.take(probe)
#   right = arr.drop(probe + 1)
#
#   if result == -1
#     binary_search(left, target)
#   elsif result == 0
#     probe
#   else
#     interim = binary_search(right, target)
#     interim.nil? ? nil : probe + 1 + interim
#   end
#
# end
#
# sorted_arr = my_arr.sort
# p sorted_arr
# p binary_search(sorted_arr, 7)
# p binary_search(sorted_arr, -3)
#
#
#
#
#
#
# def quicksorta(arr)
#   return [] if arr.empty?
#   pivot = arr[0]
#   left = arr[1..-1].select { |el| el < pivot }
#   right = arr[1..-1].select { |el| el >= pivot }
#   quicksorta(left) + [pivot] + quicksorta(right)
# end

# p quicksorta(my_arr)





def quick_sort(arr)
  return arr if arr.length <= 1
  pivot = arr[0]
  left = arr[1..-1].select {|x| x < pivot}
  right = arr[1..-1].select {|x| x >= pivot}
  quick_sort(left) + [pivot] + quick_sort(right)
end

# p quick_sort(my_arr)


def binary_search(arr, target)
  return nil if arr.empty?
  n = arr.length
  probe = n / 2



  result = target <=> arr[probe]
  left = arr.take(probe)
  right = arr.drop(probe + 1)
  if result == -1
    binary_search(left, target)
  elsif result == 0
    probe
  else
    interim = binary_search(right, target)
    interim.nil? ? nil : probe + 1 + interim
  end
end


sorted_arr = my_arr.sort
p binary_search(my_arr, 5)
p binary_search(my_arr, 8)
