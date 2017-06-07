class Array

  def my_each(&prc)

    i = 0
    while i < self.length
      prc.call(self[i])
      i += 1
    end

  end

  def my_select(direction=true, &prc)
    answer_array = []
    self.my_each do |value|
      if direction
        if prc.call(value)
          answer_array << value
        end
      else
        if !prc.call(value)
          answer_array << value
        end
      end
    end

    answer_array
  end


  def my_reject(&prc)
    self.my_select(false, &prc)
  end

  def my_all?(&prc)
    self.my_each do |value|
      if !prc.call(value)
        return false
      end
    end

    true
  end

  def my_any?(&prc)
    self.my_each do |value|
      if prc.call(value)
        return true
      end
    end

    false
  end

  def bubble_sort!(&prc)
    x = self.dup
    prc ||= Proc.new{|num1,num2| num1 <=> num2}
    i = 0
    until x.sorted?
      while i < x.length - 1
        num1 = x[i]
        num2 = x[i+1]
          if prc.call(num1,num2) == 1
            x[i],x[i+1] = x[i+1],x[i]
          end
        i += 1
      end
    end
    x
  end

  def sorted?
    self[0..-2].each_index do |idx|
      if self[idx] > self[idx+1]
        return false
      end
    end
    true
  end



  def my_flatten
    array = self.dup
    flat(array)
  end

  def flat(array, aux=[])
    array.my_each do |val|
      if val.is_a?(Array)
        flat(val,aux)
      else
        aux << val
      end
    end
    aux
  end

  def my_zip(*arr)
    array = []
    self.each_with_index do |val1, idx1|
      ans = [val1]
      arr.each do |subarray|
        ans << subarray[idx1]
      end
      array << ans
    end
    array
  end

  def my_rotate(n=1)
    idx = n % self.length
    first = self.take(idx).dup
    second = self.drop(idx).dup
    second + first
  end

  def my_join(sep="")
    ans = self.reduce("") do |acc, ch|
      acc + ch + sep
    end
    if sep != ""
      ans = ans[0..-2]
    end
    ans
  end

  def my_reverse
    array = self.dup
    aux = []
    until array.empty?
      aux << array.pop
    end
    aux
  end

end #of class


def factors(num)
  array = []
  x = Math.sqrt(num).to_f
  if x.to_i == x.to_f
    array << Math.sqrt(num).to_i
    x -= 1
  end
  (x.to_i).downto(1) do |val|
    if num % val == 0
      array.unshift(val)
      array.push(num/val)
    end
  end
  array
end
