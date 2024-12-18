require "scanf"

class Day18
  attr_accessor :instructions, :registers, :pointer, :output_part_1,
                :listener, :receive_queue, :output_part_2, :waiting,
                :terminated, :pid

  def initialize(pid, instructions, listener, receive_queue)
    self.pid = pid
    self.instructions = instructions
    self.listener = listener
    self.receive_queue = receive_queue
    self.pointer = 0
    self.waiting = false
    self.terminated = false

    self.registers = {
      "p" => pid,
    }
  end

  def self.solve_part_2(input)
    instructions = parse_file(input)
    Solver.new(instructions)
  end

  class Solver
    attr_accessor :p0, :p1, :instructions, :queues, :output_part_2, :counts

    def initialize(instructions)
      self.instructions = instructions
      self.queues = [[], []]
      self.counts = [0, 0]

      self.p0 = Day18.new(0, instructions.clone, self, self.queues[0])
      self.p1 = Day18.new(1, instructions.clone, self, self.queues[1])
    end

    def send_message(pid, message)
      if pid == 1
        queues[0] << message
        # pid-0 has received a message
        p0.waiting = false
      end

      if pid == 0
        queues[1] << message
        # pid-1 has received a message
        p1.waiting = false
      end

      self.counts[pid] += 1
    end

    def solve
      until (p0.waiting && p1.waiting) || (p0.terminated && p1.terminated)
        # in case a new message arrived
        # this will change the waiting state
        p0.run
        p1.run

        until p0.waiting || p0.terminated
          p0.run
        end

        # in case a new message arrived
        # this will change the waiting state
        p0.run
        p1.run

        until p1.waiting || p1.terminated
          p1.run
        end
      end

      self.output_part_2 = counts[1]
    end
  end

  def run
    return if terminated
    instruction, args = instructions[pointer]
    result = self.send(instruction, *args)

    case instruction
    when "rcv"
      self.pointer += 1 unless waiting
    when "jgz"
      self.pointer += result
    else
      self.pointer += 1
    end

    if pointer < 0 && instructions.length <= pointer
      self.terminated = true
    end

    pointer
  end

  def snd(x)
    listener.send_message(pid, value(x))
  end

  def rcv(x)
    if (received = receive_queue.shift)
      write(x, received)
      self.waiting = false
    else
      self.waiting = true
    end
  end

  def set(x, y)
    write(x, value(y))
  end

  def add(x, y)
    write(x, value(x) + value(y))
  end

  def mul(x, y)
    write(x, value(x) * value(y))
  end

  def mod(x, y)
    unless value(y) == 0
      write(x, value(x) % value(y))
    end
  end

  def jgz(x, y)
    if value(x) > 0
      value(y)
    else
      1
    end
  end

  def value(r)
    if r.is_a?(String)
      register(r)
    else
      r
    end
  end

  # this allows us to keep track of how many registers have been initialised
  def register(r)
    self.registers[r] ||= 0
  end

  def write(r, value)
    register(r)
    self.registers[r] = value
  end

  def self.parse_file(input)
    instructions = []

    input.split("\n").each do |line|
      match = line.strip.match(
        %r{
          ^(?<instruction>[a-z]{3})\s
           ((?<first_num_arg>-?[0-9]+)|(?<first_reg_arg>[a-z]))?\s?
           ((?<second_num_arg>-?[0-9]+)|(?<second_reg_arg>[a-z]))?$
          }ix
      )

      first_arg =
        if match[:first_num_arg]
          match[:first_num_arg].to_i
        elsif match[:first_reg_arg]
          match[:first_reg_arg]
        end

      second_arg =
        if match[:second_num_arg]
          match[:second_num_arg].to_i
        elsif match[:second_reg_arg]
          match[:second_reg_arg]
        end

      args = [first_arg, second_arg].compact

      instructions << [match[:instruction], args]
    end

    instructions
  end
end

def sample_input
  <<~INPUT
    snd 1
    snd 2
    snd p
    rcv a
    rcv b
    rcv c
    rcv d
  INPUT
end

solver = Day18.solve_part_2(sample_input)
solver.solve
pp solver.output_part_2

__END__
set i 31
set a 1
mul p 17
jgz p p
mul a 2
add i -1
jgz i -2
add a -1
set i 127
set p 680
mul p 8505
mod p a
mul p 129749
add p 12345
mod p a
set b p
mod b 10000
snd b
add i -1
jgz i -9
jgz a 3
rcv b
jgz b -1
set f 0
set i 126
rcv a
rcv b
set p a
mul p -1
add p b
jgz p 4
snd a
set a b
jgz 1 3
snd b
set f 1
add i -1
jgz i -11
snd a
jgz f -16
jgz a -19
