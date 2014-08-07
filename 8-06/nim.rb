require 'pry'
require 'highline'

class Game

  def initialize
    @document = IO.readlines("nim_arrays.rb")
    @array_problem = eval(next_problem(0))
    choose_opponent
  end

  def next_problem(num)
    @document[num]
  end

  def visualize_problem
    #@num_of_rows = @array_problem.length
      alphabet = ('a'..'z').to_a
      @array_problem.each_index do |index|
        print "#{alphabet[index]} "
        pearls = @array_problem[index]
        pearls.times { print "()" }
        puts " -- #{pearls}"
      end
  end

  def convert_to_binary
    @binary=@array_problem.map {|num| num.to_s(2).rjust(6, '0').to_i}
    binding.pry
  end

  def choose_opponent
    print "Which opponent would you like?/nEasy, Medium, Hard, or Nightmare? "
    answer = gets.chomp!
  end

end

class Opponent
  def initialize
  end

  def analyze (binary)



  end
end

class Hard < Opponent
end

class Nightmare < Opponent
end

nim = Game.new
nim.visualize_problem
