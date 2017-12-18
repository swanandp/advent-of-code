class Day9
  attr_accessor :state, :stream, :score, :output_part_1

  def initialize(stream)
    self.stream = stream.strip
    reset
    solve_part_1
  end

  def reset
    self.score = 0

    self.state = {
      open_groups: 0,
      closed_groups: 0,
      garbage: false,
      ignore: false,
    }
  end

  def solve_part_1
    stream.each_char do |char|
      case char
      when "{" then
        emit(:group_opened)
      when "}" then
        emit(:group_closed)
      when "<" then
        emit(:garbage_opened)
      when ">" then
        emit(:garbage_closed)
      when "!" then
        emit(:next_char_ignored)
      else
        emit(:simple_character, char)
      end
    end

    self.output_part_1 = score
  end

  def self.from_file(file_path)
    new(File.read(file_path).strip)
  end

  # Encapsulation, so that we can swap in a stream processing library
  def emit(event, data = nil)
    self.process_event(event, data)
  end

  # Encapsulation, so that we can swap in a stream processing library
  def process_event(event, data)
    if state_of_ignore?
      state[:ignore] = false
      puts "Ignoring (#{event}, #{data}), because !."
      return
    end

    if event == :garbage_closed || event == :next_char_ignored
      puts "Processing (#{event}, #{data})."
      self.send(event) and return
    end

    if in_garbage_state?
      puts "Ignoring (#{event}, #{data}), because garbage."
      return
    end

    puts "Processing (#{event}, #{data})."
    self.send(event)
  end

  def state_of_ignore?
    state[:ignore]
  end

  def in_garbage_state?
    state[:garbage]
  end

  # when we see {
  def group_opened
    state[:open_groups] += 1
  end

  # when we see }
  def group_closed
    self.score += state[:open_groups]
    state[:open_groups] -= 1
    state[:closed_groups] += 1
  end

  # when we see <
  def garbage_opened
    state[:garbage] = true
  end

  # when we see >
  def garbage_closed
    state[:garbage] = false
  end

  # When we see !
  def next_char_ignored
    state[:ignore] = true
  end

  # When we characters apart from special ones
  def simple_character
    # do nothing
  end
end
