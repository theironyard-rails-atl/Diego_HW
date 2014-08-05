require 'yaml'
require 'pry'


class Question
  attr_reader :question, :choices, :answer, :answer_is_correct


  def initialize(hash_obj)
    @question = hash_obj[:question]
    @choices = hash_obj[:choices]
    @answer = hash_obj[:answer]
    @written_answer = hash_obj[:choices][@answer]
    @answer = hash_obj[:answer].to_s
  end

  def print_question
    puts @question
    puts @choices
  end

  def check_answer
    print "What is your answer? "
    @guess = gets.chomp!.capitalize
    puts ""
    puts ""
    # binding.pry
    if (@guess == @answer) || (@guess == @written_answer)
      @answer_is_correct = true
    else
      @answer_is_correct = false
    end
  end


end


class Quizzer

  def initialize(document)
    @questions = []

    document.each do |hash|
      @questions << Question.new(hash)
    end

    @score = 0
    @correct_array=[]
    @incorrect_array=[]
    @questions.shuffle!
  end

  def run_quizzer
    @questions.each do |question|
      question.print_question
      question.check_answer
      calculate_score(question)

    end
  end

  def calculate_score(question)
    if question.answer_is_correct == true
      @score += 1
      @correct_array << question.question
    else
      @incorrect_array << question.question
    end
  end

  def print_results
    puts "Your score was #{@score}"
    puts ""
    puts "Correct Questions:"
    @correct_array.each {|string| puts string}
    puts ""
    puts "Incorrect Questions:"
    @incorrect_array.each {|string| puts string}
  end

end

user=Quizzer.new(YAML.load_file("quiz_questions.yml"))
puts "Welcome to the Quiz Game! Good luck!"
user.run_quizzer
user.print_results
