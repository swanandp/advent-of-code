# frozen_string_literal: true

def print_input(input, antinodes)
  input.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      if !(cell =~ /[a-z0-9]/i) && antinodes[[i, j]]
        print "#"
      else
        print cell
      end
    end

    puts ""
  end
end

input = DATA.read.strip.split("\n").map { |line| line.split("") }

r = input.length
c = input[0].length

frequencies = {}
indicators = /[a-z0-9]/i

input.each_with_index do |row, i|
  row.each_with_index do |cell, j|
    if cell =~ indicators
      frequencies[cell] ||= []
      frequencies[cell] << [i, j]
    end
  end
end

sum = 0
antinodes = {}

frequencies.each do |k, v|
  v.combination(2).each do |(node1, node2)|
    i1, j1 = node1
    i2, j2 = node2

    di = i1 - i2
    dj = j1 - j2

    antinode_possibilities = [
      [i1 - di, j1 - dj],
      [i1 + di, j1 + dj],
      [i2 - di, j2 - dj],
      [i2 + di, j2 + dj],
    ]

    orientation =
      if i1 == i2 # no duplicates, so automatically j1 != j2
        :same_row
      elsif j1 == j2 # no duplicates, so automatically i1 != i2
        :same_column
      elsif (i1 < i2 && j1 < j2) || (i1 > i2 && j1 > j2)
        :left
      elsif (i1 < i2 && j1 > j2) || (i1 > i2 && j1 < j2)
        :right
      else
        fail("Bad Data: #{[i1, j1, '', i2, j2]}")
      end

    # must be within the grid
    antinode_possibilities.select { |i, j|
      0 <= i && i < r && 0 <= j && j < c
    }.select { |i, j|
      case orientation
      when :same_row
        # compare j
        min_j, max_j = [j1, j2].sort

        if min_j - j == max_j - min_j || j - max_j == max_j - min_j
          antinodes[[i, j]] ||= []
          antinodes[[i, j]] << k
        end
      when :same_column
        # compare i
        min_i, max_i = [i1, i2].sort

        if min_i - i == max_i - min_i || i - max_i == max_i - min_i
          antinodes[[i, j]] ||= []
          antinodes[[i, j]] << k
        end
      when :left
        # assume they are consistent
        min_i, max_i = [i1, i2].sort
        min_j, max_j = [j1, j2].sort

        if (max_i - min_i == min_i - i && max_j - min_j == min_j - j) ||
          (max_i - min_i == i - max_i && max_j - min_j == j - max_j)

          antinodes[[i, j]] ||= []
          antinodes[[i, j]] << k
        end
      when :right
        # assume they are consistent
        min_i, max_i = [i1, i2].sort
        min_j, max_j = [j1, j2].sort

        if (max_i - min_i == min_i - i && max_j - min_j == j - max_j) ||
          (max_i - min_i == i - max_i && max_j - min_j == min_j - j)

          antinodes[[i, j]] ||= []
          antinodes[[i, j]] << k
        end
      else
        fail("Bad Data: #{['deltas: ', i, j, 'node1', i1, j1, 'node2', i2, j2]}")
      end
    }
  end
end

# pp antinodes
puts "Answer Part 1: #{antinodes.keys.count}"
# print_input(input, antinodes)

__END__
............
........0...
.....0......
.......0....
....0.......
......A.....
............
............
........A...
.........A..
............
............
