# frozen_string_literal: true

require_relative '../../../../aoc/2025/day_4/main'

describe 'DayFour' do
  context 'Part I' do
    let(:day_four) { DayFour.new }

    # input:
    # ..@@.@@@@.
    # @@@.@.@.@@
    # @@@@@.@.@@
    # @.@@@@..@.
    # @@.@@@@.@@
    # .@@@@@@@.@
    # .@.@.@.@@@
    # @.@@@.@@@@
    # .@@@@@@@@.
    # @.@.@@@.@.

    # Expected:
    # ..xx.xx@x.
    # x@@.@.@.@@
    # @@@@@.x.@@
    # @.@@@@..@.
    # x@.@@@@.@x
    # .@@@@@@@.@
    # .@.@.@.@@@
    # x.@@@.@@@@
    # .@@@@@@@@.
    # x.x.@@@.x.

    it 'parses the grid correctly' do
      expect(day_four.grid).to eq([[".", ".", "@", "@", ".", "@", "@", "@", "@", "."],
                                   ["@", "@", "@", ".", "@", ".", "@", ".", "@", "@"],
                                   ["@", "@", "@", "@", "@", ".", "@", ".", "@", "@"],
                                   ["@", ".", "@", "@", "@", "@", ".", ".", "@", "."],
                                   ["@", "@", ".", "@", "@", "@", "@", ".", "@", "@"],
                                   [".", "@", "@", "@", "@", "@", "@", "@", ".", "@"],
                                   [".", "@", ".", "@", ".", "@", ".", "@", "@", "@"],
                                   ["@", ".", "@", "@", "@", ".", "@", "@", "@", "@"],
                                   [".", "@", "@", "@", "@", "@", "@", "@", "@", "."],
                                   ["@", ".", "@", ".", "@", "@", "@", ".", "@", "."]])
    end

    it 'parses the max rows and columns correctly' do
      expect(day_four.instance_variable_get(:@max_rows)).to eq(9)
      expect(day_four.instance_variable_get(:@max_columns)).to eq(9)
    end

    it 'checks if position is valid' do
      # Expected:
      # ..xx.xx@x.
      # x@@.@.@.@@
      # @@@@@.x.@@
      # @.@@@@..@.
      # x@.@@@@.@x
      # .@@@@@@@.@
      # .@.@.@.@@@
      # x.@@@.@@@@
      # .@@@@@@@@.
      # x.x.@@@.x.

      expect(day_four.send(:valid_pos?, 0, 0)).to be false
      expect(day_four.send(:valid_pos?, 0, 1)).to be false
      expect(day_four.send(:valid_pos?, 0, 2)).to be true
      expect(day_four.send(:valid_pos?, 0, 3)).to be true
      expect(day_four.send(:valid_pos?, 0, 4)).to be false
      expect(day_four.send(:valid_pos?, 0, 5)).to be true
      expect(day_four.send(:valid_pos?, 0, 6)).to be true
      expect(day_four.send(:valid_pos?, 1, 0)).to be true
      expect(day_four.send(:valid_pos?, 4, 0)).to be true
      expect(day_four.send(:valid_pos?, 7, 0)).to be true
      expect(day_four.send(:valid_pos?, 9, 0)).to be true
      expect(day_four.send(:valid_pos?, 9, 0)).to be true
      expect(day_four.send(:valid_pos?, 9, 2)).to be true
      expect(day_four.send(:valid_pos?, 9, 8)).to be true
    end

    it 'counts invalid positions correctly' do
      expect(day_four.solve_part_one).to eq(13)
    end
  end
end
