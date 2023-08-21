require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = []
    @letters << ('A'..'Z').to_a.sample until @letters.size == 10
  end

  def score
    @attempt = params[:word]
    if valid_attempt?(@attempt)
      url = "https://wagon-dictionary.herokuapp.com/#{@attempt}"
      word_serialized = URI.open(url).read
      word = JSON.parse(word_serialized)
      word["found"] ? end_game(word) : @score = {score: 0, message: "not an english word" }
    else
      @score = {score: 0, message: "not in the grid" }
    end
    end
  end
  
  def end_game(word)
    score = ((word["length"]) * 100).round
    @score = { score: score, message: "well done" }
  end
  
  def valid_attempt?(attempt)
    attempt.chars.all? do |letter|
    attempt.count(letter) <= 10
  end
end
