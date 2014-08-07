#Hangman_Spec.rb
require "minitest/autorun"

require "./guessing_game"

describe Hangman
  it "isn't finished when it starts" do
    game = Hangman.new
    assert game.finished? == false
  end
  it "is lost when you complete building the man (counter = 0)" do
    game = Hangman.new("Harry Potter")
    6.times {game.guess("z")}
    assert game.finished? == true
    assert_equal game.won?, false
  end

  it "counts down the incorrect letters" do
    game = Hangman.new("Harry Potter")
    assert game.counter == 6
    game.guess("z")
    assert game.counter == 5
  end

  it "can be won by guessing all the right letters" do
    game = Hangman.new("Up")
    game.guess("U")
    game.guess("P")
    assert game.finished? == true
    assert_equal game.won?, true
  end

  it "should come up with a phrase to guess" do
    game = Hangman.new("Up")
    assert game.movie_title != nil
  end

  it "should fill in correct spots when guessed correctly" do
    game= Hangman.new("Up")
    assert game.status == "__"
    game.guess("U")
    assert game.status == "U_"
  end
