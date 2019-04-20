Rails.application.routes.draw do


  root 'static_pages#home'

  get 'static_pages/home'
  get 'static_pages/micropost',to:"static_pages#micropost"
  get 'static_pages/diary'
  get 'static_pages/hobby'
  get 'static_pages/profile'
  get 'static_pages/messageboard'


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
