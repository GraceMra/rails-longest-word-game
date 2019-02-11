require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = ("A".."Z").to_a.sample(10)
  end

  def score
# The word can't be built out of the original grid
  @letters = params[:letters].split
  input = params[:name]
  url = open("https://wagon-dictionary.herokuapp.com/#{input.to_s}").read
  user = JSON.parse(url)

  is_english = user["found"]
  is_included = input.upcase.split('') - @letters == []

    if is_english && is_included
      @results = "Congrats!"
    elsif is_included && !is_english
      @results = "Sorry, the word is valid according to the grid, but is not a valid English word"
    else
      @results = "Sorry but this can't be built out of #{@letters}"
    end

  end
end

