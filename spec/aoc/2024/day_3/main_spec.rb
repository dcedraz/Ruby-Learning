# frozen_string_literal: true

require_relative '../../../../aoc/2024/day_3/main'

describe 'DayThree' do
  context 'Part I' do
    let(:day_three) { DayThree.new(input_file: 'input_file.txt') }

    before do
      day_three.solve_part_one
    end

    # input:
    # xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))

    it 'finds all the muls' do
      expect(day_three.muls).to eq([[2, 4], [5, 5], [11, 8], [8, 5]])
    end

    it 'multiplies all mul pairs and returns the sum' do
      expect(day_three.solve_part_one).to eq(161)
    end
  end

  context 'Part II' do
    let(:day_three) { DayThree.new(input_file: 'input_file_part_two.txt') }

    before do
      day_three.solve_part_two
    end

    # input:
    # xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))

    it "finds all the muls including don't() and do()" do
      expect(day_three.muls_donts_and_dos).to eq(["mul(2,4)", "don't()", "mul(5,5)", "mul(11,8)", "do()", "mul(8,5)"])
    end

    it 'finds all the enabled muls' do
      expect(day_three.enabled_muls).to eq([[2, 4], [8, 5]])
    end

    it 'multiplies all mul pairs and returns the sum' do
      expect(day_three.calculate_enabled_muls).to eq(48)
    end
  end
end
