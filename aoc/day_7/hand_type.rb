# frozen_string_literal: true

class HandType
  FIVE_OF_KIND_REGEX = /(\w)(?=\1\1\1\1)/.freeze # (\w)(J|\1){4}
  FOUR_OF_KIND_REGEX = /(\w)(?=.*\1.*\1.*\1.*)/.freeze
  THREE_OF_KIND_REGEX = /(\w)(?=.*\1.*\1.*)/.freeze
  ONE_PAIR_REGEX = /(\w)(?=.*\1.*)/.freeze

  FIVE_OF_KIND = 'five_of_kind'
  FOUR_OF_KIND = 'four_of_kind'
  FULL_HOUSE = 'full_house'
  THREE_OF_KIND = 'three_of_kind'
  TWO_PAIRS = 'two_pairs'
  ONE_PAIR = 'one_pair'
  HIGH_CARD = 'high_card'

  HAND_TYPES = [
    HIGH_CARD,
    ONE_PAIR,
    TWO_PAIRS,
    THREE_OF_KIND,
    FULL_HOUSE,
    FOUR_OF_KIND,
    FIVE_OF_KIND
  ].freeze

  attr_reader :hand, :bid, :type

  def initialize(hand, bid)
    @hand = hand
    @bid = bid
    @type = parse_type
  end

  def parse_type
    return FIVE_OF_KIND if hand.match?(FIVE_OF_KIND_REGEX)
    return FOUR_OF_KIND if hand.match?(FOUR_OF_KIND_REGEX)
    return FULL_HOUSE if full_house?(hand)
    return THREE_OF_KIND if hand.match?(THREE_OF_KIND_REGEX)
    return TWO_PAIRS if two_pairs?(hand)
    return ONE_PAIR if hand.match?(ONE_PAIR_REGEX)

    HIGH_CARD
  end

  def two_pairs?(hand)
    return unless hand.match?(ONE_PAIR_REGEX)

    hand.gsub(hand.match(ONE_PAIR_REGEX)[0], '').match?(ONE_PAIR_REGEX)
  end

  def full_house?(hand)
    return unless hand.match?(THREE_OF_KIND_REGEX)

    hand.gsub(hand.match(THREE_OF_KIND_REGEX)[0], '').match?(ONE_PAIR_REGEX)
  end

  def joker_type
    @joker_type ||= parse_type_with_joker
  end

  def parse_type_with_joker
    return FIVE_OF_KIND if five_of_kind?
    return FOUR_OF_KIND if four_of_kind?
    return FULL_HOUSE if joker_full_house?
    return THREE_OF_KIND if joker_three_of_kind?
    return TWO_PAIRS if joker_two_pairs?
    return ONE_PAIR if joker_one_pair?

    HIGH_CARD
  end

  def five_of_kind?
    return true if jokers == 5

    cards_count.reject { |k, _v| k == 'J' }.values.max + cards_count['J'] == 5
  end

  def four_of_kind?
    return true if jokers == 4

    cards_count.reject { |k, _v| k == 'J' }.values.max + cards_count['J'] == 4
  end

  def joker_full_house?
    return true if cards_count.value?(3) && cards_count.value?(2)
    return false unless jokers >= 1

    card_values = cards_count.reject { |k, _v| k == 'J' }.values
    max_card_count = card_values.max
    return false unless max_card_count >= 2

    min_card_count_with_joker = card_values.min + jokers

    min_card_count_with_joker == (max_card_count == 3 ? 2 : 3)
  end

  def joker_three_of_kind?
    return true if cards_count.any? { |_k, v| v == 3 }
    return false unless jokers >= 1

    cards_count.reject { |k, _v| k == 'J' }.values.max + jokers == 3
  end

  def joker_two_pairs?
    return true if cards_count.values.count(2) == 2
    return true if jokers >= 2
    return false unless jokers >= 1

    cards_count.reject { |k, _v| k == 'J' }.value?(2)
  end

  def joker_one_pair?
    cards_count.values.count(2) == 1 || jokers >= 1
  end

  def cards_count
    @cards_count ||= hand.scan(/\w/).each_with_object(Hash.new(0)) do |char, counts|
      counts[char] += 1
    end
  end

  def jokers
    cards_count['J']
  end
end
