# frozen_string_literal: true

require 'pry'

class DayThree
  attr_reader :file_data, :muls, :muls_donts_and_dos, :enabled_muls

  MUL_REGEX = /mul\((\d+),(\d+)\)/
  MUL_DONT_DO_REGEX = /do\(\)|don't\(\)|mul\(\d+,\d+\)/

  def initialize(input_file: 'input_file.txt')
    @file_data = File.readlines(input_file).map(&:strip)
    @muls = []
    @muls_donts_and_dos = []
    @enabled_muls = []
  end

  def perform
    solve_part_one
    solve_part_two
  end

  def solve_part_one
    parse_muls
    puts calculate_muls
  end

  def parse_muls
    scan = file_data.flat_map do |line|
      line.scan(MUL_REGEX)
    end
    @muls = scan.map do |pair|
      pair.map(&:to_i)
    end
  end

  def calculate_muls
    muls.map do |pair|
      pair.reduce(:*)
    end.reduce(:+)
  end

  def solve_part_two
    parse_muls_donts_and_dos
    parse_enabled_muls
    puts calculate_enabled_muls
  end

  def parse_muls_donts_and_dos
    @muls_donts_and_dos = file_data.flat_map do |line|
      line.scan(MUL_DONT_DO_REGEX)
    end
  end

  def parse_enabled_muls
    mul_enabled = true

    muls_donts_and_dos.each do |mul|
      if mul == "don't()"
        mul_enabled = false
      elsif mul == "do()"
        mul_enabled = true
      elsif mul_enabled
        @enabled_muls << mul.scan(MUL_REGEX).flatten.map(&:to_i)
      end
    end
  end

  def calculate_enabled_muls
    enabled_muls.map do |pair|
      pair.reduce(:*)
    end.reduce(:+)
  end
end

DayThree.new.perform