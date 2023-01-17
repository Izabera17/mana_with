Rails.application.routes.draw do
  get 'users/index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root to: 'homes#top'
  get 'home' => "homes#home"

  get "search/keyword" => "searches#search_keyword"

  resources :post_learnings do
    resources :post_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
    get :search_genre, on: :collection
  end

  resources :post_learnings
  namespace :admin do
    resources :post_learnings, only: [:index, :new, :create, :show,  :edit, :destroy]
  end

  post "post_learnings/new" => "post_learnings#new"


  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions"
  }

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
    get "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  resources :tags, only: [:index]
  resources :users, only: [:index, :show, :edit, :update, :destroy]

  resources :genres

end




