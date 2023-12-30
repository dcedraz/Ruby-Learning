# frozen_string_literal: true

require_relative '../../../aoc/day_7/main'
require_relative '../../../aoc/day_7/hand_type'

describe 'HandType' do
  let(:five_of_kind_hand) { HandType.new('AAAAA', '0') }
  let(:four_of_kind_hand) { HandType.new('AJAAA', '0') }
  let(:full_house_hand) { HandType.new('A1A1A', '0') }
  let(:full_house_hand_two) { HandType.new('QQQAA', '0') }
  let(:three_of_kind_hand) { HandType.new('1A131', '0') }
  let(:two_pairs_hand) { HandType.new('32321', '0') }
  let(:one_pair_hand) { HandType.new('12344', '0') }
  let(:high_card_hand) { HandType.new('Q2J45', '0') }

  context 'parse all types' do
    it 'as expected' do
      expect(five_of_kind_hand.type).to eq(HandType::FIVE_OF_KIND)
      expect(four_of_kind_hand.type).to eq(HandType::FOUR_OF_KIND)
      expect(full_house_hand.type).to eq(HandType::FULL_HOUSE)
      expect(full_house_hand_two.type).to eq(HandType::FULL_HOUSE)
      expect(three_of_kind_hand.type).to eq(HandType::THREE_OF_KIND)
      expect(two_pairs_hand.type).to eq(HandType::TWO_PAIRS)
      expect(one_pair_hand.type).to eq(HandType::ONE_PAIR)
      expect(high_card_hand.type).to eq(HandType::HIGH_CARD)
    end
  end
end

describe 'DaySeven' do
  let(:day_seven) { DaySeven.new(input_file: '../../spec/aoc/day_7/input_file.txt') }

  context 'Part 1' do
    it 'works' do
      expect(day_seven.solve_part_one).to eq(6440)
    end
  end
end
