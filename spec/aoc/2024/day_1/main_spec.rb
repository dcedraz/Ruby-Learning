# frozen_string_literal: true

require_relative '../../../../aoc/2024/day_1/main'

describe 'DayOne' do
  context 'Part I' do
    # let(:day_one) { DayOne.new(input_file: '../../../spec/aoc/2024/day_1/input_file.txt') }
    let(:day_one) { DayOne.new(input_file: 'input_file.txt') }

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

    it 'succeeds' do
      expect(day_one.solve_part_one).to eq(11)
    end
  end

  # context 'Part II' do
  #   let(:day_one) { DayOne.new(input_file: '../../spec/aoc/2024/day_1/input_file_two.txt') }
  #
  #   it 'works for part 2' do
  #     expect(day_one.solve_part_two).to eq(6)
  #   end
  # end
end
