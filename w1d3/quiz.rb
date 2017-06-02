def func(arg1, arg2)
  temp = arg1 * arg2
  return_val = (temp ** 2) + (arg1 % 6 + 1) / (7 + arg2 + arg1)
end

p func(7, 8)


def add_odds(n)
  return n if n == 1

  if n.even?
    add_odds(n-1)
  else
    n + add_odds(n-1)
  end
end


# add_odds(9)
# add_odds(50000)
# add_odds(123)
# add_odds(-8)
# add_odds(1)
