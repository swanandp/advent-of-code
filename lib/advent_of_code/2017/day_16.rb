require "scanf"

class Day16
  attr_accessor :programs, :steps, :backup, :output_part_1

  def initialize(steps)
    self.steps = steps
    self.programs = ('a'..'p').to_a
  end

  def solve_part_1
    steps.each do |(move, *args)|
      self.send(move, *args)
    end

    self.output_part_1 = programs.join
  end

  def spin(x)
    self.programs = programs[(-1 * x)..-1] + programs[0..(programs.length - x - 1)]
  end

  def exchange(a, b)
    tmp = programs[a]
    self.programs[a] = programs[b]
    self.programs[b] = tmp
  end

  def partner(a, b)
    exchange(programs.index(a), programs.index(b))
  end

  def self.from_file(file_path)
    steps =
      CSV.parse_line(File.read(file_path)).map do |step|
        match = step.match(%r{^(?<move>[sxp])(?<a>[^/]+)\/?(?<b>\S+)?$}i)

        case match[:move]
        when "s"
          [:spin, match[:a].to_i]
        when "x"
          [:exchange, match[:a].to_i, match[:b].to_i]
        else
          [:partner, match[:a], match[:b]]
        end
      end

    new(steps)
  end

  class TwoSidedHash
    attr_accessor :hash, :inverse

    def initialize(hash)
      self.hash = hash
      self.inverse = hash.invert
    end

    def key(value)
      inverse[value]
    end

    def value(key)
      hash[key]
    end

    def swap_on_values(v1, v2)
      current_v1 = inverse[v1]
      current_v2 = inverse[v2]

      tmp = current_v1
      inverse[v1] = current_v2
      inverse[v2] = tmp

      tmp = hash[current_v1]
      hash[current_v1] = hash[current_v2]
      hash[current_v2] = tmp
    end

    def swap_on_keys(k1, k2)
      current_k1 = hash[k1]
      current_k2 = hash[k2]

      tmp = current_k1
      hash[k1] = current_k2
      hash[k2] = tmp

      tmp = inverse[current_k1]
      inverse[current_k1] = inverse[current_k2]
      inverse[current_k2] = tmp
    end
  end
end
