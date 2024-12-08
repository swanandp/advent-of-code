# frozen_string_literal: true

def shave_digits(l, r)
  l_chars = l.to_s.chars
  r_chars = r.to_s.chars

  return false unless l_chars.length > r_chars.length

  l_chars[0..(l_chars.length - r_chars.length - 1)].join.to_i
end

# 3267: 81 40 27
def reduce(sum, numbers)
  *head, tail = numbers

  if head.length == 1
    if (sum == head.first + tail) || (sum == head.first * tail)
      return sum
    else
      return false
    end
  end

  if (reduction = reduce(sum - tail, head)) && sum == reduction + tail
    sum
  elsif (reduction = reduce(sum / tail, head)) && sum == reduction * tail
    sum
  else
    false
  end
end

def reduce_part_2(sum, numbers)
  *head, tail = numbers

  if head.length == 1
    if (sum == head.first + tail) ||
      (sum == head.first * tail) ||
      (sum == "#{head.first}#{tail}".to_i)
      return sum
    else
      return false
    end
  end

  if (reduction = reduce_part_2(sum - tail, head)) && sum == reduction + tail
    sum
  elsif (reduction = reduce_part_2(sum / tail, head)) && sum == reduction * tail
    sum
  elsif (shave_digits = shave_digits(sum, tail)) &&
    (reduction = reduce_part_2(shave_digits, head)) &&
    sum == "#{reduction}#{tail}".to_i

    sum
  else
    false
  end
end

part_1_sum = 0
part_2_sum = 0

DATA.each_line do |line|
  answer, numbers = line.split(":").map { |n| n.strip.split(" ").map(&:to_i) }

  if reduce(answer.first, numbers)
    part_1_sum += answer.first
  end

  if reduce_part_2(answer.first, numbers)
    part_2_sum += answer.first
  end
end

puts "Part 1: #{part_1_sum}"
puts "Part 2: #{part_2_sum}"

__END__
190: 10 19
3267: 81 40 27
83: 17 5
156: 15 6
7290: 6 8 6 15
161011: 16 10 13
192: 17 8 14
21037: 9 7 18 13
292: 11 6 16 20
