# frozen_string_literal: true

require_relative '../../day_base'

class DayThree < DayBase
  attr_reader :banks

  def initialize
    super
    @banks = file_data
  end

  def solve_part_one
    result = banks.map { |bank| max_joltage(bank) }.sum
    puts "Part I Result: #{result}"
    result
  end

  def solve_part_two
    result = banks.map { |bank| larger_max_joltage(bank) }.sum
    puts "Part II Result: #{result}"
    result
  end

  #
  # My initial solution
  #
  # def max_joltage(bank)
  #   digits = bank.chars
  #   max_joltage = 0
  #
  #   digits.each_with_index do |d1, i1|
  #     digits.each_with_index do |d2, i2|
  #       next if i2 <= i1
  #
  #       joltage = (d1 + d2).to_i
  #       max_joltage = joltage if joltage > max_joltage
  #     end
  #   end
  #
  #   max_joltage
  # end

  # Copilot simplification

  def max_joltage(bank)
    digits = bank.chars
    digits.combination(2).map { |d1, d2| (d1 + d2).to_i }.max || 0
  end

  # This is a very inefficient solution, it was unable to complete even the first line of the input.
  # Probably because it generates all combinations of 12 digits from the bank, resulting in a huge number of combinations.
  def xlarger_max_joltage(bank)
    puts "Starting bank #{bank} at #{Time.now}"
    result = bank.chars.combination(12).map { |combo| combo.join.to_i }.max || 0
    puts "Finished bank #{bank} at #{Time.now}"
    result
  end

  # Solution by copilot
  def larger_max_joltage(bank)
    needed = 12
    stack = []
    bank.chars.each_with_index do |digit, i|
      while stack.any? &&
            stack.size + bank.length - i > needed &&
            stack.last < digit
        stack.pop
      end
      stack << digit if stack.size < needed
    end
    stack.join.to_i
  end
end

DayThree.new.perform
