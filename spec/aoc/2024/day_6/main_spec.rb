# frozen_string_literal: true

require_relative '../../../../aoc/2024/day_6/main'

describe 'DaySix' do
  context 'Part I' do
    let(:day_six) { DaySix.new(input_file: 'input_file.txt') }

    # input:
    # ....#.....
    # .........#
    # ..........
    # ..#.......
    # .......#..
    # ..........
    # .#..^.....
    # ........#.
    # #.........
    # ......#...

    it 'parses the file data' do
      expect(day_six.file_data[0]).to eq('....#.....')
      expect(day_six.file_data[6]).to eq('.#..^.....')
    end

    it 'finds the max rows and columns' do
      expect(day_six.max_row).to eq(9)
      expect(day_six.max_column).to eq(9)
    end

    it 'checks if a given row and column number is out of boundary' do
      expect(day_six.out_of_boundaries?(0, 0)).to be_falsey
      expect(day_six.out_of_boundaries?(9, 9)).to be_falsey
      expect(day_six.out_of_boundaries?(10, 10)).to be_truthy
      expect(day_six.out_of_boundaries?(-1, -1)).to be_truthy
    end

    it 'finds the starting position' do
      expect(day_six.starting_position).to eq([6, 4])
    end

    it 'counts how many steps until out of boundaries' do
      expect(day_six.solve_part_one).to eq(41)
    end
  end

  context 'Part II' do
    let(:day_six) { DaySix.new(input_file: 'input_file.txt') }

    before do
      day_six.solve_part_one
    end

    it 'counts how many times the new obstacle causes an infinite loop' do
      expect(day_six.solve_part_two).to eq(6)
    end
  end
end
