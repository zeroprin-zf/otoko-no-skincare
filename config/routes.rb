Rails.application.routes.draw do
  devise_for :user,skip: [:passwords], controllers: {
    registrations: 'public/registrations',
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords], controller: {
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
      collection do
        get 'confirm' => 'users#confirm'
        patch 'withdraw' => 'users#withdraw'
      end
    end

    resources :items do
      resources :comments, only: [:create] #一覧もいるかも
      resource :favorites, only: [:create, :destroy]
    end

    resources :favorites, only:[:index]
  end

  get 'admin' => 'admin/homes#top'
  namespace :admin do
    resources :posts, only: [:index, :show, :destroy] do
      resources :comments, only: [:destroy]
    end

    resources :categories, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :users, only: [:index, :show, :edit, :update]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
