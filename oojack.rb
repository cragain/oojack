# 1) Create the deck of cards.  Define Cards, then the Deck.  52 Cards total, 13 of each suit.  Each suit has 3 face cards plus and Ace.
# 2) Dealer deals cards, 2 to each player, alternating starting with player.  Show both of players cards, only last card shows of dealer.
# 3) If you get 21 on first deal, that is blackjack and you win.  If not, the dealer will check if he has blackjack when an ace shows.  If he does, he wins, game over.
# 4) If no one has blackjack, then player is asked to hit or stay.  Player can hit as often as they like until total cards reach 21 or over. Anything over is a bust.
# 5) Once the player stays, dealer must hit if total is < 17.  Once he reaches 17 or higher must stay with over 21 a bust.
# 6) If neither the player or dealer bust, once both stay cards are compared and highest wins with ties allowed.
# 7) When hand is over ask if they want to play again.



class Card
  
  def initialize(s, fv, nv)
    @suit =  s
    @face_value = fv
    @number_value = nv
  end
  
    
  
end

class Deck
 attr_accessor :deck_of_cards  

  def initialize
    @deck_of_cards = deck_of_cards
    
    @deck_of_cards = []
      ['H', 'D', 'S', 'C'].each do |suit|
      [['2', '2'], ['3', '3'], '4', '5', '6', '7', '8', '9', '10', 'J', 'Q', 'K', 'A'].each do |face_value, number_value|
        @deck_of_cards << Card.new(suit, face_value, number_value)
      end
    
    end
  end
end

puts Deck.new.deck_of_cards.to_s

class Dealer
end

class Player
end

class Hand
end

class BlackJack
end

class Bust
end

class Game
end

