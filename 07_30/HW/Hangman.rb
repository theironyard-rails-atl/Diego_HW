#Hangman.rb
#Computer comes up with word
#Converts into _'s
#give user 6 fails
#prompt user for guess
#

class Hangman
  attr_reader :status, :movie_title

  def initialize
  end

  def computer_picks_name
    array = IO.readlines("movie_titles.txt")
    movie_name = array[rand(0..66)]
  end
