# frozen_string_literal: true

require 'pry'
class DaySeven
  attr_reader :file_data

  def initialize(input_file: 'input_file.txt')
    @file_data = File.readlines(input_file).map(&:strip)
  end

  def perform
    # solve_part_one
    # solve_part_two
  end

  def equations
    @equations ||= file_data.map do |line|
      Equation.new(line)
    end
  end

  def solve_part_one
    puts "Result part one: #{file_data.count}"
    file_data.count
  end

  def solve_part_two
    puts 'Result part two'
  end

  class Equation
    attr_reader :test_value, :numbers

    POSSIBLE_OPERATORS = %w[+ *].freeze

    def initialize(line)
      @test_value, numbers = line.split(':')
      @test_value = @test_value.to_i
      @numbers = numbers.split(' ').map(&:to_i)
    end

    def possible_combinations
      number_of_pairs = numbers.size - 1
      operators_combinations = POSSIBLE_OPERATORS.repeated_permutation(number_of_pairs).to_a
      operators_combinations.map do |operators|
        numbers.zip(operators).flatten.compact.join(' ')
      end
    end

    def valid?
      numbers.each_cons(2).all? do |a, b|
        POSSIBLE_OPERATORS.include?(a.to_s) || POSSIBLE_OPERATORS.include?(b.to_s)
      end
    end
  end
end

# DaySeven.new.perform
