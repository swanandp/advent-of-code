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

# j == 7, i == 0, dots = 0, matrix[i][j] = . -> dots = 1
# j == 7, i == 1, dots = 1, matrix[i][j] = . -> dots = 2
# j == 7, i == 2, dots = 2, matrix[i][j] = . -> dots = 3
# j == 7, i == 3, dots = 3, matrix[i][j] = . -> dots = 4
# j == 7, i == 4, dots = 4, matrix[i][j] = O -> load = 10 (10 - 4 + 4)
# j == 7, i == 5, dots = 4, matrix[i][j] = # -> beam_length = 4, dots = 0
# j == 7, i == 6, dots = 0, matrix[i][j] = . -> beam_length = 4, dots = 1
# j == 7, i == 7, dots = 1, matrix[i][j] = O -> beam_length = 4, dots = 1, load =
# j == 7, i == 8, dots =  , matrix[i][j] =   ->
# j == 7, i == 9, dots =  , matrix[i][j] =   ->
def total_load(input)
  matrix = input.split("\n").map { |l| l.split("") }
  beam_load = 0

  matrix.length.times do |j|
    dots = 0

    matrix.first.length.times do |i|
      case matrix[i][j]
      when "O"
        beam_load += (matrix.length - i + dots)
      when "."
        dots += 1
      when "#"
        dots = 0
      else
        raise "Unhandled Input: #{matrix[i][j]} at [#{i},#{j}]"
      end
    end
  end

  beam_load
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
