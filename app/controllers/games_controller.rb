require 'open-uri'
require 'json'

class GamesController < ApplicationController

  def new
    @letters = Array.new(10) { ('A'..'Z').to_a.sample }
  end

  def score
    attempt = params[:word].chars.map { |letter| params[:letters].include?(letter.upcase) }
    if !attempt.include?(false)
      if english_word?
        @score = "The word is valid according to the grid and is an English word"
      else
        @score = "The word is valid according to the grid, but is not a valid English word"
      end
    else
      @score = "The word can't be built out of the original grid"
    end
  end

  private

  def english_word?
    response = open("https://wagon-dictionary.herokuapp.com/#{params[:word]}")
    json = JSON.parse(response.read)
    json['found']
  end

end
