Rails.application.routes.draw do

  resources :disciplines do
    resources :blocks
  end

  post '/disciplines/:discipline_id/blocks/start', to: 'blocks#start',
    as: 'start_discipline_block'
  post '/disciplines/:discipline_id/blocks/:id/finish', to: 'blocks#finish',
    as: 'finish_discipline_block'

  root 'disciplines#index'

end
