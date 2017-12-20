class Day14
  attr_accessor :input, :output_part_1

  def initialize(input)
    self.input = input

    solve_part_1
  end

  def solve_part_1
    self.output_part_1 =
      (0..127).map do |i|
        day10 = Day10.new(255, "#{input}-#{i}")
        day10.output_part_2.each_char.map { |c| c.to_i(16).to_s(2).rjust(4, '0') }.join
      end.join.count("1")
  end
end
