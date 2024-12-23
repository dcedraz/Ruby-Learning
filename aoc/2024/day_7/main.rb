# frozen_string_literal: true

require 'pry'
class DaySeven
  attr_reader :file_data

  def initialize(input_file: 'input_file.txt')
    @file_data = File.readlines(input_file).map(&:strip)
  end

  def perform
    solve_part_one
    solve_part_two
  end

  def equations
    @equations ||= file_data.map do |line|
      Equation.new(line)
    end
  end

  def second_equations
    @second_equations ||= file_data.map do |line|
      Equation.new(line, %w[+ * #])
    end
  end

  def solve_part_one
    result = equations.select(&:valid?).map(&:test_value).sum
    puts 'Result part one: ' + result.to_s
    result
  end

  def solve_part_two
    result = second_equations.select(&:valid?).map(&:test_value).sum
    puts 'Result part two: ' + result.to_s
    result
  end

  class Equation
    attr_reader :test_value, :numbers, :operators

    def initialize(line, operators = %w[+ *])
      @test_value, numbers = line.split(':')
      @test_value = @test_value.to_i
      @numbers = numbers.split(' ').map(&:to_i)
      @operators = operators
    end

    def possible_combinations
      @possible_combinations ||= begin
        number_of_pairs = numbers.size - 1
        operators_combinations = operators.repeated_permutation(number_of_pairs).to_a
        operators_combinations.map do |operators|
          numbers.zip(operators).flatten.compact.join(' ')
        end
      end
    end

    def evaluate_left_to_right(expression)
      tokens = expression.split
      result = tokens.shift.to_i

      tokens.each_slice(2) do |operator, operand|
        result = if operator == '#'
                   (result.to_s + operand).to_i
                 else
                   result.send(operator, operand.to_i)
                 end
      end

      result
    end
    def valid?
      possible_combinations.any? do |combination|
        evaluate_left_to_right(combination) == test_value
      end
    end
  end
end

DaySeven.new.perform
