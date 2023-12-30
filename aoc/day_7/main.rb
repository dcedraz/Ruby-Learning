# frozen_string_literal: true

require 'pry'

require_relative 'hand_type'

class DaySeven
  attr_reader :file_data

  LETTER_CARD_POWER = {
    'A' => 14,
    'K' => 13,
    'Q' => 12,
    'J' => 11,
    'T' => 10
  }.freeze

  def initialize(input_file: 'input_file.txt')
    @file_data = File.readlines(input_file).map(&:split)
  end

  def parsed_hands
    @parsed_hands ||= Array.new.tap do |parsed_hands|
      file_data.each do |hand_row|
        hand_type = HandType.new(hand_row[0], hand_row[1])
        parsed_hands << { hand: hand_type.hand, bid: hand_type.bid, type: hand_type.type, rank: 1 }
      end
    end
  end

  def solve_part_one
    ranked_hands = []
    HandType::HAND_TYPES.each do |type|
      hands_of_type = parsed_hands.select { |hand| hand[:type] == type }
      next if hands_of_type.empty?

      untie_sort(hands_of_type) while duplicates?(hands_of_type)
      hands_of_type.sort! { |a, b| a[:rank] <=> b[:rank] }
      ranked_hands << hands_of_type
    end

    result = 0
    ranked_hands.flatten.each.with_index { |hand, index| result += hand[:bid].to_i * (index + 1) }
    result

  end

  def duplicates?(array)
    all_types_array = array.map { |x| x[:rank] }
    !all_types_array.detect { |e| all_types_array.count(e) > 1 }.nil?
  end

  def untie_sort(array)
    array.sort! do |a, b|
      next if a.class != Hash || b.class != Hash

      untie_hands(a, b) if a[:rank] == b[:rank]
      a[:rank] <=> b[:rank]
    end
  end

  def untie_hands(hand_a, hand_b)
    hand_a[:hand].chars.each_with_index do |card_a, char_index|
      card_b = hand_b[:hand].chars[char_index]
      next if card_a == card_b

      if card_power(card_a) > card_power(card_b)
        hand_a[:rank] += 1
      else
        hand_b[:rank] += 1
      end
      break
    end
  end

  def card_power(card)
    if card.match?(/\d/)
      card.to_i
    else
      LETTER_CARD_POWER[card]
    end
  end

  def solve_part_two
  end

  def perform
    puts solve_part_one
    # solve_part_two
  end
end

DaySeven.new.perform
