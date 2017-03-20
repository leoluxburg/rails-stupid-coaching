Rails.application.routes.draw do
get 'ask', to: 'coach#ask'
  get 'answer', to: 'coach#answer'
end
