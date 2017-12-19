require "scanf"

class Day10
  attr_accessor :current_position, :skip_size, :lengths, :list,
                :input, :sparse_hash, :dense_hash, :output_part_1, :output_part_2

  def initialize(input_length, input)
    self.list = (0..(input_length || 255)).to_a #
    self.lengths = input.scanf("%c") { |(x, _)| x.ord } + [17, 31, 73, 47, 23]
    self.current_position = 0
    self.skip_size = 0

    solve_part_2
  end

  def solve_part_1
    lengths.each do |length|
      reverse_substring!(list, current_position, length)
      self.current_position = (self.current_position + length + skip_size) % list.length
      self.skip_size += 1
    end

    self.output_part_1 = list[0] * list[1]
  end

  def solve_part_2
    64.times do
      lengths.each do |length|
        reverse_substring!(list, current_position, length)
        self.current_position = (self.current_position + length + skip_size) % list.length
        self.skip_size += 1
      end
    end

    self.dense_hash = list.each_slice(16).map do |slice|
      slice.reduce(0) { |xor, num| xor ^ num }
    end

    self.output_part_2 = dense_hash.map do |num|
      num.to_s(16).rjust(2, "0")
    end.join
  end

  def reverse_substring!(list, from_position, substring_length)
    substring_length = [substring_length, list.length].min
    from_position = from_position % list.length

    min = from_position
    max = from_position + substring_length - 1
    mid = min + substring_length / 2 - 1

    (min..mid).each_with_index do |position, i|
      head_position = position % list.length
      tail_position = max % list.length - i

      temp = list[head_position]
      list[head_position] = list[tail_position]
      list[tail_position] = temp
    end

    list
  end
end
