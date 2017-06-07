class Employee

  attr_accessor :salary, :name

  def initialize(name, title, salary, boss)
    @name = name
    @title = title
    @salary = salary
    @boss = boss
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end

class Manager < Employee

  def initialize(name, title, salary, boss, employees)
    @employees = employees
    super(name, title, salary, boss)
  end

  def bonus(multiplier)
    sum_of_salaries = 0
    @employees.each do |em|
      if em.is_a?(Manager)
        sum_of_salaries += (em.bonus(multiplier) / multiplier) + em.salary
      else
        sum_of_salaries += em.salary
      end
    end
    sum_of_salaries * multiplier
  end

end
