module PokerHelp
  class Simulation
    attr_accessor :round, :players, :game, :betting

    def initialize(players, &block)
      @players = []
      players.times {@players << Player.new }
      @game = Game.new
      @betting = Config.bet_parameters
      instance_eval &block if block_given?
    end

    def run
      round = Round.new(game, players, betting)
      game.action_sequence.each {|action| round.send(action)}
    end
  end
end