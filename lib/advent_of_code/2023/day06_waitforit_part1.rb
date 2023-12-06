def sample_input
  <<~INPUT
    Time:      7  15   30
    Distance:  9  40  200
  INPUT
end

def combinations(input)
  times_input, distances_input = input.split("\n")

  times = times_input.split(":").map(&:strip).last.split(/\s+/).map(&:to_i)
  distances = distances_input.split(":").map(&:strip).last.split(/\s+/).map(&:to_i)

  times.each_with_index.map do |t, i|
    d = distances[i]
    l = 0

    (t + 1).times do |j|
      if d < (j * (t - j))
        break
      else
        l += 1
      end
    end

    (t + 1) - 2 * l
  end.reduce(1, &:*)
end

pp combinations(sample_input)
pp combinations(DATA.read)

__END__
Time:        61     70     90     66
Distance:   643   1184   1362   1041
