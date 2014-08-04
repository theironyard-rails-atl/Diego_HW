#survey_spec.rb
require "minitest/autorun"
require "./survey"

describe("survey") do
  it should take survey questions from document

  it should ask questions and give choices

  it "isn't finished when it starts" do
    game = Survey.new
    assert game.finished? == false
  end
  
