# frozen_string_literal: true

require 'pry'

class DayTwo
  attr_reader :file_data, :rows, :reports, :unsafe_reports

  def initialize(input_file: 'input_file.txt')
    @file_data = File.readlines(input_file).map(&:strip)
    @rows = []
    @reports = []
    @unsafe_reports = []
  end

  def solve_part_one
    parse_rows
    initialize_reports
    puts safe_reports_count
  end

  def initialize_reports
    @reports = rows.map do |row|
      Report.new(row)
    end
  end

  def safe_reports_count
    reports.count(&:safe?)
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

    def repairable?
      levels.each_index.any? do |index|
        new_report = levels.dup
        new_report.delete_at(index)
        Report.new(new_report).safe?
      end
    end
  end

  def parse_rows
    @rows = file_data.map do |line|
      line.split.map(&:to_i)
    end
  end

  def solve_part_two
    parse_rows
    initialize_reports
    find_unsafe_reports
    safe_reports_count + repairable_reports_count
  end

  def find_unsafe_reports
    @unsafe_reports = reports.reject(&:safe?)
  end

  def repairable_reports_count
    unsafe_reports.count(&:repairable?)
  end
end
