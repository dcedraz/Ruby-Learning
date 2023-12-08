# frozen_string_literal: true

require 'pry'

file_data = File.readlines('input_file.txt')
puts "There are #{file_data.count} rows to process"

result_one = 0

file_data.each_with_index do |row, _index|
  puts "Working on #{row}"
  winning_numbers, played_numbers = row.split(':').last.split('|')
  winning_numbers = winning_numbers.strip.scan(/\d+/)
  played_numbers = played_numbers.strip.scan(/\d+/)
  matched_numbers = played_numbers.filter { |x| winning_numbers.include?(x) }
  next if matched_numbers.empty?

  puts "Matched numbers: #{matched_numbers}"
  result_one += (1..matched_numbers.count).reduce { |x, _| x * 2 }
end

puts result_one
