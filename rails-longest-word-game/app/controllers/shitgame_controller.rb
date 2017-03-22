require 'open-uri'
require 'json'

class ShitgameController < ApplicationController

  def game
    @grid = generate_grid(9)
    @joined = @grid.join
  end

  def score
    @word = params[:guess].capitalize
    @grid = params[:grid].
    results = run_game(@word, @grid)
    @score = results[:score].to_i
    @message = results[:message]
    @translation = results[:translation]
  end

  def run_game(attempt, grid)
     x = {}
     if check(attempt, grid) == nil
       x[:score] = 0
       x[:message] = "not in the grid"
     else
       if translation(attempt) == attempt
         x[:translation] = nil
         x[:score] = 0
         x[:message] = "not an english word"
       else
         x[:translation] = translation(attempt)
         x[:score] = points(attempt)
         x[:message] = "well done"
       end
     end
  end

  def points(attempt)
   attempt_array = attempt.upcase.split("")
   score = attempt_array.length
  end

  def check(attempt, grid)
    attempt_array = attempt.upcase.split("")
    check = true
    attempt_array.each do |letter|
    a_occurences = attempt_array.select { |i| i == letter }
    g_occurences = grid.split(',').select { |i| i == letter }
    check = g_occurences.length < a_occurences.length ? false : true
    break if check == false
    end
  end

  def generate_grid(grid_size)
    grid_size.times.map { [*'A'..'Z'].sample }
  end

  def translation(attempt)
    url = "https://api-platform.systran.net/translation/text/translate?input=#{attempt}&source=en&target=fr&withSource=false&withAnnotations=false&backTranslation=false&encoding=utf-8&key=9fb813c6-92db-450e-a431-5a047ff2b912"
    attempt_serialized = open(url).read
    word = JSON.parse(attempt_serialized)
    word["outputs"][0]["output"]
  end

end
