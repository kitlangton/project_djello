Rails.application.routes.draw do
  get 'angular/index'

  devise_for :users

  root 'angular#index'
end
