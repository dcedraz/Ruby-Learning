# frozen_string_literal: true

require_relative '../../../../aoc/2024/day_8/main'

describe 'DayEight' do
  context 'Part I' do
    let(:day_eight) { DayEight.new(input_file: 'input_file.txt') }

    # input:
    # ............
    # ........0...
    # .....0......
    # .......0....
    # ....0.......
    # ......A.....
    # ............
    # ............
    # ........A...
    # .........A..
    # ............
    # ............

    # example
    # posA(1,8) + diffAB(-1,3) = node(0,11)
    # posB(2,5) + diffBA(1,-3) = node(3,2)

    # nodes positions
    # ......#....#
    # ...#....0...
    # ....#0....#.
    # ..#....0....
    # ....0....#..
    # .#....A.....
    # ...#........
    # #......#....
    # ........A...
    # .........A..
    # ..........#.
    # ..........#.

    it 'parses the file data' do
      expect(day_eight.file_data[0]).to eq('............')
      expect(day_eight.file_data[1]).to eq('........0...')
    end

    it 'finds the max rows and columns' do
      expect(day_eight.max_row).to eq(11)
      expect(day_eight.max_column).to eq(11)
    end

    it 'finds all frequencies positions' do
      day_eight.parse_frequencies
      expect(day_eight.frequency_hash).to eq(
        { '0' => [[1, 8], [2, 5], [3, 7], [4, 4]],
          'A' => [[5, 6], [8, 8], [9, 9]] }
      )
    end

    it 'finds all nodes positions' do
      day_eight.parse_frequencies
      day_eight.parse_nodes
      expect(day_eight.nodes).to match_array([
                                      [0, 6], [0, 11],
                                      [1, 3],
                                      [2, 4], [2, 10],
                                      [3, 2],
                                      [4, 9],
                                      [5, 1], [5, 6],
                                      [6, 3],
                                      [7, 0], [7, 7],
                                      [10, 10],
                                      [11, 10]
                                    ])
    end

    it "solves part one" do
      expect(day_eight.solve_part_one).to eq(14)
    end
  end

  context 'Part II' do
  end
end
