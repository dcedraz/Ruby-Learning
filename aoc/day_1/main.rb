# frozen_string_literal: true

DIGITS_REGEX = /[[:digit:]]|on(?=e)|tw(?=o)|th(?=ree)|fo(?=ur)|fi(?=ve)|si(?=x)|se(?=ven)|e(?=ight)|n(?=ine)/.freeze

NUMBERS_HASH = {
  on: "1",
  tw: "2",
  th: "3",
  fo: "4",
  fi: "5",
  si: "6",
  se: "7",
  e: "8",
  n: "9"
}.freeze

file_data = File.read("input_file.txt").split
puts "There are #{file_data.count} rows to process"

result = 0

def parse_digit(num_string)
  NUMBERS_HASH[num_string.to_sym] || num_string
end

file_data.each_with_index do |row, index|
  puts "Processing row #{index}: #{row}:"

  digits_array = row.downcase.scan(DIGITS_REGEX)

  first_digit = parse_digit(digits_array.first)
  puts "First digit: #{first_digit}"

  second_digit = parse_digit(digits_array.last)
  puts "Second digit: #{second_digit}"

  sum = first_digit.to_s + second_digit.to_s
  puts "Sum: #{sum.to_i}"

  result += sum.to_i

  puts "Result total: #{result}"
end
