class Day24
  attr_accessor :nodes, :links

  def initialize(file_path)
    self.nodes, self.links = parse(file_path)
  end

  def bridges(node_id, starting_port, visited = {})
    return [] if visited[node_id]

    node = nodes[node_id]
    port_1, port_2 = node
    visited[node_id] = true

    linked_port =
      if starting_port == port_1
        port_2
      else
        port_1
      end

    possible_links = links[linked_port].reject do |linked_node_id|
      visited[linked_node_id] && linked_node_id == node_id
    end

    return [[node]] if possible_links.empty?

    possible_links.reduce([]) do |child_bridges, linked_node_id|
      bridges(linked_node_id, linked_port, visited.clone).map do |child_bridge|
        child_bridges << [node, *child_bridge]
      end

      child_bridges
    end
  end

  def strongest_bridge_for_port(starting_port = 0)
    links[starting_port].map do |node_id|
      strongest_bridge_for_node(node_id, starting_port)
    end.max_by do |bridge|
      bridge.flatten.sum
    end
  end

  def strongest_bridge_for_node(node_id, starting_port)
    bridges(node_id, starting_port).max_by do |bridge|
      bridge.flatten.sum
    end
  end

  def parse(file_path)
    nodes = {}
    links = {}

    File.open(file_path, "r") do |f|
      while (line = f.gets)
        port_1, port_2 = line.strip.scanf("%d/%d")
        node_id = nodes.size
        nodes[node_id] = [port_1, port_2]
        links[port_1] ||= Set.new
        links[port_2] ||= Set.new
        links[port_1].add(node_id)
        links[port_2].add(node_id)
      end
    end

    return nodes, links
  end

  def inspect_node(nodes, port_1, port_2)
    "#{nodes.size}-(#{port_1}/#{port_2})"
  end
end
