Rails.application.routes.draw do

  resources :disciplines do
    resources :blocks
  end

  root 'disciplines#index'

end
