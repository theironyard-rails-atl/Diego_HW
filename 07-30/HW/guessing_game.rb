def turns(tries)
  puts "Time to play the masochistic guessing game!"
  puts "We picked a number between 0 and 100"
  puts "You have #{tries} tries left!"
  puts "What is your guess?: "
  return gets.chomp!.to_i
end



def close?(guess)
  case guess
  when (0...@answer)
    puts ""
    puts "Too Low"
    puts ""
  when (@answer+1..100)
    puts ""
    puts "Too High"
    puts ""
  when (@answer)
    puts ""
    puts "What are you psychic?! You win!"
    exit
  end
end

def game_starts()
  @answer=rand(101)
  tries = 5
  5.times do
    guess= turns(tries)
    tries -= 1
    close?(guess)
  end
  puts "You failed punk! The answer was #{@answer}. Better luck next time!"
end

puts "Game started"
game_starts()
