module PokerHelp
# FORKED FROM RUBY-POKER GEM by Rob Olson
# Copyright (c) 2008, Robert Olson
# All rights reserved.

# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:

#     * Redistributions of source code must retain the above copyright
#       notice, this list of conditions and the following disclaimer.
#     * Redistributions in binary form must reproduce the above copyright
#       notice, this list of conditions and the following disclaimer in
#       the documentation and/or other materials provided with the distribution.
#     * Neither the name of the author nor the names of its
#       contributors may be used to endorse or promote products derived
#       from this software without specific prior written permission.

# THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
# AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
# IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
# ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE
# LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
# CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
# SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
# INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
# CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
# ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
# POSSIBILITY OF SUCH DAMAGE.


  class Card
    SUITS = "cdhs"
    FACES = "L23456789TJQKA"
    SUIT_LOOKUP = {
      'c' => 0,
      'd' => 1,
      'h' => 2,
      's' => 3
    }
    FACE_VALUES = {
      'L' =>  1,   # this is a magic low ace
      '2' =>  2,
      '3' =>  3,
      '4' =>  4,
      '5' =>  5,
      '6' =>  6,
      '7' =>  7,
      '8' =>  8,
      '9' =>  9,
      'T' => 10,
      'J' => 11,
      'Q' => 12,
      'K' => 13,
      'A' => 14
    }

    def Card.face_value(face)
      face.upcase!
      if face == 'L' || !FACE_VALUES.has_key?(face)
        nil
      else
        FACE_VALUES[face] - 1
      end
    end

    private

    def build_from_value(value)
      @value = value
      @suit  = value / FACES.size()
      @face  = (value % FACES.size())
    end

    def build_from_face_suit(face, suit)
      suit.downcase!
      @face  = Card::face_value(face)
      @suit  = SUIT_LOOKUP[suit]
      @value = (@suit * FACES.size()) + (@face - 1)
    end

    def build_from_face_suit_values(face, suit)
      build_from_value((face - 1) + (suit * FACES.size()))
    end

    def build_from_string(card)
      build_from_face_suit(card[0,1], card[1,1])
    end

    # Constructs this card object from another card object
    def build_from_card(card)
      @value = card.value
      @suit = card.suit
      @face = card.face
    end

    public

    def initialize(*value)
      if (value.size == 1)
        if (value[0].respond_to?(:to_card))
          build_from_card(value[0])
        elsif (value[0].respond_to?(:to_str))
          build_from_string(value[0])
        elsif (value[0].respond_to?(:to_int))
          build_from_value(value[0])
        end
      elsif (value.size == 2)
        if (value[0].respond_to?(:to_str) &&
            value[1].respond_to?(:to_str))
          build_from_face_suit(value[0], value[1])
        elsif (value[0].respond_to?(:to_int) &&
               value[1].respond_to?(:to_int))
          build_from_face_suit_values(value[0], value[1])
        end
      end
    end

    attr_reader :suit, :face, :value
    include Comparable

    # Returns a string containing the representation of Card
    #
    # Card.new("7c").to_s                   # => "7c"
    def to_s
      FACES[@face].chr + SUITS[@suit].chr
    end

    # If to_card is called on a `Card` it should return itself
    def to_card
      self
    end

    # Compare the face value of this card with another card. Returns:
    # -1 if self is less than card2
    # 0 if self is the same face value of card2
    # 1 if self is greater than card2
    def <=> card2
      @face <=> card2.face
    end

    # Returns true if the cards are the same card. Meaning they
    # have the same suit and the same face value.
    def == card2
      @value == card2.value
    end
    alias :eql? :==

    # Compute a hash-code for this Card. Two Cards with the same
    # content will have the same hash code (and will compare using eql?).
    def hash
      @value.hash
    end

    # A card's natural value is the closer to it's intuitive value in a deck
    # in the range of 1 to 52. Aces are low with a value of 1. Uses the bridge
    # order of suits: clubs, diamonds, hearts, and spades. The formula used is:
    # If the suit is clubs, the natural value is the face value (remember
    # Aces are low). If the suit is diamonds, it is the clubs value plus 13.
    # If the suit is hearts, it is plus 26. If it is spades, it is plus 39.
    #
    #     Card.new("Ac").natural_value    # => 1
    #     Card.new("Kc").natural_value    # => 12
    #     Card.new("Ad").natural_value    # => 13
    def natural_value
      natural_face = @face == 13 ? 1 : @face+1  # flip Ace from 13 to 1 and
                                                # increment everything else by 1
      natural_face + @suit * 13
    end
  end
end
