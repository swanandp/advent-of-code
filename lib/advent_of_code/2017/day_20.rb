require "scanf"

class Day20
  attr_accessor :particles, :output_part_1

  def initialize(particles)
    self.particles = particles
  end

  def closest
    t = 1_000_000

    _, i = self.particles.each_with_index.min_by do |(particle, i)|
      px = particle[:p][:x]
      py = particle[:p][:y]
      pz = particle[:p][:z]

      vx = particle[:v][:x]
      vy = particle[:v][:y]
      vz = particle[:v][:z]

      ax = particle[:a][:x]
      ay = particle[:a][:y]
      az = particle[:a][:z]

      dx = px + (vx * t) + 0.5 * (ax * (t ** 2))
      dy = py + (vy * t) + 0.5 * (ay * (t ** 2))
      dz = pz + (vz * t) + 0.5 * (az * (t ** 2))

      d = dx.abs + dy.abs + dz.abs

      p [i, d]

      d
    end

    self.output_part_1 = i
  end

  def self.from_file(file_path)
    new(parse(file_path))
  end

  def self.parse(file_path)
    particles = []

    File.open(file_path, "r") do |f|
      while (line = f.gets)
        px, py, pz, vx, vy, vz, ax, ay, az = line.scanf("p=<%d,%d,%d>, v=<%d,%d,%d>, a=<%d,%d,%d>")

        particles << {
          p: { x: px, y: py, z: pz },
          v: { x: vx, y: vy, z: vz },
          a: { x: ax, y: ay, z: az },
        }
      end
    end

    particles
  end
end
