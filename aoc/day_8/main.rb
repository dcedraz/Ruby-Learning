# frozen_string_literal: true

require 'pry'

class DayEight
  attr_reader :file_data, :instructions, :hash_map, :element, :result_part_one

  def initialize(input_file: 'input_file.txt')
    @file_data = File.readlines(input_file).map(&:strip)
  end

  def perform
    puts solve_part_one
    # puts solve_part_two
  end

  def solve_part_one
    @result_part_one ||= 0
    solve
  end

  def solve_part_two
  end

  def solve
    @instructions ||= file_data.first.gsub('L', '0').gsub('R', '1').chars.map(&:to_i)
    @hash_map ||= Hash.new.tap do |hash_map|
      file_data.each.with_index do |row, index|
        next unless index > 1

        elements_array = row.scan(/\w{3}/).map(&:to_sym)
        hash_map[elements_array[0]] = [elements_array[1], elements_array[2]]
      end
    end
    @element ||= :AAA
    parse_instructions while @element != :ZZZ
    result_part_one
  end

  def parse_instructions
    instructions.each do |instruction|
      @result_part_one += 1
      @element = hash_map[@element][instruction]
    end
  end
end

DayEight.new.perform
