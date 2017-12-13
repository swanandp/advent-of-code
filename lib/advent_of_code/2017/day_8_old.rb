class Day8Old
  attr_accessor :input, :parser, :parsed_input

  def initialize(input)
    self.input = input
    self.parser = InputParser.new
    self.parsed_input = parse
  end

  class << self
    attr_accessor :identifiers
  end

  self.identifiers = {}

  def parse
    input.map do |line|
      parser.parse(line)
    end
  end

  def inspect
    %{#<#{self.class.name}:#{hash} @input=#{input[0..9]}, @parsed_input=#{parsed_input[0..9]}>}
  end

  def self.from_file(file_path)
    new(File.readlines(file_path).map(&:strip))
  end

  class InputParser < Parslet::Parser
    rule(:space) { match('\s').repeat(1) }
    rule(:space?) { space.maybe }

    rule(:positive_integer) { match('[0-9]').repeat(1).as(:int) >> space? }
    rule(:negative_integer) { (str('-') >> positive_integer).as(:minus) }
    rule(:integer) { positive_integer | negative_integer }

    rule(:increment) { str('inc') >> space? }
    rule(:decrement) { str('dec') >> space? }
    rule(:_if) { str('if') >> space? }
    rule(:equal_to) { str('==') >> space? }
    rule(:not_equal_to) { str('!=') >> space? }
    rule(:greater_than_eq) { str('>=') >> space? }
    rule(:less_than_eq) { str('<=') >> space? }
    rule(:greater_than) { str('>') >> space? }
    rule(:less_than) { str('<') >> space? }

    rule(:identifier) { match('[a-z]').repeat(1).as(:identifier) }

    rule(:operator) do
      (_if |
        increment |
        decrement |
        equal_to |
        not_equal_to |
        greater_than_eq |
        greater_than |
        less_than_eq |
        less_than).as(:operator)
    end

    rule(:operand) { integer | (identifier >> space?) }
    rule(:operation) { operand.as(:left) >> operator.as(:op) >> operand.as(:arg) }
    rule(:conditional) { operation.as(:computation) >> _if >> operation.as(:condition) }
    rule(:expression) { conditional | operation | operator | integer | identifier }

    root :expression
  end


  IntegerLiteral = Struct.new(:int) do
    def eval
      i = int.to_i

      def i.inc(amount)
        self + amount
      end

      def i.dec(amount)
        self + amount
      end

      i
    end
  end

  Operator = Struct.new(:operator) do
    def eval
      operator.strip
    end
  end

  IdentifierLiteral = Struct.new(:identifier) do
    def eval
      Day8.identifiers[identifier] ||= 0
      Day8.identifiers[identifier]
    end
  end

  Operation = Struct.new(:left, :op, :arg) do
    def eval
      left.eval.send(op.eval, arg.eval)
    end
  end

  Conditional = Struct.new(:computation, :condition) do
    def eval
      computation.eval if condition.eval
    end
  end

  class InputParserT < Parslet::Transform
    rule(int: simple(:int)) { IntegerLiteral.new(int) }
    rule(identifier: simple(:identifier)) { IdentifierLiteral.new(identifier) }
    rule(op: simple(:operator)) { Operator.new(op) }

    rule(
      left: simple(:left),
      op: simple(:op),
      arg: simple(:arg),
    ) do
      Operation.new(left, op, arg)
    end

    rule(
      computation: subtree(:computation),
      condition: subtree(:condition)
    ) do
      Conditional.new(computation, condition)
    end
  end

  def self.parse(string)
    InputParser.new.parse(string)
  end

  def self.transform(string)
    InputParserT.new.apply(parse(string))
  end
end
