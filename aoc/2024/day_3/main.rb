# frozen_string_literal: true

require 'pry'

class DayThree
  attr_reader :file_data, :muls

  MUL_REGEX = /mul\((\d+),(\d+)\)/

  def initialize(input_file: 'input_file.txt')
    @file_data = File.readlines(input_file).map(&:strip)
    @muls = []
  end

  def solve_part_one
    parse_muls
    puts calculate_muls
  end

  def parse_muls
    scan = file_data.flat_map do |line|
      line.scan(MUL_REGEX)
    end
    @muls = scan.map do |pair|
      pair.map(&:to_i)
    end
  end

  def calculate_muls
    muls.map do |pair|
      pair.reduce(:*)
    end.reduce(:+)
  end

end
