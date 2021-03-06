Rails.application.routes.draw do
  get 'angular/index'
  root 'angular#index'

  scope 'api' do
    scope 'v1' do
      resources :boards do
        resources :lists do
          resources :cards
        end
      end
    end
  end

  devise_for :users
end
