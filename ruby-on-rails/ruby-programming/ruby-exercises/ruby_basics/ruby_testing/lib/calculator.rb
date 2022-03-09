# frozen_string_literal: true

# A basic calculator
class Calculator
  def add(*nums)
    nums.reduce(0) { |total, ea| total + ea }
  end

  def multiply(*nums)
    nums.reduce(1) { |total, ea| total * ea }
  end

  def subtract(a, b)
    a - b
  end

  def divide(a, b)
    if a.is_a?(Integer) && b.is_a?(Integer) && a % b != 0
      a / b.to_f
    else
      a / b
    end
  end
end
