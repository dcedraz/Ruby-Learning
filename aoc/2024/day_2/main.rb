# frozen_string_literal: true

require 'pry'

class DayTwo
  attr_reader :file_data, :rows

  def initialize(input_file: 'input_file.txt')
    @file_data = File.readlines(input_file).map(&:strip)
    @rows = []
  end

  def perform
    puts solve_part_one
    puts solve_part_two
  end

  def solve_part_one
    puts 'initiating'
    parse_rows
    safe_reports
  end

  def safe_reports
    rows.count do |row|
      Report.new(row).safe?
    end
  end

  class Report
    attr_reader :levels

    def initialize(levels)
      @levels = levels
    end

    def increasing?
      levels.each_cons(2).all? do |a, b|
        a < b
      end
    end

    def decreasing?
      levels.each_cons(2).all? do |a, b|
        a > b
      end
    end

    def adjacent_levels?
      levels.each_cons(2).all? do |a, b|
        (a - b).abs >= 1 && (a - b).abs <= 3
      end
    end

    def safe?
      adjacent_levels? && (increasing? || decreasing?)
    end
  end

  def parse_rows
    @rows = file_data.map do |line|
      line.split.map(&:to_i)
    end
  end

  def solve_part_two
  end
end
