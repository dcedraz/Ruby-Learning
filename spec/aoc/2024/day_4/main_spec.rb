# frozen_string_literal: true

require_relative '../../../../aoc/2024/day_4/main'

describe 'DayFour' do
  context 'Part I' do
    let(:day_four) { DayFour.new(input_file: 'input_file.txt') }

    before do
      day_four.solve_part_one
    end

    # input:
    # MMMSXXMASM
    # MSAMXMSMSA
    # AMXSXMAAMM
    # MSAMASMSMX
    # XMASAMXAMM
    # XXAMMXXAMA
    # SMSMSASXSS
    # SAXAMASAAA
    # MAMMMXMMMM
    # MXMXAXMASX

    it 'finds the max rows and columns' do
      expect(day_four.max_row).to eq(9)
      expect(day_four.max_column).to eq(9)
    end

    it 'checks if a given row number is out of boundary' do
      expect(day_four.valid_row?(0)).to be_truthy
      expect(day_four.valid_row?(9)).to be_truthy
      expect(day_four.valid_row?(10)).to be_falsey
      expect(day_four.valid_row?(-1)).to be_falsey
    end

    it 'checks if a given column number is out of boundary' do
      expect(day_four.valid_column?(0)).to be_truthy
      expect(day_four.valid_column?(9)).to be_truthy
      expect(day_four.valid_column?(10)).to be_falsey
      expect(day_four.valid_column?(-1)).to be_falsey
    end

    it 'count XMAS occurences horizontally' do
      expect(day_four.count_xmas_horizontal(0, 0)).to eq(0)
      expect(day_four.count_xmas_horizontal(0, 5)).to eq(1)
      expect(day_four.count_xmas_horizontal(1, 4)).to eq(1)
      expect(day_four.count_xmas_horizontal(2, 0)).to eq(0)
    end

    it 'count XMAS occurences vertically' do
      expect(day_four.count_xmas_vertical(0, 0)).to eq(0)
      expect(day_four.count_xmas_vertical(9, 0)).to eq(0)
      expect(day_four.count_xmas_vertical(6, 0)).to eq(0)
      expect(day_four.count_xmas_vertical(4, 6)).to eq(1)
      expect(day_four.count_xmas_vertical(1, 4)).to eq(0)
      expect(day_four.count_xmas_vertical(3, 9)).to eq(1)
    end

    it 'count XMAS occurences diagonally' do
      expect(day_four.count_xmas_diagonal(0, 0)).to eq(0)
      expect(day_four.count_xmas_diagonal(0, 4)).to eq(1)
      expect(day_four.count_xmas_diagonal(1, 4)).to eq(0)
      expect(day_four.count_xmas_diagonal(5, 0)).to eq(1)
      expect(day_four.count_xmas_diagonal(9, 3)).to eq(2)
    end

    it 'counts the number of XMAS occurrences' do
      expect(day_four.xmas_count).to eq(18)
    end
  end

  context 'Part II' do
    let(:day_four) { DayFour.new(input_file: 'input_file.txt') }

    before do
      day_four.solve_part_two
    end

    it 'finds a character possible positions around from a pos in the matrix' do
      expect(day_four.find_char_positions_around(0, 0, 'X')).to be_empty
      expect(day_four.find_char_positions_around(0, 3, 'X')).to eq([[0, 4], [1, 4]])
      expect(day_four.find_char_positions_around(0, 9, 'X')).to be_empty
      expect(day_four.find_char_positions_around(1, 9, 'M')).to eq([[0, 9], [2, 8], [2, 9]])
    end

    it 'checks if an X-MAS exists for the giving A char position' do
      expect(day_four.x_mas_exists?(0, 0)).to be_falsey
      expect(day_four.x_mas_exists?(1, 1)).to be_falsey
      expect(day_four.x_mas_exists?(1, 2)).to be_truthy
      expect(day_four.x_mas_exists?(2, 6)).to be_truthy
      expect(day_four.x_mas_exists?(2, 7)).to be_truthy
    end

    it 'checks if the direction is diagonal' do
      expect(day_four.diagonal_direction?(0, 0, 1, 1)).to be_truthy
      expect(day_four.diagonal_direction?(1, 1, 0, 0)).to be_truthy
      expect(day_four.diagonal_direction?(2, 2, 1, 1)).to be_truthy
      expect(day_four.diagonal_direction?(3, 3, 4, 4)).to be_truthy
      expect(day_four.diagonal_direction?(0, 0, 0, 1)).to be_falsey
      expect(day_four.diagonal_direction?(0, 0, 1, 0)).to be_falsey
    end

    it 'counts the number of X-MAS occurrences' do
      expect(day_four.x_mas_count).to eq(9)
    end
  end
end
