# app/models/calculator.rb

class Calculator
  def self.add(numbers)
    delimiter_pattern = ",|\\n"
    custom_delimiters = []

    # Check for custom delimiters
    if numbers.start_with?("//")
      custom_delimiters = numbers[2..numbers.index("\n") - 1].split(/\[|\]/).reject(&:empty?)
      numbers = numbers[(numbers.index("\n") + 1)..-1]
      delimiter_pattern = custom_delimiters.map { |delimiter| Regexp.escape(delimiter) }.join("|")
    end

    numbers_array = numbers.split(/#{delimiter_pattern}/)

    # Ignore numbers bigger than 1000
    numbers_array.reject! { |num| num.to_i > 1000 }

    # Check for negative numbers
    negatives = numbers_array.select { |num| num.to_i < 0 }
    unless negatives.empty?
      raise "negative numbers not allowed: #{negatives.join(', ')}"
    end

    # Convert and sum the numbers
    numbers_array.map(&:to_i).sum
  end
end
