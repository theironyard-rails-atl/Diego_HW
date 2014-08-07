require 'pry'
require 'highline'
include Enumerable

class Game

  def initialize
    @document = IO.readlines("nim_arrays.rb")
    @array_problem = eval(next_problem(1))
    choose_opponent
    @my_turn = true
    start_game
  end

  def next_problem(num)
    @document[num]
  end

  def visualize_problem
      alphabet = ('a'..'z').to_a
      @array_problem.each_index do |index|
        print "#{alphabet[index]} "
        pearls = @array_problem[index]
        pearls.times { print "()" }
        puts " -- #{pearls}"
      end
  end

  def choose_opponent
    print "Which opponent would you like?\nEasy, Medium, Hard, or Nightmare? "
    answer = gets.chomp!.capitalize
    case answer
    when "Easy"
      @rival = Easy.new
    when "Medium"
      @rival = Medium.new
    when "Hard"
      @rival = Hard.new
    when "Nightmare"
      @rival = Nightmare.new
    else
      puts "You did not ask for a real opponent. Please try again."
      choose_opponent
    end
  end

  def start_game
    visualize_problem
    print "Shall you go first, or shall I? "
    starter = gets.chomp!.capitalize
    case starter
    when "You"
      @my_turn = false
      toggle
    when "Me", "I"
      @my_turn = true
      toggle
    else
      puts "#{starter} is not a valid entry. You seem confused. Maybe I should go first."
      @my_turn = false
      toggle
    end
  end

  def user_move
    puts "It is your turn"
    puts "What would you like to do?"
    answer = gets.chomp!.capitalize
    alphabet = ('A'..'D').to_a
    alphabet.each_index {|index| @row = index if alphabet[index] == answer[0]}
    @array_problem[@row] = answer[1].to_i
    visualize_problem
  end

  def opponent_move
    "Opponent's Move"
    @array_problem = @rival.make_move(@array_problem)
    visualize_problem
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
    else
      puts "You lost!"
    end
  end

  def finished?
    @array_problem.reduce(&:+) == 1
  end

  def won?
    finished? && @my_turn == false
  end
end

class Opponent
  def initialize
  end

  def analyze(binary)#have to code that if solution is bigger than reality, then move to next biggest
    binary = binary.clone
    #b= binary.clone
    b = binary.sort.reverse

    b.each_index do |index|
      row = index
      binary_sum = b.reduce(:+) - b[row]

      if binary_sum == 2 #to avoid the error caused by 1, 1, num
        new_big = 1
      elsif binary_sum == 1 #to avoid error caused by 0, 1, num
        new_big = 0
      elsif binary_sum == 0 #to avoid error caused by 0, 0, num
        new_big = 1
      else
        string_sum = binary_sum.to_s
        new_big = ""
        string_sum.each_char do |char|
          if char.to_i.odd?
            new_big << "1"
          else
            new_big << "0"
          end
        end
      end
      unless new_big.to_i > b[row]
        correct_index = binary.index(b[index])
        binary[correct_index] = new_big.to_i
        return binary
      end
    end
  end

  def make_move(decimal)
    convert_to_binary (decimal)
    if ideal_state?
    # if @binary == analyze(@binary)
      puts "I am forced to make a stupid move"
      make_stupid_move(decimal)
    else
      puts "Aha!"
      convert_to_decimal(analyze(@binary))
    end
  end

  def ideal_state?
    @binary == analyze(@binary)
  end

  def make_stupid_move(decimal)
    biggest_row = decimal.index(decimal.max_by {|x| x})
    big_int= decimal.max {|x| x}
    decimal[biggest_row]=big_int-(rand(1..big_int))
    decimal
  end


  def convert_to_binary(decimal)
    @binary = decimal.map {|num| num.to_s(2).to_i} #.rjust(6, '0')
  end

  def convert_to_decimal(binary)
    decimal=binary.map {|num| num.to_s.to_i(2)}
    decimal
  end

end

class Easy < Opponent
end

class Medium < Opponent
end

class Hard < Opponent
end

class Nightmare < Opponent
end

nim = Game.new
