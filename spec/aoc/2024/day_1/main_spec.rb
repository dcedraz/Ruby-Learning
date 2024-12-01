# frozen_string_literal: true

require_relative '../../../../aoc/2024/day_1/main'

describe 'DayOne' do
  context 'Part I' do
    # let(:day_one) { DayOne.new(input_file: '../../../spec/aoc/2024/day_1/input_file.txt') }
    let(:day_one) { DayOne.new(input_file: 'input_file.txt') }

    before do
      day_one.perform
    end

    # input:
    # 3   4
    # 4   3
    # 2   5
    # 1   3
    # 3   9
    # 3   3

    it 'parses the left instructions from the smallest to the largest' do
      expect(day_one.left_instructions).to eq([1, 2, 3, 3, 3, 4])
    end

    it 'parses the right instructions from the smallest to the largest' do
      expect(day_one.right_instructions).to eq([3, 3, 3, 4, 5, 9])
    end

    it 'finds the difference between the left and right instructions' do
      expect(day_one.instructions_difference).to eq([2, 1, 0, 1, 2, 5])
    end

    it 'succeeds by summarizing the differences' do
      expect(day_one.result_part_one).to eq(11)
    end
  end

  context 'Part II' do
    # let(:day_one) { DayOne.new(input_file: '../../spec/aoc/2024/day_1/input_file_two.txt') }
    let(:day_one) { DayOne.new(input_file: 'input_file.txt') }

    before do
      day_one.perform
    end

    # input:
    # 3   4
    # 4   3
    # 2   5
    # 1   3
    # 3   9
    # 3   3

    it 'finds how many times the left instructions appears in the right instructions' do
      expect(day_one.left_on_right_appearances).to eq([0, 0, 3, 3, 3, 1])
    end

    it 'multiples the left instructions by the number of appearances' do
      expect(day_one.similarities).to eq([0, 0, 9, 9, 9, 4])
    end

    it 'succeeds by multiplying the left instructions by the number of appearances' do
      expect(day_one.result_part_two).to eq(31)
    end
  end
end
