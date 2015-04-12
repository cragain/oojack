# 1) Create the deck of cards.  Define Cards, then the Deck.  52 Cards total, 13 of each suit.  Each suit has 3 face cards plus and Ace.
# 2) Dealer deals cards, 2 to each player, alternating starting with player.  Show both of players cards, only last card shows of dealer.
# 3) If you get 21 on first deal, that is blackjack and you win.  If not, the dealer will check if he has blackjack when an ace shows.  If he does, he wins, game over.
# 4) If no one has blackjack, then player is asked to hit or stay.  Player can hit as often as they like until total cards reach 21 or over. Anything over is a bust.
# 5) Once the player stays, dealer must hit if total is < 17.  Once he reaches 17 or higher must stay with over 21 a bust.
# 6) If neither the player or dealer bust, once both stay cards are compared and highest wins with ties allowed.
# 7) When hand is over ask if they want to play again.

require 'rubygems'
require 'pry'


class Card
  attr_accessor :suit, :face_value, :number_value
  
  def initialize(s, fv, nv)
    @suit =  s
    @face_value = fv
    @number_value = nv
  end
  
  def read_the_card
    "The #{face_value} of #{find_suit} is worth #{number_value} points"
  end

  def to_s
    read_the_card
  end

  def find_suit
    ret_val = case suit
                when 'H' then 'Hearts'
                when 'D' then 'Diamonds'
                when 'S' then 'Spades'
                when 'C' then 'Clubs'
              end
    ret_val
  end
  
end

class Deck
 attr_accessor :deck_of_cards  

  def initialize
    @deck_of_cards = deck_of_cards
    
    @deck_of_cards = []
      ['H', 'D', 'S', 'C'].each do |suit|
      [['2', '2'], ['3', '3'], ['4', '4'], ['5', '5'], ['6', '6'], ['7', '7'], ['8', '8'], ['9', '9'], ['10', '10'], ['J', '10'], ['Q', '10'], ['K', '10'], ['A', '11']].each do |face_value, number_value|
        @deck_of_cards << Card.new(suit, face_value, number_value)
        deck_of_cards.shuffle!
      end
    end
  end

  def deal_card
    deck_of_cards.pop
  end  

end

module Hand
   attr_accessor :name, :cards

  def add_card(new_card)
    @cards << new_card
  end
  
  def show_cards
    puts ''
    puts "------Player Has------"
    cards.each do|card|
     puts "#{card}"
    end
  end
  
  def show_dealer_card
    last_card = cards.last
    puts "-------Dealer Is Showing-------"
    puts "#{last_card}"
  end
  
  def dealer_shows_cards
    puts "------Dealer Now Has-----------"
    cards.each do|card|
      puts "#{card}"
    end
  end
  
  def card_total
      cards.map {|card| card.number_value.to_i}.inject {|sum, n| sum + n}
  end
end



class Dealer
  include Hand
  
  def initialize(name)
    @name = "name"
    @cards = []
  end
end

class Player
  include Hand
 
 
  def initialize(name)
    @name = name
    @cards = []
  end
end

class Game
  include Hand
  
  attr_accessor :deck, :player, :dealer
  
  BLACK_JACK = 21
  
  def initialize
    @deck = Deck.new
    @player = Player.new("Chris")
    @dealer = Dealer.new("Dealer")
  end
  
  def deal_cards

    player.add_card(deck.deal_card)
    dealer.add_card(deck.deal_card)
    player.add_card(deck.deal_card)
    dealer.add_card(deck.deal_card) 
  end
  
  def show_hands
    dealer.show_dealer_card
    player.show_cards
    puts""
    puts "Your hand total is #{player.card_total}"
  end
  
  def blackjack?(player_or_dealer)
    if player_or_dealer.card_total == BLACK_JACK 
      if player_or_dealer.is_a?(Player)
        puts "Its BlackJack!"
        dealer.dealer_shows_cards
        player.show_cards
        play_again?
      else puts "Oh No, Dealer BlackJack"
        dealer.dealer_shows_cards
        player.show_cards
        exit
      end
    end
  end
  
  def player_turn
    
    blackjack?(player)
  
    
    begin
      puts "Would you like to Hit(h) or Stay(s)"
      decision = gets.chomp.downcase
        
        if decision == 'h'
         player.add_card(deck.deal_card)
         player.show_cards
         puts "You now have #{player.card_total}"
            if player.card_total > 21
            stay_or_bust(player)
            else
            end
        else if decision == 's'
          stay_or_bust(player)
        end
        end
    end until decision =='s'
  end          
        
  def stay_or_bust(player_or_dealer)      
    if player_or_dealer.card_total > 21 && player_or_dealer.is_a?(Player)
      puts "Oh no, Player Busts"
      dealer.dealer_shows_cards
      play_again?
    elsif dealer.card_total > 21
      puts "Dealer Busts!"
    else
      puts "Stay!"
    end
  end

  
  def dealer_turn
    
    while dealer.card_total < 17
      dealer.add_card(deck.deal_card)
      dealer.dealer_shows_cards
      puts "Dealer now has #{dealer.card_total}"
      if dealer.card_total > 21
        stay_or_bust(dealer)
      end
    end until dealer.card_total > 17
  end
    
  def check_winner
    
    dealer.dealer_shows_cards
    puts ''
    puts "Dealer Final Total is #{dealer.card_total}"
    player.show_cards
    puts ''
    puts "Player Final Total is #{player.card_total}"
  
    if player.card_total == dealer.card_total
      puts "Its a Tie!"
    elsif player.card_total < 22 && player.card_total > dealer.card_total || dealer.card_total > 21
      puts "Nice work!, you won!"
    else
      puts "Ah, too bad, dealer won."
    end
  end
  
  def play_again?
    puts ""
    puts "Would you like to play again? (y/n)"
    if gets.chomp.downcase == 'y'
      puts "New game starting...."
      puts ""
      game = Game.new
      game.play
    else
      puts "See you next time"
      exit
    end
  end
    
    
  
  def play
    deal_cards
    show_hands
    player_turn
    dealer_turn
    check_winner
    play_again?
    

    
  end
end
  
game = Game.new
game.play







