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
    solve_part_two
  end

  def solve_part_one
    parse_file_data
    create_rules_hash
    puts("Result part one: ", sum_middle_number_valid_updates)
  end

  def solve_part_two
    puts "Result part two: #{sum_middle_number_invalid_updates}"
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

  def sum_middle_number_invalid_updates
    updates.map do |update|
      next if valid_update?(update)

      # fixed = []
      # while !valid_update?(update)
      #   fixed = sort_by_rules(update)
      # end

      fixed = sort_by_rules(update)
      middle = find_middle_number(fixed)
      # puts " Update: #{update}"
      # puts " fixed: #{fixed}: #{middle}"
      puts "Invalid: #{fixed}" if !valid_update?(fixed)
      middle
    end.compact.sum
    # updates.map do |update|
    #   next if valid_update?(update)
    #
    #   array = update.map{ |x|rules_left_hash.values.flatten.count(x) }
    #   max = array.max / 2
    #   binding.pry
    #   update[array.index(max)]
    # end
  end

  def sort_by_rules(update)
    puts "Occurences per rule: #{update.map { |x| rules_left_hash.values.flatten.count(x) }}"
    update.sort do |a, b|
      rules_right_hash.values.flatten.count(a) <=> rules_right_hash.values.flatten.count(b)
    end
    # binding.pry if !valid_update?(new)
  end

  # def sort_by_rules(update)
  #   sorted_update = []
  #   invalid_values = []
  #
  #   update.each_with_index do |num, index|
  #     if valid_left_rule?(update, index) && valid_right_rule?(update, index)
  #       sorted_update << num
  #       next
  #     else
  #       invalid_values << num
  #     end
  #   end
  #
  #   invalid_values.each do |num|
  #     sorted_update.each_with_index do |_sorted_num, index|
  #       # binding.pry if update == [61, 13, 29]
  #       if valid_right_rule?([invalid_values] + sorted_update, index) && valid_left_rule?([invalid_values] + sorted_update, index)
  #         sorted_update.unshift(num)
  #         break
  #       end
  #       if valid_left_rule?(sorted_update + [invalid_values], index) && valid_right_rule?(sorted_update + [invalid_values], index)
  #         sorted_update << num
  #         break
  #       end
  #     end
  #   end
  #
  #   # binding.pry if update == [75, 97, 47, 61, 53]
  #
  #   if sorted_update.length != update.length
  #     invalid_values.reverse!.each do |num|
  #       sorted_update.each_with_index do |_sorted_num, index|
  #         # binding.pry if update == [61, 13, 29]
  #         if valid_right_rule?([invalid_values] + sorted_update, index) && valid_left_rule?([invalid_values] + sorted_update, index)
  #           sorted_update.unshift(num)
  #           break
  #         end
  #         if valid_left_rule?(sorted_update + [invalid_values], index) && valid_right_rule?(sorted_update + [invalid_values], index)
  #           sorted_update << num
  #           break
  #         end
  #       end
  #     end
  #   end
  #
  #   sorted_update
  # end
end

DayFive.new.perform
