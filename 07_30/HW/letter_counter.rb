class Letter_Counter
  attr_reader :input, :letter_counts_hash

  def initialize ()
      @letter_counts_hash = {}
  end

  def get_string
    print "Don't believe that this magic can be possible? Put our claims to the test!: "
    @input = gets.chomp!.upcase
  end

  def convert_to_array
    @input.split(//)
  end

  def convert_string
    convert_to_array.each do |letter|
      unless @letter_counts_hash.has_key?(letter)
        @letter_counts_hash[letter] = 1
      else
        @letter_counts_hash[letter] += 1
      end
    end
  end
end

puts "Welcome to Letter Counter, the counter that counts your letters!"
user = Letter_Counter.new
user.get_string
user.convert_string
puts user.letter_counts_hash
puts "Tadah! Be amazed!"
