Rails.application.routes.draw do

  resources :disciplines
  resources :blocks
  root 'disciplines#index'

end
