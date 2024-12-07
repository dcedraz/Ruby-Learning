# frozen_string_literal: true

require 'pry'
class DayFour
  attr_reader :file_data, :min_row, :max_row, :min_column, :max_column, :xmas, :xmas_count

  def initialize(input_file: 'input_file.txt')
    @file_data = File.readlines(input_file)
    @min_row = 0
    @max_row = @file_data.count - 1 # 139
    @min_column = 0
    @max_column = @file_data.first.length - 2 # 139
    @xmas = 'XMAS'
  end

  def perform
    solve_part_one
    solve_part_two
  end

  def solve_part_one
    @xmas_count = 0
    count_xmas_occurrences
  end

  def count_xmas_occurrences
    (0..max_row).each do |r|
      (0..max_column).each do |c|
        next unless file_data[r][c] == xmas[0]

        puts "[#{r},#{c}] - Horizontal: #{count_xmas_horizontal(r,
                                                                c)} - Vertical: #{count_xmas_vertical(r,
                                                                                                      c)} - Diagonal: #{count_xmas_diagonal(
                                                                                                        r, c
                                                                                                      )}"

        @xmas_count += count_xmas_horizontal(r, c)
        @xmas_count += count_xmas_vertical(r, c)
        @xmas_count += count_xmas_diagonal(r, c)
        puts "XMAS count: #{@xmas_count}"
      end
    end
  end

  def xmas_count_in_position(row, column)
    return 0 if file_data[row][column] != xmas[0]

    count_xmax_recursively(row, column, 1)
    @xmas_count
  end

  def find_char_positions_around(row, column, char)
    positions = []
    (row - 1..row + 1).each do |r|
      next if r < min_row || r > max_row

      (column - 1..column + 1).each do |c|
        next if c < min_column || c > max_column
        next unless file_data[r][c] == char

        positions << [r, c]
      end
    end
    positions
  end

  def horizontal_direction?(row, column, next_row, next_column)
    row == next_row
  end

  def vertical_direction?(row, column, next_row, next_column)
    column == next_column
  end

  def diagonal_direction?(row, column, next_row, next_column)
    (row - next_row).abs == (column - next_column).abs
  end

  def count_xmas_horizontal(row, column)
    target = valid_column?(column + xmas.length - 1) ? file_data[row][column..column + xmas.length - 1] : ''
    reverse_target = valid_column?(column - xmas.length + 1) ? file_data[row][column - xmas.length + 1..column] : ''

    (xmas == target ? 1 : 0) + (xmas.reverse == reverse_target ? 1 : 0)
  end

  def count_xmas_vertical(row, column)
    target_down = (0..xmas.length - 1).map { |i| valid_row?(row + i) ? file_data[row + i][column] : '' }.join
    target_up = (0..xmas.length - 1).map { |i| valid_row?(row - i) ? file_data[row - i][column] : '' }.join

    (target_down == xmas ? 1 : 0) + (target_up == xmas ? 1 : 0)
  end

  def count_xmas_diagonal(row, column)
    directions = [[1, 1], [-1, -1], [1, -1], [-1, 1]]
    directions.count do |dr, dc|
      target = (0..xmas.length - 1).map do |i|
        next unless valid_row?(row + i * dr) && valid_column?(column + i * dc)

        file_data[row + i * dr][column + i * dc]
      end.join
      target == xmas
    end
  end

  def valid_row?(number)
    number >= min_row && number <= max_row
  end

  def valid_column?(number)
    number >= min_column && number <= max_column
  end

  def solve_part_two
  end
end

DayFour.new.perform