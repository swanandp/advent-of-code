class Day5
  attr_accessor :instructions, :original_instructions, :output_part_1, :output_part_2, :processed_input, :step_size

  def initialize(instructions)
    self.original_instructions = instructions.freeze
    self.instructions = instructions.dup # clone not needed
    solve_part_1
    solve_part_2
  end

  def solve_part_1
    position = 0
    steps = 0

    while 0 <= position && position < original_instructions.length
      n = instructions[position]
      instructions[position] += 1
      position += n
      steps += 1
    end

    self.output_part_1 = steps
  end

  def solve_part_2
    self.instructions = original_instructions.dup
    position = 0
    steps = 0

    while 0 <= position && position < original_instructions.length
      n = instructions[position]

      if n >= 3
        instructions[position] -= 1
      else
        instructions[position] += 1
      end

      position += n
      steps += 1
    end

    self.output_part_2 = steps
  end

  def self.from_file(file_path)
    new(CSV.parse(File.read(file_path), converters: :numeric).map(&:first))
  end
end
