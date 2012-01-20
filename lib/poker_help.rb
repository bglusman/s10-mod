module PokerHelp
  require 'pry'
  require 'forwardable'
  require_relative 'poker_help/actions'
  require_relative 'poker_help/card'
  require_relative 'poker_help/config'
  require_relative 'poker_help/deck'
  require_relative 'poker_help/game'
  require_relative 'poker_help/hand'
  require_relative 'poker_help/player'
  require_relative 'poker_help/pot'
  require_relative 'poker_help/round'
  require_relative 'poker_help/simulation'
  require_relative 'poker_help/utility'

  OverbetError  = Class.new(StandardError)
  FoldError     = Class.new(StandardError)
end