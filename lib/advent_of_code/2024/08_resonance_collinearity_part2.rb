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
antinodes = {}

input.each_with_index do |row, i|
  row.each_with_index do |cell, j|
    if cell =~ indicators
      frequencies[cell] ||= []
      frequencies[cell] << [i, j]
      antinodes[[i, j]] ||= []
      antinodes[[i, j]] << "X"
    end
  end
end


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
        j_delta = max_j - min_j

        if min_j - j == j_delta || j - max_j == j_delta
          antinodes[[i, j]] ||= []
          antinodes[[i, j]] << k

          # new antinodes left of min_j
          if j < min_j
            j_new = j - j_delta

            while 0 <= j_new && j_new < c
              antinodes[[i, j_new]] ||= []
              antinodes[[i, j_new]] << k

              j_new -= j_delta
            end
          end

          # new antinodes right of max_j
          if max_j < j
            ((j + j_delta)..c).step(j_delta).each { |jx|
              antinodes[[i, jx]] << k
            }
          end
        end
      when :same_column
        # compare i
        min_i, max_i = [i1, i2].sort
        i_delta = max_i - min_i

        if min_i - i == i_delta || i - max_i == i_delta
          antinodes[[i, j]] ||= []
          antinodes[[i, j]] << k

          # new antinodes above/north of min_i
          if i < min_i
            i_new = i - i_delta

            while 0 <= i_new && i_new < r
              antinodes[[i_new, j]] ||= []
              antinodes[[i_new, j]] << k

              i_new -= i_delta
            end
          end

          # new antinodes below/south of max_i
          if max_i < i
            ((i + i_delta)..r).step(i_delta).each { |ix|
              antinodes[[ix, j]] ||= []
              antinodes[[ix, j]] << k
            }
          end
        end
      when :left
        # assume they are consistent
        min_i, max_i = [i1, i2].sort
        min_j, max_j = [j1, j2].sort
        i_delta = max_i - min_i
        j_delta = max_j - min_j

        if (i_delta == min_i - i && j_delta == min_j - j) ||
          (i_delta == i - max_i && j_delta == j - max_j)

          antinodes[[i, j]] ||= []
          antinodes[[i, j]] << k

          # new antinodes all the way to [0,0]
          if i < min_i # then j will also be < min_j
            i_new = i - i_delta
            j_new = j - j_delta

            while 0 <= i_new && i_new < r && 0 <= j_new && j_new < c
              antinodes[[i_new, j_new]] ||= []
              antinodes[[i_new, j_new]] << k

              i_new -= i_delta
              j_new -= j_delta
            end
          end

          # new antinodes all the way to [r, c]
          if max_i < i # then max_j will also be < j
            i_enum = ((i + i_delta)..r).step(i_delta)
            j_enum = ((j + j_delta)..c).step(j_delta)

            i_enum.zip(j_enum).each do |ix, jx|
              if ix && jx && 0 <= ix && ix < r && 0 <= jx && jx < c
                antinodes[[ix, jx]] ||= []
                antinodes[[ix, jx]] << k
              end
            end
          end
        end
      when :right
        # assume they are consistent
        min_i, max_i = [i1, i2].sort
        min_j, max_j = [j1, j2].sort
        i_delta = max_i - min_i
        j_delta = max_j - min_j

        if (i_delta == min_i - i && j_delta == j - max_j) ||
          (i_delta == i - max_i && j_delta == min_j - j)

          antinodes[[i, j]] ||= []
          antinodes[[i, j]] << k

          # new antinodes all the way to [0,c]
          if i < min_i # then j will be > max_j
            i_new = i - i_delta
            j_new = j + j_delta

            while 0 <= i_new && i_new < r && 0 <= j_new && j_new < c
              antinodes[[i_new, j_new]] ||= []
              antinodes[[i_new, j_new]] << k

              i_new -= i_delta
              j_new += j_delta
            end
          end

          # new antinodes all the way to [r,0]
          if max_i < i # then j will < min_j
            i_new = i + i_delta
            j_new = j - j_delta

            while 0 <= i_new && i_new < r && 0 <= j_new && j_new < c
              antinodes[[i_new, j_new]] ||= []
              antinodes[[i_new, j_new]] << k

              i_new += i_delta
              j_new -= j_delta
            end
          end
        end
      else
        fail("Bad Data: #{['deltas: ', i, j, 'node1', i1, j1, 'node2', i2, j2]}")
      end
    }
  end
end

# pp antinodes
puts "Answer Part 2: #{antinodes.keys.count}"
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
