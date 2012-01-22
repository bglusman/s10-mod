module PokerHelp
  class Player
    attr_accessor :chips, :other_players, :fake_deck
    attr_reader   :name
    def initialize(name, chips=500)
      @chips  = chips
      @name   = name
    end

    def hand=(cards)
      @hand =cards
    end

    def hand
      Hand.new(@hand)
    end

    def receive_cards(hand)
      @hand = (@hand.nil? ? hand : @hand + hand)
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
      case
      when (rand < 0.1)
        if choices.include?(:raise)
          bet(bet_size*2, pot)
          return :raise
        else
          bet(bet_size, pot)
          return :call
        end
      when (hand.size <= 3) && (hand > fake_hands.max)
        if choices.include?(:raise)
          bet(bet_size*2, pot)
          return :raise
        else
          bet(bet_size, pot)
          return :call
        end
      when hand.size > 2 && choices.include?(:raise)
        if have_pot_odds?(bet_size, pot) && hand > fake_hands.max
          bet(bet_size*2, pot)
          return :raise
        else
          return :fold
        end
      when hand.size > 2 && choices.include?(:bet)
        if have_pot_odds?(bet_size, pot) && hand > fake_hands.max
          bet(bet_size, pot)
          return :bet
        else
          return :check
        end
      else
        if hand.size > 2 && choices.include?(:call)
          if have_pot_odds?(bet_size, pot)
            bet(bet_size, pot)
            return :call
          else
            return :fold
          end
        end
      end
    end

    def have_pot_odds?(bet_size, pot)
      (Utility.outs_odds_probability_hash(hand,
          fake_deck).fetch(:probability) > bet_size.to_f/pot.total)
    end

    def <=>(other)
      hand <=> other.hand
    end

    def simulated_other_hands(count)
      self.fake_deck = Deck.new
      self.fake_deck.burn(hand.to_a)
      fakes = []
      count.times { fakes << Hand.new(self.fake_deck.deal(hand.size)) }
      fakes
    end


  end
end