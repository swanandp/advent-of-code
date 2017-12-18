class Day8
  attr_accessor :input, :parser, :parsed_input, :registers, :output_part_1, :output_part_2

  def initialize(input)
    self.input = input
    self.parsed_input = parse
    self.registers = {}
    solve_part_1
  end

  def solve_part_1
    max_ever = 0

    parsed_input.each do |instruction|
      if evaluate?(instruction)
        name = instruction[:write_register]
        r = register(name) # ensure value exists

        registers[name] =
          self.send(
            instruction[:operator],
            r,
            to_int(instruction[:change]),
          )

        if registers[name] > max_ever
          max_ever = registers[name]
        end
      end
    end

    self.output_part_1 = registers.values.max
    self.output_part_2 = max_ever
  end

  def inc(register, value)
    register + value
  end

  def dec(register, value)
    register - value
  end

  def evaluate?(instruction)
    register(instruction[:read_register])
      .send(
        instruction[:comparator],
        comparable(instruction[:comparable])
      )
  end

  def register(name)
    registers[name] ||= 0
    registers[name]
  end

  def matcher
    @matcher ||=
      %r{
        ^(?<write_register>[a-z]+)
        \s?(?<operator>[a-z]+)
        \s?(?<change>-?\d+)
        \s?if
        \s?(?<read_register>[a-z]+)
        \s?(?<comparator>\S+)
        \s?(?<comparable>-?\d+)
        \s?$
      }ix
  end

  def to_int(slice)
    slice.to_i
  end

  alias comparable to_int

  def parse
    input.map do |line|
      match = matcher.match(line)
      fail("Failed to match. Problematic regex.") unless match

      {
        write_register: match[:write_register],
        operator: match[:operator],
        change: match[:change],
        read_register: match[:read_register],
        comparator: match[:comparator],
        comparable: match[:comparable],
      }
    end
  end

  def self.from_file(file_path)
    new(File.readlines(file_path).map(&:strip))
  end
end
