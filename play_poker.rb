require_relative 'lib/poker_help'

PokerHelp::HUMAN = true
game = PokerHelp::Simulation.new(7)

#uncomment for deterministic behavior
# module Kernel
#   def rand
#     srand 3579
#   end
# end

loop do
  game.run
  p game.players.sort{|x,y| x.name <=> y.name }.map {|p| "#{p.name}: $#{p.chips}.00"}
  p game.round.winner.hand
  break if game.players.detect {|p| p.chips < 25}
end


