Hangman Design


If the computer is creating, it needs a database, with a list of words or
phrases that it can use as its word. Maybe a hint for each one. (Dictionary
would be a good place to start). Maybe booktitles. And then use a random readline to get the word.

Ideally it would have graphics.

I would make a method where there will be a until_dead variable where it
would start with number 6 and count down. When it reaches 0, player loses.

I would use grep or select to see if our guess works, otherwise it would call above method.

I would have a status method after each guess to show where the player stands. What is the current
status of the hangman, how many letters we have and wrong guesses.

the answer will be in the form of a string, and will be copied with an underscore substitution.

while until_dead > 0 then
  guess = gets.chomp!.downcase

If a guess is correct replace the string with underscores with the correct letter. That function
will be pretty tricky. Have a method figure out where the correct letters are located. Then
use answer[n]= "correct_guess_letter" to fill it in, and call the refresh method.

Of course add taunts and words of praise.
