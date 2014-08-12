require 'httparty'

class Avatar
  def initialize(data)
    @data= data
  end

  def name
    if @data["name"] && @data["name"] != ''
      @data["name"]
    else
      "NAME WITHELD"
    end
  end

  def avatar_url
    @data["avatar_url"]
  end
end


class Github
  include HTTParty
  base_uri 'https://api.github.com'
  #basic_auth 'Bartlebyy', 'password'
  attr_reader :students

  def initalize
    @students= %w(rjgroller mgriffeth mattyice50 Bartlebyy taylormartin andrewhouse khinlatt williammasonjones JTorr dhaskew rvirani1 danarch jamesdabbs)
  end

  def self.repos_for(username)
    response = get "/users/#{username}", headers: { "User-Agent" => "rubystudentsapp" }
    Avatar.new(response)
  end
end
