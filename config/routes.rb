Rails.application.routes.draw do
  get '/quotes' => 'shipping#quotes'
end
