Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root 'static_pages#top'
  get '/users/sign_out' => 'devise/sessions#destroy'
  
  devise_scope :user do
    get 'login', to: 'devise/sessions#new'
    post 'login', to: 'devise/sessions#create'
    delete 'signout', to: 'devise/sessions#destroy'
  end
  
end
