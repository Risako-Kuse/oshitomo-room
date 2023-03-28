Rails.application.routes.draw do

  namespace :public do
    get 'relationships/followings'
    get 'relationships/followers'
  end
  # 顧客用
  # URL /customers/sign_in ...
  devise_for :customers,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  # ゲストログイン機能
  devise_scope :customer do
    post 'customers/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  root :to => "public/homes#top"
  namespace :public do
    get 'customers/withdrawal_check'
    patch 'customers/withdrawal'
    resources :directmails, only: [:new, :index, :show, :create]
    #resources :posts
    resources :customers, only: [:index, :show, :edit, :update]
    get "/about" => "homes#about"

    # ↓ コメント機能
    resources :posts do
      resources :post_comments, only: [:create, :destroy]
       resource :favorites, only: [:create, :destroy] #イイね機能
    end

    # フォロー機能 ネストさせる
    resources :customers do
      resource :relationships, only: [:create, :destroy]
      get 'relationships' => 'customers#followings', as: 'followings'
      get 'reverse_of_relationships' => 'customers#followers', as: 'followers'
    end

    get "/search" => "searches#search"
  end


  # 管理者用
  # URL /admin/sign_in ...
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }
  namespace :admin do
    resources :posts, only: [:index, :destroy]
    resources :customers, only: [:index, :show, :destroy]
    get 'homes/top'
  end

end
