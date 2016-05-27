Rails.application.routes.draw do
  get '/' => 'shipping#index'
  get '/quotes' => 'shipping#quotes'
end
