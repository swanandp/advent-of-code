def sample_input
  <<~INPUT
    Time:      7  15   30
    Distance:  9  40  200
  INPUT
end

def combinations(input)
  times_input, distances_input = input.split("\n")

  t = times_input.split(":").map(&:strip).last.gsub(/\s+/, "").to_i
  d = distances_input.split(":").map(&:strip).last.gsub(/\s+/, "").to_i
  l = 0

  (t + 1).times do |j|
    if d < (j * (t - j))
      break
    else
      l += 1
    end
  end

  (t + 1) - 2 * l
end

pp combinations(sample_input)
pp combinations(DATA.read)

__END__
Time:        61     70     90     66
Distance:   643   1184   1362   1041
