Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  # 
  post 'user/signup', to: 'users#signup'
  post 'user/login', to: 'users#login'
  post 'wallets/deposit', to: 'wallets#deposit'
  post 'wallets/withdrawal', to: 'wallets#withdrawal'
  get 'wallet/balances', to: 'wallets#balances'
  post 'order/create', to: 'orders#create'
  put 'order/cancel', to: 'orders#cancel'
  get 'dashboard', to: 'dashboard#index'
end
