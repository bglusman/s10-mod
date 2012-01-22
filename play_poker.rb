require_relative 'lib/poker_help'

game = PokerHelp::Simulation.new(2)

p game

module Kernel
  def rand
    srand 3579
  end
end

p game.run

module Kernel
  def rand
    srand 2468
  end
end

p game.run