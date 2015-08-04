class Employee

  attr_reader :name, :title, :salary, :boss

  def initialize(name, title, salary, boss)
    @name, @title, @salary, @boss  = name, title, salary, boss
  end

  def bonus(multiplier)
    salary * multiplier
  end

end

class Manager < Employee
  attr_reader :employees

  def initialize(name, title, salary, boss, *employees)
    super(name, title, salary, boss)
    @employees = employees
  end

  def bonus(multiplier)
    total_salary = employees.inject(0) do |sum, employee|
      sum + employee.salary
    end
    total_salary * multiplier
  end

end

david = Employee.new("David", "TA", 10000, "Darren")
shawna = Employee.new("Shawna", "TA", 12000, "Darren")
darren = Manager.new("Darren", "TA Manager", 78000, "Ned",shawna, david )
ned = Manager.new("Ned", "Founder", 1000000, nil, darren, shawna, david )

p ned.name
p ned.salary
