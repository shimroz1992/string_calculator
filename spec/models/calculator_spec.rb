# spec/models/calculator_spec.rb

require 'rails_helper'
require 'calculator'

RSpec.describe Calculator do
  describe '.add' do
    it 'returns 0 for an empty string' do
      expect(Calculator.add("")).to eq(0)
    end

    it 'returns the number itself when a single number is passed' do
      expect(Calculator.add("1")).to eq(1)
    end

    it 'returns the sum of two numbers' do
      expect(Calculator.add("1,2")).to eq(3)
    end

    it 'returns the sum of multiple numbers' do
      expect(Calculator.add("1,2,3,4,5")).to eq(15)
    end

    it 'returns the sum when numbers are separated by new lines' do
      expect(Calculator.add("1\n2,3")).to eq(6)
    end

    it 'supports different delimiters' do
      expect(Calculator.add("//;\n1;2")).to eq(3)
    end

    it 'throws an exception for negative numbers' do
      expect { Calculator.add("1,-2,3,-4") }.to raise_error("negative numbers not allowed: -2, -4")
    end

    it 'ignores numbers bigger than 1000' do
      expect(Calculator.add("2,1001")).to eq(2)
    end

    it 'supports multiple custom delimiters' do
      expect(Calculator.add("//[***][%%%]\n1***2%%%3")).to eq(6)
    end

    it 'supports single character custom delimiters' do
      expect(Calculator.add("//;\n1;2;3")).to eq(6)
    end

    it 'supports multi-character custom delimiters' do
      expect(Calculator.add("//[***]\n1***2***3")).to eq(6)
    end
  end
end