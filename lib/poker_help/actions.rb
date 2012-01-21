module PokerHelp
  module Actions
    def ante
      players.each {|p| p.bet(self.betting[:ante_size], pot)}
    end

    def post_small_blind
      players.first.bet(self.betting[:small_blind_size], pot)
    end

    def post_big_blind
      players.rotate.first.bet(self.betting[:big_blind_size], pot)
    end

    def deal_two_hole_cards
      players.each {|p| p.receive_cards(Hand.new(deck.deal(2)))}
    end

    def limit_bet
      ordering = (state == :blind_bet) ? players.rotate.rotate : players
      ordering.each do |player|
        action = player.choose(pot, current_bet_size, current_choices)
        update_state(action, player)
      end
    end

    def deal_flop
      self.flop   = deck.deal(3)
      self.state = :first_action
      players.each { |player| player.receive_cards(board) }
    end

    def turn_event
      self.post_turn_event = true
      self.pot.current_bet_size = current_bet_size
    end

    def deal_turn
      self.turn = deck.deal
      self.state = :first_action
      players.each { |player| player.receive_cards(turn) }
    end

    def deal_river
      self.river = deck.deal
      self.state = :first_action
      players.each { |player| player.receive_cards(river) }
    end

    def showdown_and_award_pot
      self.winner ||= players.max
      winner.chips += pot.total
    end

    def move_button
      players.rotate!
    end

  end
end