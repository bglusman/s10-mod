module PokerHelp
  class Simulation
    attr_accessor :round, :players, :game, :betting

    def initialize(players, &block)
      @players = []
      players.times {@players << Player.new }
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
      round = Round.new(game, players, betting)
      game.action_sequence.each {|action| round.send(action); next if round.winner}
    end
  end
end