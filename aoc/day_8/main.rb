# frozen_string_literal: true

require 'pry'

class DayEight
  attr_reader :file_data, :instructions, :hash_map, :element, :steps

  ELEMENT_REGEX = /\w{3}/.freeze
  ELEMENT_ENDS_WITH_A_REGEX = /\w{2}A/.freeze
  ELEMENT_ENDS_WITH_Z_REGEX = /\w{2}Z/.freeze

  def initialize(input_file: 'input_file.txt')
    @file_data = File.readlines(input_file).map(&:strip)
    @instructions = parse_instructions
    @hash_map = parse_hash_map
    @steps = 0
  end

  def parse_instructions
    file_data.first.gsub('L', '0').gsub('R', '1').chars.map(&:to_i)
  end

  def parse_hash_map
    Hash.new.tap do |hash_map|
      file_data.each.with_index do |row, index|
        next unless index > 1

        elements_array = row.scan(ELEMENT_REGEX).map(&:to_sym)
        hash_map[elements_array[0]] = [elements_array[1], elements_array[2]]
      end
    end
  end

  def perform
    puts solve_part_one
    puts solve_part_two
  end

  def solve_part_one
    @element ||= :AAA
    parse_element while @element != :ZZZ
    steps
  end

  def parse_element
    instructions.each do |instruction|
      @steps += 1
      @element = hash_map[@element][instruction]
    end
  end

  def solve_part_two
    initial_elements = hash_map.keys.select { |element| element.match(ELEMENT_ENDS_WITH_A_REGEX) }
    elements_steps = initial_elements.map do |curr_element|
      @steps = 0
      @element = curr_element
      parse_element until @element.match(ELEMENT_ENDS_WITH_Z_REGEX)
      steps
    end
    elements_steps.reduce(:lcm)
  end
end

DayEight.new.perform
