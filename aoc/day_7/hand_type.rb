# frozen_string_literal: true

class HandType
  FIVE_OF_KIND_REGEX = /(\w)(?=\1\1\1\1)/.freeze
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
    if hand.match?(FIVE_OF_KIND_REGEX)
      FIVE_OF_KIND
    elsif hand.match?(FOUR_OF_KIND_REGEX)
      FOUR_OF_KIND
    elsif full_house?(hand)
      FULL_HOUSE
    elsif hand.match?(THREE_OF_KIND_REGEX)
      THREE_OF_KIND
    elsif two_pairs?(hand)
      TWO_PAIRS
    elsif hand.match?(ONE_PAIR_REGEX)
      ONE_PAIR
    else
      HIGH_CARD
    end
  end

  def two_pairs?(hand)
    return unless hand.match?(ONE_PAIR_REGEX)

    hand.gsub(hand.match(ONE_PAIR_REGEX)[0], '').match?(ONE_PAIR_REGEX)
  end

  def full_house?(hand)
    return unless hand.match?(THREE_OF_KIND_REGEX)

    hand.gsub(hand.match(THREE_OF_KIND_REGEX)[0], '').match?(ONE_PAIR_REGEX)
  end
end
