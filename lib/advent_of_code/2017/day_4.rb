require "set"

class Day4
  attr_accessor :input, :output_part_1, :output_part_2, :processed_input, :step_size

  def initialize(phrases)
    self.input = phrases
    solve_part_1
  end

  def solve_part_1
    self.output_part_1 = input.select do |phrase|
      phrase.length == Set.new(phrase).length
    end.length
  end

  def self.from_file(file_path)
    new(CSV.parse(File.read(file_path), col_sep: " "))
  end
end
