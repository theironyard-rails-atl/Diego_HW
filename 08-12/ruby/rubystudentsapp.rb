require 'haml'
require 'pry'
require 'sinatra'

require './lib/ironyardstudents'

before do
  @students= %w(rjgroller mgriffeth mattyice50 Bartlebyy taylormartin andrewhouse khinlatt williammasonjones JTorr dhaskew rvirani1 danarch jamesdabbs)
  @user_info = Github.repos_for(@students.sample)

end

get '/' do
  haml :avatar
end

post '/' do
  haml :avatar
end
