# Write a function reverse(string) that takes in a string and returns it reversed.
def reverse(str)
  return "" if str.length == 0
  str[-1] + reverse(str[0..-2])
end

p reverse("house") # => "esuoh"
p reverse("dog") # => "god"
p reverse("atom") # => "mota"
p reverse("q") # => "q"
p reverse("id") # => "di"
p reverse("") # => ""


# Write a function sum_to(n) that uses recursion to calculate the sum from 1 to n (inclusive of n).

def sum_to(n)
  return nil if n < 0
  return 0 if n == 0
  sum_to(n - 1) + n

end

p sum_to(5)  # => returns 15
p sum_to(1)  # => returns 1
p sum_to(9)  # => returns 45
p sum_to(-8)  # => returns nil
#
#
# # Write a function add_numbers(nums_array) that takes in an array of Fixnums and returns the sum of those numbers. Write this method recursively
#
def add_numbers(arr)
  return nil if arr.length == 0
  return arr[0] if arr.length == 1
  add_numbers(arr[0..-2]) + arr[-1]
end
p add_numbers([1,2,3,4]) # => returns 10
p add_numbers([3]) # => returns 3
p add_numbers([-80,34,7]) # => returns -39
p add_numbers([]) # => returns nil
#
# # Let's write a method that will solve Gamma Function recursively. The Gamma Function is defined Γ(n) = (n-1)!.
def gamma_fnc(n)
  # Γ(n) = (n-1)!
  return nil if n <= 0
  return 1 if n == 1
  (n - 1) * gamma_fnc(n - 1)

  # return nil if n < 1
  # return 1 if n == 1
  # (n - 1) * gamma_fnc(n - 1)
end

p gamma_fnc(0)  # => returns nil
p gamma_fnc(1)  # => returns 1
p gamma_fnc(4)  # => returns 6
p gamma_fnc(8)  # => returns 5040
#
# # Write a function ice_cream_shop(flavors, favorite) that takes in an array of ice cream flavors available at the ice cream shop,
# # as well as the user's favorite ice cream flavor.
# # Recursively find out whether or not the shop offers their favorite flavor.
#
def ice_cream_shop(arr, str)
  return false if arr.length == 0
  # return true if arr[0] == str
  return true if arr[-1] == str
  ice_cream_shop(arr[0..-2], str)
end
#
p ice_cream_shop(['vanilla', 'strawberry'], 'blue moon')  # => returns false
p ice_cream_shop(['pistachio', 'green tea', 'chocolate', 'mint chip'], 'green tea')  # => returns true
p ice_cream_shop(['cookies n cream', 'blue moon', 'superman', 'honey lavender', 'sea salt caramel'], 'pistachio')  # => returns false
p ice_cream_shop(['moose tracks'], 'moose tracks')  # => returns true
p ice_cream_shop([], 'honey lavender')  # => returns false
