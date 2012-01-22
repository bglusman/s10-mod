module PokerHelp
  class Round
    attr_reader :players, :game, :deck, :pot, :board, :betting
    attr_accessor :winner, :flop, :turn, :river, :post_turn_event, :raises, :state
    include Actions
    def initialize(game, players, betting)
      @game = game
      @players = players
      @players.each {|p| p.hand = nil}
      @betting = betting
      @deck = Deck.new
      @pot = Pot.new
      @pot.current_bet_size = current_bet_size
      @flop =  []
      @turn = nil
      @river = nil
      @winner = nil
      @post_turn_event = false
      @state = :blind_bet
      @raises = 0
    end

    def current_bet_size
      post_turn_event ? betting[:big_blind_size] * 2 : betting[:big_blind_size]
    end

    def current_choices
      case state
      when :blind_bet, :bet_or_raise_made
        [:fold, :call, :raise]
      when :first_action
        [:check, :bet, :fold]
      when :raise_limit_reached
        [:fold, :call]
      else
        raise "Invalid state"
      end
    end

    def board
      [flop, turn, river].flatten
    end

    def update_state(action, player)
      players.delete(player)              if action == :fold
      self.raises += 1                    if action == :raise
      self.state  = :raise_limit_reached  if self.raises == betting[:raise_limit]
      self.state  = :bet_or_raise_made    if [:bet, :raise].include?(action)
      self.winner = players.first if players.size == 1
    end

  end
end