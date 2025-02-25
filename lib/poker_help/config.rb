module PokerHelp
  class Config
    class << self
      attr_reader :holdem, :bet_parameters
    end
    @holdem =[:ante,
             :post_big_blind,
             :post_small_blind,
             #:preflop_event,
             :deal_two_hole_cards,
             :limit_bet,
             #:flop_event,
             :deal_flop,
             :limit_bet,
             :turn_event,
             :deal_turn,
             :limit_bet,
             :deal_river,
             :limit_bet,
             :showdown_and_award_pot]

    @bet_parameters = {:ante_size             => 0,       #used w/ blinds in tournaments & in stud/draw
                      :limit                  => :single, #:pot, :nolimit
                      :big_blind_size         => 15,
                      :small_blind_size       => 5,
                      :min_bet_pre_turn       => 15,
                      :min_bet_post_turn      => 30,
                      :raise_limit  => 3
                      }

  end
end