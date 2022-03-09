# frozen_string_literal: true

require './lib/calculator'

describe Calculator do
  describe '#add' do
    it 'returns the sum of two numbers' do
      calculator = Calculator.new
      expect(calculator.add(5, 2)).to eql(7)
    end

    it 'returns the sum of more than two numbers' do
      calculator = Calculator.new
      expect(calculator.add(2, 5, 7)).to eql(14)
    end
  end

  describe '#multiply' do
    it 'returns the product of two numbers' do
      calculator = Calculator.new
      expect(calculator.multiply(5, 2)).to eql(10)
    end
    it 'returns the product or more than two numbers' do
      calculator = Calculator.new
      expect(calculator.multiply(5, 2, 7)).to eql(70)
    end
  end

  describe '#subtract' do
    it 'returns the difference of two numbers' do
      calculator = Calculator.new
      expect(calculator.subtract(5, 2)).to eql(3)
    end
    it 'returns negative numbers when needed' do
      calculator = Calculator.new
      expect(calculator.subtract(2, 5)).to eql(-3)
    end
  end

  describe '#divide' do
    it 'returns the quotient of two numbers' do
      calculator = Calculator.new
      expect(calculator.divide(6, 2)).to eql(3)
    end
    it 'returns a float if needed' do
      calculator = Calculator.new
      expect(calculator.divide(5, 2)).to eql(2.5)
    end
  end
end
