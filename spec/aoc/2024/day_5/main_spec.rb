# frozen_string_literal: true

require_relative '../../../../aoc/2024/day_5/main'

describe 'DayFive' do
  context 'Part I' do
    let(:day_five) { DayFive.new(input_file: 'input_file.txt') }

    before do
      day_five.solve_part_one
    end

    # input:
    # 47|53
    # 97|13
    # 97|61
    # 97|47
    # 75|29
    # 61|13
    # 75|53
    # 29|13
    # 97|29
    # 53|29
    # 61|53
    # 97|53
    # 61|29
    # 47|13
    # 75|47
    # 97|75
    # 47|61
    # 75|61
    # 47|29
    # 75|13
    # 53|13
    #
    # 75,47,61,53,29
    # 97,61,53,29,13
    # 75,29,13
    # 75,97,47,61,53
    # 61,13,29
    # 97,13,75,29,47

    it 'parses the rules from the filedata' do
      expect(day_five.rules[0]).to eq([47, 53])
      expect(day_five.rules[1]).to eq([97, 13])
      expect(day_five.rules[2]).to eq([97, 61])
    end

    it 'parses the updates from the filedata' do
      expect(day_five.updates[0]).to eq([75, 47, 61, 53, 29])
      expect(day_five.updates[1]).to eq([97, 61, 53, 29, 13])
      expect(day_five.updates[2]).to eq([75, 29, 13])
    end

    it 'creates a hash of the rules on the right side' do
      expect(day_five.rules_right_hash[47]).to eq([53, 13, 61, 29])
      expect(day_five.rules_right_hash[97]).to eq([13, 61, 47, 29, 53, 75])
    end

    it 'creates a hash of the rules on the left side' do
      expect(day_five.rules_left_hash[47]).to eq([97, 75])
      expect(day_five.rules_left_hash[97]).to eq([])
      expect(day_five.rules_left_hash[75]).to eq([97])
    end

    it 'checks if a giving position on an update is valid for left rules' do
      expect(day_five.valid_left_rule?([75, 47, 61, 53, 29], 0)).to be_truthy
      expect(day_five.valid_left_rule?([75, 47, 61, 53, 29], 1)).to be_truthy
      expect(day_five.valid_left_rule?([75, 47, 61, 53, 29], 2)).to be_truthy
      expect(day_five.valid_left_rule?([75, 47, 61, 53, 29], 3)).to be_truthy
      expect(day_five.valid_left_rule?([75, 47, 61, 53, 29], 4)).to be_truthy
      expect(day_five.valid_left_rule?([61, 13, 29], 2)).to be_falsey
    end

    it 'checks if a giving position on an update is valid for right rules' do
      expect(day_five.valid_right_rule?([75, 47, 61, 53, 29], 0)).to be_truthy
      expect(day_five.valid_right_rule?([75, 47, 61, 53, 29], 1)).to be_truthy
      expect(day_five.valid_right_rule?([75, 47, 61, 53, 29], 2)).to be_truthy
      expect(day_five.valid_right_rule?([75, 47, 61, 53, 29], 3)).to be_truthy
      expect(day_five.valid_right_rule?([75, 47, 61, 53, 29], 4)).to be_truthy
      expect(day_five.valid_right_rule?([75, 97, 47, 61, 53], 0)).to be_falsey
      expect(day_five.valid_right_rule?([61, 13, 29], 1)).to be_falsey
    end

    it 'finds the middle number of an update' do
      expect(day_five.find_middle_number([75, 47, 61, 53, 29])).to eq(61)
      expect(day_five.find_middle_number([97, 61, 53, 29, 13])).to eq(53)
      expect(day_five.find_middle_number([75, 29, 13])).to eq(29)
      expect(day_five.find_middle_number([75, 97, 47, 61, 53])).to eq(47)
      expect(day_five.find_middle_number([61, 13, 29])).to eq(13)
      expect(day_five.find_middle_number([97, 13, 75, 29, 47])).to eq(75)
    end

    it 'checks if an update is valid' do
      expect(day_five.valid_update?([75, 47, 61, 53, 29])).to be_truthy
      expect(day_five.valid_update?([97, 61, 53, 29, 13])).to be_truthy
      expect(day_five.valid_update?([75, 29, 13])).to be_truthy
      expect(day_five.valid_update?([75, 97, 47, 61, 53])).to be_falsey
      expect(day_five.valid_update?([61, 13, 29])).to be_falsey
      expect(day_five.valid_update?([97, 13, 75, 29, 47])).to be_falsey
    end

    it 'sums up the middle number of valid updates' do
      expect(day_five.sum_middle_number_valid_updates).to eq(143)
    end
  end

  context 'Part II' do
    let(:day_five) { DayFive.new(input_file: 'input_file.txt') }

    before do
      day_five.perform
    end

    it 'fixes an invalid update' do
      expect(day_five.sort_by_rules([75, 97, 47, 61, 53])).to eq([97, 75, 47, 61, 53])
      expect(day_five.sort_by_rules([61, 13, 29])).to eq([61, 29, 13])
      expect(day_five.sort_by_rules([97, 13, 75, 29, 47])).to eq([97, 75, 47, 29, 13])
    end

    it 'sums up the middle number of invalid updates' do
      expect(day_five.sum_middle_number_invalid_updates).to eq(123)
    end
  end
end
