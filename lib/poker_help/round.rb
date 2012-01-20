module PokerHelp
  class Round
    attr_reader :players, :game, :deck, :pot, :board, :betting
    attr_accessor :winner, :flop, :turn, :river, :post_turn_event
    include Actions
    def initialize(game, players, betting)
      @game = game
      @players = players
      @betting = betting
      @deck = Deck.new
      @pot = Pot.new
      @flop =  []
      @turn = nil
      @river = nil
      @winner = nil
      @post_turn_event = false
    end

    def current_bet_size
      post_turn_event ? betting[:big_blind_size] * 2 : betting[:big_blind_size]
    end

    def board
      [flop, turn, river].flatten
    end

    def update_players(action, player)
      players.delete(player) if action == :fold
      self.winner = players.first if players.size == 1
    end

  end
end