class Day7
  attr_accessor :input, :parsed_input, :children, :weights, :tree, :root

  def initialize(input)
    self.input = input
    self.parsed_input = parse(input)
    self.tree = {}
    self.children = {}
    self.weights = {}
    solve_part_1
  end

  def solve_part_1
    parsed_input.each do |node, (weight, dependents)|
      tree[node] ||= nil
      weights[node] ||= weight
      children[node] ||= dependents

      dependents.each do |dependent|
        tree[dependent] ||= node
      end
    end

    root = children.first.first

    while tree[root] do
      root = tree[root]
    end

    self.root = root
  end

  def parse(input)
    input.reduce({}) do |acc, line|
      root, leaves = line.strip.split(" -> ")
      match = root.match(/^(?<node>[a-z]+)\s\((?<weight>\d+)\)/i)
      node = match[:node]
      weight = match[:weight].to_i
      dependents = leaves.nil? ? [] : CSV.parse_line(leaves, col_sep: ",").map(&:strip)
      acc[node] = [weight, dependents]
      acc
    end
  end

  def child_weight_at(node)
    children[node].sum { |child| weight_at(child) }
  end

  def weight_at(node)
    weights[node] + child_weight_at(node)
  end

  def balanced?(node = root)
    # since only 1 child is different, this will be max 2
    children_weights(node).keys.length < 2
  end

  def fault(node = root)
    return if balanced?(node)

    if children[node].all? { |child| balanced?(child) }
      # one of the child's weight is a problem
      faulty, good = children_weights(node).sort_by { |_, v| v.length }
      return weights[faulty[1][0]] - ( faulty[0] - good[0] )
    else
      # problem is somewhere down the stack
      children[node].each do |child|
        f = fault(child)
        break f if f
      end
    end
  end

  def children_weights(node = root)
    children[node].reduce({}) do |set, child|
      child_weight = weight_at(child)
      set[child_weight] ||= []
      set[child_weight] << child
      set
    end
  end

  def self.from_file(file_path)
    new(File.readlines(file_path))
  end
end
