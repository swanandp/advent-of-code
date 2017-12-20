class Day13
  attr_accessor :firewall, :output_part_1

  def initialize(firewall)
    self.firewall = firewall
  end

  def solve_part_1
    self.output_part_1 = firewall.sum do |(depth, range)|
      next 0 if depth == 0
      frequency = 2 * (range - 1)

      if depth % frequency == 0
        depth * range
      else
        0
      end
    end
  end

  def self.from_file(file_path)
    firewall = {}

    File.open(file_path, "r") do |f|
      while (line = f.gets)
        depth, range = line.strip.scanf("%d:%d")
        firewall[depth] = range
      end
    end

    new(firewall)
  end
end
