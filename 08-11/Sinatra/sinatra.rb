require 'sinatra'
require 'pry'

get '/' do
  'Hello World'
end

get '/elevator_status' do
  elevator_status = "...still not working."
  haml :elevator, :locals => {:status => elevator_status}
end

get '/reverse' do
  @text = params[:text]
  haml :reverse
end

post '/reverse' do
  @text = "Whoa! Your text has been reversed!?:'#{params[:text].reverse}'"
  haml :reverse
end
