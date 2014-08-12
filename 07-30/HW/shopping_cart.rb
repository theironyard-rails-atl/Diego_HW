class Shopping_Cart

  attr_reader :total, :groceries
  def initialize
    @total=0
    @groceries={}
  end

  def add_goods (item, price)
    @groceries[item] = price
    @total += price
  end

  def delete_goods (item)
    @total -= @groceries[item]
    @groceries.delete(item)
  end

  def tax_total()
    unless total > 100 then
      @total = total.to_i * 1.07
    else
      puts "You have qualified for a 10% discount for spending more than $100!"
      @total = total.to_i * 1.07 * 0.9
    end
  end
end

def pitch(cart)

  puts "Would you like to Shop, Return, or Check Out?"
  choice = gets.chomp!.downcase
  case choice
  when "shop"
    puts "That's what I like to hear! What would you like?"
    item= gets.chomp!.to_s
    price= item.length * 10
    cart.add_goods(item, price)
    puts "That will be $#{price}. Your total without taxes is now $#{cart.total}."
    "What would you like to do next?"
    pitch(cart)
  when "return"
    puts "Great... What would you like to return?"
    failed_good= gets.chomp!.to_s
    if cart.groceries[failed_good] != nil then
      cart.delete_goods(failed_good)
      puts "*grumble* Happy to help. *grumble* Your total without taxes is now $#{cart.total}."
      "What would you like to do next?"
      pitch(cart)
    else
      puts "Yeah...you don't have that product in your cart. Let me ask this again, since you're obviously rattled."
      pitch(cart)
    end
  when "check out"
    cart.tax_total()
    puts "Terrific! Your grand total is $#{cart.total.round(2)}"
    what_you_purchased= cart.groceries.empty? ? "nothing! You bum" : cart.groceries.keys.join(", ")
    puts "You have purchased #{what_you_purchased}."
    puts "Please come back soon!"
    exit
  else
    puts "I'm sorry, I do not understand. Let me ask you again."
    pitch(cart)
  end
end

users_cart = Shopping_Cart.new
puts "Welcome to Diego's Infinity Store, where you can purchase anything your heart desires!"
pitch(users_cart)
