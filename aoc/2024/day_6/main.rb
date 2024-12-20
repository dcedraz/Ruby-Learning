# frozen_string_literal: true

require 'pry'
class DaySix

  attr_reader :file_data, :starting_position, :min_row, :max_row, :min_column, :max_column, :positions_visited

  START_SYMBOL = '^'
  OBSTACLE_SYMBOL = '#'

  def initialize(input_file: 'input_file.txt')
    @file_data = File.readlines(input_file).map(&:strip)
    @min_row = 0
    @max_row = @file_data.count - 1 # 129
    @min_column = 0
    @max_column = @file_data.first.length - 1 # 129
    @positions_visited = []
  end

  def perform
    solve_part_one
    solve_part_two
  end

  def solve_part_one
    puts "Result part one: #{steps_to_exit}"
  end

  def steps_to_exit
    row, column = starting_position
    directions = {
      north: { move: -> { row -= 1 }, revert: -> { row += 1 }, next: :east },
      east: { move: -> { column += 1 }, revert: -> { column -= 1 }, next: :south },
      south: { move: -> { row += 1 }, revert: -> { row -= 1 }, next: :west },
      west: { move: -> { column -= 1 }, revert: -> { column += 1 }, next: :north }
    }
    current_direction = :north

    loop do
      positions_visited << [row, column] unless out_of_boundaries?(row, column)
      puts "Direction: #{current_direction.capitalize} - Row: #{row}, Column: #{column} - Steps: #{positions_visited.uniq.count}"

      return positions_visited.uniq.count if out_of_boundaries?(row, column)

      directions[current_direction][:move].call
      if hit_obstacle?(row, column)
        directions[current_direction][:revert].call
        current_direction = directions[current_direction][:next]
      end
    end
  end

  # def steps_to_exit
  #   steps = 0
  #   row, column = starting_position
  #   north_direction = true
  #   east_direction = false
  #   south_direction = false
  #   west_direction = false
  #
  #   loop do
  #     steps += 1
  #     puts "North: #{north_direction}, East: #{east_direction}, South: #{south_direction}, West: #{west_direction} - Row: #{row}, Column: #{column} - Steps: #{steps}"
  #
  #     return steps if out_of_boundaries?(row, column)
  #
  #     if north_direction
  #       row -= 1
  #       if hit_obstacle?(row, column)
  #         row += 1
  #         # column += 1
  #         # row -= 1
  #         north_direction = false
  #         east_direction = true
  #       end
  #     end
  #
  #     if east_direction
  #       column += 1
  #       if hit_obstacle?(row, column)
  #         column -= 1
  #         # row += 1
  #         # column += 1
  #         east_direction = false
  #         south_direction = true
  #       end
  #     end
  #
  #     if south_direction
  #       row += 1
  #       if hit_obstacle?(row, column)
  #         row -= 1
  #         # column -= 1
  #         # row += 1
  #         south_direction = false
  #         west_direction = true
  #       end
  #     end
  #
  #     if west_direction
  #       column -= 1
  #       if hit_obstacle?(row, column)
  #         column += 1
  #         # row -= 1
  #         # column -= 1
  #         west_direction = false
  #         north_direction = true
  #       end
  #     end
  #   end
  # end

  def out_of_boundaries?(row, column)
    row < min_row || row > max_row || column < min_column || column > max_column
  end

  def hit_obstacle?(row, column)
    return if out_of_boundaries?(row, column)

    file_data[row][column] == OBSTACLE_SYMBOL
  end

  def solve_part_two
  end

  def starting_position
    @starting_position ||= file_data.each_with_index do |line, row|
      column = line.index(START_SYMBOL)
      return [row, column] if column
    end
  end

end

DaySix.new.perform