class CoachController < ApplicationController
  def ask

  end

  def answer
    @question = params[:question]
    @answer = coach_answer(@question)
  end

  def coach_answer(que)
    if que.include?("?")
      return "yes"
    else
      return "no"
    end
  end
end
