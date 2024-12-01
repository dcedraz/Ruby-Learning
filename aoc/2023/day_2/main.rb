# frozen_string_literal: true

require 'pry'
require_relative 'game_set'

file_data = File.readlines('input_file.txt')
puts "There are #{file_data.count} rows to process"

result_part_one = 0
result_part_two = 0

def part_two(game_sets)
  min_greens = game_sets.map(&:greens).max
  min_blues = game_sets.map(&:blues).max
  min_reds = game_sets.map(&:reds).max
  min_greens * min_blues * min_reds
end

file_data.each_with_index do |row, index|
  puts "Working on #{row}"
  sets_array = row.split(':').last.split(';').map(&:strip)
  game_sets = Array.new.tap do |game_sets|
    sets_array.each do |set|
      game_sets << GameSet.new(set: set)
    end
  end
  game_sets.each(&:print_cubes)
  result_part_two += part_two(game_sets)

  if game_sets.reject(&:valid).empty?
    result_part_one += index + 1
    puts "Added to total result_1: #{result_part_one}"
  end
end

puts result_part_one
puts result_part_two
