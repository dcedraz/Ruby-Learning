# frozen_string_literal: true

require_relative '../../day_base'

class DayOne < DayBase
  attr_reader :rows, :pointer
  attr_accessor :position, :count_zero_occurrences

  FIRST_POSITION = 0
  LAST_POSITION = 99
  INITIAL_POINTER_POSITION = 50
  def initialize
    super
    @rows = file_data
    @pointer = Array(FIRST_POSITION..LAST_POSITION)
    @position = INITIAL_POINTER_POSITION
    @count_zero_occurrences = 0
  end

  def solve_part_one
    rows.each do |instruction|
      calc_new_position(instruction)
    end
    puts "Part I Result: #{count_zero_occurrences}"
    count_zero_occurrences
  end

  def solve_part_two
    result = real_password
    puts "Part II Result: #{result}"
    result
  end

  def calc_new_position(instruction)
    direction, steps = instruction[0], instruction[1..].to_i

    if direction == 'L'
      while new_pos_backwards_to_zero?(position - steps)
        steps -= (LAST_POSITION + 1)
      end
      @position = pointer[position - steps]
    else
      while new_pos_forwards_to_zero?(position + steps)
        steps -= (LAST_POSITION + 1)
      end
      @position = pointer[position + steps]
    end
    @count_zero_occurrences += 1 if position.zero?
  end

  #
  # Copied the solution by Erik Kessler
  # https://github.com/erikkessler1/advent-of-code-2025/blob/master/day-01/secret_entrance.rb
  #

  def real_password
    pointer = 50
    zeros = 0

    turns.each do |turn|
      distance = if turn.negative?
                   (100 - pointer) + (turn * -1)
                 else
                   pointer + turn
                 end

      zeros += distance / 100
      zeros -= 1 if turn.negative? && pointer.zero?
      pointer = (pointer + turn) % 100
    end

    zeros
  end

  private

  def turns
    rows.map do |line|
      value = line[1..].to_i
      line.start_with?("L") ? value * -1 : value
    end
  end

  #
  # End of Erik Kessler solution
  #

  def new_pos_backwards_to_zero?(new_pos)
    new_pos < FIRST_POSITION
  end

  def new_pos_forwards_to_zero?(new_pos)
    new_pos > LAST_POSITION
  end
end

DayOne.new.perform
