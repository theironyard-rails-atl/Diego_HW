require 'yaml'
require 'pry'
include Enumerable


class Reader
  def initialize (document)
    @document = document
    @revenue = 0
    @cost = 0
  end

  def most_expensive_widget
    @document.max_by {|widget| widget[:price]}
  end

  def least_expensive_widget
    @document.min_by {|widget| widget[:price]}
  end

  def total_revenue
    @document.each {|widget| @revenue +=widget[:price]*widget[:sold]}
    @revenue
  end

  def total_profit
    @document.each {|widget| @cost +=widget[:cost_to_make]*widget[:sold]}
    profit = @revenue - @cost
    profit
  end

  def top_ten_best_selling
    top_10 = @document.sort_by {|widget| widget[:sold]}
    top_10.reverse!
    top_10[0..9]
  end

  def sort_by_department
    department = @document.group_by {|widget| widget[:department]}
    department.each do |ind_department, hash|
      puts "#{ind_department}: #{hash.reduce(0) {|sum, hash| sum + hash[:sold]}}"
    end
  end

end


user = Reader.new(YAML.load_file("widget.yml"))
puts user.most_expensive_widget
puts user.least_expensive_widget
puts user.total_revenue
puts user.total_profit
puts user.top_ten_best_selling
user.sort_by_department
