module PokerHelp
  class Player
    attr_accessor :chips, :hand, :other_players
    def initialize(chips=500)
      @chips = chips
    end

    def receive_cards(hand)
      @hand = @hand.nil? ? hand : @hand + hand
    end

    def fold
      raise FoldError if @hand.nil?
      @hand = nil
    end

    def bet(amount, pot)
      raise OverbetError if amount > chips
      self.chips -= amount
      pot.bet(amount, self)
    end

    def choose(pot, bet_size, choices)
      fake_hands = simulated_other_hands(other_players.count)
#      if hand.size <= 3 && hand > fake_hands.max

      #while empty presumably they check always?
      return :fold
    end

    def <=>(other)
      hand <=> other.hand
    end

    def simulated_other_hands(count)
      deck = Deck.new
      deck.burn(hand.to_a)
      fakes = []
      count.times { fakes << Hand.new(deck.deal(hand.size)) }
    end

  end
end