module PokerHelp
  module Actions
    def ante
      players.each {|p| p.bet(self.betting[:ante_size])}
    end

    def post_small_blind
      players.each {|p| p.bet(self.betting[:small_blind_size])}
    end

    def post_big_blind
      players.each {|p| p.bet(self.betting[:big_blind_size])}
    end

    def deal_two_hole_cards
      players.each {|p| p.receive_cards(deck.deal(2))}
    end

    def limit_bet

    end

         # :deal_three_board_cards,
         # :limit_bet,
         # :turn_event,
         # :deal_one_board_card,
         # :limit_bet,
         # :deal_one_board_card,
         # :limit_bet,
         # :showdown,
         # :award_pot,
         # :move_button
  end
end