require "scanf"

class Day16
  attr_accessor :programs, :steps, :backup, :output_part_1, :output_part_2

  def initialize(steps)
    self.steps = steps
    self.programs = ('a'..'p').to_a
  end

  def solve_part_1
    dance

    self.output_part_1 = programs.join
  end

  def solve_part_2
    results = []
    results_hash = {} # only for fast look-ups

    until (key = programs.join) && results_hash.key?(key)
      results << key
      results_hash[key] = true
      dance
    end

    self.output_part_2 = results[1_000_000_000 % results.size]
    results
  end

  def dance
    steps.each do |(move, *args)|
      self.send(move, *args)
    end
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
end
