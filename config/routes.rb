Rails.application.routes.draw do
  devise_for :users
  namespace :admin do
    resources :countries
    resources :cities
    resources :candidate_types
    resources :candidates do
      collection do
        get 'progress'
        post 'progress_update'
        get 'probability_candidates'
        get 'import_csv_new'
        post 'import_csv'
      end
      get 'reply'
      get 'meeting'
    end
    get 'pages/setting' => "pages#setting"
  end
  root :to => 'admin/candidates#index'
end
