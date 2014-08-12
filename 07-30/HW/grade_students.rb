require "pry"


def grade (numerical_grade)
  case numerical_grade
  when 90..100
    return "A"
  when 80..89
    return "B"
  when 70..79
    return "C"
  when 60..69
    return "D"
  when 50..59
    return "F"
  end
end


def students (n)
  list_of_students = []
  n.times {list_of_students << rand(50..100)}
  letter_grades=list_of_students.map {|student| grade(student)}
  puts letter_grades
  puts letter_grades.count("A")

end


# def count_a (letter_grade)

students(25)
