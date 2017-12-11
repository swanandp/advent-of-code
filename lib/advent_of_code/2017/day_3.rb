class Day3
  attr_accessor :x, :output_part_1, :output_part_2, :k, :k2_1, :k2_1_sq, :matrix

  def initialize(x)
    self.x = x
    calculate_anchors!
    solve_part_1
  end

  def solve_part_1
    self.output_part_1 = center_distances.min + k
  end

  def solve_part_2
    sums = 75.times.reduce({}) { |m, i| m[i + 1] = Day3.new(i + 1).sum; m }
    _, v = sums.detect do |_, s|
      x < s
    end

    self.output_part_2 = v
  end

  def output_part_2
    solve_part_2
    @output_part_2
  end

  class << self
    attr_accessor :sums
  end

  self.sums = {
    1 => 1,
    2 => 1,
  }

  def sum
    if self.class.sums[x]
      return self.class.sums[x]
    end

    s = neighbours.sum do |n|
      Day3.new(n).sum
    end

    self.class.sums[x] = s
  end

  def neighbours
    raise ArgumentError, "You gotta be kidding me..." if x < 1
    return neighbours_for_minnows[x] if (1..9).include?(x)

    if (c, _ = corner?)
      return corner_neighbours(corner_functions[c].(k - 1))[c]
    end

    edge_neighbours(* edge?)
  end

  def neighbours_for_minnows
    {
      1 => [1],
      2 => [1],
      3 => [1, 2],
      4 => [1, 2, 3],
      5 => [1, 4],
      6 => [1, 4, 5],
      7 => [1, 6],
      8 => [1, 2, 6, 7],
      9 => [1, 2, 8],
    }
  end

  def corner_neighbours(prev)
    {
      bottom_right: [x - 1, prev, prev + 1],
      bottom_left: [x - 1, prev],
      top_left: [x - 1, prev],
      top_right: [x - 1, prev],
    }
  end

  def edge_neighbours(edge, next_c, prev_c)
    a = f_of_a(edge).(k - 1)

    d_next = next_c - x
    d_prev = x - prev_c

    case edge
    when :right
      right_neighbours(a, d_next, d_prev)
    when :bottom
      bottom_neighbours(a, d_next, d_prev)
    else
      other_neighbours(a, d_next, d_prev)
    end
  end

  def right_neighbours(a, d_next, d_prev)
    case d_next
    when 1
      [x - 1, a, a - 1]
    else
      case d_prev
      when 1
        [x - 1, a - d_next + 2]
      when 2
        [x - 1, x - 2, a - d_next + 1, a - d_next + 2]
      else
        [x - 1, a - d_next, a - d_next + 1, a - d_next + 2]
      end
    end
  end

  def other_neighbours(a, d_next, d_prev)
    case d_next
    when 1
      [x - 1, a, a - 1]
    else
      case d_prev
      when 1
        [x - 1, x - 2, a - d_next + 1, a - d_next + 2]
      else
        [x - 1, a - d_next, a - d_next + 1, a - d_next + 2]
      end
    end
  end

  def bottom_neighbours(a, d_next, d_prev)
    case d_next
    when 1
      [x - 1, a, a - 1, a + 1]
    else
      case d_prev
      when 1
        [x - 1, x - 2, a - d_next + 1, a - d_next + 2]
      else
        [x - 1, a - d_next, a - d_next + 1, a - d_next + 2]
      end
    end
  end

  def corner?
    corners.detect do |(_, n)|
      n == x
    end
  end

  # Return [edge_name, next_corner, prev_corner]
  def edge?
    return corner? if corner?

    if corners[:top_left] > x && x > corners[:top_right]
      [:top, corners[:top_left], corners[:top_right]]
    elsif corners[:bottom_left] > x && x > corners[:top_left]
      [:left, corners[:bottom_left], corners[:top_left]]
    elsif corners[:bottom_right] > x && x > corners[:bottom_left]
      [:bottom, corners[:bottom_right], corners[:bottom_left]]
    elsif corners[:top_right] > x && x > corner_functions[:bottom_right].(k - 1)
      [:right, corners[:top_right], corner_functions[:bottom_right].(k - 1)]
    else
      fail("Impossible case!")
    end
  end

  def calculate_anchors!
    sqrt_ceil = Math.sqrt(x).ceil
    self.k2_1 = sqrt_ceil.odd? ? sqrt_ceil : 1 + sqrt_ceil
    self.k2_1_sq = k2_1 ** 2
    self.k = k2_1 / 2
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

  def corners
    corner_functions.reduce({}) do |c, (l, f)|
      c[l] = f.(k)
      c
    end
  end

  def corner_functions
    {
      bottom_right: ->(n) { (n * 2 + 1) ** 2 },
      bottom_left: ->(n) { ((n * 2 + 1) ** 2) - 2 * n },
      top_left: ->(n) { ((n * 2 + 1) ** 2) - 4 * n },
      top_right: ->(n) { ((n * 2 + 1) ** 2) - 6 * n },
    }
  end

  def f_of_a(edge)
    case edge
    when :right
      corner_functions[:top_right]
    when :top
      corner_functions[:top_left]
    when :left
      corner_functions[:bottom_left]
    else # :bottom
      corner_functions[:bottom_right]
    end
  end
end
