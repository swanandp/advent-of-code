class Day19
  attr_accessor :tubes, :x, :y, :direction, :letters, :output_part_1, :steps

  def initialize(tubes)
    self.tubes = tubes

    self.x = 0 # Always start in the first row
    self.y = tubes[0].index("|")
    self.direction = :down
    self.letters = []
    self.steps = 0
  end

  def solve_part_1
    while valid?
      move
    end

    self.output_part_1 = letters.join
  end

  def move
    return unless valid?
    step = tubes[x][y]

    case step
    when "|"
      self.x, self.y = directions[direction].(x, y)
    when "-"
      self.x, self.y = directions[direction].(x, y)
    when /[a-z]/i
      self.letters << step
      self.x, self.y = directions[direction].(x, y)
    when "+"
      self.direction, (self.x, self.y) = feasible_neighbours(self.x, self.y).first
    else
      fail("This shouldn't have happened: #{[x, y, step, direction]}".strip)
    end

    self.steps += 1
  end

  def valid?(x = self.x, y = self.y)
    0 <= x && x < tubes.length &&
      0 <= y && y < tubes[x].length &&
      tubes[x][y] != " "
  end

  # WARNING Useful for changing directions, but otherwise introduces ambiguity
  def feasible_neighbours(x, y)
    # noinspection RubyArgCount
    neighbours(x, y).select { |dir, (nx, ny)| # nx = neighbour's x
      valid?(nx, ny) &&(dir != opposites[direction] || dir == direction)
    }
  end

  def neighbours(x, y)
    directions.reduce({}) do |m, (dir, l)|
      m[dir] = l.(x, y)
      m
    end
  end

  def opposites
    @opposites ||=
      {
        down: :up,
        up: :down,
        left: :right,
        right: :left,
      }
  end

  def directions
    @directions ||=
      {
        down: ->(x, y) { [x + 1, y] },
        up: ->(x, y) { [x - 1, y] },
        left: ->(x, y) { [x, y - 1] },
        right: ->(x, y) { [x, y + 1] },
      }
  end

  def self.from_file(file_path)
    new(parse_file(file_path))
  end

  def self.parse_file(file_path)
    tubes = []

    File.open(file_path, "r") do |f|
      while (line = f.gets)
        tubes << line.chomp
      end
    end

    tubes
  end
end
