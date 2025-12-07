# frozen_string_literal: true

require_relative '../../day_base'

class DayFour < DayBase

  attr_reader :grid
  def initialize
    super
    @grid = file_data.map(&:chars)
    @max_columns = @grid[0].size - 1
    @max_rows = @grid.size - 1
  end

  def solve_part_one
    valid_count = 0
    (0..@max_rows).each do |row|
      (0..@max_columns).each do |col|
        valid_count += 1 if valid_pos?(row, col)
      end
    end
    puts "Part I Result: #{valid_count}"
    valid_count
  end

  def solve_part_two
  end

  def valid_pos?(row, col)
    return false unless grid[row][col] == '@'

    adjacent_at_count = 0
    (-1..1).each do |row_offset|
      (-1..1).each do |col_offset|
        next if row_offset.zero? && col_offset.zero?

        new_row, new_col = row + row_offset, col + col_offset
        if new_row.between?(0, @max_rows) && new_col.between?(0, @max_columns)
          adjacent_at_count += 1 if grid[new_row][new_col] == '@'
        end
      end
    end
    adjacent_at_count < 4
  end

end

DayFour.new.perform
