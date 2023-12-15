def sample_input
  <<~INPUT
    O....#....
    O.OO#....#
    .....##...
    OO.#O....O
    .O.....O#.
    O.#..O.#.#
    ..O..#O..O
    .......O..
    #....###..
    #OO..#....
  INPUT
end

def print_matrix(matrix)
  puts matrix.map { |l| l.join }.join("\n")
end

def tilt_north(matrix)
  matrix.length.times do |j|
    dots = 0

    matrix.first.length.times do |i|
      case matrix[i][j]
      when "O"
        matrix[i][j] = "."
        matrix[i - dots][j] = "O"
      when "."
        dots += 1
      when "#"
        dots = 0
      else
        raise "Unhandled Input: #{matrix[i][j]} at [#{i},#{j}]"
      end
    end
  end
end

def tilt_west(matrix)
  matrix.length.times do |i|
    dots = 0

    matrix.first.length.times do |j|
      case matrix[i][j]
      when "O"
        matrix[i][j] = "."
        matrix[i][j - dots] = "O"
      when "."
        dots += 1
      when "#"
        dots = 0
      else
        raise "Unhandled Input: #{matrix[i][j]} at [#{i},#{j}]"
      end
    end
  end
end

def tilt_south(matrix)
  matrix.length.times do |j|
    dots = 0

    matrix.first.length.times do |i|
      case matrix[matrix.length - i - 1][j]
      when "O"
        matrix[matrix.length - i - 1][j] = "."
        matrix[matrix.length - i - 1 + dots][j] = "O"
      when "."
        dots += 1
      when "#"
        dots = 0
      else
        raise "Unhandled Input: #{matrix[i][j]} at [#{i},#{j}]"
      end
    end
  end
end

def tilt_east(matrix)
  matrix.length.times do |i|
    dots = 0

    matrix.first.length.times do |j|
      case matrix[i][matrix.length - j - 1]
      when "O"
        matrix[i][matrix.length - j - 1] = "."
        matrix[i][matrix.length - j - 1 + dots] = "O"
      when "."
        dots += 1
      when "#"
        dots = 0
      else
        raise "Unhandled Input: #{matrix[i][j]} at [#{i},#{j}]"
      end
    end
  end
end

def matrix_load(matrix)
  load = 0

  matrix.map.with_index { |r, i| r.count { |c| c == "O" } * (10 - i) }.sum

  matrix.length.times do |i|
    matrix.first.length.times do |j|
      if matrix[i][j] == "O"
        load += (matrix.length - i)
      end
    end
  end

  load
end

def total_load(input)
  matrix = input.split("\n").map { |l| l.split("") }
  tilt_cycle = %w[north west south east].cycle

  1000.times.map do
    tilt_cycle.take(4).each do |dir|
      send("tilt_#{dir}".to_sym, matrix)
    end
    matrix.map.with_index { |r, i| r.count { |c| c == "O" } * (matrix.length - i) }.sum
  end
end

pp total_load(sample_input)
pp total_load(DATA.read)


__END__
...##OOOO...#..#.OO..#O........O.O.#..O........#...O#.O..#O.............O....#....O.O#.#.O......OO.O
O.......#..O.O.....O..O.OO.O#O..#.#.OO.OO.O.O.....O.#..O....O...O.......O..O#O.O.O.........O#OOO..OO
..O.OO..#...O#O.....O...##O.O..#...O##OO..#.O..#O#O...#.O.OO..#..#.#...........O..###...OOO##......O
O####O#....O.O##OO.O...#O...O.O...O#...O...#..#....#...OO.#.#.O#O..O..#O...#...#.....#.O#.O...##....
#O..O..O..#.###.....O.#....O#...#..##..OO....OO.#.#O#O...O#..#........O.O....#...OO..O......#.......
O.O....O.#.......#.....O...........O..#.....#.O.....#...O.......O#.#.......O..#.........#......OO.O.
.O..#.......O.............#..O...##.OO##..O...#.....OO.O.#.....#.O..O..........#O#..##.#.#O#.O....#.
......O..O#O.##.O...#.##..OO....O#..#.O.##.OO...#..#.....O...#..OO.....OO.O......####..O.......O.#.O
...O.OO.....OO.#OO..#.....#......O.#....#.#...O....#.O#....O...O..#...##...O.#...#.O.....O#O...O....
OO#.O..O...O.#......#.....O#.O..O.OO....#......#...O#...#.#..O..O...#.#.O#...OO#....OO#O.......#....
O.....OO..#.#..#..O.#...........O.O..##.#.O.#.O.O.OO.O...O.O.O.OO##..O.......##.OO....O....OO....#OO
O..O#.O#.....####.#....#.##.OO..O...OO##....#.....#O.#O..#.O....#.O.#.O..O...##...O.......O.O..OO.#.
...O.#..O.O.....#..O##.....#OO.O............O......O.#..#.OO#....O.O..O........#.#.#O...O....#..OO#O
##.#.O##..#.##O....OOOO...#........#..O..OOO....O...O...O..O...O.O..OOO...##...O#O.O.OO.OOOOO#.#..##
...#..O.O##.O.#O.#..O#.#..O#..#...OO#...OOO.........O.O..O.#..O.....O.#........O....#...O....#..OO.#
.......#.#...#OO.O#..OO..OO.##.#O.OO.OO.OO.#....O..#O...#.O..O..O#.O.O.O.O...O#......O..O#....#...#.
....O....O#....OOO.....OO.#O......#.OO..O.#OO........O..O.O..O....OO...##..OO#.......#..OO.#O.O.##.O
OO.#...O.OO.#O#....##O#O.#....#.O.#.O.#.OO.....#...#.###.#.O..OO.O.O.OO.#.O#O...O.O#..OO...#O...OOO.
.......#....OO#..##O.#..O.O.O..#.#.#..OO.#..#.................O....OO##.##O..OO.O..#O.#.#..#.....O#O
..OO...O.O....O.O....O.O....#O.O....OO.........#..........#...#..OO...OO.......#.O...##.#.O.O##...OO
.OO.O#O.#....OOO..O.O.#..#O...O.O#.#O.O.##..##....#..OO.....#....#OO#.##........OOO.OO#O......#..O.#
...##.....#.........#.##..O.....#.O.#O.##..#..##O.OO#.....O#.......O.O..O#..O..#.....#....O.........
O....O....O.#...#...#OO#.O....#O##......O..#O..#..#..O#...O..O..#...OOOO#.OO..............O#....#.OO
.O.O..OO.##...OOO...O..OO.O....#.#....OO#O#......O#O.....O#.OO...OOOO..#....#..##..........#.O....O.
..#..O..#.......O#O..OO..O.........OOO..##....O..O..OO.#....O.....#.O.#.O.#.#OO#....#.....##.#O...O.
#....O.......O.#......OO.OO...O..O......#.O.O.O...#....#.#..#.O....#.#O.OOO..#.O..O.O.#.##........#.
OO..OO##..#.O..#OOO...O..O.O......O.#.#.O#....O#O#..O#........##.O#....OO..#O#..O..##.........O.#...
.OOO......O#.OO...........OO#..#.O.O..#...OO#...#.....#........O...O##....OO.....O..OOOO...#........
O#.O....#.#..O.O..O.#.OOO.O..O......O.OOO..#..O..##..O.O....O.O.OO.##.....#.#O..##O..O......O##..#..
#...#..O.OO..#.#.#......O.#..O.#.OO.#............#O#....#....O.......O...O....###....O.#.#O...OO#O.O
O..O..#....O.#.O..#.O.#.#OO#...O.O..#...O.#O......OO.O.O.....O...OO.#O#......#..#.......O#...#..O...
..O..O.#O.O#.##O..#OOO.O#.O.#....O.##.#..O..O...#......O..#O..OO....#O#..#O#.#OOO.#O.OO......OO#....
#.....O#O..O..O.OO.#.......O........O.OO.#OO........O...O......O..O.O.......#.#....O#..O..#.....##..
.....O.......#........OO...OOO#.#.#.#.O..##..O........#O.#.#O.#..#O.....#O....OO.......#......O....O
....#..#..O.#..#O#O..O....O..#.#....#..##.........O..O.#O.O..OO...O.##....#.O.#.#OOO..O..#.....#..O.
.#OO......O...#..##.O...#.O..........#.##.O....OO.O#....O.OOO....O..OO...#.#.O#...OO.O#O#O......#.##
O....O.#....O.#......OO.##..O..#...O.#..#..O....#..##...#....#........OO.......#..O.#.#...#..O......
.#.#..O..O.#..#.O.#O..#..O....O...OO.#.#...OO.##..##.O..O..O..O.#...O.#OO##O..#.O.....#.##..O....O..
..##................O#O#....#..#O.O....##.#...O...O.....#.....OO.#.#............OO#....O.#.O.O...O#.
.#..O.O...#O.O....#O....OO.#..O#...........O#.....##.O..#OO...#...O.OO.........OOOO.O...##.#....O##.
..O.......OOO...O.#OO.#......O.O......O.....O.OO......O#..#OO..#.O.......O.#.#.....#.O.O#O..O...O.#O
#............O#..O..O#.....#.O.#.O...O....#O..#...O........##OO..O.OO.OO.....O...###O.O#..#.##....#.
..#O..#.#...O......O......O....#.##O#.O.#OOO.....O..#.O.....#O..#..#.O.O...O..#.....#....#.......OO#
#..O..#O..#.O........###....OO.O.O...OOO#..OO.#..O...#..O...O#...O..O.O.O..O.......OO.O#..O..O...O.#
OO.OO.#OO.........O...#.OO.OO#..OO...#.....#O.O.O..#O..#.....O..##......O###O.......#.##..O.........
.#..O..O.O..OO.O..OOO..#...#.#..O.....O.....#.#...OO....O..#.OO#..##O#..OO.O...O..O...###.#..O#...O.
O...O.O................#....#...O#.#.#O#.O..#O..OO.O.OOO...O...O.OO.....#.OO..#.....#.....#.O.....OO
O...O..##O...####O###....O##O..O#.O.........#..O..O.###......O#..O...O#O...O#...O......O.O#..O.#...#
O..#.O...O.#..##O.#.....O........O.......OOO....#...#..O..#...##....#.##.O.O..#....O#...O.....#..OOO
O..#O#...O..O.O#....#...O..O..#....O.O..#.O..#O.......O#.O.........O.#.#..O.....O....#.OO.O........O
..#.........O..#OO.#O...O..#..O.#.O.O...O####........OO.##.O..#.#..#.#O#.OO..O.#.O..OOO...O..O...O..
...#.....#.#...O.#.O#...O#..#.O....#.....#......O....#O#..O#O........O#....###OO....#...O##......#O#
..#.#..O.O#......O.O.OO........#O.#O..#.O#O......O.........O#O...#..#........#.....O............OOO.
.#O...####O#...#..O#..OO.O.OO..##O.#O...#...O....O.#......O..O...O..O.#..OO..#..#.##OO#.#..O......##
#..O.#.O..#.O#O#.O.#....O#..#.O.O...OO#O..O#.O.##O.O.OO......O##..###.O#....O..O.#.##.OO.O#OO....#..
..O#.O....O.....#....OO#.O.....OO.#..OO..O....O..#..#O.#OO...O..O....##.O#.OOO.O#...#O..O..##O..OOO.
O...#........OO.OO.#O......#O..........##....O.#......O..#O.....O...#...O.O.#....##.....##.O.O.#..##
...O#..O.O.....OO.O......#.OO.O...O..O###OO....O.......#.O.OO..#O#...#.....#.........#OO......O..OOO
##...O..#OOO..O.#.O.O#..OOO##..O.....O#..O.OO........OO...O..#..O..###..#....O#.#.#......#..........
..#.O.OOO..OO#..#....O.#.O..O.#.#.........OO...##......#.O.O#O...O...O.O.#..........##....#.#..O#..#
#...O#.....O..O........#...#.#.#O.##O#.O.#O..O.......O#...#.#.......##.#..OO...#.#O#..#.O..O.......#
.##.OO.#.#.#.O.#.........O..O.O#O...OO.....#..#OOO.#...O....O....O...##O.#O....OO.#O........###OO#..
.##............O.#O.#O.....##..O.#...#.....O.OOO............O..#.#........#...#.O..#..#...#O..#.....
##O#..##O....#OO..#..#OOO..O.#OO.#..#..#OO#.OO.#.OO..O....OOO...O...O....O...O........#......#...O..
#.#O.....#.OOO#O#...#.O....#O...#.OO.OO.O..O#.O##.O.O.O.O..O......#..OO...#O..O##.......O...O#O#O..#
#.....O...........O....#O##.O...O...........#..O...OO.###..OO.........OO..O.#....##.##.##...#.#...O.
O.#....OO#..O..OO.#O..OO...#O....O.O.OOOO##.#.....O..O........O.#....##O#..#..#.#..O.O....OO...O....
..#O.#...#.O.#O.O..O.O#.......#.#...O.#......##OO..##O..O.O...#O...........O.#.#..O.O...O......O...#
.O....#O#.OO#..#.......#.O.....#......#OOO..O#..OO.....O.O...O..O#...OO.......#.O.#.O#........O.O..O
O....O.O.#.OO........O#..#..O.O...#......#...#...##.#.O#...OO.....#O#...#..#....O.O#.#.#....O..O....
OO#.#..#OO###.O...#.O.#..#OOO.O....O..OO..O...O.#O#...#O.O.O.O..#O..O...##...O.#O...O....OO..O..#.OO
OOO....#OO....O..O#O.#O.....O#...O.#..O....O.....#O..........O#.#.#.OO.....O.....O.##.........O....#
.OO..#....#O..O.......O.##.O.......#.....#.....O.O..........#.O.O.O..#....#..#....O..#......#...O.O.
..#.#.#....OO.O#O..O#.#...OO..O.#OO..#O.##......#...#.O......#..#O.#O.#..O.#..O.........#.#........O
...O#.OO#.###.#..O.#...O..O#.O....#..O..O.#O.O........#..O..O..#.#.#OO.OO##O#............#..OOO#.O..
....#..OO.O...O#.#.##O.O...O#...#.##.#.###...O..O...#...#...#..#.#O...#.........#.#.O.O#O..O..O#O...
.#.......O#O.#..##.OO#..OO..##...O#O.#.O...##..O..OO..#...O.#..#..........#....O...#....O.#.#...O...
..O..O..#.O..OO..O.##.O.OO.#.O.O....O.#O#.#.O..#.O...O.#...#O...#..O.......O....#O#..O..#OO...##....
..O....O..OOO........OO..#..#..O.#...#.##OO...O...OOO..###O#.O.OO#.....O#...........OOO..OOOO.#O..##
.##.O##.#O.#..O......#.....O...#....O.O..#.......#...O..#.OOOO..#.#.##.#..O.....O...#.#..OO..#O#..O.
O.......O..O.O...O..#....O.#...OO........#....#O...O..OO....#...O.#O...OO....#.##O......#.O.O....OOO
O........O##..#.OO.O...#..OO..OO....#.O.O#.#..........OOO.#.O..###.#O..##...........O.#.O....#...O.O
..O.#OO...O..#...O###..O.#...O........#O.O...#.O#..#O..........O...#O...#...#.O..O....#O###.....#...
.OO#O###.O##O.O...O#...#..O#.........#..#.#.#OO#...O#O...#....##.#..#.O.OO...O...O.#O.OO.OO.#...O..O
OO.O.O#...O...#O#O.OOO...O....#OO..OO....O...#..O.O.O....#.O#.......O.#.O..#.O.#O..O..#O.O..O.O##O.#
.......#.....O.#....O.O.O.#..O#O#....O..O........O...OO...O.O.O.##.O..O.......#..........O#.#O..#...
.O..OO..O##......##......OOO........O...O..O.O##..#...O.O.#O#.#...#..........#.O...#O.OO...O....##..
O........#...OO#....O..#OOO.O.#.#.O..O......O..O.O#.....#....O.....####.........#O...#O.####.OO.....
#..#O...#.#......OOO.OO..O#.O..O....#........O.......#.O........O..........O...O..#.....#O#.O.#..OO.
O#.....#OO......#..O..#.##OO.O..#.#O.OO....O..O.#....O.......###..#OO...#..O#.............O.........
O....#..O.O.#O#....O#...###.#O.#........O...#.......#.O.#O.#OO#OO.#O#....#O.....#.O##...O..#.#......
.##......O....###...........O......#.....O..#.O...#.OO.##O...O.O#....#O.##...#O.O#..O..OO.O...#.O.O.
.##.#..#.##.O#.#.....##...#.O..#..##...O..O..#.#.O...#O..#...O#..O.#...O..#..#.O#.O#.O.##.O.#.#..#.O
.O..O....O...#O..OO..##O.O...##..#....#.....OO.O.O.####O..OO.......#...#....OO...O..#O.#.#......#O..
O...#..O.....#..#......##O#O#.O#OO...O#..O.#.OO.O#.O#O..#.O#.#......OO...O.....O....OO.OOO.#....O#..
#..##..........O...#....#.....#OO......O#####.....O.....O##O..O#O..O...O.O......OOO..OO......O.O..#.
...O#...OO#......OO.O....#..O..#........O.O......#O..#.....O............O.....O##.OO..O..#.O.#......
..OO...O.#..O..O..........##O.OOO.....O..O.#...#.#..........#..#O...O.O.#..#.#.O.O...O..##..#.OO....
O.............O.####O...O...#.O...##.O#.O.O..OOO..OO..#...#....#.O..O##...#..##...O..#..O..###.#.#.O
...O.O.....O.....O.....#.O.O..OO...O..O....OO##.....#.O.....#.#.#...O#.....#OO....O..........#..#.O.
