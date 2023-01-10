Rails.application.routes.draw do
  get 'users/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get 'home' => "homes#home" 

  
  resources :post_learnings do
    get :search, on: :collection
  end
  
  
  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }
  
  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
    get "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end
  
  resources :post_comments, only: [:create, :destroy]
  resources :favorites, only: [:create, :destroy]
  resources :tags, only: [:index]
  resources :users, only: [:index]
  
  resources :genres
  
  get "users/mypage" => "users#show"
end
