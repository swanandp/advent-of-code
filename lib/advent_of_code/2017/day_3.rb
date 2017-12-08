class Day3
  attr_accessor :x, :output_part_1, :output_part_2, :k, :k2_1, :k2_1_sq

  def initialize(x)
    self.x = x
    solve_part_1
    # solve_part_2
  end

  def solve_part_1
    sqrt_ceil = Math.sqrt(x).ceil
    self.k2_1 = sqrt_ceil.odd? ? sqrt_ceil : 1 + sqrt_ceil
    self.k2_1_sq = k2_1 ** 2
    self.k = k2_1 / 2
    self.output_part_1 = center_distances.min + k
  end

  def center_distances
    centers.map { |c| (c - x).abs }
  end

  def centers
    [
      k2_1_sq - 1 * k,
      k2_1_sq - 3 * k,
      k2_1_sq - 5 * k,
      k2_1_sq - 7 * k,
    ]
  end
end
