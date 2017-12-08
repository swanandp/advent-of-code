require "csv"

class Day2
  attr_accessor :input, :output_part_1, :output_part_2, :processed_input

  def initialize(spreadsheet)
    self.input = spreadsheet
    self.processed_input = CSV.parse(self.input, col_sep: " ", converters: :numeric)
    solve_part_1
    solve_part_2
  end

  def solve_part_1
    self.output_part_1 =
      processed_input.reduce(0) do |checksum, row|
        checksum += (row.max - row.min)

        checksum
      end
  end

  def solve_part_2
    self.output_part_2 =
      processed_input.reduce(0) do |checksum, row|
        sorted_row = row.sort

        numerator, denominator = sorted_row.each do |numerator|
          denominator = sorted_row.reverse.detect do |d|
            numerator % d == 0 && numerator / d != 1
          end

          next unless denominator
          break [numerator, denominator] if denominator
        end

        checksum += (numerator / denominator)
        checksum
      end
  end
end
