Rails.application.routes.draw do
  root "home#index"

  resources :categories, only: [:index, :show] do
    resources :products, only: [:index, :show] do
      resources :reviews, only: [:new, :create]
    end
  end

  resources :orders, except: [:index]
  resources :products, only: [:index]

  resources :merchants, only: [:show] do
    resources :products, except: [:delete]
    resources :categories, except: [:edit, :update, :delete]
    resources :orders, only: [:index, :show]
  end

  get "products" => "products#index"

  get "/auth/:provider/callback" =>  "sessions#create"
  get "/sessions/additional_info", to: "sessions#new", as: "new_session"
  patch "/sessions/additional_info", to: "sessions#update", as: "additional_info"
  get "/sessions/login_failure", to: "sessions#login_failure", as: "login_failure"
  get "sessions" => "sessions#index"
  delete "sessions", to: "sessions#destroy"

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
