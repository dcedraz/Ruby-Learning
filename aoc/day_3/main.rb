# frozen_string_literal: true

require 'pry'

file_data = File.readlines('input_file.txt')
puts "There are #{file_data.count} rows to process"

MIN_ROW = 0
MAX_ROW = file_data.count - 1 # 139

MIN_COLUMN = 0
MAX_COLUMN = file_data.first.length - 1 # 139

NON_SPECIAL_SYMBOLS = /[\w.\n]/.freeze

result_one = 0

def digit?(char)
  char.match?(/[[:digit:]]/)
end

def symbol_around?(matrix, x, y)
  (x - 1..x + 1).each do |row|
    next if row < MIN_ROW || row > MAX_ROW

    (y - 1..y + 1).each do |column|
      next if column < MIN_COLUMN || column > MAX_COLUMN
      next if matrix[row][column].match?(NON_SPECIAL_SYMBOLS)

      return true
    end
  end
  false
end

file_data.each_with_index do |row, row_index|
  sequential_number = []
  symbol_around = false
  row.chars.each_with_index do |char, char_index|
    if digit?(char)
      sequential_number << char
      symbol_around ||= symbol_around?(file_data, row_index, char_index)
    elsif !sequential_number.empty? && symbol_around
      puts "Index: #{row_index} - Sequential Number: #{sequential_number.join}"
      result_one += sequential_number.join.to_i
      sequential_number = []
      symbol_around = false
    else
      sequential_number = []
      symbol_around = false
    end
  end
end

puts result_one
