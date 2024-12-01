# frozen_string_literal: true

class GameSet

  attr_reader :set, :blues, :reds, :greens, :valid

  COLORS = ['green', 'red', 'blue']
  MAX_RED = 12
  MAX_GREEN = 13
  MAX_BLUE = 14

  def initialize(set:)
    @set = set
    @blues = 0
    @reds = 0
    @greens = 0
    @valid = true
    count_cubes
  end

  def count_cubes
    COLORS.each do |color|
      cubes_by_color(color)
    end
  end

  def cubes_by_color(color)
    count = set.scan(/\d+\s#{color}/).first.to_i
    instance_variable_set("@#{color}s", count)
    return unless valid

    @valid = count <= Object.const_get("GameSet::MAX_#{color.upcase}")
  end

  def print_cubes
    puts "Set: #{set} - Blues: #{blues} - Red: #{reds} - Greens: #{greens} - Valid: #{valid}"
  end
end
