Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :countries
    resources :cities
    resources :candidate_types
    resources :candidates do
      get 'progress', on: :collection
      post 'progress_update', on: :collection
      get 'probability_candidates', on: :collection
      get 'reply'
      get 'meeting'
    end
    get 'pages/setting' => "pages#setting"
  end
  root :to => 'admin/candidates#index'
end
