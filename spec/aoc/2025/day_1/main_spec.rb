# frozen_string_literal: true

require_relative '../../../../aoc/2025/day_1/main'

describe 'DayOne' do
  context 'Part I' do
    let(:day_one) { DayOne.new }

    # input:
    # L68
    # L30
    # R48
    # L5
    # R60
    # L55
    # L1
    # L99
    # R14
    # L82

    it 'parses the rows correctly' do
      expect(day_one.rows).to eq(["L68", "L30", "R48", "L5", "R60", "L55", "L1", "L99", "R14", "L82"])
    end

    it 'starts at the initial pointer position' do
      expect(day_one.position).to eq(DayOne::INITIAL_POINTER_POSITION)
    end

    it 'decreases the pointer position for left instructions' do
      day_one.position = 50
      day_one.calc_new_position("L10")
      expect(day_one.position).to eq(40)
    end

    it 'increases the pointer position for right instructions' do
      day_one.position = 50
      day_one.calc_new_position("R20")
      expect(day_one.position).to eq(70)
    end

    context "when the pointer goes below 0" do
      it 'wraps around to the end of the range' do
        day_one.position = 5
        day_one.calc_new_position("L10")
        expect(day_one.position).to eq(95)
      end
    end

    context "when the pointer goes above 99" do
      it 'wraps around to the start of the range' do
        day_one.position = 95
        day_one.calc_new_position("R10")
        expect(day_one.position).to eq(5)
      end
    end

    it 'counts zero occurrences correctly' do
      day_one.position = 5
      day_one.calc_new_position("L5") # goes to 0, counts as a zero crossing
      expect(day_one.count_zero_occurrences).to eq(1)
      day_one.calc_new_position("L10")
      day_one.calc_new_position("R10")
      expect(day_one.count_zero_occurrences).to eq(2)
    end

    it 'solves part one correctly' do
      day_one.solve_part_one
      expect(day_one.count_zero_occurrences).to eq(3)
    end

    it 'solves part two correctly' do
      expect(day_one.solve_part_two).to eq(6)
    end
  end
end
