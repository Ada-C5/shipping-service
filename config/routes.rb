Rails.application.routes.draw do
  root to: 'shipping#quotes'
  get '/quotes' => 'shipping#quotes'
end
