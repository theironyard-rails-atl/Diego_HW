#needs to

class Quizzer

Questions = [
  {
     question: "What do you put in a toaster?",
     choices: [
       "Toast",
       "Bread"
     ],
     answer: 1
  },
  {
     question: "If a red house is made from red bricks and a blue house is made from blue bricks and a pink house is made from pink bricks and a black house is made from black bricks, what is a greenhouse made from? ",
     choices: [
       "Green Bricks",
       "Glass"
     ],
     answer: 1
  },
  {
     question: "Maria's father had five daughters: Ma, Me, Mi, Mo and?",
     choices: [
       "Mu",
       "Maria"
     ],
     answer: 1
  },
  {
     question: "It is 10 years ago, and a plane is flying at 20,000 feet over Germany. During the flight, the two engines fail. The pilot, realizing that the last remaining engine is also failing, decides on a crash landing procedure. Unfortunately the engine fails before he can do so and the plane fatally crashes smack in the middle of Berlin. Where would you bury the survivors? ",
     choices: [
       "West Berlin",
       "East Berlin",
       "No Man's Land",
       "You don't bury survivors"
     ],
     answer: 3
  },
  {
     question: "Say 'silk' five times. Now spell 'silk.' What do cows drink?",
     choices: [
       "Milk",
       "Water"
     ],
     answer: 1
  }
]

  def initialize
    @counter = 4
    @answer_is_correct = false
    @score = 0
    @correct_array=[]
    @incorrect_array=[]
    Questions.shuffle!
  end

  def decrease_counter
    @counter -=1
  end

  def print_question
    puts Questions[@counter][:question]
    puts Questions[@counter][:choices]
  end

  def check_answer
    print "What is your answer? "
    @guess = gets.chomp!.capitalize
    puts ""
    puts ""
    num_answer = Questions[@counter][:answer] #gets the numerical answer

    if @guess==Questions[@counter][:choices][num_answer] then
      @answer_is_correct = true
    else
      @answer_is_correct = false
    end
  end

  def calculate_score
    if @answer_is_correct == true then
      @score += 1
      @correct_array << Questions[@counter][:question]
    else
      @incorrect_array << Questions[@counter][:question]
    end
  end

  def run_quizzer
    while @counter >= 0 do
      print_question
      check_answer
      calculate_score
      decrease_counter
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

Student_1=Quizzer.new()
puts "Welcome to the Quiz Game! Good luck!"
Student_1.run_quizzer
Student_1.print_results
