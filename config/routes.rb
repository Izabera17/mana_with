Rails.application.routes.draw do
  get 'users/index'
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get 'home' => "homes#home" 
  post 'homes/guest_sign_in', to: 'homes#new_guest'
  
  resources :post_learnings do
    get :search, on: :collection
  end
  
  resources :post_comments, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :tags, only: [:index]
  resources :users, only: [:index]
  get "users/mypage" => "users#show"
end
