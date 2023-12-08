# frozen_string_literal: true

require 'pry'

file_data = File.readlines('input_file.txt')
puts "There are #{file_data.count} rows to process"

result_one = 0
result_two = 0

def find_matched_numbers_recursively(file_data, row, index, result_two)
  result_two += 1
  puts "Result two: #{result_two}"
  winning_numbers, played_numbers = row.split(':').last.split('|')
  winning_numbers = winning_numbers.strip.scan(/\d+/)
  played_numbers = played_numbers.strip.scan(/\d+/)
  matched_numbers = played_numbers.filter { |x| winning_numbers.include?(x) }
  return result_two if matched_numbers.empty?

  puts "Matched numbers: #{matched_numbers}"
  matched_numbers.each_with_index do |_, matched_index|
    new_index = index + matched_index + 1
    result_two = find_matched_numbers_recursively(file_data, file_data[new_index], new_index, result_two)
  end
  result_two
end

file_data.each_with_index do |row, index|
  puts "Working on #{row}"
  result_two = find_matched_numbers_recursively(file_data, row, index, result_two)
  # winning_numbers, played_numbers = row.split(':').last.split('|')
  # winning_numbers = winning_numbers.strip.scan(/\d+/)
  # played_numbers = played_numbers.strip.scan(/\d+/)
  # matched_numbers = played_numbers.filter { |x| winning_numbers.include?(x) }
  # next if matched_numbers.empty?
  #
  # puts "Matched numbers: #{matched_numbers}"
  # result_one += (1..matched_numbers.count).reduce { |x, _| x * 2 }
end

puts result_one
puts result_two
