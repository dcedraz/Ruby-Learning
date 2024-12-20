# frozen_string_literal: true

require 'pry'
class DaySix
  attr_reader :file_data, :starting_position, :min_row, :max_row, :min_column, :max_column, :positions_visited,
              :infinite_loop_count

  START_SYMBOL = '^'
  OBSTACLE_SYMBOL = '#'
  NEW_OBSTACLE_SYMBOL = '0'
  DEFAULT_SYMBOL = '.'

  def initialize(input_file: 'input_file.txt')
    @file_data = File.readlines(input_file).map(&:strip)
    @min_row = 0
    @max_row = @file_data.count - 1 # 129
    @min_column = 0
    @max_column = @file_data.first.length - 1 # 129
    @positions_visited = Hash.new { |h, k| h[k] = 0 }
    @infinite_loop_count = 0
  end

  def perform
    solve_part_one
    solve_part_two
  end

  def solve_part_one
    parse_map
    puts "Result part one: #{positions_visited.keys.count}"
    positions_visited.keys.count
  end

  def parse_map
    row, column = starting_position
    directions = {
      north: { move: -> { row -= 1 }, revert: -> { row += 1 }, next: :east },
      east: { move: -> { column += 1 }, revert: -> { column -= 1 }, next: :south },
      south: { move: -> { row += 1 }, revert: -> { row -= 1 }, next: :west },
      west: { move: -> { column -= 1 }, revert: -> { column += 1 }, next: :north }
    }
    current_direction = :north

    loop do
      positions_visited[[row, column]] += 1 unless out_of_boundaries?(row, column)

      return if out_of_boundaries?(row, column)

      if starting_position != [row, column] && positions_visited[[row, column]] > 5
        @infinite_loop_count += 1
        return
      end

      directions[current_direction][:move].call
      if hit_obstacle?(row, column)
        directions[current_direction][:revert].call
        current_direction = directions[current_direction][:next]
      end
    end
  end

  def out_of_boundaries?(row, column)
    row < min_row || row > max_row || column < min_column || column > max_column
  end

  def hit_obstacle?(row, column)
    return if out_of_boundaries?(row, column)

    file_data[row][column] == OBSTACLE_SYMBOL || file_data[row][column] == NEW_OBSTACLE_SYMBOL
  end

  def solve_part_two
    positions_visited.keys.each_with_index do |new_pos, index|
      puts "Index: #{index} / #{positions_visited.keys.count}" if (index % 100).zero?
      @positions_visited = Hash.new { |h, k| h[k] = 0 }
      next if new_pos == starting_position

      file_data[new_pos[0]][new_pos[1]] = NEW_OBSTACLE_SYMBOL
      parse_map
      file_data[new_pos[0]][new_pos[1]] = DEFAULT_SYMBOL
    end
    puts "Result part two: #{infinite_loop_count}"
    infinite_loop_count
  end

  def starting_position
    @starting_position ||= file_data.each_with_index do |line, row|
      column = line.index(START_SYMBOL)
      return [row, column] if column
    end
  end
end

DaySix.new.perform
