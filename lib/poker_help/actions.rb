module PokerHelp
  module Actions
    def ante
      players.each {|p| p.bet(self.betting[:ante_size], pot)}
    end

    def post_small_blind
      players.each {|p| p.bet(self.betting[:small_blind_size], pot)}
    end

    def post_big_blind
      players.each {|p| p.bet(self.betting[:big_blind_size], pot)}
    end

    def deal_two_hole_cards
      players.each {|p| p.receive_cards(deck.deal(2))}
    end

    def limit_bet
      players.each { |player| action = player.choose(pot, current_bet_size)
                              update_players(action, player) }
    end

    def deal_flop
      self.flop = deck.deal(3)
      players.each { |player| player.receive_cards(board) }
    end

    def turn_event
      self.post_turn_event = true
    end

    def deal_turn
      self.turn = deck.deal
      players.each { |player| player.receive_cards(turn) }
    end

    def deal_river
      self.river = deck.deal
      players.each { |player| player.receive_cards(river) }
    end

    def showdown_and_award_pot
      self.winner ||= players.max
      winner.chips += pot.total
    end

    def move_button
      players.rotate
    end

  end
end