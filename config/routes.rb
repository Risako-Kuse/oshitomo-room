Rails.application.routes.draw do
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }
  root :to => "public/homes#top"
  namespace :public do
    resources :directmails, only: [:new, :index, :show, :create]
    resources :posts
    resources :customers, only: [:index, :show, :edit, :update]
    get 'customers/withdrawal_check'
    patch 'customers/withdrawal'
    get "/about" => "homes#about"
  end


  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :posts, only: [:index, :destroy]
    resources :customers, only: [:index, :destroy]
    get 'homes/top'
  end

end
