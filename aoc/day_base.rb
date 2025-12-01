# frozen_string_literal: true

require 'pry'

class DayBase
  attr_reader :file_data

  def initialize(input_file: 'input_file.txt')
    @file_data = File.readlines(input_file).map(&:strip)
  end

  def perform
    solve_part_one
    solve_part_two
  end

  def solve_part_one
    # Implement in subclass
  end

  def solve_part_two
    # Implement in subclass
  end
end
