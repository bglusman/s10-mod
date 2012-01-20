module PokerHelp
  class Deck
    include Enumerable
    extend Forwardable
    def_delegators :@cards, :each
    #alias :count :size

    def initialize
      @cards = []
      Card::SUITS.each_byte do |suit|
        # careful not to double include the aces...
        Card::FACES[1..-1].each_byte do |face|
          @cards.push(Card.new(face.chr, suit.chr))
        end
      end
      shuffle
    end

    def shuffle
      @cards = @cards.sort_by { rand }
      return self
    end

    def deal(count=1)
      @cards.pop(count)
    end

    def burn(burn_cards=1)
      if burn_cards.is_a?(Integer) && size < burn_cards
        return false
      elsif burn_cards.is_a?(Integer)
        burn_cards.times{deal}
        return true
      elsif burn_cards.is_a?(Card) || burn_cards.is_a?(String)
        burn_cards = [burn_cards]
      end

      burn_cards.map! do |c|
        c = Card.new(c) unless c.class == Card
        @cards.delete(c)
      end
      true
    end

    # return count of the remaining cards
    def size
      @cards.size
    end

    def empty?
      @cards.empty?
    end
  end
end