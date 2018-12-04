module Enumerable
  def frequency
    h = Hash.new(0); each { |v| h[v] += 1 }; h
  end
end
