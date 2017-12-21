class Day17
  attr_accessor :buffer, :number_of_steps, :current_length,
                :iteration_count, :current_position, :output_part_1, :output_part_2

  def initialize(number_of_steps)
    self.number_of_steps = number_of_steps

    reset
  end

  def reset
    self.buffer = [0] # Initial state
    self.current_position = 0
    self.iteration_count = 2017
    self.current_length = 1
  end

  def solve_part_1
    reset
    iteration_count.times do
      spinlock
    end

    self.output_part_1 = buffer[(current_position + 1) % buffer.length]
  end

  def solve_part_2
    reset
    last_at_1 = nil

    50_000_000.times do
      self.current_position = (current_position + number_of_steps) % current_length + 1

      if current_position == 1
        last_at_1 = current_length
      end

      self.current_length += 1
    end

    self.output_part_2 = last_at_1
  end

  def spinlock
    self.current_position = (current_position + number_of_steps) % buffer.length + 1
    self.buffer.insert(current_position, buffer.length)
  end
end
