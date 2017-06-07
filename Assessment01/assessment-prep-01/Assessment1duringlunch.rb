class Array

  def my_inject(accumulator=nil, &prc)
    i = 0

    if accumulator.nil?
      accumulator = self.first
      i = 1
    end

    #because we're either starting with 0 or 1, use while instead of each
    while i < self.count
      accumulator = prc.call(accumulator, self[i])
      i += 1
    end

    accumulator
  end

end#of class


def is_prime?(num)
  (2...num).none? { |divisor| num % divisor == 0 }
end

def primes(num)
  primes = []
  potential_prime = 2
  while primes.count < num
    primes << potential_prime if is_prime?(potential_prime)
    potential_prime += 1
  end

  primes
end

def factorials_rec(num)
  return [] if num == 0
  return [1] if num == 1
  # return [1, 1] if num == 2

  prev_factorials = factorials_rec(num - 1)
  prev_factorials + [prev_factorials.last * (num - 1)]
 end

class Array
   def dups
    #  dups = Hash.new {[]} #doesn't fix problem of it not stored in hash
    #  memorize below!!!! see that you are feeding hash and keys instead of keys, values....just accept this
     dups = Hash.new { |h, k| h[k] = [] }  #if you later iterate into hash...just do regular |k, v|
     self.each_with_index do |el, index|
       dups[el] << index
     end

     dups.select { |_, v| v > 1 }
   end
 end#of class

 class String
  def symmetric_substrings
    subs = []

    0.upto(self.length - 2) do |index1|
      (index1 + 1).upto(self.length - 1) do |index2|
        potential_sub = self[index1..index2]
        #this is how you catch the palindrome
        if potential_sub == potential_sub.reverse
          subs << potential_sub
        end
      end
    end

  end
 end

#know how to just write merge_sort....always recursive
#when you see a prc passed, assign a default prc to control it yourself
#in this case, &prc is going to tell it what to sort by....this is arbitrary to our method

class Array

  #not true: this does the sorting and outsources the merging to the helper method
   def merge_sort(&prc)
     prc ||= Proc.new { |x, y| x <=> y }

     return self if self.count <= 1   #becuase already sorted when so short
     midindex = self.count / 2

     left, right = self.take(midindex), self.drop(midindex) #very clean way to split array, even if odd length

     #can call merge_sort on left and right because they are also arrays
     left_sorted, right_sorted = left.merge_sort(&prc), right.merge_sort(&prc)
     #asks the class of the array we're working on and calls merge on it
     self.class.merge(left_sorted, right_sorted, &prc)


   end

   def merge(left, right, &prc)
     merged = []
     until left.empty? || right.empty?
       result = prc.call(left.first, right.first)
       if result <= 0
         merged << left.shift
       else
         merged << right.shift
       end

      #  case prc.call(left.first, right.first)
      #  when -1
      #    merged << left.shift #shift is important to also take this value off of the array it came from
      #  when 0
      #    merged << left.shift
      #  when 1
      #   merged << right.shift
      #  end
    end

    #need to do this addition at the end because either left or right will have remaining values
    #...so need to add them to the final
    #remember you only exhausted either left or right above
    merged + left + right  #

   end


end
