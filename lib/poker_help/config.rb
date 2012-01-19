module PokerHelp
  class Config
    class < self
      attr_reader :holdem, :bet_parameters
    end
    @holdem =[:ante,
             :post_big_blind,
             :post_small_blind,
             #:preflop_event,
             :deal_two_hole_cards,
             :limit_bet,
             #:flop_event,
             :deal_three_board_cards,
             :limit_bet,
             :turn_event,
             :deal_one_board_card,
             :limit_bet,
             :deal_one_board_card,
             :limit_bet,
             :showdown,
             :award_pot,
             :move_button]

    @bet_parameters = {:ante_size         => 0,       #used w/ blinds in tournaments & in stud/draw
                      :limit              => :single, #:pot, :nolimit
                      :big_blind_size     => 2,
                      :small_blind_size   => 1,
                      :min_bet_pre_turn   => 2,
                      :min_bet_post_turn  => 4
                      }

  end
end