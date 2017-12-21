class Day21
  attr_accessor :rules, :pattern

  def initialize(file_path)
    self.rules = parse(file_path)
    self.pattern = line_to_array(".#./..#/###")
  end

  def solve_part_1
    5.times do
      nice_print(pattern)
      iterate
    end

    pattern.join.count("#")
  end

  def iterate
    self.pattern = enhance
  end

  def enhance
    puts pattern.length

    if pattern.length == 2 || pattern.length == 3
      line_to_array(rules[array_to_line(pattern)])
    elsif pattern.length % 2 == 0 || pattern.length % 3 == 0
      join(
        split(pattern).map do |row|
          row.map do |smaller_array|
            line_to_array(rules[array_to_line(smaller_array)])
          end
        end
      )
    end
  end

  # utilities
  def split(array)
    l = array.length - 1

    if array.length % 2 == 0
      return split_2(array, l)
    end

    if array.length % 3 == 0
      split_3(array, l)
    end
  end

  def split_2(array, l)
    (0..l).each_slice(2).map do |r1, r2|
      (0..l).each_slice(2).map do |c1, c2|
        [
          [array[r1][c1], array[r1][c2]],
          [array[r2][c1], array[r2][c2]]
        ]
      end
    end
  end

  def split_3(array, l)
    (0..l).each_slice(3).map do |r1, r2, r3|
      (0..l).each_slice(3).map do |c1, c2, c3|
        [
          [array[r1][c1], array[r1][c2], array[r1][c3]],
          [array[r2][c1], array[r2][c2], array[r2][c3]],
          [array[r3][c1], array[r3][c2], array[r3][c3]],
        ]
      end
    end
  end

  def join(array)
    array.flat_map do |el|
      el[0].length.times.map do |i|
        el.map { |arr| arr[i] }.flatten
      end
    end
  end

  def array_to_line(array)
    array.map { |row| row.join }.join("/")
  end

  def line_to_array(line)
    line.split("/").map { |el| el.split("") }
  end

  def rotate(array, rotations = 1)
    rotations %= 4
    return array if rotations == 0
    return array.transpose.map { |el| el.reverse } if rotations == 1
    rotate(rotate(array, rotations - 1))
  end

  def flip(array)
    array.map { |el| el.reverse }
  end

  def nice_print(array)
    puts array.map { |el| el.join }.join("\n")
  end

  # Input parsing
  def parse(file_path)
    rules = {}

    File.open(file_path, "r") do |f|
      while (line = f.gets)
        key, expansion = line.strip.scanf("%s => %s")

        4.times do
          rules[key] = expansion
          array = line_to_array(key)
          rules[array_to_line(flip(array))] = expansion
          key = array_to_line(rotate(array))
        end
      end
    end

    rules
  end
end
