# frozen_string_literal: true

require 'pry'
require_relative 'game_set'

file_data = File.readlines('input_file.txt')
puts "There are #{file_data.count} rows to process"

result = 0

file_data.each_with_index do |row, index|
  puts "Working on #{row}"
  sets_array = row.split(':').last.split(';').map(&:strip)
  game_sets = Array.new.tap do |game_sets|
    sets_array.each do |set|
      game_sets << GameSet.new(set: set)
    end
  end
  game_sets.each(&:print_cubes)

  if game_sets.reject(&:valid).empty?
    result += index + 1
    puts "Added to total result: #{result}"
  end
end

puts result
