Rails.application.routes.draw do
  get 'game', to: 'shitgame#game'

  get 'score', to: 'shitgame#score'

end
