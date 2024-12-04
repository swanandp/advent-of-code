# frozen_string_literal: true
# started 7pm
# simulate a two player tennis match(extend to 4 player) (20-30 min)
# should handle input players details
# alternate serves.
#   print winners.
#     test cases (if the candidate is a craftsperson)

# turn based game
# serve alternates
# unique point system

# initialize
# accept move
# advance game if valid move
# return state
class TennisMatch
  attr_accessor :player_1, :player_2, :match, :max_sets, :current_set, :current_game, :status

  # sets:
  # [
  #   [6, 3], # handle tie-break later
  #   [3, 6],
  # ]
  def initialize(player_1, player_2, max_sets = 1)
    self.player_1 = player_1 # opening serve
    self.player_2 = player_2
    puts "#{player_1} starts serve. #{player_2} receives."
    self.max_sets = ([1, 3, 5].include?(max_sets)) ? max_sets : 1
    self.match = { score: [], sets: [] }
    self.status = :in_progress # player_1_win | player_2_win

    # 0-index track score at every move like 0-0, 1-0, 1-1, 2-1, 5-3, 6-3
    self.current_set = reset_set(nil)

    # 0-index track score at every move like 0-0, 15-0, 30-0, 30-15, 40-15, W
    self.current_game = reset_game(nil)
  end

  def next_server(player)
    raise "Please set player_1 first" if player_1.nil? || player_1.empty?
    raise "Please set player_2 first" if player_2.nil? || player_2.empty?

    @next_server ||= {
      player_1 => player_2,
      player_2 => player_1,
    }

    @next_server[player] || player_1
  end

  def game

  end

  def game_won?
    s_total, r_total = 0, 0

    current_game[:score].each do |(s, r)|
      s_total += s
      r_total += r
    end

    if s_total >= 4 && s_total - r_total >= 2
      # server won
      puts "#{current_game[:server]} wins on their serve"
      current_game[:server]
    elsif r_total >= 4 && r_total - s_total >= 2
      # receiver won
      winner = next_server(current_game[:server])
      puts "#{winner} wins a serve break from #{current_game[:server]}"
      winner
    else
      false
    end
  end

  def set_won?
    s_total, r_total = 0, 0

    current_set[:score].each do |(s, r)|
      s_total += s
      r_total += r
    end

    if s_total >= 6 && s_total - r_total >= 2
      # server won
      current_set[:server]
    elsif r_total >= 6 && r_total - s_total >= 2
      # receiver won
      next_server(current_set[:server])
    else
      false
    end
  end

  def match_won?
    s_total, r_total = 0, 0

    match[:score].each do |(s, r)|
      s_total += s
      r_total += r
    end

    winning_total = max_sets / 2 + 1

    if s_total == winning_total
      player_1
    elsif r_total == winning_total
      player_2
    else
      false
    end
  end

  def accept_move
    # serving player wins the point with 70% probability
    self.current_game[:score] << ((rand < 0.6) ? [1, 0] : [0, 1])

    if (game_winner = game_won?)
      self.current_set[:score] << ((current_game[:server] == game_winner) ? [1, 0] : [0, 1])
      self.current_set[:games] << current_game
      puts "#{current_game[:server]} finished serving."
      self.current_game = reset_game
      puts "#{current_game[:server]} to serve next."

      if (set_winner = set_won?)
        self.match[:score] << ((player_1 == set_winner) ? [1, 0] : [0, 1])
        self.match[:sets] << current_set
        puts "#{current_game[:server]} finished serving this set."
        self.current_set = reset_set
        puts "#{current_game[:server]} to serve next set."

        if (match_winner = match_won?)
          self.status = "#{match_winner} has won." # ugh, can be better
        end
      end
    end
  end

  def reset_game(server = current_game[:server])
    { server: next_server(server), score: [[0, 0]] }
  end

  def reset_set(server = current_set[:server])
    { server: next_server(server), score: [[0, 0]], games: [] }
  end

  def print_score
    puts %{#{match[:score].map(&:first).join("\t")}\t#{current_set[:score].map(&:first).join("\t")}\t#{current_game[:score].map(&:first).join("\t")}}
    puts %{#{match[:score].map(&:last).join("\t")}\t#{current_set[:score].map(&:last).join("\t")}\t#{current_game[:score].map(&:last).join("\t")}}
  end
end

class GameEngine
  attr_accessor :game

  def toss_for_serve(player_1, player_2)
    if rand < 0.5 # equal chance of first serve
      [player_1, player_2]
    else
      [player_2, player_1]
    end
  end

  def start(player_1, player_2)
    @game = TennisMatch.new(player_1, player_2)
    counter = 5
    loop do
      @game.accept_move
      @game.print_score
      counter -= 1

      if @game.status == :in_progress || counter > 0
        next
      else
        puts @game.status.to_s
        break
      end
    end
  end
end

