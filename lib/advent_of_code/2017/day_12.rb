class Day12
  attr_accessor :graph

  # {
  #   0: [2],
  #   1: [1],
  #   2: [0, 3, 4],
  #   1: [1],
  # }
  def initialize(graph)
    self.graph = graph
  end

  def count(node, visited = {})
    visited[node] = true

    1 + graph[node].sum do |child|
      next 0 if visited[child]

      visited[child] = true
      count(child, visited)
    end
  end

  def number_of_groups
    visited = {}
    groups = 0

    graph.each do |node, _|
      if visited[node]
        next
      end

      count(node, visited)
      groups += 1
    end

    groups
  end

  def self.from_file(file_path)
    graph = {}

    File.open(file_path, "r") do |f|
      while (line = f.gets)
        root, leaves = line.strip.split(" <-> ")
        graph[root.to_i] = leaves.scanf("%d%s") { |(x, _)| x }
      end
    end

    new(graph)
  end
end
