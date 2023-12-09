# frozen_string_literal: true

require 'pry'

PARSE_NUMBERS_REGEX = /\d+(?:\s+\d+)*/.freeze

locations = []

seeds = File.read('input_file.txt').scan(PARSE_NUMBERS_REGEX)[0].split

def find_destination(mapping_set, target_source)
  mapping_set.each do |set|
    destination, source, range = set.map(&:to_i)

    destination_max = destination + range
    source_max = source + range

    source_range = (source..source_max)

    next unless source_range.member?(target_source)

    puts "Source found on set: #{set}"
    return ((target_source - source_max).abs - destination_max).abs
  end
  false
end

def parse_set(index)
  File.read('input_file.txt').scan(PARSE_NUMBERS_REGEX)[index].split(/\n/).map { |x| x.split(/\s/) }
end

seeds.each do |seed|
  mapping_set = [
    { seed_to_soil: nil },
    { soil_to_fertilizer: nil },
    { fertilizer_to_water: nil },
    { water_to_light: nil },
    { light_to_temperature: nil },
    { temperature_to_humidity: nil },
    { humidity_to_location: nil }
  ]
  puts "Worning on seed: #{seed}"
  mapping_set.each_with_index do |set, index|
    puts "Looking for #{set.keys.first}"
    target_source = mapping_set[index - 1].values.first || seed.to_i
    result = find_destination(parse_set(index + 1), target_source) || target_source
    puts "Result: #{result}"
    mapping_set[index] = { set.keys.first => result }
  end
  puts mapping_set
  locations << mapping_set.last.values.first
end
puts locations
puts "Min location: #{locations.min}"

