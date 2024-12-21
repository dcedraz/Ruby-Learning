# frozen_string_literal: true

require_relative '../../../../aoc/2024/day_7/main'

describe 'DaySeven' do
  context 'Part I' do
    let(:day_seven) { DaySeven.new(input_file: 'input_file.txt') }

    # input:
    # 190: 10 19
    # 3267: 81 40 27
    # 83: 17 5
    # 156: 15 6
    # 7290: 6 8 6 15
    # 161011: 16 10 13
    # 192: 17 8 14
    # 21037: 9 7 18 13
    # 292: 11 6 16 20

    it 'parses the file data' do
      expect(day_seven.file_data[0]).to eq('190: 10 19')
      expect(day_seven.file_data[1]).to eq('3267: 81 40 27')
    end

    it 'parses the equations and numbers' do
      expect(day_seven.equations[0].test_value).to eq(190)
      expect(day_seven.equations[0].numbers).to eq([10, 19])
      expect(day_seven.equations[1].test_value).to eq(3267)
      expect(day_seven.equations[1].numbers).to eq([81, 40, 27])
    end

    it 'calculates the possibilities for a combination of numbers' do
      expect(day_seven.equations[0].possible_combinations).to eq(['10 + 19', '10 * 19'])
      expect(day_seven.equations[1].possible_combinations).to eq(['81 + 40 + 27', '81 + 40 * 27', '81 * 40 + 27', '81 * 40 * 27'])
      expect(day_seven.equations[2].possible_combinations).to eq(['17 + 5', '17 * 5'])
    end

    xit 'checks if an equation is valid' do
      expect(day_seven.equations[0].valid?).to be_truthy
      expect(day_seven.equations[1].valid?).to be_truthy
      expect(day_seven.equations[2].valid?).to be_falsey
      expect(day_seven.equations[8].valid?).to be_truthy
    end
  end

  context 'Part II' do
    let(:day_seven) { DaySeven.new(input_file: 'input_file.txt') }

  end
end
