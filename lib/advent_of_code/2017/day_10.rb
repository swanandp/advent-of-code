class Day10
  attr_accessor :current_position, :skip_size, :lengths, :list

  def initialize(input_length, rotation_lengths)
    self.list = (0..(input_length || 255)).to_a #
    self.lengths = rotation_lengths
    self.current_position = 0
    self.skip_size = 0

    solve_part_1
  end

  def solve_part_1
    lengths.each do |length|
      reverse_substring!(list, current_position, length)
      self.current_position = (self.current_position + length + skip_size) % list.length
      self.skip_size += 1
    end
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
