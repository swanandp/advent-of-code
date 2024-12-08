# frozen_string_literal: true

# if you're currently facing X, and you turn right, what do you face next?
# Nomenclature:
# north -> up
# east -> right
# down -> south
# left -> west
# up and down is relative, north, south are absolute
def turn_right_next_direction(current_direction)
  @turn_right_next_direction ||= {
    north: :east,
    east: :south,
    south: :west,
    west: :north,
  }

  @turn_right_next_direction[current_direction]
end

# if you want to move in a direction, what are the deltas you need?
def next_position(current_position, next_direction)
  @move_deltas ||= {
    north: [-1, 0], # previous row, same column
    east: [0, 1], # same row, next column
    south: [1, 0], # next row, same column
    west: [0, -1], # same row, previous column
  }

  i, j = @move_deltas[next_direction]
  [current_position[0] + i, current_position[1] + j]
end

# return next position or false
def can_move_straight(input, current_position, current_direction)
  i, j = next_position(current_position, current_direction)

  if inside?(input, [i, j])
    (input[i][j] != "#") ? [i, j] : false
  else
    [i, j]
  end
end

def inside?(input, position)
  0 <= position[0] && position[0] < input.length &&
    0 <= position[1] && position[1] < input[0].length
end

def print_input(input, origin, visited, loop_obstacles = [])
  input.each_with_index do |row, i|
    row.each_with_index do |cell, j|
      if loop_obstacles.include?([i, j])
        print "O"
      elsif origin == [i, j]
        print "^"
      elsif visited[[i, j]]&.keys&.count.to_i > 0
        print "X"
      else
        print cell
      end
    end

    puts ""
  end
end

def escape_maze(input, start_position, start_direction = :north)
  position = [*start_position]
  direction = start_direction

  visited = {
    position => {
      direction => true
    }
  }

  while inside?(input, position) do
    if (i, j = can_move_straight(input, position, direction))
      position = [i, j]

      if inside?(input, position)
        visited[position] ||= {}
        visited[position][direction] = true
      end
    else
      direction = turn_right_next_direction(direction)
    end
  end

  visited
end

def detect_loops(input, start_position, start_direction = :north)
  # Do one round and populate the visited nodes
  visited = escape_maze(input, start_position, start_direction)
  loop_obstacles = []
  position = [*start_position]
  direction = start_direction

  # condition one for detecting loop:
  # we come across the same right turn again
  # TODO

  # condition two for detecting loop:
  # if we turn right here,
  # we stumble upon a path previously taken, without escaping the loop
  # TODO

  [position, direction, visited, loop_obstacles]
end

origin = []
input = DATA.read.strip.split("\n").map { |l| l.split("") }
# pp input

input.each_with_index do |row, i|
  row.each_with_index do |cell, j|
    unless %w{# .}.include?(cell)
      origin = [i, j]
      break
    end
  end
end

loop_obstacles = [
  [6, 3],
  [7, 6],
  [7, 7],
  [8, 1],
  [8, 3],
  [9, 7],
]

# Part 1
visited = escape_maze(input, origin)
print_input(input, origin, visited, loop_obstacles)

loop_obstacles.each do |o|
  pp [o, visited[o]]
end

puts "Part 1 Answer: #{visited.keys.count}"

# Part 2
# position, direction, visited, loop_obstacles = detect_loops(input, origin)
# pp loop_obstacles



# ....#.....
# ....XXXXX#
# ....X...X.
# ..#.X...X.
# ..XXXXX#X.
# ..X.X.X.X.
# .#XOXXXXX.
# .XXXXXXX#.
# #XXXXXXX..
# ......#X..

__END__
....#.....
.........#
..........
..#.......
.......#..
..........
.#..^.....
........#.
#.........
......#...
