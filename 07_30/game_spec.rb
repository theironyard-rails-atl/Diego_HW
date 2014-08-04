require "minitest/autorun"

require "./guessing_game"


describe GuessingGame do
  it "isn't finished when it starts" do
    game. GuessingGame.new
    assert game.finished? == false
  end
end
