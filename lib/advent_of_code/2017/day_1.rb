class Day1 < AdventDay
  attr_accessor :step_size

  def initialize(numeric_string)
    self.input = numeric_string
    solve_part_1
    solve_part_2
  end

  def solve_part_1
    step_size = 1
    self.processed_input = process_input(step_size)
    self.output_part_1 = solve(step_size)
  end

  def solve_part_2
    step_size = input.length / 2
    self.processed_input = process_input(step_size)
    self.output_part_2 = solve(step_size)
  end

  def process_input(step_size)
    (input + input[0..(step_size - 1)]).split(//)
  end


  def solve(step_size)
    processed_input.each_cons(step_size + 1).reduce(0) do |sum, sub_str|
      if sub_str[0] == sub_str[-1]
        sum += sub_str[0].to_i
      end

      sum
    end
  end
end
