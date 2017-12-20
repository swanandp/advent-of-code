class Day15
  attr_accessor :factor_a, :factor_b, :seed_a, :seed_b, :large, :output_part_1, :output_part_2

  def initialize(seed_a, seed_b)
    self.seed_a = seed_a
    self.seed_b = seed_b

    self.factor_a = 16807
    self.factor_b = 48271
    self.large = 2147483647
  end

  def brute_force_part_1(num_iterations = 40_000_000)
    count = 0
    a = seed_a
    b = seed_b

    num_iterations.times do
      a = (a * factor_a) % large
      b = (b * factor_b) % large

      if a & 0xffff == b & 0xffff
        count += 1
      end
    end

    self.output_part_1 = count
  end

  def solve_part_2(num_iterations = 40_000_000)
    ag = self.ag(num_iterations)
    bg = self.bg(num_iterations)
    count = 0

    while true
      a = ag.next
      b = bg.next

      if a & 0xffff == b & 0xffff
        count += 1
      end
    end

  rescue StopIteration
    puts "Exhausted"
  ensure
    self.output_part_2 = count
  end

  def ag(num_iterations = 40_000_000)
    Enumerator.new do |yielder|
      a = seed_a

      num_iterations.times do
        a = (a * factor_a) % large

        yielder.yield a if a % 4 == 0
      end
    end
  end

  def bg(num_iterations = 40_000_000)
    Enumerator.new do |yielder|
      b = seed_b

      num_iterations.times do
        b = (b * factor_b) % large

        yielder.yield b if b % 8 == 0
      end
    end
  end

  def next
    ->(seed, factor, divisor) {
      (seed * factor) % divisor
    }
  end

  def next_a(previous = seed_a)
    (previous * factor_a) % large
  end

  def next_b(previous = seed_b)
    (previous * factor_b) % large
  end
end
