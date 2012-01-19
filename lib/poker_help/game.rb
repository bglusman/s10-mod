module PokerHelp
  class Game
    #poker sessions sometimes change the game every round, or every few rounds, with the same players
    #a game should encapsulate card dealing and placement logic, validity rules and decision options
    #(though outside of draw poker decisions are usuaully just bet/check/fold/raise, w/ or w/o limits)

    #I may hard code the rules for one game type now with the goal of generalizing later, with consistent interface
    attr_reader :type, :action_sequence

    def initialize(sequence=Config.holdem)
      @type = :limit_holdem
      @action_sequence = sequence
      @action_iterator = action_sequence.each
    end

    def next
      @action_iterator.next
    end

  end
end