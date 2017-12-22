class Day22
  attr_accessor :nodes, :converter, :bounds, :direction,
                :infected, :cleaned, :position, :file_path

  def initialize(file_path)
    self.file_path = file_path

    reset
  end

  def reset
    self.nodes = {}
    self.bounds = Hash.new(0)
    self.position = [0, 0]
    self.infected = 0
    self.cleaned = 0
    self.direction = :up

    create_nodes(readlines(file_path))
  end

  def burst
    self.direction = determine_direction(*position)

    if infected?(*position)
      clean!(*position)
    elsif clean?(*position)
      infect!(*position)
    end

    move
  end

  def move
    self.position = directions[direction].(*position)
    insert_node(*position, ".") unless nodes.dig(*position)
  end

  def determine_direction(x, y)
    if infected?(x, y)
      relative_direction(:right)
    else
      relative_direction(:left)
    end
  end

  def clean?(x, y)
    nodes[x][y] == "."
  end

  def infected?(x, y)
    nodes[x][y] == "#"
  end

  def infect!(x, y)
    return if infected?(x, y)
    self.infected += 1
    self.nodes[x][y] = "#"
  end

  def clean!(x, y)
    return if clean?(x, y)
    self.cleaned += 1
    self.nodes[x][y] = "."
  end

  def print_nodes
    puts "Facing #{direction}"
    puts
    ((-1 * bounds[:y_max])..(-1 * bounds[:y_min])).each do |iy|
      (bounds[:x_min]..bounds[:x_max]).each do |x|
        y = -iy
        print_char =
          if position == [x, y]
            if infected?(x, y)
              "I"
            elsif clean?(x, y)
              "C"
            end
          else
            nodes[x][y]
          end

        print print_char || " "
      end

      puts ""
    end
  end

  # Standard cartesian coordinate system
  def relative_direction(dir)
    relative_directions[direction][dir]
  end

  def relative_directions
    {
      down: {
        down: :up,
        up: :down,
        left: :right,
        right: :left,
      },
      up: {
        down: :down,
        up: :up,
        left: :left,
        right: :right,
      },
      left: {
        down: :right,
        up: :left,
        left: :down,
        right: :up,
      },
      right: {
        down: :left,
        up: :right,
        left: :up,
        right: :down,
      },
    }
  end

  def directions
    @directions ||=
      {
        down: ->(x, y) { [x, y - 1] },
        up: ->(x, y) { [x, y + 1] },
        left: ->(x, y) { [x - 1, y] },
        right: ->(x, y) { [x + 1, y] },
      }
  end

  # INPUT PARSING
  # value should 1 char for best printing
  def insert_node(x, y, value)
    self.nodes[x] ||= {}
    self.nodes[x][y] = value

    self.bounds[:x_max] = x if x > bounds[:x_max]
    self.bounds[:x_min] = x if x < bounds[:x_min]
    self.bounds[:y_max] = y if y > bounds[:y_max]
    self.bounds[:y_min] = y if y < bounds[:y_min]

    value
  end

  # Center is the origin
  def create_nodes(lines)
    nodes = {}
    size = lines.length
    width = size / 2

    self.converter = index_0_to_cartesian.curry[width]

    lines.each_with_index do |row, r|
      row.split("").each_with_index do |char, c|
        x, y = converter.(r, c)
        insert_node(x, y, char)
      end
    end

    nodes
  end

  def index_0_to_cartesian
    ->(width, r, c) {
      [c - width, width - r]
    }
  end

  def readlines(file_path)
    File.readlines(file_path).map(&:strip)
  end
end
