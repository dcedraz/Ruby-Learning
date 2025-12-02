# frozen_string_literal: true

require_relative '../../day_base'

class DayTwo < DayBase

  attr_reader :ranges, :ids
  def initialize
    super
    @ranges = file_data.first.split(',')
    @ids = parse_ranges
  end

  def solve_part_one
    invalid_ids = ids.select { |id| !valid_id?(id) }
    result = invalid_ids.sum
    puts result
    result
  end

  def parse_ranges
    ranges.map do |range|
      start_id, end_id = range.split('-').map(&:to_i)
      (start_id..end_id).to_a
    end.flatten
  end

  def valid_id?(id)
    digits = id.digits.reverse
    length = digits.length
    half_length = length / 2

    return true unless length.even?

    first_half = digits[0...half_length]
    second_half = digits[half_length...length]

    first_half != second_half
  end

end

DayTwo.new.perform