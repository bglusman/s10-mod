###Poker Odds Helper

This is a simple little simulation, currently tailored to Limit Hold'em but additional games should be easy to add by defining new actions/action sequences.

Start the game by typing bin/play_poker

The game can be played as a human against (by default) 7 bots, or they can play each other in simulated rounds until one of them goes broke, showing you the winning hands along the way.

Each round your choices will be presented as check, bet, fold and/or raise, depending on the actions by players in front of you, and small and big blinds will be posted automatically.  Actions are picked by entering 1, 2 or 3 corresponding to the choices provided (when 3 choices are available, 3 raise limit is enforced).

The game ends when any player drops below 60 in chips.  Each player starts with 500.