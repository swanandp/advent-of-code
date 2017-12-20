class Day14
  attr_accessor :input, :output_part_1, :output_part_2, :disk, :visited_blocks

  class << self
    attr_accessor :grid_size
  end

  self.grid_size = 128

  def initialize(input)
    self.input = input

    solve_part_1
  end

  def solve_part_1
    self.disk =
      (0..127).map do |i|
        day10 = Day10.new(255, "#{input}-#{i}")
        day10.output_part_2.each_char.map { |c| c.to_i(16).to_s(2).rjust(4, '0') }.join.split('')
      end

    self.output_part_1 = disk.join.count("1")
  end

  def solve_part_2
    visited = unvisited_grid
    regions = 0

    (0..127).each do |row|
      (0..127).each do |col|

        if disk[row][col] == "1" && !(visited[row][col])
          regions += 1
        end

        visit_region(row, col, visited)
      end
    end

    self.visited_blocks = visited
    self.output_part_2 = regions
  end

  def visit_region(row, col, visited = unvisited_grid)
    return if disk[row][col] == "0" || visited[row][col]

    visited[row][col] = true

    visitable_children(row, col).each do |(child_row, child_col)|
      visit_region(child_row, child_col, visited)
    end
  end

  def visitable_children(row, col)
    all_children(row, col).select do |(r, c)|
      disk[r][c] == "1" && disk[row][col] == "1"
    end
  end

  def all_children(row, col)
    return [] unless row.between?(0, self.class.grid_size - 1) && col.between?(0, self.class.grid_size - 1)

    [
      [row - 1, col],
      [row, col - 1], [row, col + 1],
      [row + 1, col]
    ].select do |(r, c)|
      r.between?(0, self.class.grid_size - 1) && c.between?(0, self.class.grid_size - 1)
    end
  end

  def unvisited_grid
    (0..127).map do
      (0..127).map { |_| false }
    end
  end
end
