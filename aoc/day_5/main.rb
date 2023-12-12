# frozen_string_literal: true

require 'pry'
require 'get_process_mem'

def print_usage(description)
  mb = GetProcessMem.new.mb
  puts "#{description} - MEMORY USAGE(MB): #{mb.round}"
end

def print_usage_before_and_after(message)
  print_usage("Before - #{message} - at #{Time.now}")
  yield
  print_usage("After - #{message} - at #{Time.now}")
end

PARSE_NUMBERS_REGEX = /\d+(?:\s+\d+)*/.freeze

min_location = nil

def parse_set(index)
  File.read('input_file.txt').scan(PARSE_NUMBERS_REGEX)[index].split(/\n/).map { |x| x.split(/\s/) }
end

seeds = File.read('input_file.txt').scan(PARSE_NUMBERS_REGEX)[0].split.map(&:to_i)
seed_to_soil = parse_set(1)
soil_to_fertilizer = parse_set(2)
fertilizer_to_water = parse_set(3)
water_to_light = parse_set(4)
light_to_temperature = parse_set(5)
temperature_to_humidity = parse_set(6)
humidity_to_location = parse_set(7)

parsed_sets = [
  seed_to_soil,
  soil_to_fertilizer,
  fertilizer_to_water,
  water_to_light,
  light_to_temperature,
  temperature_to_humidity,
  humidity_to_location
]

max_location = parsed_sets.last.map { |set| set[1] }.map(&:to_i).max

def find_destination(mapping_set, target_source)
  mapping_set.each do |set|
    destination, source, range = set.map(&:to_i)

    destination_max = destination + range
    source_max = source + range

    source_range = (source..source_max)

    next unless source_range.member?(target_source)

    return ((target_source - source_max).abs - destination_max).abs
  end
  false
end

def find_source(mapping_set, target_destination)
  mapping_set.each do |set|
    destination, source, range = set.map(&:to_i)

    destination_max = destination + range
    source_max = source + range
    destination_range = (destination..destination_max)

    next unless destination_range.member?(target_destination)

    return ((target_destination - destination_max).abs - source_max).abs
  end
  false
end

puts "Start process: #{Time.now}"

seeds_range = []

seeds.each_slice(2) do |seed_start, range|
  seed_end = seed_start + range
  seeds_range << (seed_start..seed_end)
end

(0..max_location).each do |location|
  puts "Processing location #{location} - #{Time.now}" if location % 1000000 == 0
  target_destination = location
  mapping_set = parsed_sets.reverse.map do |set|
    target_destination = find_source(set, target_destination) || target_destination
    target_destination
  end
  next unless seeds_range.any? { |range| range.member?(mapping_set.last) }

  min_location = location
  break
end

puts "End process: #{Time.now}"
puts "Min location: #{min_location}"
