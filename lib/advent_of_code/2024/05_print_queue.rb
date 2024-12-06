# frozen_string_literal: true

section = :rules
order = []
updates = []

DATA.each_line do |line|
  if line.strip.empty?
    section = :updates
    next
  end

  case section
  when :rules
    order << line.split("|").map(&:to_i)
  else
    # :updates
    updates << line.split(",").map(&:to_i)
  end
end

lt_order = order.reduce({}) do |lt, (l, r)|
  lt[l] ||= []
  lt[l] << r
  lt
end

gt_order = order.reduce({}) do |gt, (l, r)|
  gt[r] ||= []
  gt[r] << l
  gt
end

correct = []
incorrect = []

updates.each_with_index do |line, i|
  sorted_line = line.sort do |x, y|
    if lt_order[x]&.include?(y)
      -1
    elsif gt_order[x]&.include?(y)
      +1
    else
      0
    end
  end

  if line == sorted_line
    correct << line
  else
    incorrect << sorted_line
  end
end

answer_part_1 = correct.sum do |line|
  line[line.length / 2]
end

answer_part_2 = incorrect.sum do |line|
  line[line.length / 2]
end

puts "Part 1: #{answer_part_1}"
puts "Part 2: #{answer_part_2}"

__END__
47|53
97|13
97|61
97|47
75|29
61|13
75|53
29|13
97|29
53|29
61|53
97|53
61|29
47|13
75|47
97|75
47|61
75|61
47|29
75|13
53|13

75,47,61,53,29
97,61,53,29,13
75,29,13
75,97,47,61,53
61,13,29
97,13,75,29,47
