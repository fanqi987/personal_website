Rails.application.routes.draw do


  root 'static_pages#home'

  get 'static_pages/home',to:'static_pages#home'
  get 'static_pages/micropost', to: "static_pages#micropost"
  get 'static_pages/diary', to: 'static_pages#diary'
  get 'static_pages/hobby', to: 'static_pages#hobby'
  get 'static_pages/profile', to: 'static_pages#profile'
  get 'static_pages/messageboard', to: 'static_pages#messageboard'
  get 'static_pages/material', to: 'static_pages#material'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
