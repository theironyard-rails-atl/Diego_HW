require './blackjack'
require 'minitest/autorun'

describe Card do
  it "knows the values of number cards" do
    2.upto(10) do |x|
      card = Card.new(x, :S)
      assert_equal card.value, x
    end
  end

  it "knows the values of face cards" do
    [:K, :Q, :J].each do |rank|
      card = Card.new(rank, :H)
      assert_equal card.value, 10
    end
  end

  it "knows the value of an ace" do
    card = Card.new(:A, :D)
    assert_equal card.value, 11
  end
end

describe Deck do
  def setup
    @deck = Deck.new
  end

  it "has the right number of cards" do
    assert_equal @deck.cards.count, 52
  end

  it "knows how many cards are left after drawing" do
    @deck.draw
    assert_equal @deck.cards.count, 51
  end

  it "tracks which cards have been drawn and which remain" do
    drawn_card = @deck.draw
    assert_equal @deck.cards.count, 51
    refute_includes @deck.cards, drawn_card
    assert_includes @deck.drawn, drawn_card
  end
end

describe Hand do
  def setup
    @hand = Hand.new
  end

  it "computes values with number cards" do
    @hand.add(Card.new(9, :H), Card.new(7, :S))
    assert_equal @hand.value, 16

    @hand.add(Card.new(4, :D))
    assert_equal @hand.value, 20
  end

  it "computes values with face cards" do
    @hand.add(Card.new(9, :H), Card.new(:K, :S))
    assert_equal @hand.value, 19
  end

  it "computes values with aces" do
    @hand.add(Card.new(:A, :H), Card.new(:K, :S))
    assert_equal @hand.value, 21

    @hand.add(Card.new(5, :S))
    assert_equal @hand.value, 16
  end

  it "can bust" do
    @hand.add(Card.new(6, :H), Card.new(:K, :S), Card.new(9, :H))
    assert @hand.busted?
  end

  it "knows a blackjack" do
    @hand.add(Card.new(:A, :H), Card.new(:K, :S))
    assert @hand.blackjack?
  end

  it "can be printed to string" do
    @hand.add(Card.new(:A, :H), Card.new(:K, :S))
    @hand.add(Card.new(5, :S))
    assert_equal @hand.to_str, 'AH, KS, 5S'
   end
 end
