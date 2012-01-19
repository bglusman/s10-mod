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
      chips -= amount
      pot += amount
    end
  end
end