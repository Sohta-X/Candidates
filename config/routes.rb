Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :candidates do
      get 'progress', on: :collection
      post 'progress_update', on: :collection
      get 'probability_candidates', on: :collection
    end
  end
end
