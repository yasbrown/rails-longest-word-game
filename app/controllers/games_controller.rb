require "json"
require "open-uri"

class GamesController < ApplicationController

  def new
    @letters = ('A'..'Z').to_a.sample(10)
  end

  def score
    @answer = params[:word].upcase
    @letters = params[:letters].chars

    url = "https://wagon-dictionary.herokuapp.com/#{@answer}"
    dictionary = URI.open(url).read
    words = JSON.parse(dictionary)
    words[:found]

    @new_answer = @answer.split('')

    character_in_grid = true
    @new_answer.each do |character|
      character_in_grid = @letters.include?(character)
      break if character_in_grid == false
    end

    if character_in_grid && words['found'] == true
      @result = "Congratulations! #{@answer} is a valid English word!"
    elsif character_in_grid && words['found'] == false
      @result = "Sorry but #{answer} does not seem to be a valid English word..."
    else
      @result = "Sorry but #{answer} can't be built out of #{@letters}"
    end
  end
end
