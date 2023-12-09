# frozen_string_literal: true

class MapSet
  attr_reader :mapping_set, :mappings_hash

  def initialize(mapping_set:)
    @mapping_set = mapping_set
    @mappings_hash = {}
    # calc_mappings
  end

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

  def calc_mappings
    mapping_set.each do |set|
      puts "Processing set: #{set}"
      destination, source, range = set.map(&:to_i)
      # destination_range = (destination..destination + range).to_a
      # source_range = (source..source + range).to_a
      (0..range).each do |index|
        mappings_hash[source + index] = destination + index
      end
    end
  end
end
