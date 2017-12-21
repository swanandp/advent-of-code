class Day17
  attr_accessor :buffer, :number_of_steps, :value,
                :iteration_count, :current_position, :output_part_1

  def initialize(number_of_steps)
    self.number_of_steps = number_of_steps

    self.buffer = [0] # Initial state
    self.current_position = 0
    self.value = 0
    self.iteration_count = 2017
  end

  def solve_part_1
    iteration_count.times do
      spinlock
    end

    self.output_part_1 = buffer[(current_position + 1) % buffer.length]
  end

  def spinlock
    self.current_position = (current_position + number_of_steps) % buffer.length + 1
    self.value += 1
    self.buffer.insert(current_position, value)
  end

  def step_forward
  end
end
