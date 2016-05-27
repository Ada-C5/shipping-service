Rails.application.routes.draw do

  post '/shipping_rates' => 'shipments#get_rates'
  # Example return:
  # @ups_rates = [["UPS Ground", 1777, nil],
  #  ["UPS Three-Day Select",
  #   4875,
  #   Tue, 31 May 2016 00:00:00 +0000],
  #  ["UPS Second Day Air",
  #   7310,
  #   Mon, 30 May 2016 00:00:00 +0000],
  #  ["UPS Next Day Air Saver",
  #   11610,
  #   Fri, 27 May 2016 00:00:00 +0000],
  #  ["UPS Next Day Air",
  #   11947,
  #   Fri, 27 May 2016 00:00:00 +0000],
  #  ["UPS Next Day Air Early A.M.",
  #   15029,
  #   Fri, 27 May 2016 00:00:00 +0000]]

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
