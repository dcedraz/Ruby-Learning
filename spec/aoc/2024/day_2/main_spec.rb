# frozen_string_literal: true

require_relative '../../../../aoc/2024/day_2/main'

describe 'DayTwo' do
  context 'Part I' do
    let(:day_two) { DayTwo.new(input_file: 'input_file.txt') }

    before do
      day_two.perform
    end

    # input:
    # 7 6 4 2 1
    # 1 2 7 8 9
    # 9 7 6 2 1
    # 1 3 2 4 5
    # 8 6 4 4 1
    # 1 3 6 7 9

    it 'parses the rows' do
      expect(day_two.rows).to eq([[7, 6, 4, 2, 1], [1, 2, 7, 8, 9], [9, 7, 6, 2, 1], [1, 3, 2, 4, 5], [8, 6, 4, 4, 1],
                                  [1, 3, 6, 7, 9]])
    end

    context 'Reports class' do
      let(:report_one) { DayTwo::Report.new([7, 6, 4, 2, 1]) }

      it 'checks the levels are all increasing' do
        expect(report_one.increasing?).to be_falsey
      end

      it 'checks the levels are all decreasing' do
        expect(report_one.decreasing?).to be_truthy
      end

      it 'checks any two adjacent levels differ by at least one and at most three' do
        expect(report_one.adjacent_levels?).to be_truthy
      end

      it 'checks the report is safe' do
        expect(report_one.safe?).to be_truthy
      end

      let(:report_two) { DayTwo::Report.new([1, 3, 2, 4, 5]) }

      it 'checks the levels are all increasing' do
        expect(report_two.increasing?).to be_falsey
      end

      it 'checks the levels are all decreasing' do
        expect(report_two.decreasing?).to be_falsey
      end

      it 'checks any two adjacent levels differ by at least one and at most three' do
        expect(report_two.adjacent_levels?).to be_truthy
      end

      it 'checks the report is safe' do
        expect(report_two.safe?).to be_falsey
      end
    end

    it 'counts the number of safe reports' do
      expect(day_two.safe_reports).to eq(2)
    end
  end

  context 'Part II' do
    let(:day_two) { DayTwo.new(input_file: 'input_file.txt') }

    before do
      day_two.perform
    end
  end
end
