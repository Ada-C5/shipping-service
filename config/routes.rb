Rails.application.routes.draw do
  resources :carriers, only: [:index] do 
    collection do 
      post 'choose_rates'
      post 'get_rates' => 'carriers#index'
    end 
  end 
end
