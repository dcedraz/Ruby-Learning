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
    invalid_ids = ids.reject { |id| simple_valid_id?(id) }
    result = invalid_ids.sum
    puts "Part I Result: #{result}"
    result
  end

  def solve_part_two
    invalid_ids = ids.reject { |id| complex_valid_id?(id) }
    result = invalid_ids.sum
    puts "Part II Result: #{result}"
    result
  end

  def parse_ranges
    ranges.map do |range|
      start_id, end_id = range.split('-').map(&:to_i)
      (start_id..end_id).to_a
    end.flatten
  end

  def simple_valid_id?(id)
    digits = id.digits.reverse
    length = digits.length
    half_length = length / 2

    return true unless length.even?

    first_half = digits[0...half_length]
    second_half = digits[half_length...length]

    first_half != second_half
  end

  def complex_valid_id?(id)
    digits = id.digits.reverse
    length = digits.length

    regex_shortest = /(.+?)\1+/
    regex_longest = /(.+)\1+/
    matches = id.to_s.scan(regex_shortest).flatten + id.to_s.scan(regex_longest).flatten
    matches.uniq!

    return true if matches.empty?

    matches.none? do |match|
      next unless (length % match.length).zero?

      repeated_digits = match.chars.map(&:to_i)
      digits.each_slice(repeated_digits.length).all? { |slice| slice == repeated_digits }
    end
  end

end

DayTwo.new.perform
