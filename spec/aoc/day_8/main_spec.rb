# frozen_string_literal: true

require_relative '../../../aoc/day_8/main'

describe 'DayEight' do
  let(:day_eight) { DayEight.new(input_file: '../../spec/aoc/day_8/input_file.txt') }

  it 'works for part 1' do
    expect(day_eight.solve_part_one).to eq(6)
  end

  it 'works for part 2' do
    # expect(day_eight.solve_part_two).to eq(5905)
  end
end
