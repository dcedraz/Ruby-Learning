# frozen_string_literal: true

require 'pry'

class DayOne
  attr_reader :file_data, :left_instructions, :right_instructions, :instructions_difference,
              :left_on_right_appearances, :similarities, :result_part_one, :result_part_two

  def initialize(input_file: 'input_file.txt')
    @file_data = File.readlines(input_file).map(&:strip)
    @left_instructions = []
    @right_instructions = []
    @instructions_difference = []
    @left_on_right_appearances = []
    @similarities = []
    @result_part_one = 0
    @result_part_two = 0
  end

  def perform
    puts solve_part_one
    puts solve_part_two
  end

  def solve_part_one
    parse_instructions
    calculate_difference
    @result_part_one = instructions_difference.sum
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

  def solve_part_two
    calc_left_on_right_appearances
    calc_similarities
    @result_part_two = similarities.sum
  end

  def calc_left_on_right_appearances
    right_appearances = right_instructions.each_with_object(Hash.new(0)) do |right, hash|
      hash[right] += 1
    end
    @left_on_right_appearances = left_instructions.map do |left|
      right_appearances[left]
    end
  end

  def calc_similarities
    @similarities = left_instructions.zip(left_on_right_appearances).map do |left, appearances|
      left * appearances
    end
  end
end

DayOne.new.perform