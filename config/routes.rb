Rails.application.routes.draw do

  root 'static_pages#home'
  get '/home', to: 'static_pages#home'
  get '/profile', to: 'static_pages#profile'
  get '/messageboard', to: 'static_pages#messageboard'
  get '/material', to: 'static_pages#material'

  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  get '/register/success', to: 'users#createSuccess'

  get '/login/profile', to: 'sessions#edit'
  get '/login/profile/info', to: 'sessions#edit'
  get '/login/profile/pwd', to: 'sessions#edit'
  patch '/login/profile/info', to: 'sessions#update_info'
  patch '/login/profile/pwd', to: 'sessions#update_pwd'
  delete '/login/profile', to: 'sessions#destroy'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  get '/micropost_home', to: "static_pages#micropost"

  resources :microposts, only: [:create, :index, :show]
  delete '/microposts', to: 'microposts#destroy'
  post '/microposts/search', to: 'microposts#search'
  post '/microposts/like', to: 'microposts#like'
  post '/microposts/more', to: 'microposts#more'
  post '/microposts/comment', to: 'microposts#create_comment'
  post '/microposts/comment/like', to: 'microposts#comment_like'
  post '/microposts/comment/more', to: 'microposts#more_comment'
  delete '/microposts/comment', to: 'microposts#destroy_comment'

  get '/diary_home', to: "static_pages#diary"

  resources :diaries do
    post :like, to: 'diaries#like'
    member do
      get :comments, to: 'diaries#show'
      post :comments, to: 'diaries#create_comment'
      delete :comments, to: 'diaries#destroy_comment'
      # post :comment_like,to:'diaries#like_comment'
    end
  end
  delete '/diaries', to: 'diaries#destroy'

  get '/hobby_home', to: 'static_pages#hobby'

  resources :hobbies
  post '/hobby/upload', to: 'hobbies#upload'
  post '/hobby/edit_upload', to: 'hobbies#edit_upload'
  post '/hobby/refresh', to: 'hobbies#refresh'
  post '/hobby/images/like', to: 'hobbies#like_image'
  delete '/hobby/images', to: 'hobbies#destroy_image'
  patch '/hobby/images', to: 'hobbies#update_image'
end
