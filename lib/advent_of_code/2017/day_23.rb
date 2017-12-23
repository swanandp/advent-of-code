require "scanf"

class Day23
  attr_accessor :instructions, :state, :output_part_1, :multiply_invoked, :pointer

  def initialize(instructions)
    self.instructions = instructions
    self.multiply_invoked = 0
    self.pointer = 0

    self.state = {
      registers: {
        'a' => 1,
      }, # instead of Hash.new, see def register below
      last_frequency: nil,
    }
  end

  def solve_part_1(num = 10000)
    pointer = self.pointer
    count = 0

    self.output_part_1 =
      while 0 <= pointer && pointer < instructions.length && count < num
        pointer = run_instruction(pointer, log = false)
        count += 1
      end
  end

  def solve_part_2
    
  end

  def run_instruction(pointer = self.pointer, log = true)
    instruction, args = instructions[pointer]
    result = self.send(instruction, *args)

    p [instruction, *args, result] if log

    case instruction
    when "jgz"
      pointer += result
    when "jnz"
      pointer += result
    else
      pointer += 1
    end

    self.pointer = pointer
  end

  def snd(x)
    self.state[:last_frequency] = value(x)
  end

  def set(x, y)
    write(x, value(y))
  end

  def add(x, y)
    write(x, value(x) + value(y))
  end

  def sub(x, y)
    write(x, value(x) - value(y))
  end

  def mul(x, y)
    self.multiply_invoked += 1
    write(x, value(x) * value(y))
  end

  def mod(x, y)
    unless value(y) == 0
      write(x, value(x) % value(y))
    end
  end

  def rcv(x)
    recover_last_frequency if value(x) != 0
  end

  def jgz(x, y)
    if value(x) > 0
      value(y)
    else
      1
    end
  end

  def jnz(x, y)
    if value(x) != 0
      value(y)
    else
      1
    end
  end

  def recover_last_frequency
    self.state[:last_frequency]
  end

  def value(r)
    if r.is_a?(String)
      register(r)
    else
      r
    end
  end

  def register(r)
    self.state[:registers][r] ||= 0
  end

  def write(r, value)
    register(r)
    self.state[:registers][r] = value
  end

  def self.from_file(file_path)
    instructions = []

    File.open(file_path, "r") do |f|
      while (line = f.gets)
        puts line.strip
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
    end

    new(instructions)
  end
end
