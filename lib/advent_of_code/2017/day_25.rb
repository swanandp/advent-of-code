class Day25
  attr_accessor :tape, :steps_taken, :current_state

  def initialize
    reset
  end

  def reset
    self.tape = Tape.new
    self.steps_taken = 0
    self.current_state = :a
  end

  def run(steps = 10, debug = true)
    steps.times {
      advance
      tape.nice_print if debug
    }
  end

  def advance
    actions = state_machine.dig(current_state, tape.value)

    tape.write(actions.dig(:write))
    tape.move(actions.dig(:move))
    self.current_state = actions.dig(:next_state)
  end

  def state_machine_sample
    @state_machine_sample ||= {
      a: {
        0 => {
          write: 1,
          move: :right,
          next_state: :b,
        },
        1 => {
          write: 0,
          move: :left,
          next_state: :b,
        },
      },

      b: {
        0 => {
          write: 1,
          move: :left,
          next_state: :a,
        },
        1 => {
          write: 1,
          move: :right,
          next_state: :a,
        },
      },
    }
  end

  def state_machine
    @state_machine ||= {
      a: {
        0 => {
          write: 1,
          move: :right,
          next_state: :b,
        },
        1 => {
          write: 0,
          move: :left,
          next_state: :f,
        },
      },

      b: {
        0 => {
          write: 0,
          move: :right,
          next_state: :c,
        },
        1 => {
          write: 0,
          move: :right,
          next_state: :d,
        },
      },

      c: {
        0 => {
          write: 1,
          move: :left,
          next_state: :d,
        },
        1 => {
          write: 1,
          move: :right,
          next_state: :e,
        },
      },

      d: {
        0 => {
          write: 0,
          move: :left,
          next_state: :e,
        },
        1 => {
          write: 0,
          move: :left,
          next_state: :d,
        },
      },

      e: {
        0 => {
          write: 0,
          move: :right,
          next_state: :a,
        },
        1 => {
          write: 1,
          move: :right,
          next_state: :c,
        },
      },

      f: {
        0 => {
          write: 1,
          move: :left,
          next_state: :a,
        },
        1 => {
          write: 1,
          move: :right,
          next_state: :a,
        },
      },
    }
  end

  class Tape
    attr_accessor :x, :grid, :x_max, :x_min

    def initialize
      self.x = 0
      self.grid = Hash.new(0)
      self.x_max = 0
      self.x_min = 0
    end

    def value
      grid[x]
    end

    def move(direction)
      self.x = directions[direction].(x)

      self.x_max = x if x > x_max
      self.x_min = x if x < x_min
    end

    def write(value)
      self.grid[x] = value
    end

    def directions
      @directions ||= {
        left: ->(x) { x - 1 },
        right: ->(x) { x + 1 },
      }
    end

    def nice_print(debug = false)
      print_range = ((x_min - 3)..(x_max + 3))

      print_range.each do |c|
        char =
          if c == x
            "[#{grid[c]}]"
          else
            grid[c]
          end

        print "#{char}\t"
      end

      puts ""

      if debug
        print_range.each { |_| print "-" * 10 }
        puts ""
        print_range.each { |c| print "#{c}\t" }
        puts ""
      end
    end
  end

  class Parser
    def initial
      "Begin in state %s."
    end

    def num_steps
      "Perform a diagnostic checksum after %d steps."
    end

    def state_begin
      "In state %s:"
    end

    def state
      <<~STATE
        If the current value is %d:
          - Write the value %d.
          - Move one slot to the %s.
          - Continue with state %s.
      STATE
    end
  end

  def parse(file_path)
    File.open(file_path, "r") do |f|
      while (line = f.gets)
        root, leaves = line.strip.split(" <-> ")
        graph[root.to_i] = leaves.scanf("%d%s") { |(x, _)| x }
      end
    end
  end
end
