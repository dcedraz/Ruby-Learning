# frozen_string_literal: true

require 'pry'
class DayFive
  attr_reader :file_data, :rules, :updates, :rules_right_hash, :rules_left_hash
  def initialize(input_file: 'input_file.txt')
    @file_data = File.readlines(input_file).map(&:strip)
    @rules = []
    @updates = []
    @rules_right_hash = Hash.new { |h, k| h[k] = [] }
    @rules_left_hash = Hash.new { |h, k| h[k] = [] }
  end

  def perform
    solve_part_one
  end

  def solve_part_one
    parse_file_data
    create_rules_hash
    puts("Result part one: ", sum_middle_number_valid_updates)
  end

  def parse_file_data
    file_data.each do |line|
      next if line.empty?

      if line.match?(/\d+\|\d+/)
        rules << line.split('|').map(&:to_i)
      else
        updates << line.split(',').map(&:to_i)
      end
    end
  end

  def create_rules_hash
    rules.each do |rule|
      rules_right_hash[rule[0]] << rule[1]
      rules_left_hash[rule[1]] << rule[0]
    end
  end

  def sum_middle_number_valid_updates
    updates.map do |update|
      next unless valid_update?(update)

      find_middle_number(update)
    end.compact.sum
  end

  def valid_update?(update)
    update.all? do |num|
      valid_left_rule?(update, update.index(num)) && valid_right_rule?(update, update.index(num))
    end
  end

  def valid_left_rule?(update, pos)
    update[0..pos].none? { |num| rules_right_hash[update[pos]].include?(num) }
  end

  def valid_right_rule?(update, pos)
    update[pos..].none? { |num| rules_left_hash[update[pos]].include?(num) }
  end

  def find_middle_number(update)
    middle = update.length / 2
    update[middle]
  end
end

DayFive.new.perform
