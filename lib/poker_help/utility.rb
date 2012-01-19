module PokerHelp
  module Utility
    def count_outs(hand, deck, cards_remaining=1,
      targets = [:straight?, :flush?, :straight_flush?,
        :royal_flush?, :full_house?, :three_of_a_kind?, :two_pair?])

      candidates = {}

      deck.each do |card|
        deck_copy = Marshal.load( Marshal.dump(deck) )
        hand_copy = Marshal.load( Marshal.dump(hand) )
        hand_copy << card
        deck_copy.burn(card)
        candidates[deck_copy] = hand_copy
      end

      hits = outs(candidates, targets)

      size = candidates.size.to_f
      probabilities = []
      0.upto(cards_remaining-1) do |chance_num|
        probabilities << (((size - chance_num) - hits)/(size - chance_num))
      end

      total = 1 - probabilities.reduce(1) {|accum, x| accum * x}

      [hits, total, probabilities.map{|p| 1-p}]
    end

    def outs(candidates, targets)
      candidates.select do |deck, hand|
          targets.reduce(false) {|bool, target| bool || hand.send(target)}.size
        end
    end
  end
end


