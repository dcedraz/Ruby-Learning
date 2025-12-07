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
end

DayThree.new.perform
