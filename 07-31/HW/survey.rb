#survey.rb
class Survey
  attr_reader :questions

  def initialize
    @questions = IO.readlines("survey_questions.txt")
    @response_hash = {}
    @counter = 0
    @sum_value= 0.0
  end

  def ask_questions
    until @counter == @questions.length do
      puts ""
      puts @questions[@counter]
      print "On a 1 (low) to 5 (high) scale, how strongly do you agree with the above statement?: "
      @input = gets.chomp!.to_i
      save_input
      @counter+=1
    end
  end

  def results
    puts "Thank you for completing our survey!"
    get_max_min(@response_hash)
    average_value(@response_hash)
    puts "Your highest rating was #{@max_value}"
    puts "Your lowest rating was #{@min_value}"
    puts "Your average rating was #{@avg_value}"
  end

  def get_max_min(hash)
    @max_value = hash.values.max
    @min_value = hash.values.min
  end

  def average_value(hash)
    hash.values.map {|value| @sum_value += value}
    @avg_value=@sum_value/@questions.length
  end

  def save_input
    @response_hash[@counter]=@input
  end

  def finished?
  end

end

class Question
  def initialize
  end
end
