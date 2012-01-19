module PokerHelp
  class Round
    attr_reader :players, :game, :deck, :pot
    include Actions
    def initialize(game, players, betting)
      @game = game
      @players = players
      @betting = betting
      @deck = Deck.new
      @pot = Pot.new
    end


  end
end