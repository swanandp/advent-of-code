require "set"

class Day01
  attr_accessor :file_path, :deltas

  def initialize(file_path)
    self.file_path = file_path
    self.deltas = File.readlines(file_path).map { |line| line.strip.to_i }
  end

  def self.run(file_path)
    puts "Part 1:"
    puts new(file_path).part_1
    puts ""

    puts "Part 2:"
    puts new(file_path).part_2
    puts ""
  end

  def part_1
    frequency = 0

    deltas.each do |delta|
      frequency += delta
    end

    puts frequency
  end

  def part_2
    frequency = 0
    seen_frequencies = Set.new
    seen_frequencies.add(frequency)

    deltas.cycle do |delta|
      frequency += delta

      unless seen_frequencies.add?(frequency)
        puts frequency
        break
      end
    end
  end
end

if __FILE__.include?($0)
  Day01.run(ARGV.first)
end
