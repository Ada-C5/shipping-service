Rails.application.routes.draw do
 resources :carriers do 
   collection do 
     post 'get_rates' => 'carriers#index'
   end 
 end 
end