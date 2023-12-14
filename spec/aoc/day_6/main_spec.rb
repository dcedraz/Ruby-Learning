# frozen_string_literal: true

require_relative '../../../aoc/day_6/main'

describe 'DaySix' do
  let(:day_six) { DaySix.new }

  before do
    allow(File).to receive(:readlines).and_return(
      ["Time:        7     15     30     \n", "Distance:   9   40   200   "]
    )
  end

  context 'Part 1' do
    context 'win_race? method' do
      it 'returns valid results' do
        expect(day_six.win_race?(0, 7, 9)).to eq(false)
        expect(day_six.win_race?(1, 7, 9)).to eq(false)
        expect(day_six.win_race?(2, 7, 9)).to eq(true)
        expect(day_six.win_race?(3, 7, 9)).to eq(true)
        expect(day_six.win_race?(4, 7, 9)).to eq(true)
        expect(day_six.win_race?(5, 7, 9)).to eq(true)
        expect(day_six.win_race?(6, 7, 9)).to eq(false)
        expect(day_six.win_race?(7, 7, 9)).to eq(false)
      end
    end

    context 'solve part 1' do
      it 'returns valid results' do
        expect(day_six.solve_part_one).to eq(288)
      end
    end
  end

  context 'Part 2' do
    it 'returns valid results' do
      expect(day_six.solve_part_two).to eq(71503)
    end
  end
end
