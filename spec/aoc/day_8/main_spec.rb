# frozen_string_literal: true

require_relative '../../../aoc/day_8/main'

describe 'DayEight' do
  context 'Part I' do
    let(:day_eight) { DayEight.new(input_file: '../../spec/aoc/day_8/input_file.txt') }

    it 'succeeds' do
      expect(day_eight.solve_part_one).to eq(6)
    end
  end

  context 'Part II' do
    let(:day_eight) { DayEight.new(input_file: '../../spec/aoc/day_8/input_file_two.txt') }

    it 'works for part 2' do
      expect(day_eight.solve_part_two).to eq(6)
    end
  end
end
