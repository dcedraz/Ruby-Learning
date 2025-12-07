# frozen_string_literal: true

require_relative '../../../../aoc/2025/day_3/main'

describe 'DayThree' do
  context 'Part I' do
    let(:day_three) { DayThree.new }


    # input:
    # 987654321111111
    # 811111111111119
    # 234234234234278
    # 818181911112111

    it 'parses the banks correctly' do
      expect(day_three.banks).to eq([
        "987654321111111",
        "811111111111119",
        "234234234234278",
        "818181911112111"
      ])
    end

    it 'finds the largest possible joltage for a bank' do
      expect(day_three.max_joltage("987654321111111")).to eq(98)
      expect(day_three.max_joltage("811111111111119")).to eq(89)
      expect(day_three.max_joltage("234234234234278")).to eq(78)
      expect(day_three.max_joltage("818181911112111")).to eq(92)
    end

    it 'sums all the largest joltage values correctly' do
      expect(day_three.solve_part_one).to eq(357)
    end
  end
end
