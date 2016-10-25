Rails.application.routes.draw do
  get 'landing/index'

  get 'welcome/index'

  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :posts do
    member do
      get 'like', to: 'posts#upvote'
      get 'dislike', to: 'posts#downvote'
    end
    resources :comments
  end

  resources :users do
    member do
      get :posts
    end
  end

  # we dont need to get all the resources of the welcome controller
  get 'welcome/index'
  get 'landing/index'
  # if the user is authenticated, he/she will redirect to this page
  authenticated :user do
   root to: 'welcome#index', as: :authenticated_root
  end
  # if the user is not, redirect to this page....
  root to: 'landing#index'
end
