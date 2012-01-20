module PokerHelp
  class Player
    attr_accessor :chips, :hand
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

    def choose(pot, bet_size)
      #while empty presumably they check always?
      return :fold
    end

    def <=>(other)
      hand <=> other.hand
    end

  end
end