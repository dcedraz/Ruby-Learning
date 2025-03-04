# frozen_string_literal: true

require 'pry'
class DayEight
  attr_reader :file_data, :min_row, :max_row, :min_column, :max_column
  attr_accessor :frequency_hash, :nodes

  def initialize(input_file: 'input_file.txt')
    @file_data = File.readlines(input_file).map(&:strip)
    @min_row = 0
    @max_row = @file_data.count - 1 # 49
    @min_column = 0
    @max_column = @file_data.first.length - 1 # 49
    @frequency_hash = Hash.new { |h, k| h[k] = [] }
  end

  def perform
    solve_part_one
    solve_part_two
  end

  def solve_part_one
    parse_frequencies
    parse_nodes
    puts 'Result part one: ' + nodes.count.to_s
    nodes.count
  end

  def parse_frequencies
    file_data.each_with_index do |row, row_index|
      row.split('').each_with_index do |column, column_index|
        next if column == '.'

        frequency_hash[column] << [row_index, column_index]
      end
    end
  end

  # example
  # posA(1,8) + diffAB(-1,3) = node(0,11)
  # posB(2,5) + diffBA(1,-3) = node(3,2)
  def parse_nodes
    @nodes ||= frequency_hash.flat_map do |frequency, positions|
      positions.flat_map do |row, column|
        positions.map do |next_row, next_column|
          next if row == next_row && column == next_column

          diff_row = row - next_row
          diff_column = column - next_column
          node_row = row + diff_row
          node_column = column + diff_column
          next if out_of_boundaries?(node_row, node_column)

          [node_row, node_column]
        end
      end
    end.compact.uniq
  end

  def solve_part_two

  end

  def out_of_boundaries?(row, column)
    row < min_row || row > max_row || column < min_column || column > max_column
  end
end

DayEight.new.perform