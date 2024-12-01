# frozen_string_literal: true

require 'pry'

class DayOne
  attr_reader :file_data, :left_instructions, :right_instructions, :instructions_difference

  def initialize(input_file: 'input_file.txt')
    @file_data = File.readlines(input_file).map(&:strip)
    @left_instructions = []
    @right_instructions = []
    @instructions_difference = []
    parse_instructions
    calculate_difference
  end

  def parse_instructions
    file_data.each do |line|
      left, right = line.split
      left_instructions << left.to_i
      right_instructions << right.to_i
    end
    right_instructions.sort!
    left_instructions.sort!
  end

  def calculate_difference
    # left_instructions.each_with_index{|v,i| @instructions_difference << (v - right_instructions[i]).abs}
    @instructions_difference = left_instructions.zip(right_instructions).map do |left, right|
      (left - right).abs
    end
  end

  def perform
    puts solve_part_one
    # puts solve_part_two
  end

  def solve_part_one
    instructions_difference.sum
  end

  # def solve_part_two
  #   left_instructions.zip(right_instructions).map do |left, right|
  #     left * right
  #   end.sum
  # end
end

DayOne.new.perform