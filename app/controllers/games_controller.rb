require 'open-uri'
require 'json'

class GamesController < ApplicationController
  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    @message = ""
    if included?
      if english_word?
        @message = "well done"
      else
        @message = "not an english word"
      end
    else
      @message = "not in the grid"
    end
  end

  def included?
    guess = params[:word].upcase.chars
    guess.all? { |letter| guess.count(letter) <= params[:letters].count(letter) }
  end

  def english_word?
    response = URI.open("https://wagon-dictionary.herokuapp.com/#{params[:word].downcase}")
    json = JSON.parse(response.read)
    return json['found']
  end
end
