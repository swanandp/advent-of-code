require "scanf"

DO = "do()"
DONT = "don't()"
INSTRUCTION_PATTERN = "mul(%d,%d)"

def solve(input)
  input.scan(/mul\(\d+,\d+\)/).sum { |m| m.scanf(INSTRUCTION_PATTERN) { |(x, y)| x * y }.first }
end

def solve_part_two(input)
  enabled = true
  sum = 0

  input.scan(/(?<instruction>mul\(\d+,\d+\))|(?<modifier>(do\(\))|(don't\(\)))/).each do |(instruction, modifier)|
    if modifier == DONT
      enabled = false
    end

    if modifier == DO
      enabled = true
    end

    if enabled && instruction
      sum += instruction.scanf(INSTRUCTION_PATTERN) { |(x, y)| x * y }.first
    end
  end

  sum
end

input = DATA.read.strip

pp solve(input)
pp solve_part_two(input)

__END__
xmul(2,4)&mul[3,7]!^don't()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))
