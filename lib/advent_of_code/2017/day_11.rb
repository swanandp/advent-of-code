class Day11
  attr_accessor :steps, :coordinates, :output_part_1, :output_part_2, :furthest

  def initialize(steps)
    self.steps = steps
    reset

    solve
  end

  def solve
    take_steps
    self.output_part_1 = distance_away
    self.output_part_2 = furthest
  end

  def take_steps
    self.furthest = 0

    steps.each do |step|
      movement = movements[step]
      self.coordinates = movement.(*coordinates)

      if distance_away > furthest
        self.furthest = distance_away
      end
    end
  end

  def distance_away
    self.coordinates.max_by { |c| c.abs }.abs
  end

  def reset
    self.coordinates = [0, 0, 0] # ordered: [x, y, z]
  end

  # Cubic coordinate system for hex grids by Amit Patel
  # https://www.redblobgames.com/grids/hexagons/#coordinates-cube
  def movements
    @movements ||= {
      "s" => -> (x, y, z) { [x, y - 1, z + 1] },
      "n" => -> (x, y, z) { [x, y + 1, z - 1] },
      "ne" => -> (x, y, z) { [x + 1, y, z - 1] },
      "se" => -> (x, y, z) { [x + 1, y - 1, z] },
      "nw" => -> (x, y, z) { [x - 1, y + 1, z] },
      "sw" => -> (x, y, z) { [x - 1, y, z + 1] },
    }
  end

  def self.from_file(file_path)
    new(CSV.parse_line(File.read(file_path)))
  end
end
