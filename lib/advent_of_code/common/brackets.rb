# frozen_string_literal: true

def log(str = "")
  puts str if @debug
end

def brackets_valid?(str)
  log "Evaluating: `#{str}`"
  log
  left_brackets = %w{[ ( \{}
  right_brackets = %w{] ) \}}
  matching_bracket = {
    '}' => '{',
    '{' => '}',
    ']' => '[',
    '[' => ']',
    ')' => '(',
    '(' => ')',
  }
  stack = []

  str.each_char do |c|
    log "Processing #{c}"

    if left_brackets.include?(c)
      stack.push(c)
      log "Found left `#{c}`, pushed. stack: `#{stack.join("")}`"
    elsif right_brackets.include?(c) && c == matching_bracket[stack[-1]]
      log "Matched right to left `#{c}`, popped: `#{stack.pop}`, stack: `#{stack.join('')}`"
    else
      log "No match. c: `#{c}`, last_in_stack: `#{matching_bracket[stack[-1]]}`, stack: `#{stack.join('')}`"
    end
  end

  stack.empty?
end

tests = {
  "()" => true,
  "()[]{}" => true,
  "(]" => false,
  "([])" => true,
  "{[]}" => true,
  "([)]" => false,
  "" => true,
  "(((((((())))))))" => true,
  "(((((((()))))))" => false,
}

@debug = false

tests.each do |k, v|
  log "Failed for `#{k}`" unless brackets_valid?(k) == v
end
