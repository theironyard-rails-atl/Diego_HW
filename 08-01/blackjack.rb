require "pry"

class Card

  attr_reader :untouched_value, :suit

  def initialize(value, suit)
    @untouched_value = value
    @suit = suit
  end

  def value
    case @untouched_value
    when (2..10)
      @untouched_value
    when :K, :Q, :J
      10
    when :A
      11
    end
  end
end


class Deck

  attr_reader :cards, :drawn

  def initialize
    @cards = []
    @nums = [2,3,4,5,6,7,8,9,10,:J,:Q,:K,:A]
    @suits = [:D, :S, :H, :C]
    new_card
    @drawn = []
  end

  def new_card
    @nums.each do |x|
      @suits.each do |y|
        @cards << Card.new(x,y)
      end
    end
    shuffle
  end

  def shuffle
    @cards.shuffle!
  end

  def draw
    single_card = @cards.pop
    @drawn << single_card
    single_card
  end

  def display_status
    self.cards.length
  end
end

class Hand
  attr_reader :value

  def initialize
    @value = 0
    @cards_in_hand =[]
    @number_of_aces = 0
  end

  def add(*cards)
    cards.each do |card|
      @value += card.value
      @number_of_aces += 1 if card.value == 11
      @cards_in_hand << "#{card.untouched_value}#{card.suit}"
    end
  end

  def calculate_hand
    unless @value < 21
      if @number_of_aces > 0
        until @value <= 21 || @number_of_aces == 0
          @value -= 10
          @number_of_aces -= 1
        end
      end
    end
  end

  def value
    calculate_hand
    @value
  end

  def display_status
    self.to_str
  end

  def busted?
    value
    @value > 21
  end

  def blackjack?
    value
    @value == 21
  end

  def to_str
    return @cards_in_hand.join(", ")
  end

end

class Person
  attr_accessor :wallet, :hand, :bet
  def initialize(wallet)
    @hand= Hand.new
    @wallet = wallet
    @bet = 0.0
  end

  def transfer(money)
    @wallet += money
  end

  def draw_until_completion(deck)
    while @hand.value < 15
      @hand.add(deck.draw)
    end
  end

  def clear_hand
    @hand = Hand.new
  end
end

class Game
  attr_reader :player, :dealer, :deck
  def initialize
    @player = Person.new(100.00)
    @dealer = Person.new(1)
    @deck = Deck.new
  end

  def start
    while @player.wallet > 0 do
      puts "You have $#{@player.wallet} left to spend."
      print "How much would you like to bet?: $"
      @player.bet = gets.chomp!.to_i
      puts "\nAlright you have bet $#{@player.bet}."
      puts "Let's start!"
      @player.clear_hand
      @dealer.clear_hand

      @dealer.hand.add(@deck.draw)
      2.times {@player.hand.add(@deck.draw)}

      run_game(@player.bet)
    end
    puts ":) Aww, it looks like you ran out of cash *snicker*."
    puts " Why don't you come back later when you have more to lose."
    exit
  end

  def run_game(bet)
    display_status
    if @player.hand.blackjack?
      puts "OMG! You got blackjack!"
      won?
    elsif @player.hand.busted?
      puts "Ew...sorry you busted."
      won?
    else
      hit_or_stand?(bet)
    end
  end

  def hit_or_stand?(bet)
    print "Would you like to HIT or STAND? "
    request = gets.chomp!.upcase
    case request
    when "HIT"
      puts ""
      @player.hand.add(@deck.draw)
      run_game(bet)
    when "STAND"
      won?
      start
    end
  end

  def display_status
    puts "\nDEALER'S HAND: #{@dealer.hand.to_str}\n \n"
    puts "YOUR HAND: #{@player.hand.to_str} \n "
    puts "Current Value: #{@player.hand.value}"
  end

  def won?
    if @player.hand.busted?
      display_status
      puts "\nYou lost.\n"
      @player.transfer(@player.bet*-1)
    else
      @dealer.draw_until_completion(deck)
      display_status
      if !@dealer.hand.busted? && @player.hand.value < @dealer.hand.value
        puts "\nYou lost.\n"
        @player.transfer(@player.bet*(-1))
      else
        puts "\nYou won!\n"
        @player.transfer(@player.bet)
      end
    end

    puts "Your current balance is now #{@player.wallet}"
    puts "Would you like to play another round, YES or NO?"
    response = gets.chomp!.upcase
    case response
    when "YES"
    when "NO"
      puts "Thanks for playing! Goodbye!"
      exit
    else
      puts "You didn't put a valid entry, so I'll just assume you meant 'YES, I'd like another opportunity to lose money'"
    end
  end
end


#--------- Running Script ----------

if __FILE__ == $PROGRAM_NAME
  game = Game.new
  puts "Time to play Blackjack!"
  game.start
end
