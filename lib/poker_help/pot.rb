module PokerHelp
  class Pot
    attr_accessor :bets, :player, :bet_to_call, :history
    def initialize
      @bets     =[]
      @history  =[]
    end

    def total
      bets.reduce(&:+)
    end

    def bet(amount, bettor)
      bet_to_call = amount
      bets << amount
      history << [amount, bettor]
      player = bettor
    end
  end
end