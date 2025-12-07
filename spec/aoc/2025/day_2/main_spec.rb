# frozen_string_literal: true

require_relative '../../../../aoc/2025/day_2/main'

describe 'DayTwo' do
  context 'Part I' do
    let(:day_two) { DayTwo.new }


    # input:
    # 11-22,95-115,998-1012,1188511880-1188511890,222220-222224,
    # 1698522-1698528,446443-446449,38593856-38593862,565653-565659,
    # 824824821-824824827,2121212118-2121212124

    it 'parses the ranges correctly' do
      expect(day_two.ranges).to eq([
                                     "11-22", "95-115", "998-1012", "1188511880-1188511890", "222220-222224",
                                     "1698522-1698528", "446443-446449", "38593856-38593862", "565653-565659",
                                     "824824821-824824827", "2121212118-2121212124"
                                   ])
    end

    it 'explodes the ranges into IDs' do
      expect(day_two.ids).to eq([
        (11..22).to_a,
        (95..115).to_a,
        (998..1012).to_a,
        (1188511880..1188511890).to_a,
        (222220..222224).to_a,
        (1698522..1698528).to_a,
        (446443..446449).to_a,
        (38593856..38593862).to_a,
        (565653..565659).to_a,
        (824824821..824824827).to_a,
        (2121212118..2121212124).to_a
      ].flatten)
    end

    it 'validates if an ID is valid or invalid with simple conditions' do
      expect(day_two.simple_valid_id?(95)).to be true
      expect(day_two.simple_valid_id?(100)).to be true
      expect(day_two.simple_valid_id?(110)).to be true
      expect(day_two.simple_valid_id?(1000)).to be true
      expect(day_two.simple_valid_id?(1698522)).to be true
      expect(day_two.simple_valid_id?(38593856)).to be true

      expect(day_two.simple_valid_id?(11)).to be false
      expect(day_two.simple_valid_id?(22)).to be false
      expect(day_two.simple_valid_id?(99)).to be false
      expect(day_two.simple_valid_id?(1010)).to be false
      expect(day_two.simple_valid_id?(1188511885)).to be false
      expect(day_two.simple_valid_id?(222222)).to be false
      expect(day_two.simple_valid_id?(446446)).to be false
      expect(day_two.simple_valid_id?(38593859)).to be false
    end

    it 'sums all the invalid IDs correctly' do
      expect(day_two.solve_part_one).to eq(1227775554)
    end

    it 'validates if an ID is valid or invalid with complex conditions' do
      expect(day_two.complex_valid_id?(95)).to be true
      expect(day_two.complex_valid_id?(100)).to be true

      expect(day_two.complex_valid_id?(11)).to be false
      expect(day_two.complex_valid_id?(22)).to be false
      expect(day_two.complex_valid_id?(99)).to be false
      expect(day_two.complex_valid_id?(999)).to be false
      expect(day_two.complex_valid_id?(1010)).to be false
      expect(day_two.complex_valid_id?(1188511885)).to be false
      expect(day_two.complex_valid_id?(222222)).to be false
      expect(day_two.complex_valid_id?(446446)).to be false
      expect(day_two.complex_valid_id?(38593859)).to be false
      expect(day_two.complex_valid_id?(565656)).to be false
      expect(day_two.complex_valid_id?(824824824)).to be false
      expect(day_two.complex_valid_id?(2121212121)).to be false
    end

    it 'sums all the invalid IDs correctly for complex validation' do
      expect(day_two.solve_part_two).to eq(4174379265)
    end
  end
end
