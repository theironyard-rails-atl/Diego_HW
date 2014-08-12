# def turns(tries)
#   puts "What is your guess?: "
#   return gets.chomp!.to_i
# end
#
# def close?(guess)
#   case guess
#   when (0...@answer)
#     "Too Low"
#   when (@answer+1..100)
#     "Too High"
#   when (@answer)
#     return "What are you psychic?! You win!"
#     exit
#   end
# end
#
# def game_starts()
#   @answer=rand(101)
#   tries = 5
#   tries.times do
#     guess= turns(tries)
#     tries -= 1
#     close?(guess)
#   end
#   puts "You failed punk! The answer was #{@answer}. Better luck next time!"
# end
#
#
# game_starts()
require "sinatra"
require "pry"
enable :sessions
def status_check
  case params[:guess].to_i
  when (0...session["answer"])
    "Too Low"
  when (session["answer"]+1..100)
    "Too High"
  when (session["answer"])
    "What are you psychic?! You win!"
  else
  end
end



get "/guessing_game" do
  session["answer"]= rand(101)
  session["counter"]= 5
  @opening= "Time to play the masochistic guessing game!\nWe picked a number between 0 and 100\nYou have 5 tries left!"
  @guess= params[:guess]
  haml :guessing_game
end

post '/guessing_game' do
  session["counter"]-= 1
  @answer= session["answer"]
  @guess= "Your guess was: '#{params[:guess]}'"
  @status= status_check

  haml :guessing_game
end
