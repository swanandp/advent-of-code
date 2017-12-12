class Day6
  attr_accessor :bank, :original_bank, :output_part_1, :output_part_2, :combinations, :steps

  def initialize(bank)
    self.original_bank = bank
    self.bank = original_bank.dup
    self.combinations = Set.new
    self.steps = 0
    solve_part_1
    # solve_part_2
  end

  def solve_part_1
    until combinations.include?(bank) do
      combinations.add(bank)
      self.steps += 1
      break if steps > 100_000
      largest = bank.max
      largest_index = bank.index(largest)
      dist = [largest / (bank.length - 1), 1].max

      ((largest_index + 1)..(bank.length - 1)).each do |i|
        if bank[largest_index] > 0
          bank[largest_index] -= dist
          bank[i] += dist
        end
      end

      (0..(largest_index - 1)).each do |i|
        if bank[largest_index] > 0
          bank[largest_index] -= dist
          bank[i] += dist
        end
      end

    end

    self.output_part_1 = steps
  end

  def self.from_file(file_path)
    new(CSV.parse(File.read(file_path), converters: :numeric).first)
  end
end
