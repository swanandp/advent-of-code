require "text"

def sample_input
  <<~INPUT
    #.##..##.
    ..#.##.#.
    ##......#
    ##......#
    ..#.##.#.
    ..##..##.
    #.#.##.#.

    #...##..#
    #....#..#
    ..##..###
    #####.##.
    #####.##.
    ..##..###
    #....#..#
  INPUT
end

def reflections(block)
  matching_rows = []
  block.each_cons(2).with_index do |(l1, l2), i|
    if l1 == l2
      matching_rows << i
    end
  end

  matching_rows.select do |i|
    pairs = i.downto(0).map { |x| [x, i + (i - x + 1)] }.select { |(x, y)| 0 <= x && y < block.length }

    pairs.all? { |(r1, r2)|
      block[r1] == block[r2]
    }
  end
end

def summarize(input)
  sum = 0

  input.split("\n\n").each do |pattern|
    block = pattern.split("\n").map { |l| l.split("") }
    horizontals = reflections(block)
    verticals = reflections(block.transpose)

    block_sum = 100 * horizontals.map { |h| h + 1 }.sum + verticals.map { |v| v + 1 }.sum
    sum += block_sum
  end

  sum
end

pp summarize(sample_input)
pp summarize(DATA.read)

__END__
#..##..
#.#.##.
#.####.
.####..
#.###.#
...####
#...#..
..#.#..
#...##.
.#####.
.#....#
.#####.
.####..
###.###
###.###
.####..
.#####.

#.##..#..######..
....##.##..##..##
###...##..#..#..#
###...##..#..#..#
....##.##..##..##
#.##..#..######..
.#..###.###..###.
####...###...####
######..########.
.#..#....#.##.#..
##...###.#....#.#

#...##...#..#.#..
#...##...#..#.#..
.#.#...#.#....#..
#.#..#.##..##.#.#
#..###.#..#..#...
###.#####.##.#.#.
##############...
#.....#######..#.
..##..##.####..##
#.####..##.#..#.#
#.####..##.#..#.#
..##..##.####..##
#.....#######..#.
##############..#
###.#####.##.#.#.
#..###.#..#..#...
#.#..#.##..##.#.#

.#.....##.....#
.#.....##.....#
.##.##...#.##..
##.##.#.#.##..#
######..#.#..##
..#.#..#.#..#.#
.....#..###.#.#
###..#.##..#..#
#..#.##.#..#.#.
#..#.##.#..#.#.
###..#.##..#..#
.....#..###.#.#
..#.#.##.#..#.#
######..#.#..##
##.##.#.#.##..#
.##.##...#.##..
.#.....##.....#

###..##########
#.####.#....#.#
.#....#.####.#.
#.####.##..##.#
#.#..#.######.#
..###..........
##....##....##.

####...#.##.###
..##...##...#.#
.#...##.#.#####
###...#...###..
..#....#...#...
.###.#####.#...
##...#####..#..
.####...##...##
#.#.#.#..###...
..##.#.####..##
#..##.##.####..
##..#.#..#..#..
..###.#.#.#..##
..###.#.#.#..##
##..#.#..#..#..

###.#..#.#####.##
..#.#..#.#.......
....####.#...#.##
#...#..#...##.###
#...####...#.###.
#.#.#..#.#.###.#.
#..#....#..#.....
.##########..###.
##.#....#.###..#.
#...####...###.##
#...####...###.##
##.#....#.###..#.
.##########..###.
#..#....#..#.....
#.#.#..#.#.###.#.
#...####...#.###.
#...#..#...##.###

#####..#.
#..#.#.#.
#####..#.
.##.##..#
....#.###
....#####
.##.##..#

#####..
..#.##.
..#.##.
#####..
##.....
###.##.
#..#.##
######.
..##.##
..#.#..
..#####

#.###..###.##.#
#.#..##..#.##.#
#.##.##.##.##.#
##........####.
.#.#.##.#.#..#.
#..........##..
###.####.######
##.#.##.#.####.
..########....#
.#..####..####.
..##.##.##....#

.......##..##
..##...#.#...
.#..#...#.###
.####...#..##
##..##.####.#
#.##.#.#.....
.......#.##..
..##..#.#.###
......#..#..#
.......#.##.#
......#..#.##
#...##..#..##
.####.#.#..##
.####.#.##...
.####.#.##...

...#........#..
##.#..#..#..#.#
##.##.####.##.#
##..##.##.##..#
...#..#..#..#..
..#..######..#.
...#.#.##.#.#..
..##...##...##.
...#...##...#..
##..###..###..#
...#..####..#..
...###....###..
.......##......
####..####..###
#####......###.
..#..######..#.
..#..#....#..#.

.#.#..#.##.##.##.
#.#....#.######.#
####.#..#......#.
.#.#.#..#.####.#.
..#####.##....##.
###..#...........
...##.#.#..##..#.
..###.##...##...#
..######...##...#

....###.##.###.
#.#####.#...#.#
#..#.#...##.###
..#####..##.##.
..#####..##.##.
#..#.#..###.###
#.#####.#...#.#
....###.##.###.
...###.#.###...
...##...#..#...
.####.#....###.
.####.#....###.
...##...#..#...

####.####
##.#.###.
####..#.#
##.##...#
#####..#.
####.####
###....#.
####.#..#
###.#.###
..#..#.#.
##.#.....
....#..#.
..##.####
..##...#.
..##...#.
..##.####
....#....

..#....#..##.##
..##..##..#.#.#
..##..##....#..
..##..##....#..
..##..##..#.#.#
..##..##..##.##
##..##..##.#..#
....##.....#..#
.#.####.#...#.#

...##.#.#..##
.#.#..#.#..##
.##.##...#..#
.##.##...#..#
.#.#..#.#..##
...##.#.#..##
.#.#.##....#.
########....#
##..#.#...#.#
......##.....
#..#.....###.
#.#.#####.##.
#.#.#####.##.
#..#.....###.
......##.....
##..#.#.#.#.#
########....#

##.##.####.
#..##..##..
.##..##..##
###..######
.#.##.#..#.
.##..##..##
###..######
#.####.##.#
#..##.####.

##.#.#####.####
##..#..#.##....
##.#..#.#.#.#..
##..##.#....##.
..##.#...##.#..
..##..###.#....
#####.##...#.##
##.....#.##..##
##..########...
###....#..#.###
...##.######.##
###...#########
##.#.##.##.##..
...##.####.#.##
##..#..###.#.##
###.##.##.#.###
...####..###...

.####.#..#.
.####.#..#.
......##.##
.####.#.###
.#..#.##.##
.###..##.#.
##..##...#.
......#####
######.##.#
#.##.##.#.#
......#.#..

##..##..###.#
.##........##
...########..
.#.#.####.#.#
#.####..####.
#.##......##.
.##.#.##.#.##
..#..#..#..#.
#.###....###.
....######...
.#..........#
#.#.######.#.
#..###..###..
#.#........#.
#.#........#.
#..###..###..
#.#.######.#.

..##...#....####.
##.....###..#..#.
####.#.###.######
####...#.#.######
..####.#.###....#
..##.#..##...##..
###..######......
...####.###....#.
##...####.#.####.
####..####.##..##
##.#..#.#.#.####.
..........##.##.#
..#...####.#.##.#

..###..#.#.....
.##.#.##.......
...#.##..#.....
#.##....#..####
...#..####.#..#
.####.###.#....
##..#####......
##..#..#.......
..####..#......

.......####
.......####
##..#..##.#
....#.##.##
..###.#...#
.#.##..##..
##.#.##...#
.#.#.##...#
.#.##..##..
..###.#...#
....#.##.##

####.....#..#...#
####.....#..#...#
####.##.#.###.###
.###.###.....##.#
....###.#.#.#.#..
...#..#..#.##..#.
##...#########..#
###.#.#.##...####
#...#..#.##...#..
#...#..#.##...#..
###.#.#.##...####
###..#########..#
...#..#..#.##..#.
....###.#.#.#.#..
.###.###.....##.#

.##.#....#.##.#
..##....#.###.#
..##....#.###..
#.##.##.#......
.####..#..##.##
..##..##..####.
......#.##.###.
#....###..###.#
......####..#.#
.####.#.#####.#
#.##.#......#.#
.####...##.#.#.
.####...##.#.#.
#.##.#......#.#
.####.#.#####.#

##....#.#.#..#.
##..####..#..#.
....#.##..#..#.
###.#.#........
#.###...#######
..#.#.##.......
....#..........
##.##..####..##
..#...###..##..
........#.#####
........#.#####

##.#.##
##.#.##
..#.#..
.######
#...#.#
#.#####
#.###.#

...#.####...##...
...#..###...##...
.##.##.##..#...##
..##.#.##....####
..##.#.##....####
.##.##.##..#...##
...#..###...##...
...#.####...##...
#.#.##...##....#.
#####.###..#####.
...#..#....#.#..#

###.#.###.#
..#.##.#...
########.##
##.##.#..#.
..#...##.#.
.....####.#
.#.#######.
##...#.####
...#..#..##
####.#.####
##..######.
.........#.
.........#.
##..######.
####.#.####

#.#.#.##.
...##...#
...##...#
#.#.#.#..
#..######
.#.##..##
.###.#.##
#...####.
#..##....
....#.#.#
####.#.#.
###...#..
.#.##...#
##.####..
##.####..
.#.##...#
###...#..

##....#####.#
.#.##.#.#..#.
########..#..
##....####..#
##....####.#.
#.#..#.#####.
##.##.##...##
##.##.##...##
#.#..#.##.##.
##....####.#.
##....####..#

#.##.#.#.###...
#.##.###.###...
..##........##.
.####.##...#.##
......#.....##.
..##..#.#.#..#.
.####.###.#####
########.#.....
#.##.####.###.#
#....##.#..##.#
.####.###.#..##

.#.#....#.#..
##.#....#.###
.....##......
.#.######....
.###....###..
..#.#..#.#...
#..##..##..##
#..######..##
###..##..####
...#....#....
.##..##..##..

...#.#.......
###.####...##
..##...##.#.#
###.##..#.#.#
##....##.####
##....##.####
###..#..#.#.#

..##.####
.#..#....
....#....
..#.#####
#####....
.##.#####
##....##.
#....####
.....####
#..#.####
..#.#....
#.##.####
###..####

######.#.##
#.###..#..#
..#..##...#
#...##..##.
.....##.#.#
....#...#..
....#...#..
.....##.#.#
#...##..##.
..#..##...#
#####..#..#
######.#.##
######.#.##

...##....#..##..#
..#..#..##.#..#.#
.######.###....##
#.####.###.####.#
...##...#.##..##.
..####....######.
#.#..#.#..##..##.
.######.##..##..#
#......#.#.#..#.#
##....####......#
.##.###.##......#
##.##.###..#..#..
########....##...
#..##..###.####.#
.##..##..#......#
#.####.#.#..##..#
#.####.#.#.####.#

##.###..###.#
..###.##.###.
.#..........#
#............
#...######...
..##.####.##.
.##.######.##
.##.######.##
###.#.##...##
..##.#..#.##.
..##.#..#.##.

..#.###.###
.......#.#.
.......#.#.
..#.###..##
#.#####.##.
##..#####..
#....#.##.#
#.#.####..#
.##.###.###
#..###..#.#
...#...##..
...#...##..
#..###..#.#

#####........#.#.
#####........#.#.
.#.#.#.###..##..#
.##...#.#..##.###
#..#....#.....#.#
..#..##..#.#.#..#
...#....#.##..#..
#..#####....##.##
.###...##.#.#####
.###...##.#.#####
#..#####....##.##
...#....#.##..#..
..#..##..#.#.#..#
#..#....#.....#.#
.##...#.#..##.###
.#.#.#..##..##..#
#####........#.#.

.#.##.#.#......
##.##.##...##..
.######..#....#
#..##..##.#..#.
.##..##........
##.##.##..#..#.
#......##.####.
#.####.##.#..#.
.##..##..#.##.#
..####....####.
#.####.###....#
#..##..##.####.
.#.##.#.#...#..
##....##.......
...##.....#..#.
#..##..#.......
#......########

###.##....##...
#..####.##..#.#
#..####.##..#.#
###.##....##...
.##.#########.#
.#.##.#.##.#...
.....##..#.#.##
.###....#....##
...###.#...#...
..#.##..##...##
..#.##..#....##
...###.#...#...
.###....#....##

##.#..#....#.
#######.##.##
.##.#..#..#..
.#......##...
...##.#######
...##.#######
.#......##...
.##.#..#..#..
#######.##.##

#.#######
.....#..#
##..#####
..#..####
####.####
##.##....
###......
.########
#####....

#..........
#.....#....
#.##.#...#.
#####..#.#.
..##..##..#
###..##.#..
..#..#...#.
.#.#.#.##.#
.#.#.#.##.#
..#..#...#.
###..##.#..
..##..##..#
#####..#.#.

...#.###...####.#
...#.###...###..#
#..#..##.##...#.#
#.#..##.##.....#.
##.###.#.####.###
#..#..##..#.##..#
#..#..##..#.##..#

..#.##...####
#...#.#..#..#
.#####.#.#..#
.#####.#.#..#
#...#.#..#..#
..#.##...####
#.....#.##..#
##.##.####...
#....#####..#
.....#.......
..#..########
##.##########
#.####.#..##.

.####..##..##
.####..##..##
.....#...##..
#.##..##.##.#
##........#..
..####..####.
#...##..#..#.
##..#........
...##.#..##..

#....####....##
###....#...####
.#.##.##.##.#..
#...#.##.#...##
.#.##.##.##.#..
.#...#..#...#..
...###..###....

...##....###..#
########..###..
........###...#
........###...#
########..###..
...##....###..#
.#.##.#...#####
..#.....##.###.
.#.##.#.#.##..#

..#.###.#
..##....#
.###.#...
#....#.##
#....#.##
.###.#...
..##....#
..#.###.#
..#.##..#

.##.###.#####
.##.#..#.....
##.###.....##
#####..#...##
#####.....###
.##..##.#.#..
......##.....

#.#.#...#####
#.#.....#####
.#.#.###....#
###..#....##.
#.#....##..#.
..####.#.####
#.#.#.####...
..##.......#.
.##.######.#.
.##.#.#..####
.##.#.#..####

##...####
##...####
...#..##.
..##..#.#
#.###.#..
##.###.##
...##.#.#
##.##.###
..#.....#
..#.....#
##.##.#.#
...##.#.#
##.###.##
#.###.#..
..##..#.#
...#..##.
##...####

##..##....##.#.
..##..##..#...#
######.##.#....
.####...#.#..#.
#######.#..#..#
#....##...#.##.
#....##...#.##.
#######.#..#..#
.####.....#..#.
######.##.#....
..##..##..#...#
##..##....##.#.
.#..#..#....##.
#.##.###...###.
..##..#.#######
#######....#...
##..####.#..##.

...........#...#.
.#.#..#.#.....###
..#.##.#.......#.
##########.#..#.#
##.####.##....#.#
##.####.##....#.#
##########.#..#.#
..#.##.#.......#.
.#.#..#.#.....###
...........#...#.
...#..#...##..##.
#.#....#.###.##..
##.##.#.##..##..#

....#.###......
......##.##..#.
.##..#...#.#.#.
.##...##...#.##
.##...##...#.##
.##..#...#.#.#.
......##.##..#.
....#.###......
.....#..#.##..#
####...####..##
...###.#.#..###
#####.#.##.####
#..##.#..#..###
....##...#....#
.....###.#.#.#.
#..##.##....#..
.##....##..#..#

#..........###..#
#.##....##.###..#
.##########......
####.#..####..##.
..#..##..#..#....
..##....##...#..#
#...#..#...##....
##.##..##.####..#
.##########.#....
.#..#..#..#.#####
#...####...######
.#..#..#..#......
..#......#..#####
#..#....#..##....
#.#..##..#.#.####

...##.#
...##.#
...#...
#.####.
#..#.#.
..###..
##..#..
##..#..
..###..
##.#.#.
#.####.
...#...
...##.#

#.##.#....#..
..##..####.##
#....#.#..#..
##..####...##
.####....#...
##..##.#.#...
########.####
#.##.##.#.###
..##.....##..
.........##..
.....#.##..##

###.##.
###.##.
..##...
#..#.#.
.#.#.##
#..###.
..##.##
#.#.###
.#.##..
..#.###
..#####
#....##
#..#.##

..##########.##
#...##..#.#####
#####.####..##.
.#.###..#......
####..###.#....
##...#.#.######
#.######.##.##.
#.#.#..#...#..#
.####....##.##.
.#.#.#.###.####
.....###.##.##.
.....###.##.##.
.#.#.#.###.####
.####....##.##.
#.#.#..#...#..#

#..####.##.####
###....#..#....
###.##.####.##.
..#.##.####.##.
.#.############
.#.#..#....#..#
###....####....
#..###..##..###
....##..##..##.

..###.###
####..##.
.##...##.
#..#.....
.###.####
....#####
####.#..#
####.#..#
....#####
.###.####
#..#.....

####.##.##...
.#...#..#..#.
..##....#.#..
.#.###....#..
.#....##..##.
....##.##....
..#.#...#####
..#.#...#####
....##.##....
.#....##..##.
.#.##.....#..
..##....#.#..
.#...#..#..#.
####.##.##...
####.##.##...

###..#.#..#
#...#..##..
#...#..##..
###..#.##.#
###..#.##.#
#...#..##..
#...#..##..
###..#.#..#
#....#####.
...#..#.#.#
..##.##...#
.#..#..##..
.#....#.#..
...##.###..
..#....####

....#.##...
####..####.
###.###.#..
..#..##....
....#.##.##
....#.##.##
..#..##....
###.###.#..
####..####.
....#.##...
..#......#.
..##.#.###.
..##......#
#.##.####.#
..#...###..

#.##...####
.##.##.#..#
#..###..##.
.###.......
...#.#.####
#..####.##.
#..#.##.##.

#...##.
.#..##.
.#.....
.###..#
.###..#
.#.####
..#####
.#.....
..##..#
#...##.
#.##..#
..##..#
#...##.

.##..#..#....
.#.##...##..#
#...##...####
####........#
#.##...#.####
........#....
#.#..####.##.
#######.#....
#######.#....

...###...#..#.#
####....##.#.#.
##....##..#....
###....#..#...#
###....#..#...#
##....##..#....
####....##.#.#.
...###...#..#.#
..##..##....#.#
####....###..#.
#..###.....#..#
##.#.#.#..###.#
..####.#.####.#
...#..###...##.
..######.#..##.

#####.##.#..#
######.#.#.##
##...#.#...#.
##...#.#...#.
######.#.#.##
#####.##.#..#
##.###..#.#.#
....####.....
.#..#.##.#.##

##.....##..
...##......
##....####.
###.#.#..#.
.....##..##
..#.#.####.
.....##..##
##.....##..
##....#..#.
###.#.####.
##...#....#
###.#......
#.#########
####...##..
..##.#....#
#####......
......#..#.

.#.######.##.
.#.##..##.#.#
#.#......#.#.
#.##.##.##.##
#...#..#...#.
...#....#...#
.#........#..
##...##...###
#.########.##
#.#.####.#.#.
.#.#.##.#.#..
.#.#.##.#.#..
#.#.####.#.#.
#.########.##
##...##...###
.#........#..
...#....#...#

##.##.##..##.
##....#######
###..###.#.##
###..###.#..#
#..##..#.#..#
.#....#.#.##.
.#....#.#.##.
...##....#..#
###..###.#..#

#####.##.
###......
..#...#.#
....##...
####.##.#
####....#
####...##
####.##.#
....##...
..#...#.#
###......

##......##.#.
..####...#...
##.#.##..#..#
##.#.##..#..#
..####..##...
#...#..##.###
#...#..##.###
..####..##...
##.#.##..#..#
##.#.##..#..#
..####...#...

#..##.#
#..##.#
.#..#..
.#..##.
..#####
#.#....
....###
....###
#.##...
..#####
.#..##.
.#..#..
#..##.#

......###
#..##.#.#
#..##.#..
......###
#..#...#.
......###
....#.##.
.##.#....
......##.
####..#..
#..#####.
#..##....
#..#.###.
....#.#..
.##.#####
.....#.#.
#..##.##.

..##..#####..##
##..#######..##
..#.###.###..##
##.##..#..#.##.
##.#..###.#..#.
...#.##.##....#
..#..#.##..##..
####...#.......
...###.#...##..
...#.....##..##
##.........##..
####....#......
##..#..##.####.
###...#.#.#..#.
##.##.#...####.
##.###..##.##.#
##.####........

######......#####
##.#..##..##..#.#
##.##........#..#
###.#........#.##
##.##..#..#..##.#
##.....####.....#
...#.########.#..
###..##.##.##..##
###............##
..#.##......##.#.
......#....#.....

.#.#.#.##...###.#
.###....###..#.#.
.......##..#.#..#
......#..#..#..##
#.....##..#######
..#..#.##.##..##.
.#.....###.#...#.
##.##.#..##..####
##..#.#..##..####
.#.....###.#...#.
..#..#.##.##..##.
..#..#.##.##..##.
.#.....###.#...#.
##..#.#..##..####
##.##.#..##..####
.#.....###.#...#.
..#..#.##.##..##.

..##.####
..##.####
#.#######
#####...#
####..##.
.###.####
##.#.....
##.#.....
##.#.####
#.#.##..#
####.#..#

.#..##....##...
.#..######..###
.#.###.########
.###....##..##.
.###...........
.#....#..#..#..
##.############
..#..##...##...
.#.#......##...
#....##..#..#..
.##..#.........

##..####..#####
....#..#.......
#....##....####
.####..####....
##..#..#..#####
#...#..#...#..#
.#.#.##.###.##.
##.######.##..#
##.#....#.##..#
...#.##.#......
.#.#.##.#.#.##.
...#....#...##.
.###.##.###....

##...####..
#..###.###.
.##.#.#....
.#..##.#..#
.#..##.#..#
.##.#.#....
#..###.###.
##....###..
.#...#.##.#
.#...#.##.#
##....###..
#..###.###.
.##.#.#....

.##.#.#..
.....###.
....#.#.#
#..####.#
.##.#.###
#..##.#..
#..##.#..
.##.#.###
#..####.#
....#.#.#
.....###.
.##.#.##.
#..##....
#..####.#
....####.

..#.###
...#...
...##..
##....#
....#..
###...#
###..#.
#####.#
......#
......#
#####.#
###..#.
###....
....#..
##....#

..##..#
.####..
##..##.
.####..
#.##.#.
#.##.##
.####..

########.##...##.
..####......#####
.######.####.#..#
###..#####...####
..#..#..##.#.####
#..##..#.....####
.#.##.#.###......
##....######..##.
#########.##.##.#

.#.#..#
#.#.##.
.##.##.
.#..##.
#.#.##.
.#.#..#
.###..#
.##.##.
#......

.####.....#
.#..#..#.#.
.##.#...###
#.##.###...
..##..###..
#######.#.#
..##..##.##
##..##...##
##..###..#.
#.##.#...#.
#.##.#...#.

####..##.#.
...#.....#.
##.#..###..
######.....
###..#...#.
###..#...#.
######.....
##.#..###..
...#....##.
####..##.#.
###.######.
##....##.##
##.###.#.#.

.#..#..####..#.
#..#..........#
#.##..........#
.#..#..####..#.
###.##.#..#.##.
####.###..###.#
...###.####.###
.#....#....#...
##..##..##..##.

....#..
#####..
.....##
.....##
.##.#..
.##.###
####.##
....###
....#..
###.#..
.....##
####...
.##.###
.##.###
.##.#..

#.######.##..
.#.####.#.###
###########..
##..##..##.##
##.#..#.###..
####..#####..
..#....#..#.#
.#.####.#.#..
##......##...
...........##
#.######.#...
#.#.##.#.#.##
#.##..##.#...
.#.####.#..##
#.##..##.####
.#..##..#.#..
#...##...####

###..#..##..#..##
..####......####.
..#.#.#....#.#.#.
...#.#......#.#..
##.#.###..###.#.#
..##...####...##.
##..#.##..##.#..#
..#.#..#..##.#.#.
.....##.##.##....
##.##.#....#.##.#
##..##.####.##..#

#####..
.###...
.###...
#####..
....###
#...###
##.#...
#...#..
.....##
###.###
#.#.#.#
.##..##
.#.#.##
.##.###
###....
#.###..
##..###

..###..#.
..##...#.
..#.#.##.
...##....
..#..#..#
..#.#####
##..#.#.#

