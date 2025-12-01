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
      puts "Current Position: #{position}, Instruction: #{instruction}, Zeros Count: #{count_zero_occurrences}"
      calc_new_position(instruction)
      puts "New Position: #{position}"
    end
    puts count_zero_occurrences
  end

  def calc_new_position(instruction)
    direction, steps = instruction[0], instruction[1..].to_i

    if direction == 'L'
      steps -= (LAST_POSITION + 1) while (position - steps) < FIRST_POSITION
      @position = pointer[position - steps]
    elsif (position + steps) > LAST_POSITION
      steps -= (LAST_POSITION + 1) while (position + steps) > LAST_POSITION
      @position = pointer[position + steps]
    else
      @position = pointer[position + steps]
    end

    @count_zero_occurrences += 1 if position.zero?
  end

end

DayOne.new.perform
