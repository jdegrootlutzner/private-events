Rails.application.routes.draw do
  devise_for :users, :controllers => {registrations: 'registrations'}
  resources :events do
    resources :attendances, only: %i[create destroy]
  end
  root 'events#index'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get 'future_events', to: 'events#future'
  get 'past_events', to: 'events#past'
end
