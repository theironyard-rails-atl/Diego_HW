require 'pry'
require 'highline'
include Enumerable

class Game

  def initialize
    @document = IO.readlines("nim_arrays.rb")
    @level_counter = 0
    @array_problem = eval(next_problem(@level_counter))
    choose_opponent
    @my_turn = true
    rule_explanation
    start_game
  end

  def rule_explanation
    puts "\nWelcome to the game of NIM!\nI shall now explain the rules.\nThe circles below, as you can see, are separated into different rows.\nOn your turn, you may remove as many circles as you like from any one row.\nEx: a3 => removes three circles from row 'a'\nThe object of the game is to leave the last of the circles for your opponent to take.\nGood luck, and may the odds be ever in your favor!"
  end
  def next_problem(num)
    @document[num]
  end

  def visualize_problem
      puts
      puts "Level #{@level_counter+1}"
      @array_problem.each_index do |index|
        print "#{alphabet[index]} "
        pearls = @array_problem[index]
        pearls.times { print "()" }
        puts " -- #{pearls}"
      end
      puts
  end

  def choose_opponent
    print "Which opponent would you like?\nEasy, Medium, Hard, or Nightmare? "
    answer = gets.downcase
    if answer == " nightmare\n" #enjoy the easter egg! Trick your friends!
      @rival = Nightmare2.new
      @level_counter = 6
      @array_problem = eval(next_problem(@level_counter))
    else
      answer.chomp!
      case answer
      when "easy"
        @rival = Easy.new
      when "medium"
        @rival = Medium.new
      when "hard"
        @rival = Hard.new
      when "nightmare"
        @rival = Nightmare.new
        @level_counter = 6
        @array_problem = eval(next_problem(@level_counter))
      else
        puts "You did not ask for a real opponent. Please try again."
        choose_opponent
      end
    end
  end

  def start_game
    if @rival.must_go_first?
      visualize_problem
      puts "Press ENTER to continue."
      understand = gets.chomp
      print "So glad to play another victim! As always, I will go first!"
      sleep(1)
      @my_turn = false
      toggle
    else
      visualize_problem
      print "Will you go first, or shall I? "
      starter = gets.chomp!.downcase
      case starter
      when "you"
        @my_turn = false
        toggle
      when "me", "i"
        @my_turn = true
        toggle
      else
        puts "#{starter} is not a valid entry. You seem confused. Maybe I should go first."
        @my_turn = false
        toggle
      end
    end
  end

  def user_move
    answer = get_input

    while valid_input?(answer) == false
      answer = get_input
    end

    alphabet.each_index {|index| @row = index if alphabet[index] == answer[0]}
    answer.slice!(0)
    answer = answer.to_i

    @array_problem[@row] = @array_problem[@row] - answer
    visualize_problem
  end

  def get_input
    puts
    puts "It is your turn"
    puts "What would you like to do? (ex: a3) "
    answer = gets.chomp!.downcase
    answer
  end

  def valid_input?(answer)
    answer = answer.clone
    unless alphabet.include?(answer[0])
      puts "#{answer} is not a valid entry. Please try again."
      return false
    end

    alphabet.each_index {|index| @row = index if alphabet[index] == answer[0]}
    answer.slice!(0)
    answer_int = answer.to_i

    if answer_int == 0
      puts "#{answer} is not a valid integer."
      puts "Please try again."
      false
    elsif answer_int > @array_problem[@row]
      puts "You cannot subtract #{answer} from #{@array_problem[@row]}."
      puts "Please try again."
      false
    else
      true
    end
  end

  def opponent_move
    "Opponent's Move"
    @array_problem = @rival.make_move(@array_problem)
    visualize_problem
    sleep(1)
  end

  def toggle
    while !finished?
      if @my_turn == true
        @my_turn = false
        user_move
      else
        @my_turn = true
        opponent_move
      end
    end
    if won?
      puts "You win!"
      new_game
    else
      puts "You lost!"
      new_game
    end
  end

  def start_new_game?
    print "Would you like to play again? "
    continue = gets.chomp.downcase
    while (continue != "yes") && (continue != "no")
      puts "I'm sorry. Please return a 'yes' or 'no' answer."
      puts
      print "Would you like to play again? "
      continue = gets.chomp.downcase
    end
    continue == "yes"
  end

  def new_game
    @rival.reset_counter
    if start_new_game?
      @level_counter += 1 if won?
      @array_problem = eval(next_problem(@level_counter))
      start_game
    else
      exit
    end
  end

  def finished?
    @array_problem.reduce(&:+) == 1
  end

  def won?
    finished? && @my_turn == false
  end

  private
  def alphabet
    ('a'..'d').to_a
  end

end

class Opponent
  def initialize
    @counter = 0
  end

  def must_go_first?
    false
  end

  def analyze(binary)
    binary = binary.clone
    rows = binary.sort.reverse

    rows.each_index do |index|
      binary_sum = rows.reduce(:+) - rows[index]
      if binary_sum <= 2
        new_row = binary_sum.even? ? 1 : 0 #to avoid the error caused by 1, 1, num
      else
        new_row = generate_ideal_row(binary_sum)
      end
      unless new_row.to_i > rows[index]
        correct_index = binary.index(rows[index])
        binary[correct_index] = new_row.to_i
        return binary
      end
    end

  end

  def generate_ideal_row (binary_sum)
    string_sum = binary_sum.to_s
    new_row = ""
    string_sum.each_char do |char|
      if char.to_i.odd?
        new_row << "1"
      else
        new_row << "0"
      end
    end
    new_row
  end

  def make_move(decimal)
    sleep(1)
    convert_to_binary (decimal)
    puts
    if ideal_state?
    # if @binary == analyze(@binary)
      puts "Opponent Moved: *grumble*"
      sleep(2)
      make_stupid_move(decimal)
    else
      puts "Opponent Moved: Aha!"
      sleep(1)
      convert_to_decimal(analyze(@binary))
    end
  end

  def ideal_state?
    @binary == analyze(@binary)
  end

  def make_stupid_move(decimal)

    biggest_row = decimal.index(decimal.max_by {|x| x})
    big_int = decimal.max {|x| x}
    decimal[biggest_row]=big_int-(rand(1..big_int))
    decimal
  end


  def convert_to_binary(decimal)
    @binary = decimal.map {|num| num.to_s(2).to_i} #.rjust(6, '0')
  end

  def convert_to_decimal(binary)
    decimal = binary.map {|num| num.to_s.to_i(2)}
    decimal
  end

  def reset_counter
    @counter = 0
  end
end

class Easy < Opponent

  def make_move(decimal)
    @counter+=1
    sleep(1)
    convert_to_binary(decimal)
    puts
    if !ideal_state? && @counter > 2 #2 turns of mistakes
      puts "...I think this is correct..."
      sleep(1)
      convert_to_decimal(analyze(@binary))
    else
      puts "...I think this is correct..."
      sleep(2)
      make_stupid_move(decimal)
    end
  end
end

class Medium < Opponent
  def make_move(decimal)
    @counter+=1
    sleep(1)
    convert_to_binary (decimal)
    puts
    if !ideal_state? && @counter > 1
      puts "How's this!"
      sleep(1)
      convert_to_decimal(analyze(@binary))
    else
      puts "How's this?!"
      sleep(2)
      make_stupid_move(decimal)
    end
  end
end

class Hard < Opponent
  #perfect just the way you are!
end

class Nightmare < Opponent
  def must_go_first?
    true
  end

  def make_move(decimal)
    sleep(1)
    convert_to_binary (decimal)
    puts
    if ideal_state?
    # if @binary == analyze(@binary)
      puts "What?! How is this possible?!"
      sleep(2)
      make_stupid_move(decimal)
    else
      puts "Your fate has already been sealed, when you decided to face me."
      sleep(1)
      convert_to_decimal(analyze(@binary))
    end
  end
end

class Nightmare2 < Nightmare

  def make_move(decimal)
    sleep(1)
    convert_to_binary (decimal)
    puts
    if ideal_state?
    # if @binary == analyze(@binary)
      puts "What?! How is this possible?!"
      sleep(2)
      make_stupid_move(decimal)
    else
      puts "Your fate has already been sealed, when you decided to face me."
      sleep(1)
      make_stupid_move(decimal)
    end
  end

end

nim = Game.new
