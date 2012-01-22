module PokerHelp
  class Simulation
    attr_accessor :round, :players, :game, :betting

    PLAYER_NAMES = ["A1", "B2", "C3", "D4", "E5", "F6", "G7", "H8", "I9", "J10"]

    def initialize(players, &block)
      @players = []
      name = PLAYER_NAMES.each
      players.times {@players << Player.new(name.next) }
      @players.each do |p|
        players_copy = @players.dup
        players_copy.delete(p)
        p.other_players = players_copy
      end
      @game = Game.new
      @betting = Config.bet_parameters
      instance_eval &block if block_given?
    end

    def run
      round = Round.new(game, players.dup, betting)
      game.action_sequence.each {|action| round.send(action); next if round.winner}
      players.rotate!
    end
  end
end