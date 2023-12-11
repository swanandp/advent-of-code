def sample_universe
  <<~INPUT
    ...#......
    .......#..
    #.........
    ..........
    ......#...
    .#........
    .........#
    ..........
    .......#..
    #...#.....
  INPUT
end

def sample_universe_expanded
  <<~INPUT
    ....#........
    .........#...
    #............
    .............
    .............
    ........#....
    .#...........
    ............#
    .............
    .............
    .........#...
    #....#.......
  INPUT
end

# do if needed
def expand_universe(universe) end

def sum(input)
  universe = input.split("\n").map { |l| l.split("") }
  galaxies = []
  empty_rows = []
  galaxies_in_columns = {}

  universe.each_with_index do |r, i|
    galaxy_spotted = false

    r.each_with_index do |c, j|
      galaxies_in_columns[j] ||= 0

      if c == "#"
        galaxy_spotted = true
        galaxies << [i, j]
        galaxies_in_columns[j] ||= 0
        galaxies_in_columns[j] += 1
      end
    end

    unless galaxy_spotted
      empty_rows << i
    end
  end

  empty_columns = galaxies_in_columns.select { |k, v| v == 0 }.keys

  galaxies.combination(2).reduce(0) do |sum, (g1, g2)|
    rd = g2[0] - g1[0] # row distance
    cd = g2[1] - g1[1] # column distance

    re = empty_rows.count { |r| r.between?(*[g1[0], g2[0]].sort) } # row expansion
    ce = empty_columns.count { |r| r.between?(*[g1[1], g2[1]].sort) } # row expansion

    sum += (rd.abs + (1000000 - 1) * re + cd.abs + (1000000 - 1) * ce)
    sum
  end
end

pp sum(sample_universe)
pp sum(DATA.read)

__END__
...........................#.......#.....................#................#.......................................#.............#...........
..................................................#...........................................#.......................................#.....
........#....................................#....................................#.......................#.................................
........................................................................................................................#...................
#...................#.......................................#...............................................................................
...............#.......................................................................#...........#...........#............#...............
........................................................#...........................................................................#.......
..............................................#.....................#...................................#...................................
.............................#......#.....................................#.................................................................
.......................#...........................#............................................#.................#.........................
.....#.....................................................................................................................................#
...........#......#...............................................#..............................................................#..........
.......................................................................................#...................#................................
..............................#........................#....................................................................#...............
.................................................#..........#......................................#........................................
........#................................#...................................................#..........#.....#......#......................
.........................#.........................................................................................................#........
............#.................................................................#.........#...................................................
....................#.......................................................................................................................
............................................#.............#.................................................................................
..............................#.....#...........................................................#........................................#..
#.........#........................................#............#................................................................#..........
.........................................................................................................#..................................
..................#.....................................#..............................#.............................#.......#..............
...........................#..............................................#.................................................................
...........................................................................................#......#.........................................
.......................#.......#..................#..........#....................................................................#......#..
.....#.............................................................#............................................#...........................
....................................#............................................#......................................#...................
.....................................................................................................................................#......
..............#.............................#.......#....................................#..................................................
.........#......................................................#.................................................#...........#.............
............................................................................................................................................
.#.....................................................................#..........#....................#....................................
..................................#....................................................................................................#....
...........#.........#............................#......#........................................#.........................................
................................................................................................................................#...........
..............................................................................................#.............................................
......................................#..............#.......................................................#...........#..................
....#............#.........................................#................................................................................
............#..............#.............................................................#..................................................
...............................................#...................................................#..........................#............#
..................................#.........................................................................................................
........................................................................#...........#...............................#.....#.................
#.........#..............#..................................................................................................................
.......................................................................................................................................#....
................#..........................................#................#................#.................#..................#.........
...................................................................#........................................................................
................................................#....................................................#......................................
.....................................................#..........................................#...........................................
..........................#.................................................................................................................
.....#.....#.....................................................................#.......#..............................#...................
.....................#........................#...............................................................#................#............
................................#........#............................................................#.....................................
.................................................................................................#................#.........................
..................................................................#.................................................................#.......
............................................................................................................................................
................................................#.....#.................#................#....................................#.............
......................#.....................................................................................#........#..................#...
..........#........................#................................................#.......................................................
....#.............#...................................................................................#...........................#.........
.........................................#..................................................#.....................#.........................
............................................................................................................................................
..........................#..................#..........................#.................................................#.................
.......................................................................................#......................#.............................
................................#......#.....................#................................#......................#..................#...
............................................................................................................................................
........#.........#.................................................................#.......................................#......#........
..........................................#........#........................................................................................
............................................................................................................................................
...............................................................................................#.......................#....................
............................#............................................................................#.................................#
............................................................................................................................................
......#...........#...................................#........#........#...................................................................
....................................................................................#.........................................#.............
.......................................#.........#......................................................................#...................
............................................................................................................................................
..............................#..................................................................................#..........................
.......................#......................................................#................#............................................
........#..........................................................#..................#................#...........................#........
.............#.....#................#.......................................................................................................
.........................................#...............................#.....................................#............................
.#...........................................................#...................#..................#.......................................
...........................#.................#............................................................................#.................
.......................................................#..................................................#.........#.....................#.
......................................................................................#........#............................................
......#.........#.................#............................#................................................................#...........
..........................................................................#.................................................................
...........#.........#.........................................................................................#............................
...........................................#..............#.................................................................#...............
.....................................................#.............#...................................................................#....
....#.........#.................#................................................................................................#..........
.......................#.......................................................#..................#........#............#...................
......................................#..................................#...................#..............................................
.......#.....................................#......................................................................#.......................
..#..........................#...........................#..........................#.......................................................
...........#.............................................................................#......................#......................#....
...............................................................#.........................................#..................#...............
.................#......................#........#...............................#..........................................................
......................#.......................................................................#......#..............................#.......
............................#......#......................#.................................................................................
...........................................#.............................#..........................................#.....#.................
...........#......................................................................................#.....................................#...
.......................................................#..........#....................................#.......#.................#..........
...............................#........................................................#...................................................
..#.....#.............................#................................#....................................................................
..................................................#...........................#.............................#...............................
.............................................................................................#.....#........................................
...............#........................................#.............................................................#.....................
#....................#...........#..........................................................................................................
............................#..............#..............................#.......................................................#.........
.....................................................................................#......................................................
.................#...........................................................................................#..............................
.........#..............#............................................................................................#...................#..
....................................#................#..............................................#.......................................
...............................#.........#.................#...................#.........................#..................#...............
#.............................................#........................................#....................................................
......................................................................#..........................................#..........................
.............#...............................................................................#........#...............................#.....
...#............................................................#............................................#..........#..................#
...................................................#........................................................................................
..........................................#..............................#..................................................#...............
.............................................................#....................#.....................................................#...
.....................#..............#..................#................................................#...................................
.......#.......................#........................................................#.......#..............#.................#..........
..........................................................................................................................#.................
...#.......................................#....................#...................#.......................................................
..................#.........................................................................................................................
...........................#...........#...................................................................#......#.........................
................................#.............#....................#........................................................................
.........................................................................................#.......#..........................................
.......#.....................................................#................................................................#...........#.
..................................................#.......................#.................................................................
.............#...................................................................................................#...................#......
............................#.........#................#.............................#................#.....................................
......................#.......................................................................#...........................#.................
............................................................................................................................................
.............................................................................................................#.......#............#.........
.......#...........#.....#.....#.............................#..............................................................................
.............#...............................#..........#..........................................#......................................#.
