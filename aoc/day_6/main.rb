# frozen_string_literal: true

require 'pry'

class DaySix
  # Time:        53     91     67     68
  # Distance:   250   1330   1081   1025

  def win_race?(time_pressed, time_total, distance)
    speed = time_pressed
    remaining_time = time_total - time_pressed
    final_distance = speed * remaining_time
    final_distance > distance
  end

  def solve_part_one
    result = []

    file_data ||= File.readlines('input_file.txt').map(&:split)
    time_array = file_data[0][1..].map(&:to_i)
    distance_array = file_data[1][1..].map(&:to_i)

    distance_array.each_with_index do |race_distance, race_index|
      win_possibilities = 0
      race_time = time_array[race_index]
      (0..race_time).each do |time_pressed|
        next unless win_race?(time_pressed, race_time, race_distance)

        win_possibilities += 1
      end
      result << win_possibilities
    end
    result.reduce(&:*)
  end

  # def solve_part_two
  #
  # end

  def perform
    solve_part_one
    # solve_part_two
  end
end
DaySix.new.perform