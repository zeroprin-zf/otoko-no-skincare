Rails.application.routes.draw do
  devise_for :user,skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controllers: {
    sessions: 'admin/sessions'
  }
  root to: 'public/homes#top'

  get 'home/about' => 'public/homes#about'
  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end
  #カテゴリーの検索もいる
  scope module: :public do
    resources :users, only: [:index, :show, :edit, :update] do
      resources :favorites, only:[:index]
      resources :bookmarks, only:[:index]#doの直下にすることでidを取得できる
      collection do
        get 'confirm' => 'users#confirm' #退会確認画面
        patch 'withdraw' => 'users#withdraw' #論理削除用のルーティング
      end
      member do
        get :favorites#後で消して一覧見てみて
        get :favorited
      end
    end

    get "search" => "searches#search"
    get '/category/search' => 'searches#category_search'

    resources :items do
      resources :comments, only: [:create, :index] #一覧もいるかも
      resource :favorites, only: [:create, :destroy]
    end

    resources :items, except: [:index] do
     resource :bookmarks, only: [:create, :destroy]
    end


  end

  get 'admin' => 'admin/homes#top'
  namespace :admin do
    resources :items, only: [:index, :show, :destroy] do
      resources :comments, only: [:index, :destroy]
    end

    resources :categories, only: [:index, :create, :edit, :update, :destroy]
    resources :users, only: [:index, :show, :edit, :update] do
        get 'confirm' => 'users#confirm'
        patch 'withdraw' => 'users#withdraw'
      end
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
